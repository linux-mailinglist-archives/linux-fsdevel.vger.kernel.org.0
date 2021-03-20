Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDAA342DE1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 16:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhCTPmk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 11:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCTPmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:42:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D7EC061574;
        Sat, 20 Mar 2021 08:42:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x21so14276139eds.4;
        Sat, 20 Mar 2021 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8C4TkW2VBo+3wK2nTKB/hjLpyDt3GndZ24G33/9RjKE=;
        b=Jt7RAU1zd4P2MJfFTYCqrXYCCJ7Rx1CDq+xC1Txde5GC5vI5Ta5g1+jN+ENXbm0l98
         WtecMcS4Ah2vcZWwpWXN5uiGNbeFum4r1cUBtwbVHv9qCCgjEBTbxAo8PeMz3gF5kjDs
         GEQme3rn+zRMVbD5XFns3qkqAb/sFcnGOkvIEKJBLEyKmuOhdLQaY0Qtf6CI+Tb2itlu
         Qrrx196n1B8grOj0uyp+oqZKulIATBQ37aLTHUZEMoCTE5a8jAAwA2h9MoWCbSCfHU3d
         AChPbxWC9I9S2Vjs+0PI5Mg2cyifGVvbMa1HI+AYtoI3aMXULloPsa1hvXv1VmbMBOxR
         tbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8C4TkW2VBo+3wK2nTKB/hjLpyDt3GndZ24G33/9RjKE=;
        b=nnLdfS2zr8cJCJPolvpSfR4qNQ3GJ/vcR9nYNGnDMeP0AQ7WfpMQ9vJ3KHslefcwLj
         G0wo1VkSfQb5oulWONxtws/4XCtRqKOKxRdXvzZei98YAWfiHT5JfRpWr6BMARRxKADd
         Qj6P23UwrnDSOW+CMc56Zq77ta8P1WtyBJfTE7g8efy5FTdKWgQSPCeJn357NniHvUZA
         IjdR8n+LHqIRA27fxDh0JF8KUcEWmsCxvNxcOuxRhiOaKpRJn0X/gsaGt9CxHQ5GJTRD
         QUetUCUlRF/AjUh8Z7X4Lqd9HXuDLR3tzf5x06ZxYEYa89IjowwY159Vvv26AIJkDcPg
         t6AQ==
X-Gm-Message-State: AOAM532Y3kABZTaTnkkq5dHFb0gcfZVVArK3DJJgl68438jYm/uWGwIO
        vTdD64QZGgWRFKYh4n7M4w==
X-Google-Smtp-Source: ABdhPJz8foQU11+dUCQqanKqqZJdjFyPuN86QEk3bDOkpGUzdJmwJTAgt65RUoYa/3vsk9pCXErJHw==
X-Received: by 2002:aa7:cf02:: with SMTP id a2mr15888733edy.59.1616254930344;
        Sat, 20 Mar 2021 08:42:10 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.213])
        by smtp.gmail.com with ESMTPSA id a9sm6456336eds.33.2021.03.20.08.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 08:42:09 -0700 (PDT)
Date:   Sat, 20 Mar 2021 18:42:08 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: mandate ->proc_lseek in "struct proc_ops"
Message-ID: <YFYX0Bzwxlc7aBa/@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that proc_ops are separate from file_operations and other
operations it easy to check all instances to have ->proc_lseek
hook and remove check in main code.

Note:
nonseekable_open() files naturally don't require ->proc_lseek.

Garbage collect pde_lseek() function.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/isdn/capi/kcapi_proc.c                     |    1 +
 drivers/net/wireless/intersil/hostap/hostap_proc.c |    1 +
 drivers/scsi/esas2r/esas2r_main.c                  |    1 +
 fs/proc/inode.c                                    |   14 ++------------
 include/linux/proc_fs.h                            |    1 +
 5 files changed, 6 insertions(+), 12 deletions(-)

--- a/drivers/isdn/capi/kcapi_proc.c
+++ b/drivers/isdn/capi/kcapi_proc.c
@@ -201,6 +201,7 @@ static ssize_t empty_read(struct file *file, char __user *buf,
 
 static const struct proc_ops empty_proc_ops = {
 	.proc_read	= empty_read,
+	.proc_lseek	= default_llseek,
 };
 
 // ---------------------------------------------------------------------------
--- a/drivers/net/wireless/intersil/hostap/hostap_proc.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_proc.c
@@ -227,6 +227,7 @@ static ssize_t prism2_aux_dump_proc_no_read(struct file *file, char __user *buf,
 
 static const struct proc_ops prism2_aux_dump_proc_ops = {
 	.proc_read	= prism2_aux_dump_proc_no_read,
+	.proc_lseek	= default_llseek,
 };
 
 
--- a/drivers/scsi/esas2r/esas2r_main.c
+++ b/drivers/scsi/esas2r/esas2r_main.c
@@ -617,6 +617,7 @@ static const struct file_operations esas2r_proc_fops = {
 };
 
 static const struct proc_ops esas2r_proc_ops = {
+	.proc_lseek		= default_llseek,
 	.proc_ioctl		= esas2r_proc_ioctl,
 #ifdef CONFIG_COMPAT
 	.proc_compat_ioctl	= compat_ptr_ioctl,
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -273,25 +273,15 @@ void proc_entry_rundown(struct proc_dir_entry *de)
 	spin_unlock(&de->pde_unload_lock);
 }
 
-static loff_t pde_lseek(struct proc_dir_entry *pde, struct file *file, loff_t offset, int whence)
-{
-	typeof_member(struct proc_ops, proc_lseek) lseek;
-
-	lseek = pde->proc_ops->proc_lseek;
-	if (!lseek)
-		lseek = default_llseek;
-	return lseek(file, offset, whence);
-}
-
 static loff_t proc_reg_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	loff_t rv = -EINVAL;
 
 	if (pde_is_permanent(pde)) {
-		return pde_lseek(pde, file, offset, whence);
+		return pde->proc_ops->proc_lseek(file, offset, whence);
 	} else if (use_pde(pde)) {
-		rv = pde_lseek(pde, file, offset, whence);
+		rv = pde->proc_ops->proc_lseek(file, offset, whence);
 		unuse_pde(pde);
 	}
 	return rv;
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -32,6 +32,7 @@ struct proc_ops {
 	ssize_t	(*proc_read)(struct file *, char __user *, size_t, loff_t *);
 	ssize_t (*proc_read_iter)(struct kiocb *, struct iov_iter *);
 	ssize_t	(*proc_write)(struct file *, const char __user *, size_t, loff_t *);
+	/* mandatory unless nonseekable_open() or equivalent is used */
 	loff_t	(*proc_lseek)(struct file *, loff_t, int);
 	int	(*proc_release)(struct inode *, struct file *);
 	__poll_t (*proc_poll)(struct file *, struct poll_table_struct *);
