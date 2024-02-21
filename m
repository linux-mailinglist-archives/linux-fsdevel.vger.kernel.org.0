Return-Path: <linux-fsdevel+bounces-12276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E2B85E186
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 16:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97A01C208DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 15:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5CF8063A;
	Wed, 21 Feb 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEGoJtq8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24C8060A
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530024; cv=none; b=FKugKg/KesREy9uHioudrOPdBe/OMvN260mq/rodknPx473fssiWufj4IPqcyO/h0YCaS7jB7Vfp0Yuk+mg2ddBCKi/TfIms4+A2YFyUK7vNwOBcd1rSiNdFm/u4KKm6G4LKw44R6H9fJJl7xXqyjFxoFjiwoOJ3MkS91YchgZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530024; c=relaxed/simple;
	bh=11BfD+MCY6Y+9SESMnYBe/3YCvfkPbA1sUVkHSpW/Cg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sQMRoGxqWDlsPISm8vP0V7SxKLk4GUsGmwxTpjpfH2dKeJ12zHccgnGRl262lky5YPqEghMwLUMoQVamojOqWCh+SqDFa2DlucsNGdD699dldvlBlMlKku8LBV1ES6bfBbP1CHDg0Wmz/x+0CfWYaBSirauU0Y5csPIXb3QfzRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WEGoJtq8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708530021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wI6a6AhnjPcQiRlAb6glD4TWiIKDjy5BpYxe+G0O8w=;
	b=WEGoJtq8jD+RNlceXAbC1sNWAMi0cMmJsVjZPJRre3xbIuaSQ2QxGqcMIJXAuIzxIeXbz5
	QSkI/OFUS9vtq/ZEHC40AuHg5Jh3QGkn7GiCVUDaRFm0f47nHYG8KhuEoY+pTmGY2CxmBh
	j0Lhhq5RcUbl+5lwkuR49b2OZweyr1I=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-pp0ci5rVPcmVrm2rXHwwPw-1; Wed, 21 Feb 2024 10:40:08 -0500
X-MC-Unique: pp0ci5rVPcmVrm2rXHwwPw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c0001148c3so575662039f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 07:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530006; x=1709134806;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wI6a6AhnjPcQiRlAb6glD4TWiIKDjy5BpYxe+G0O8w=;
        b=B4BAvBKDxAyL7y43XyzlFMJNXbJOD1DOK1JbNu7+38ymQf+9x73dOvK5ZlXIRCgU5g
         ga+OCmFJkFN5ZY9tcwZvdNdsWhth+K8O/wrvkPha8mo1xAKR/vD8N9J+l8XoICSgRkU/
         oKyGVvm4OLTka21ep2iXWdi3ipvMeL0m2in3hL4YiGRCTyeVIJd32nT+aGMJKuWDItzi
         pu0++EjZEikbMiZyJVAssuWIfbmXPOuEvAOjYGJvfpBdtEy6qfepY3TZiWMLvkRi2f7a
         L1LMukszMg/ISU4i68kcUbBoFAbfApQrK+v/aRw8eoJNodPIcQQpjpeJihwItbrihBWQ
         Phqg==
X-Gm-Message-State: AOJu0YyD1CzyRJOQzzA3EGAMalgNuub4G1m2S62WBPqrX06zDg4nESPn
	iw53kDW1QKzrRMgACM0EHDbxDsIYISYhoRBDJ9yT8JarODXg1ys5ZRM8rKNpqO/c5lhkhTFCWEk
	8fIz60bXps2cFVZZSiEDbo+kr3llj/0RphypOrze4UlXNEaWX4WuVUnlvW/91CMVgyQ6WVFDMVA
	YlJRRRuOnL5c4HaJbCY3Htq0Kf/pi9scl7Ro3uP8XZXBwh+Q==
X-Received: by 2002:a92:c80f:0:b0:365:2230:b2e4 with SMTP id v15-20020a92c80f000000b003652230b2e4mr11931672iln.14.1708530006566;
        Wed, 21 Feb 2024 07:40:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWDr9LbCpj3LzvDYuvQI2bXzKbP7QlVn4lHx/lU25nhKMk+BzuE6iDSzGKANRKiSzGW3xljw==
X-Received: by 2002:a92:c80f:0:b0:365:2230:b2e4 with SMTP id v15-20020a92c80f000000b003652230b2e4mr11931656iln.14.1708530006161;
        Wed, 21 Feb 2024 07:40:06 -0800 (PST)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id j7-20020a05663822c700b004742adef7a1sm1582211jat.112.2024.02.21.07.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:40:05 -0800 (PST)
Message-ID: <97650eeb-94c7-4041-b58c-90e81e76b699@redhat.com>
Date: Wed, 21 Feb 2024 09:40:03 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH V2] Convert coda to use the new mount API
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
 Bill O'Donnell <billodo@redhat.com>, Christian Brauner <brauner@kernel.org>
References: <2d1374cc-6b52-49ff-97d5-670709f54eae@redhat.com>
In-Reply-To: <2d1374cc-6b52-49ff-97d5-670709f54eae@redhat.com>
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

V2: Remove extra task_active_pid_ns check from fill_super() that I missed
(note that Jan did not test with this change)

NB: This updated patch is based on 
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=mount-api-viro&id=4aec2ba3ca543e39944604774b8cab9c4d592651

hence the From: David above.

 fs/coda/inode.c | 143 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 98 insertions(+), 45 deletions(-)

diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 0c7c2528791e..a50356c541f6 100644
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
 
@@ -102,78 +104,102 @@ static const struct super_operations coda_super_operations =
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
+}
+
+/*
+ * Parse coda's binary mount data form.  We ignore any errors and go with index
+ * 0 if we get one for backward compatibility.
+ */
+static int coda_parse_monolithic(struct fs_context *fc, void *_data)
+{
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
 }
 
-static int coda_fill_super(struct super_block *sb, void *data, int silent)
+static int coda_fill_super(struct super_block *sb, struct fs_context *fc)
 {
+	struct coda_fs_context *ctx = fc->fs_private;
 	struct inode *root = NULL;
 	struct venus_comm *vc;
 	struct CodaFid fid;
 	int error;
-	int idx;
-
-	if (task_active_pid_ns(current) != &init_pid_ns)
-		return -EINVAL;
-
-	idx = get_device_index((struct coda_mount_data *) data);
 
-	/* Ignore errors in data, for backward compatibility */
-	if(idx == -1)
-		idx = 0;
-	
-	pr_info("%s: device index: %i\n", __func__,  idx);
+	infof(fc, "coda: device index: %i\n", ctx->idx);
 
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
@@ -313,18 +339,45 @@ static int coda_statfs(struct dentry *dentry, struct kstatfs *buf)
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
 {
-	return mount_nodev(fs_type, flags, data, coda_fill_super);
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
+{
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


