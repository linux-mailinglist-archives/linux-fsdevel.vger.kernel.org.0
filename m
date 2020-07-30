Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7633232903
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 02:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgG3AcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 20:32:17 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54148 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbgG3AbV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 20:31:21 -0400
Received: from dede-linux-virt.corp.microsoft.com (unknown [131.107.160.54])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6342620B490F;
        Wed, 29 Jul 2020 17:31:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6342620B490F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596069080;
        bh=+61YBSjOP4ZQrvaK6jew3ITHo5Th5B0Y1X96EWC3CeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6MB2iC5YpjPOBp774dDuSE7Wzv34z0ERFqgb4MbETlNZmmgELjrrtDvWkZL0NYzi
         j3Lc/2iY2UTduS+1EuPBHRzhQt/scEmOlCrgGSH1211sjaRgwOcFPfJVm1tSX3vYF1
         0nOIdFu2NJmmxYk+4H7wja+RQudVAQj2xBnOV5zE=
From:   Deven Bowers <deven.desai@linux.microsoft.com>
To:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        viro@zeniv.linux.org.uk, paul@paul-moore.com, eparis@redhat.com,
        jannh@google.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-audit@redhat.com
Cc:     tyhicks@linux.microsoft.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, mdsakib@microsoft.com,
        nramas@linux.microsoft.com, pasha.tatashin@soleen.com
Subject: [RFC PATCH v6 06/11] dm-verity: add bdev_setsecurity hook for dm-verity signature
Date:   Wed, 29 Jul 2020 17:31:08 -0700
Message-Id: <20200730003113.2561644-7-deven.desai@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730003113.2561644-1-deven.desai@linux.microsoft.com>
References: <20200730003113.2561644-1-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a security hook call to set a security property of a block_device
in dm-verity with the results of a verified, signed root-hash.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
---
 drivers/md/dm-verity-target.c     |  2 +-
 drivers/md/dm-verity-verify-sig.c | 14 +++++++++++---
 drivers/md/dm-verity-verify-sig.h | 10 ++++++----
 include/linux/device-mapper.h     |  2 ++
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index eec9f252e935..9970488e67ed 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -1134,7 +1134,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	}
 
 	/* Root hash signature is  a optional parameter*/
-	r = verity_verify_root_hash(root_hash_digest_to_validate,
+	r = verity_verify_root_hash(v, root_hash_digest_to_validate,
 				    strlen(root_hash_digest_to_validate),
 				    verify_args.sig,
 				    verify_args.sig_size);
diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-verify-sig.c
index 614e43db93aa..2cd9f8c85449 100644
--- a/drivers/md/dm-verity-verify-sig.c
+++ b/drivers/md/dm-verity-verify-sig.c
@@ -8,7 +8,10 @@
 #include <linux/device-mapper.h>
 #include <linux/verification.h>
 #include <keys/user-type.h>
+#include <linux/security.h>
+#include <linux/list.h>
 #include <linux/module.h>
+#include "dm-core.h"
 #include "dm-verity.h"
 #include "dm-verity-verify-sig.h"
 
@@ -103,8 +106,9 @@ int verity_verify_sig_parse_opt_args(struct dm_arg_set *as,
  * @sig_len: Size of the signature.
  *
  */
-int verity_verify_root_hash(const void *root_hash, size_t root_hash_len,
-			    const void *sig_data, size_t sig_len)
+int verity_verify_root_hash(struct dm_verity *v, const void *root_hash,
+			    size_t root_hash_len, const void *sig_data,
+			    size_t sig_len)
 {
 	int ret;
 
@@ -121,8 +125,12 @@ int verity_verify_root_hash(const void *root_hash, size_t root_hash_len,
 	ret = verify_pkcs7_signature(root_hash, root_hash_len, sig_data,
 				sig_len, NULL, VERIFYING_UNSPECIFIED_SIGNATURE,
 				NULL, NULL);
+	if (ret)
+		return ret;
 
-	return ret;
+	return security_bdev_setsecurity(dm_table_get_md(v->ti->table)->bdev,
+					 DM_VERITY_SIGNATURE_SEC_NAME,
+					 sig_data, sig_len);
 }
 
 void verity_verify_sig_opts_cleanup(struct dm_verity_sig_opts *sig_opts)
diff --git a/drivers/md/dm-verity-verify-sig.h b/drivers/md/dm-verity-verify-sig.h
index 19b1547aa741..6b7de1d48e5a 100644
--- a/drivers/md/dm-verity-verify-sig.h
+++ b/drivers/md/dm-verity-verify-sig.h
@@ -20,8 +20,9 @@ struct dm_verity_sig_opts {
 
 #define DM_VERITY_ROOT_HASH_VERIFICATION_OPTS 2
 
-int verity_verify_root_hash(const void *data, size_t data_len,
-			    const void *sig_data, size_t sig_len);
+int verity_verify_root_hash(struct dm_verity *v, const void *data,
+			    size_t data_len, const void *sig_data,
+			    size_t sig_len);
 bool verity_verify_is_sig_opt_arg(const char *arg_name);
 
 int verity_verify_sig_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
@@ -34,8 +35,9 @@ void verity_verify_sig_opts_cleanup(struct dm_verity_sig_opts *sig_opts);
 
 #define DM_VERITY_ROOT_HASH_VERIFICATION_OPTS 0
 
-int verity_verify_root_hash(const void *data, size_t data_len,
-			    const void *sig_data, size_t sig_len)
+int verity_verify_root_hash(struct dm_verity *v, const void *data,
+			    size_t data_len, const void *sig_data,
+			    size_t sig_len)
 {
 	return 0;
 }
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 73dec4b5d5be..ab6b8eb0a150 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -625,4 +625,6 @@ static inline unsigned long to_bytes(sector_t n)
 	return (n << SECTOR_SHIFT);
 }
 
+#define DM_VERITY_SIGNATURE_SEC_NAME DM_NAME	".verity-sig"
+
 #endif	/* _LINUX_DEVICE_MAPPER_H */
-- 
2.27.0

