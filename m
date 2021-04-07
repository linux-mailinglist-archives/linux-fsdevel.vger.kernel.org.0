Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B9C356A96
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 12:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351692AbhDGKzt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 06:55:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2795 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhDGKzq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:55:46 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFh2W3Fwcz686G6;
        Wed,  7 Apr 2021 18:48:35 +0800 (CST)
Received: from fraphisprd00473.huawei.com (7.182.8.141) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 12:55:34 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v5 11/12] ima: Introduce template field evmsig and write to field sig as fallback
Date:   Wed, 7 Apr 2021 12:52:51 +0200
Message-ID: <20210407105252.30721-12-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210407105252.30721-1-roberto.sassu@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [7.182.8.141]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With the patch to accept EVM portable signatures when the
appraise_type=imasig requirement is specified in the policy, appraisal can
be successfully done even if the file does not have an IMA signature.

However, remote attestation would not see that a different signature type
was used, as only IMA signatures can be included in the measurement list.
This patch solves the issue by introducing the new template field 'evmsig'
to show EVM portable signatures and by including its value in the existing
field 'sig' if the IMA signature is not found.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
---
 Documentation/security/IMA-templates.rst  |  4 ++-
 security/integrity/ima/ima_template.c     |  2 ++
 security/integrity/ima/ima_template_lib.c | 33 ++++++++++++++++++++++-
 security/integrity/ima/ima_template_lib.h |  2 ++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index c5a8432972ef..9f3e86ab028a 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -70,9 +70,11 @@ descriptors by adding their identifier to the format string
    prefix is shown only if the hash algorithm is not SHA1 or MD5);
  - 'd-modsig': the digest of the event without the appended modsig;
  - 'n-ng': the name of the event, without size limitations;
- - 'sig': the file signature;
+ - 'sig': the file signature, or the EVM portable signature if the file
+   signature is not found;
  - 'modsig' the appended file signature;
  - 'buf': the buffer data that was used to generate the hash without size limitations;
+ - 'evmsig': the EVM portable signature;
 
 
 Below, there is the list of defined template descriptors:
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index e22e510ae92d..90e8a8282927 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -45,6 +45,8 @@ static const struct ima_template_field supported_fields[] = {
 	 .field_show = ima_show_template_digest_ng},
 	{.field_id = "modsig", .field_init = ima_eventmodsig_init,
 	 .field_show = ima_show_template_sig},
+	{.field_id = "evmsig", .field_init = ima_eventevmsig_init,
+	 .field_show = ima_show_template_sig},
 };
 
 /*
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index c022ee9e2a4e..4314d9a3514c 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -10,6 +10,7 @@
  */
 
 #include "ima_template_lib.h"
+#include <linux/xattr.h>
 
 static bool ima_template_hash_algo_allowed(u8 algo)
 {
@@ -438,7 +439,7 @@ int ima_eventsig_init(struct ima_event_data *event_data,
 	struct evm_ima_xattr_data *xattr_value = event_data->xattr_value;
 
 	if ((!xattr_value) || (xattr_value->type != EVM_IMA_XATTR_DIGSIG))
-		return 0;
+		return ima_eventevmsig_init(event_data, field_data);
 
 	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
 					     DATA_FMT_HEX, field_data);
@@ -484,3 +485,33 @@ int ima_eventmodsig_init(struct ima_event_data *event_data,
 	return ima_write_template_field_data(data, data_len, DATA_FMT_HEX,
 					     field_data);
 }
+
+/*
+ *  ima_eventevmsig_init - include the EVM portable signature as part of the
+ *  template data
+ */
+int ima_eventevmsig_init(struct ima_event_data *event_data,
+			 struct ima_field_data *field_data)
+{
+	struct evm_ima_xattr_data *xattr_data = NULL;
+	int rc = 0;
+
+	if (!event_data->file)
+		return 0;
+
+	rc = vfs_getxattr_alloc(&init_user_ns, file_dentry(event_data->file),
+				XATTR_NAME_EVM, (char **)&xattr_data, 0,
+				GFP_NOFS);
+	if (rc <= 0)
+		return 0;
+
+	if (xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG) {
+		kfree(xattr_data);
+		return 0;
+	}
+
+	rc = ima_write_template_field_data((char *)xattr_data, rc, DATA_FMT_HEX,
+					   field_data);
+	kfree(xattr_data);
+	return rc;
+}
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index 6b3b880637a0..f4b2a2056d1d 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -46,4 +46,6 @@ int ima_eventbuf_init(struct ima_event_data *event_data,
 		      struct ima_field_data *field_data);
 int ima_eventmodsig_init(struct ima_event_data *event_data,
 			 struct ima_field_data *field_data);
+int ima_eventevmsig_init(struct ima_event_data *event_data,
+			 struct ima_field_data *field_data);
 #endif /* __LINUX_IMA_TEMPLATE_LIB_H */
-- 
2.26.2

