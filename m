Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F7FE90F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 21:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfJ2Un5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 16:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfJ2Un4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:43:56 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27ABC21721;
        Tue, 29 Oct 2019 20:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572381835;
        bh=bA1Nt9TWZvija+pWQm/jvZD5pLPHccs35Yz1RfF2GZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rd7PXg6zwRW6AzBcDukG70kVXPnDFY/Yp1M1Yi465IxdRteBn/mWEGk2RcSAX0bx9
         zel1es+30DpGpOmI1ko07QXwQLI0WJLYWrVJ486au+twTpg7V/PgIwyKBDURx3jDP4
         2oMAidPnxs9Tw9ec8wOtrlajmDWE6C9PK+eKYyUs=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [PATCH 1/4] statx: define STATX_ATTR_VERITY
Date:   Tue, 29 Oct 2019 13:41:38 -0700
Message-Id: <20191029204141.145309-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191029204141.145309-1-ebiggers@kernel.org>
References: <20191029204141.145309-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add a statx attribute bit STATX_ATTR_VERITY which will be set if the
file has fs-verity enabled.  This is the statx() equivalent of
FS_VERITY_FL which is returned by FS_IOC_GETFLAGS.

This is useful because it allows applications to check whether a file is
a verity file without opening it.  Opening a verity file can be
expensive because the fsverity_info is set up on open, which involves
parsing metadata and optionally verifying a cryptographic signature.

This is analogous to how various other bits are exposed through both
FS_IOC_GETFLAGS and statx(), e.g. the encrypt bit.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/stat.h      | 3 ++-
 include/uapi/linux/stat.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/stat.h b/include/linux/stat.h
index 765573dc17d659..528c4baad09146 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -33,7 +33,8 @@ struct kstat {
 	 STATX_ATTR_IMMUTABLE |				\
 	 STATX_ATTR_APPEND |				\
 	 STATX_ATTR_NODUMP |				\
-	 STATX_ATTR_ENCRYPTED				\
+	 STATX_ATTR_ENCRYPTED |				\
+	 STATX_ATTR_VERITY				\
 	 )/* Attrs corresponding to FS_*_FL flags */
 	u64		ino;
 	dev_t		dev;
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 7b35e98d3c58b1..ad80a5c885d598 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -167,8 +167,8 @@ struct statx {
 #define STATX_ATTR_APPEND		0x00000020 /* [I] File is append-only */
 #define STATX_ATTR_NODUMP		0x00000040 /* [I] File is not to be dumped */
 #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
-
 #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
+#define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

