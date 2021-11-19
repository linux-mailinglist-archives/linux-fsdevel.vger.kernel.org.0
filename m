Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EB8457702
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 20:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbhKSTb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 14:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhKSTbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 14:31:55 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAAFC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 11:28:53 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id r23so9413169pgu.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 11:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=inEVTtx9dg780b45QDw2zmi3tLaKJ0sVb3YOqvqO6Sg=;
        b=Ilad5Flc374k2I5x+I91zJu9Tii8adfRVPu97UrQozOjQ7AUektnlWF+At3TFTPSm4
         pvIZCzHuSBC7LFq+rQeKud5buRxfGqyM/fdheiFAXOctBT45bzvGDCl2oCO81sKEfoa1
         C2UstnT3lg/f6F4NY1D/zYiN/uLX9IBmxtsaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=inEVTtx9dg780b45QDw2zmi3tLaKJ0sVb3YOqvqO6Sg=;
        b=CFl+apdjW7O6xgBLJd9OesHnegOS75k53gf/LSpnhRYJvmB4aDrrmzGZbVihRIcJ9o
         bXKbUPLJHBAfYTMsjVHp2OJKXY1u8gLcXX5aQNUCT6UJ+xyjYD1J2Y1tabW+QNYJAA/s
         H4jFqbwfMhdupzPv5wg3c/RgNVNLCRAeIBHHS4H1X7M5rDHwKIo5V0nMkNFbQ7Bi2Rbz
         tul5GRSLcPXQC9nYJeSoXD7YTT06XeaV9Q3dJ1MCLpy79VlsYAJb+GNySQZukWC6TO6Y
         XbSKgY5FnqW34ViHvrCDmO8Uh9or6CUh6I+hegjIUyjrAedsjnHPmNUiZ8Q6LFl8CXTH
         Ge8A==
X-Gm-Message-State: AOAM532IKQTi/StOYHU+MtrifiGSzR+kkGD63+oaDeNmcWaF0VETla3g
        Izj/er/xQZkMxgOmzpvHGle7pg==
X-Google-Smtp-Source: ABdhPJweh3pTn1evOXD3uFsGXSY2PwZdgKvvYq0xO4ybAoL3tHBX2EipzAOM8xwxinUGzRYK23qpRg==
X-Received: by 2002:a05:6a00:1a56:b0:4a3:3c0c:11c0 with SMTP id h22-20020a056a001a5600b004a33c0c11c0mr13015115pfv.42.1637350133097;
        Fri, 19 Nov 2021 11:28:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f29sm357733pgf.34.2021.11.19.11.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 11:28:52 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] hfsplus: Use struct_group_attr() for memcpy() region
Date:   Fri, 19 Nov 2021 11:28:51 -0800
Message-Id: <20211119192851.1046717-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2620; h=from:subject; bh=SCJbRPRIgSrbgcI0+anP4QpGg3OM58wHZmhAt7+/j14=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhl/ry4/8jGV6MXqmu/7C8vq8DKE761j4O7Dvj4ee+ +UHR6j2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYZf68gAKCRCJcvTf3G3AJsyLEA CxlpW5BfTUERCVzkLeA4yk5WzpRqsHUnTNs3g3dZCWt39oCeTmDnNFr/Wbj1Pth9za402aDi4w5r4Z dnQHlIiVSvELxTNHFZ+KSpsztpoq7HWHyg6Y1K/5nN8W50Njcyx2IzDxNs6QpR+7hatTugOjenFiPv lVwARpl20w3hr22bWuG3qIyTWFSwijfBrzkaSmnVHCro+svaPQhewrucv6ekl5oMBBPKLhVr2W85nE PfpwLFPitagoQCLyDMYjud9b6cuuD/1PCtieuenR5NUtYnRInM3eyLldUqpryj/o9o4+M9eBwSU8fV NAgdvCB1DgdvC81wcnm7ZMaF6T4E+uXySyGjtDnr0R+83UV5/ZZ5dNOEO3rl8aBcUlz+dHfFsvdXGT YyP6JQ4hBxQpw6uQsIYwrBrRF0yuq/PEQW53aVG04Mp6PUMMirV75kxhHJYCfqnA583z6PFdnx+aAL z44OfBB6XzwqQXDwwPWK8EgBVylrT4AgD6LVMOMTEkEPfuAYR1Lv3ayE02jx3ABLL2Afu1z9wy4N9e os2GcQRNh8b3nw294oQ/O9woIHZzLIYTLBZRsqwQLiKjdy430bS1Jd/wHoSOdo8vDZn2l4DDvyoZIV LSBm0gNRIwIn7BhjuV8cGCoCtiXxJgE+cgQq7Ouq7Fy0yXQss/bkjzDjM/Xw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add struct_group() to mark the "info" region (containing struct DInfo
and struct DXInfo structs) in struct hfsplus_cat_folder and struct
hfsplus_cat_file that are written into directly, so the compiler can
correctly reason about the expected size of the writes.

"pahole" shows no size nor member offset changes to struct
hfsplus_cat_folder nor struct hfsplus_cat_file.  "objdump -d" shows no
object code changes.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/hfsplus/hfsplus_raw.h | 12 ++++++++----
 fs/hfsplus/xattr.c       |  4 ++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/hfsplus/hfsplus_raw.h b/fs/hfsplus/hfsplus_raw.h
index 456e87aec7fd..68b4240c6191 100644
--- a/fs/hfsplus/hfsplus_raw.h
+++ b/fs/hfsplus/hfsplus_raw.h
@@ -260,8 +260,10 @@ struct hfsplus_cat_folder {
 	__be32 access_date;
 	__be32 backup_date;
 	struct hfsplus_perm permissions;
-	struct DInfo user_info;
-	struct DXInfo finder_info;
+	struct_group_attr(info, __packed,
+		struct DInfo user_info;
+		struct DXInfo finder_info;
+	);
 	__be32 text_encoding;
 	__be32 subfolders;	/* Subfolder count in HFSX. Reserved in HFS+. */
 } __packed;
@@ -294,8 +296,10 @@ struct hfsplus_cat_file {
 	__be32 access_date;
 	__be32 backup_date;
 	struct hfsplus_perm permissions;
-	struct FInfo user_info;
-	struct FXInfo finder_info;
+	struct_group_attr(info, __packed,
+		struct FInfo user_info;
+		struct FXInfo finder_info;
+	);
 	__be32 text_encoding;
 	u32 reserved2;
 
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index e2855ceefd39..49891b12c415 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -296,7 +296,7 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 					sizeof(hfsplus_cat_entry));
 		if (be16_to_cpu(entry.type) == HFSPLUS_FOLDER) {
 			if (size == folder_finderinfo_len) {
-				memcpy(&entry.folder.user_info, value,
+				memcpy(&entry.folder.info, value,
 						folder_finderinfo_len);
 				hfs_bnode_write(cat_fd.bnode, &entry,
 					cat_fd.entryoffset,
@@ -309,7 +309,7 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 			}
 		} else if (be16_to_cpu(entry.type) == HFSPLUS_FILE) {
 			if (size == file_finderinfo_len) {
-				memcpy(&entry.file.user_info, value,
+				memcpy(&entry.file.info, value,
 						file_finderinfo_len);
 				hfs_bnode_write(cat_fd.bnode, &entry,
 					cat_fd.entryoffset,
-- 
2.30.2

