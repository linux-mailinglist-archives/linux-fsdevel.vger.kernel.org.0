Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4E468B21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 15:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbfGONix (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 09:38:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55509 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730517AbfGONiw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:38:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so15210192wmj.5;
        Mon, 15 Jul 2019 06:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G0qrvSOgvQ6yK2rmDZbEXEOEVLwb2sXgjUX4/QpRTUM=;
        b=YJGgtSA7qdI6JnxPZWXZ6fSdBUEo1por2dydSgOvVeWb6sdhGCg1FIluTDB30o4c/a
         6QAe4MwiENh+zaFguimXDdmi5IJnH1E0Siaax/96si7k7nar/L2bNhtmGLXMZ/KJbvtn
         DRTS0IqzQsxIYDXNRH6j+oter8esDUvZse7MkJNt4KDv4Aet55D6tFinwY2RWVtOKMBu
         cYTvQ0T7BBKXH2KlzTjLlLgRLWtotjyX7InmkTTmymEyYKDYwKLX+8dLzSNsWqF4oSr4
         ZoRpzKrEy16cYtgZ3Foes4ojz14hWcafTud6RFHiaFJtBlV3p7BcRDJ48efDupHwYSQC
         IlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G0qrvSOgvQ6yK2rmDZbEXEOEVLwb2sXgjUX4/QpRTUM=;
        b=XwhSoePLDIFLTZuWOi23qxMGdQ52bQ1bgJ1/R8BTM2lCC8w15lG0Lu/StsSd+RGRRb
         LdQx7sVX4IE27j6uxPIpsWAcZlIIHakL5lTbtrYbG745h2MleLB3ZheVRFaY0qoaHp1R
         8FK6chqPMB2sEpLw3+xT92W5PTLeP6+uu8V9fXb/3mjncpMRNBEBZdVPYjLGNHO3YhTi
         7ywqJt91OjJY+GaugcaEbrkK6sDs1HUh571AdZvDgdXGGzZ+CmG7gjALMa2EEaLcezPe
         oZCGZVnCJOjLY9cRIp+vqU6m/gIWQ701OIW8+kC0IYy5uze6FSNmu7px/rTF4P4QHApX
         u4UA==
X-Gm-Message-State: APjAAAXxKrDpgaBHAg7Vwm17wk57mjUtv/EaY9kljCdKj65kEgSR1i3u
        BCTEaH+GgscXvfXsRYh+q9I=
X-Google-Smtp-Source: APXvYqwXqTMClxMel7/FgiVQ3ov8D+2z7O0Ekjwg5niB2eVa5v9G0uzg0XYRMtAsBTxqcG/ex2S6yA==
X-Received: by 2002:a1c:eb17:: with SMTP id j23mr26006087wmh.151.1563197930640;
        Mon, 15 Jul 2019 06:38:50 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id s15sm4058250wrw.21.2019.07.15.06.38.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 06:38:50 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [PATCH 1/4] ovl: support [S|G]ETFLAGS ioctl for directories
Date:   Mon, 15 Jul 2019 16:38:36 +0300
Message-Id: <20190715133839.9878-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715133839.9878-1-amir73il@gmail.com>
References: <20190715133839.9878-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[S|G]ETFLAGS and FS[S|G]ETXATTR ioctls are applicable to both files and
directories, so add ioctl operations to dir as well.

ifdef away compat ioctl implementation to conform to standard practice.

With this change, xfstest generic/079 which tests these ioctls on files
and directories passes.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c      | 10 ++++++----
 fs/overlayfs/overlayfs.h |  2 ++
 fs/overlayfs/readdir.c   |  4 ++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index e235a635d9ec..c6426e4d3f1f 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -502,7 +502,7 @@ static long ovl_ioctl_set_fsxflags(struct file *file, unsigned int cmd,
 				   ovl_fsxflags_to_iflags(fa.fsx_xflags));
 }
 
-static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	long ret;
 
@@ -527,8 +527,8 @@ static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return ret;
 }
 
-static long ovl_compat_ioctl(struct file *file, unsigned int cmd,
-			     unsigned long arg)
+#ifdef CONFIG_COMPAT
+long ovl_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
 	case FS_IOC32_GETFLAGS:
@@ -545,6 +545,7 @@ static long ovl_compat_ioctl(struct file *file, unsigned int cmd,
 
 	return ovl_ioctl(file, cmd, arg);
 }
+#endif
 
 enum ovl_copyop {
 	OVL_COPY,
@@ -646,8 +647,9 @@ const struct file_operations ovl_file_operations = {
 	.fallocate	= ovl_fallocate,
 	.fadvise	= ovl_fadvise,
 	.unlocked_ioctl	= ovl_ioctl,
+#ifdef CONFIG_COMPAT
 	.compat_ioctl	= ovl_compat_ioctl,
-
+#endif
 	.copy_file_range	= ovl_copy_file_range,
 	.remap_file_range	= ovl_remap_file_range,
 };
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 6934bcf030f0..7c94cc3521cb 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -416,6 +416,8 @@ struct dentry *ovl_create_temp(struct dentry *workdir, struct ovl_cattr *attr);
 
 /* file.c */
 extern const struct file_operations ovl_file_operations;
+long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+long ovl_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 
 /* copy_up.c */
 int ovl_copy_up(struct dentry *dentry);
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 47a91c9733a5..eff8fbfccc7c 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -907,6 +907,10 @@ const struct file_operations ovl_dir_operations = {
 	.llseek		= ovl_dir_llseek,
 	.fsync		= ovl_dir_fsync,
 	.release	= ovl_dir_release,
+	.unlocked_ioctl	= ovl_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ovl_compat_ioctl,
+#endif
 };
 
 int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
-- 
2.17.1

