Return-Path: <linux-fsdevel+bounces-39569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E50CA15AEC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 02:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FDB188B726
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 01:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966CF3398B;
	Sat, 18 Jan 2025 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vnYCK/4C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18821EED7
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jan 2025 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737164678; cv=none; b=XtbdKKaGOb9TSteVrhzmF31PjbAjMPC0l8KajNX18Bq+GMxcVCUr1jYmNS2HsGGFRNrpkCdh63KIt31TWdBf9ijZ+Rr+kVB5tHLoQl/H+zPL8ISIMwmVaXbOdo4pc8EtKXlDUBqDW/40APAkdwQ1OqT2byAhL+DML2kRX1iKtEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737164678; c=relaxed/simple;
	bh=EMBY+cRvNJ+Dr/SNlVQ+h52dhVeCOd2ZCeLF3Xcx0+A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=af0jpr0+YjPcDRT+JIG4bT7E0qc41hNO+11Gp5ytl/fNyIQ5wG7XV3wTnhxFaPGt34yS6TQHI2GhLjL1Av+sYq1flO2WK4eTcZaqH3sae04sLfPmKOOY0wf3jemohUVc5HdC7/8UvAG2QmFevq1Nnft5WJlZSP6g2Fr04YEW7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vnYCK/4C; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=tS4GR78Zf1WYHN42B9f/TUnJcc/Q1/pdBpR9oVD43Js=; b=vnYCK/4C9brQMU2qaiJDtPclTV
	7KY802457UP9Uh/OVjYUAfmrj2ZmwSAMTQp1a+xWjLr4/kgc9PcR8DAt2Jzt9f1fWhS3MCqD+EUpw
	GCuwgWQaxokKIHEcA9EZdfm+yhN31jjmhdUQO5Q6xnyySHLEzA3AhymV/gi11OiNLBGstAe9OQgYu
	0UF20bBOV0SE6vQJtwNG20e4OaBF5ngHu47dSRLyAvRuaHj6x3K0NWTzxG/Mlby9L3mTFZar3E34/
	a1LhZ44kOZ/PytaimTUfuHJAbxFAGH6ZBBP0YRVM98Y6BKUmRlFAS/ZS21D51nfYuqVe5B9iAFf/j
	wG6PbTTQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYxt4-00000003jlW-0tnh;
	Sat, 18 Jan 2025 01:44:34 +0000
Date: Sat, 18 Jan 2025 01:44:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH][RFC] make use of anon_inode_getfile_fmode()
Message-ID: <20250118014434.GT1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

["fallen through the cracks" misc stuff]

A bunch of anon_inode_getfile() callers follow it with adjusting
->f_mode; we have a helper doing that now, so let's make use
of it.
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/arch/powerpc/platforms/pseries/papr-vpd.c b/arch/powerpc/platforms/pseries/papr-vpd.c
index 1574176e3ffc..c86950d7105a 100644
--- a/arch/powerpc/platforms/pseries/papr-vpd.c
+++ b/arch/powerpc/platforms/pseries/papr-vpd.c
@@ -482,14 +482,13 @@ static long papr_vpd_create_handle(struct papr_location_code __user *ulc)
 		goto free_blob;
 	}
 
-	file = anon_inode_getfile("[papr-vpd]", &papr_vpd_handle_ops,
-				  (void *)blob, O_RDONLY);
+	file = anon_inode_getfile_fmode("[papr-vpd]", &papr_vpd_handle_ops,
+				  (void *)blob, O_RDONLY,
+				  FMODE_LSEEK | FMODE_PREAD);
 	if (IS_ERR(file)) {
 		err = PTR_ERR(file);
 		goto put_fd;
 	}
-
-	file->f_mode |= FMODE_LSEEK | FMODE_PREAD;
 	fd_install(fd, file);
 	return fd;
 put_fd:
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 49559605177e..c321d442f0da 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -266,24 +266,12 @@ static struct file *vfio_device_open_file(struct vfio_device *device)
 	if (ret)
 		goto err_free;
 
-	/*
-	 * We can't use anon_inode_getfd() because we need to modify
-	 * the f_mode flags directly to allow more than just ioctls
-	 */
-	filep = anon_inode_getfile("[vfio-device]", &vfio_device_fops,
-				   df, O_RDWR);
+	filep = anon_inode_getfile_fmode("[vfio-device]", &vfio_device_fops,
+				   df, O_RDWR, FMODE_PREAD | FMODE_PWRITE);
 	if (IS_ERR(filep)) {
 		ret = PTR_ERR(filep);
 		goto err_close_device;
 	}
-
-	/*
-	 * TODO: add an anon_inode interface to do this.
-	 * Appears to be missing by lack of need rather than
-	 * explicitly prevented.  Now there's need.
-	 */
-	filep->f_mode |= (FMODE_PREAD | FMODE_PWRITE);
-
 	/*
 	 * Use the pseudo fs inode on the device to link all mmaps
 	 * to the same address space, allowing us to unmap all vmas
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index fe3de9ad57bf..d9bc67176128 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -317,8 +317,9 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req,
 		goto err_free_id;
 	}
 
-	anon_file->file = anon_inode_getfile("[cachefiles]",
-				&cachefiles_ondemand_fd_fops, object, O_WRONLY);
+	anon_file->file = anon_inode_getfile_fmode("[cachefiles]",
+				&cachefiles_ondemand_fd_fops, object,
+				O_WRONLY, FMODE_PWRITE | FMODE_LSEEK);
 	if (IS_ERR(anon_file->file)) {
 		ret = PTR_ERR(anon_file->file);
 		goto err_put_fd;
@@ -333,8 +334,6 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req,
 		goto err_put_file;
 	}
 
-	anon_file->file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
-
 	load = (void *)req->msg.data;
 	load->fd = anon_file->fd;
 	object->ondemand->ondemand_id = object_id;
diff --git a/fs/eventfd.c b/fs/eventfd.c
index 76129bfcd663..af42b2c7d235 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -406,14 +406,13 @@ static int do_eventfd(unsigned int count, int flags)
 	if (fd < 0)
 		goto err;
 
-	file = anon_inode_getfile("[eventfd]", &eventfd_fops, ctx, flags);
+	file = anon_inode_getfile_fmode("[eventfd]", &eventfd_fops,
+					ctx, flags, FMODE_NOWAIT);
 	if (IS_ERR(file)) {
 		put_unused_fd(fd);
 		fd = PTR_ERR(file);
 		goto err;
 	}
-
-	file->f_mode |= FMODE_NOWAIT;
 	fd_install(fd, file);
 	return fd;
 err:
diff --git a/fs/signalfd.c b/fs/signalfd.c
index d1a5f43ce466..d469782f97f4 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -277,15 +277,14 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
 			return ufd;
 		}
 
-		file = anon_inode_getfile("[signalfd]", &signalfd_fops, ctx,
-				       O_RDWR | (flags & O_NONBLOCK));
+		file = anon_inode_getfile_fmode("[signalfd]", &signalfd_fops,
+					ctx, O_RDWR | (flags & O_NONBLOCK),
+					FMODE_NOWAIT);
 		if (IS_ERR(file)) {
 			put_unused_fd(ufd);
 			kfree(ctx);
 			return PTR_ERR(file);
 		}
-		file->f_mode |= FMODE_NOWAIT;
-
 		fd_install(ufd, file);
 	} else {
 		CLASS(fd, f)(ufd);
diff --git a/fs/timerfd.c b/fs/timerfd.c
index 9f7eb451a60f..753e22e83e0f 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -439,15 +439,15 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 		return ufd;
 	}
 
-	file = anon_inode_getfile("[timerfd]", &timerfd_fops, ctx,
-				    O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS));
+	file = anon_inode_getfile_fmode("[timerfd]", &timerfd_fops, ctx,
+			    O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS),
+			    FMODE_NOWAIT);
 	if (IS_ERR(file)) {
 		put_unused_fd(ufd);
 		kfree(ctx);
 		return PTR_ERR(file);
 	}
 
-	file->f_mode |= FMODE_NOWAIT;
 	fd_install(ufd, file);
 	return ufd;
 }
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index de2c11dae231..0ba0ffc4abc9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4222,15 +4222,14 @@ static int kvm_vcpu_ioctl_get_stats_fd(struct kvm_vcpu *vcpu)
 	if (fd < 0)
 		return fd;
 
-	file = anon_inode_getfile(name, &kvm_vcpu_stats_fops, vcpu, O_RDONLY);
+	file = anon_inode_getfile_fmode(name, &kvm_vcpu_stats_fops, vcpu,
+					O_RDONLY, FMODE_PREAD);
 	if (IS_ERR(file)) {
 		put_unused_fd(fd);
 		return PTR_ERR(file);
 	}
 
 	kvm_get_kvm(vcpu->kvm);
-
-	file->f_mode |= FMODE_PREAD;
 	fd_install(fd, file);
 
 	return fd;
@@ -4982,16 +4981,14 @@ static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
 	if (fd < 0)
 		return fd;
 
-	file = anon_inode_getfile("kvm-vm-stats",
-			&kvm_vm_stats_fops, kvm, O_RDONLY);
+	file = anon_inode_getfile_fmode("kvm-vm-stats",
+			&kvm_vm_stats_fops, kvm, O_RDONLY, FMODE_PREAD);
 	if (IS_ERR(file)) {
 		put_unused_fd(fd);
 		return PTR_ERR(file);
 	}
 
 	kvm_get_kvm(kvm);
-
-	file->f_mode |= FMODE_PREAD;
 	fd_install(fd, file);
 
 	return fd;

