Return-Path: <linux-fsdevel+bounces-12181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C04E85C78D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 22:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FEE283186
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 21:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82960151CF0;
	Tue, 20 Feb 2024 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/TcvGFd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768E14AD15
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463639; cv=none; b=ebBtOxl5ijhLB5ZBeRgTGX1HqFbVVbWjxoVuhtvTGhQPMCaKyaWdtiLs6cMuNnRxQAhzW1hvJUP21RrjCBZuHDjsmwrxLhvTO3ijMQFMVbDM1YcLuNSvC3ZdVCnvPQeHaUgr7IaW6z5/a6fSoM/eHsD8ekKs/qf2HEKTbSQd4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463639; c=relaxed/simple;
	bh=uZg5Et8gEN8FRZRx9g+kWWI4DedzL6Vaw8HrIxM7bro=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=CuBwGPGkqa8f2MelPyCKt0WqzCnQRV28y6bNJeSeP+TKiFiqy/IUwWIoHw/QzNu+e4olw/D4kO0uZJeHADQ06JsybnQNqOiGJOpNQbltJGSUS//gq/j7+DVEJzMbF9qqFHuc+esVnpwrERGgigHvvDCX9rEj/yLv7qcRnORuEIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/TcvGFd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708463636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7jZyBE/flQJD7h7/ZWRDjew/3POt0RMkhi3E1kyQ7FA=;
	b=O/TcvGFda0Wr3R5l6w/oVNIk7RcM4949ouEvjnw4MmyTzSy7Lrb2lMBCgFaI4iz9ACuJzI
	3QZuRtmzEVq4KtgZB3GNUorh/E4jvS97w24AHkqM8fBCB3/Nur1+232Ve2MS04awmLtRM3
	Th5AfjH82W690OaWs0OLvu5alJa6t2I=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-nOIgViPGNq2oHjjBStFJbQ-1; Tue, 20 Feb 2024 16:13:54 -0500
X-MC-Unique: nOIgViPGNq2oHjjBStFJbQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3651d2b88aeso30868985ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 13:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708463632; x=1709068432;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7jZyBE/flQJD7h7/ZWRDjew/3POt0RMkhi3E1kyQ7FA=;
        b=Eou6FddNHuqKTdyuZCa3i4huUfwvKnj74wfcB72rg9tTBIY9HaD8IAvllCSTyZ3Oxi
         HoCiRqr+6uNsR9wRwT8KDGmdO13Jxm7iHcqVpSrSspZD40DZGs77sj5irR+2ILy7kQcS
         vheWb/PQkvFQfg9sBpgcpQEWjNo212XLWvPFAuQahno9XmolJux9ioge2UV2mucZHVbv
         dW5cJn1c1iYawZSS8oMsrdrh0skkNLd2O/0hdylKzAS4jK3jyiDo9fow04t2bWLD4417
         P9SGZ6SY8Q2Ql6Z58D6zBvTkMWtIGQTI9eTANcMjrt9HXOIChmwJ8IQ3ReV/TNnG7Nn+
         1buw==
X-Gm-Message-State: AOJu0YxO3zSYI+yYIpU/VWZmsdV13QtkBavHXNNWo/IXZDk7tbpyhoCe
	a9EIbDkNjdUyENUqrByco/7WI6qgvAEQRCqC5PcNP7wIUNE7KnxjrbsVUoLMpACTVzo4uxKCNkH
	fqfQVUIzNeoCmXQjaFuhZ38/9vy6bIT7mBWrMmiuW0KBWvHWeR3WDTAcDWmg0ltRKAIuCKkruTm
	OZJV44jLk/YzpPLd2j8J7SHcsev4SYG5M0Jr534cY3IajoSA==
X-Received: by 2002:a92:d44b:0:b0:365:1741:368a with SMTP id r11-20020a92d44b000000b003651741368amr12755566ilm.9.1708463632521;
        Tue, 20 Feb 2024 13:13:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQHfFFFQi+5jyZhIRSgW+/zNgY3K04fYutOjwm4yoJA/8s6eBB8ooIMmvjkW1NR1lsXBZB7w==
X-Received: by 2002:a92:d44b:0:b0:365:1741:368a with SMTP id r11-20020a92d44b000000b003651741368amr12755547ilm.9.1708463632165;
        Tue, 20 Feb 2024 13:13:52 -0800 (PST)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id j3-20020a05663822c300b00472f79e0001sm2244895jat.171.2024.02.20.13.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 13:13:51 -0800 (PST)
Message-ID: <2d1374cc-6b52-49ff-97d5-670709f54eae@redhat.com>
Date: Tue, 20 Feb 2024 15:13:50 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
 Bill O'Donnell <billodo@redhat.com>, Christian Brauner <brauner@kernel.org>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] Convert coda to use the new mount API
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From: David Howells <dhowells@redhat.com>

Convert the coda filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.rst for more information.

Note this is slightly tricky as coda currently only has a binary mount data
interface.  This is handled through the parse_monolithic hook.

Also add a more conventional interface with a parameter named "fd" that
takes an fd that refers to a coda psdev, thereby specifying the index to
use.

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
[sandeen: forward port to current upstream mount API interfaces]
Tested-by: Jan Harkes <jaharkes@cs.cmu.edu>
cc: coda@cs.cmu.edu

---

NB: This updated patch is based on 
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=mount-api-viro&id=4aec2ba3ca543e39944604774b8cab9c4d592651

hence the From: David above.

 fs/coda/inode.c | 140 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 98 insertions(+), 42 deletions(-)

diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 0c7c2528791e..479c45b7b621 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -24,6 +24,8 @@
 #include <linux/pid_namespace.h>
 #include <linux/uaccess.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/vmalloc.h>
 
 #include <linux/coda.h>
@@ -87,10 +89,10 @@ void coda_destroy_inodecache(void)
 	kmem_cache_destroy(coda_inode_cachep);
 }
 
-static int coda_remount(struct super_block *sb, int *flags, char *data)
+static int coda_reconfigure(struct fs_context *fc)
 {
-	sync_filesystem(sb);
-	*flags |= SB_NOATIME;
+	sync_filesystem(fc->root->d_sb);
+	fc->sb_flags |= SB_NOATIME;
 	return 0;
 }
 
@@ -102,78 +104,105 @@ static const struct super_operations coda_super_operations =
 	.evict_inode	= coda_evict_inode,
 	.put_super	= coda_put_super,
 	.statfs		= coda_statfs,
-	.remount_fs	= coda_remount,
 };
 
-static int get_device_index(struct coda_mount_data *data)
+struct coda_fs_context {
+	int	idx;
+};
+
+enum {
+	Opt_fd,
+};
+
+static const struct fs_parameter_spec coda_param_specs[] = {
+	fsparam_fd	("fd",	Opt_fd),
+	{}
+};
+
+static int coda_parse_fd(struct fs_context *fc, int fd)
 {
+	struct coda_fs_context *ctx = fc->fs_private;
 	struct fd f;
 	struct inode *inode;
 	int idx;
 
-	if (data == NULL) {
-		pr_warn("%s: Bad mount data\n", __func__);
-		return -1;
-	}
-
-	if (data->version != CODA_MOUNT_VERSION) {
-		pr_warn("%s: Bad mount version\n", __func__);
-		return -1;
-	}
-
-	f = fdget(data->fd);
+	f = fdget(fd);
 	if (!f.file)
-		goto Ebadf;
+		return -EBADF;
 	inode = file_inode(f.file);
 	if (!S_ISCHR(inode->i_mode) || imajor(inode) != CODA_PSDEV_MAJOR) {
 		fdput(f);
-		goto Ebadf;
+		return invalf(fc, "code: Not coda psdev");
 	}
 
 	idx = iminor(inode);
 	fdput(f);
 
-	if (idx < 0 || idx >= MAX_CODADEVS) {
-		pr_warn("%s: Bad minor number\n", __func__);
-		return -1;
+	if (idx < 0 || idx >= MAX_CODADEVS)
+		return invalf(fc, "coda: Bad minor number");
+	ctx->idx = idx;
+	return 0;
+}
+
+static int coda_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, coda_param_specs, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_fd:
+		return coda_parse_fd(fc, result.uint_32);
 	}
 
-	return idx;
-Ebadf:
-	pr_warn("%s: Bad file\n", __func__);
-	return -1;
+	return 0;
 }
 
-static int coda_fill_super(struct super_block *sb, void *data, int silent)
+/*
+ * Parse coda's binary mount data form.  We ignore any errors and go with index
+ * 0 if we get one for backward compatibility.
+ */
+static int coda_parse_monolithic(struct fs_context *fc, void *_data)
 {
+	struct coda_mount_data *data = _data;
+
+	if (!data)
+		return invalf(fc, "coda: Bad mount data");
+
+	if (data->version != CODA_MOUNT_VERSION)
+		return invalf(fc, "coda: Bad mount version");
+
+	coda_parse_fd(fc, data->fd);
+	return 0;
+}
+
+static int coda_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct coda_fs_context *ctx = fc->fs_private;
 	struct inode *root = NULL;
 	struct venus_comm *vc;
 	struct CodaFid fid;
 	int error;
-	int idx;
 
 	if (task_active_pid_ns(current) != &init_pid_ns)
 		return -EINVAL;
 
-	idx = get_device_index((struct coda_mount_data *) data);
+	infof(fc, "coda: device index: %i\n", ctx->idx);
 
-	/* Ignore errors in data, for backward compatibility */
-	if(idx == -1)
-		idx = 0;
-	
-	pr_info("%s: device index: %i\n", __func__,  idx);
-
-	vc = &coda_comms[idx];
+	vc = &coda_comms[ctx->idx];
 	mutex_lock(&vc->vc_mutex);
 
 	if (!vc->vc_inuse) {
-		pr_warn("%s: No pseudo device\n", __func__);
+		errorf(fc, "coda: No pseudo device");
 		error = -EINVAL;
 		goto unlock_out;
 	}
 
 	if (vc->vc_sb) {
-		pr_warn("%s: Device already mounted\n", __func__);
+		errorf(fc, "coda: Device already mounted");
 		error = -EBUSY;
 		goto unlock_out;
 	}
@@ -313,18 +342,45 @@ static int coda_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0; 
 }
 
-/* init_coda: used by filesystems.c to register coda */
+static int coda_get_tree(struct fs_context *fc)
+{
+	if (task_active_pid_ns(current) != &init_pid_ns)
+		return -EINVAL;
 
-static struct dentry *coda_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	return get_tree_nodev(fc, coda_fill_super);
+}
+
+static void coda_free_fc(struct fs_context *fc)
+{
+	kfree(fc->fs_private);
+}
+
+static const struct fs_context_operations coda_context_ops = {
+	.free		= coda_free_fc,
+	.parse_param	= coda_parse_param,
+	.parse_monolithic = coda_parse_monolithic,
+	.get_tree	= coda_get_tree,
+	.reconfigure	= coda_reconfigure,
+};
+
+static int coda_init_fs_context(struct fs_context *fc)
 {
-	return mount_nodev(fs_type, flags, data, coda_fill_super);
+	struct coda_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct coda_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	fc->fs_private = ctx;
+	fc->ops = &coda_context_ops;
+	return 0;
 }
 
 struct file_system_type coda_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "coda",
-	.mount		= coda_mount,
+	.init_fs_context = coda_init_fs_context,
+	.parameters	= coda_param_specs,
 	.kill_sb	= kill_anon_super,
 	.fs_flags	= FS_BINARY_MOUNTDATA,
 };
-- 
2.43.0



