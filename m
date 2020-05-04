Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1541C3532
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 11:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgEDJAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 05:00:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46407 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728194AbgEDJAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 05:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588582849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pYARjpihRrtKHuBd7iM95rQrsYmHI/OYPL0qU7wB4t0=;
        b=S8RlAGasqMqZXaQHiiH02Vbf9OWF5Z9CxFXgnJn+jxca5j2vMckD0xc6lvP1YVY7NKCLES
        H0+O5mv+ugHa3lQEaFkDFIARioEqVxdCczOvE34yDBlOG4c9ctNPz0r62Pgc7oYTz+W1oe
        4voQ77nId7STm2XynQQZ2BsSBkxSRvU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-f5KL50jQPJqgy4i7D3FdSA-1; Mon, 04 May 2020 05:00:47 -0400
X-MC-Unique: f5KL50jQPJqgy4i7D3FdSA-1
Received: by mail-wr1-f72.google.com with SMTP id x8so1658718wrl.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 02:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYARjpihRrtKHuBd7iM95rQrsYmHI/OYPL0qU7wB4t0=;
        b=B+eWDmdn0kz6Or/AfOeTSLZJK5Vj0UH/TOuKP/W870ze4ioI6pZUAB0oFpQh0rrhQR
         DcoFGFl8vTBLsyZsF/anseQZm7LW3tMjj8vHw9s2b3IkACXI2uKnSJfG9EE8f3XuH4MZ
         85GH5sBkJaODEX2IL+jbF19uXrb0ayi62umEj5gwsNKru1XLDC7RP3fBymvzs8S3dbQi
         4tRqCj3ulBn8r08ZXNlTlE+o07ivNhek1XLVAQJqT3bByLWYw0zwkJU1aCDvADZJ8kve
         pD3rcD/o9oZ1swtBa0D4SOxBgc8HmxEH6qVaTbQIlOSRGi0APJ6OLhVc0ARF7ulJxujR
         z19g==
X-Gm-Message-State: AGi0PuY37bzBm22fbrSL50NpE9+3dEkCvVDqksXhGnAQl12G11DzGZrX
        llUqKAMaW2vis9s6cycR0OhUNaZmmQQiSNZ+xDUUwHdVizs78Q5DIRUv4Ocb+5N8veN3cTDHdGK
        CDiQldF2LS1SZOMJnivpEMMxqLA==
X-Received: by 2002:a5d:6ca7:: with SMTP id a7mr612104wra.391.1588582846143;
        Mon, 04 May 2020 02:00:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypJAvfUqvdhS8WNoWyou/iLyp7nXSbFY8lynVG1+fNVeY9be6X5BocsAcNWcvzsjKPIsWwC3iw==
X-Received: by 2002:a5d:6ca7:: with SMTP id a7mr612075wra.391.1588582845898;
        Mon, 04 May 2020 02:00:45 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.213])
        by smtp.gmail.com with ESMTPSA id u127sm12984720wme.8.2020.05.04.02.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 02:00:45 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v3 7/7] tracefs: switch to simplefs inode creation API
Date:   Mon,  4 May 2020 11:00:32 +0200
Message-Id: <20200504090032.10367-8-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200504090032.10367-1-eesposit@redhat.com>
References: <20200504090032.10367-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove tracefs_get_inode(), since it will be substituted
by new_inode_current_time() in the simplefs_create_dentry call.

There is no semantic change intended; the code in the libfs.c
functions in fact was derived from debugfs and tracefs code.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 fs/tracefs/inode.c | 96 ++++------------------------------------------
 1 file changed, 7 insertions(+), 89 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 370eb38ff1ad..4a9a05e94c15 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -124,16 +124,6 @@ static const struct inode_operations tracefs_dir_inode_operations = {
 	.rmdir		= tracefs_syscall_rmdir,
 };
 
-static struct inode *tracefs_get_inode(struct super_block *sb)
-{
-	struct inode *inode = new_inode(sb);
-	if (inode) {
-		inode->i_ino = get_next_ino();
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
-	}
-	return inode;
-}
-
 struct tracefs_mount_opts {
 	kuid_t uid;
 	kgid_t gid;
@@ -308,57 +298,6 @@ static struct file_system_type trace_fs_type = {
 };
 MODULE_ALIAS_FS("tracefs");
 
-static struct dentry *start_creating(const char *name, struct dentry *parent)
-{
-	struct dentry *dentry;
-	int error;
-
-	pr_debug("tracefs: creating file '%s'\n",name);
-
-	error = simple_pin_fs(&tracefs, &trace_fs_type);
-	if (error)
-		return ERR_PTR(error);
-
-	/* If the parent is not specified, we create it in the root.
-	 * We need the root dentry to do this, which is in the super
-	 * block. A pointer to that is in the struct vfsmount that we
-	 * have around.
-	 */
-	if (!parent)
-		parent = tracefs.mount->mnt_root;
-
-	inode_lock(parent->d_inode);
-	if (unlikely(IS_DEADDIR(parent->d_inode)))
-		dentry = ERR_PTR(-ENOENT);
-	else
-		dentry = lookup_one_len(name, parent, strlen(name));
-	if (!IS_ERR(dentry) && dentry->d_inode) {
-		dput(dentry);
-		dentry = ERR_PTR(-EEXIST);
-	}
-
-	if (IS_ERR(dentry)) {
-		inode_unlock(parent->d_inode);
-		simple_release_fs(&tracefs);
-	}
-
-	return dentry;
-}
-
-static struct dentry *failed_creating(struct dentry *dentry)
-{
-	inode_unlock(dentry->d_parent->d_inode);
-	dput(dentry);
-	simple_release_fs(&tracefs);
-	return NULL;
-}
-
-static struct dentry *end_creating(struct dentry *dentry)
-{
-	inode_unlock(dentry->d_parent->d_inode);
-	return dentry;
-}
-
 /**
  * tracefs_create_file - create a file in the tracefs filesystem
  * @name: a pointer to a string containing the name of the file to create.
@@ -395,49 +334,28 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	if (security_locked_down(LOCKDOWN_TRACEFS))
 		return NULL;
 
-	if (!(mode & S_IFMT))
-		mode |= S_IFREG;
-	BUG_ON(!S_ISREG(mode));
-	dentry = start_creating(name, parent);
-
+	dentry = simplefs_create_file(&tracefs, &trace_fs_type,
+				      name, mode, parent, data, &inode);
 	if (IS_ERR(dentry))
 		return NULL;
 
-	inode = tracefs_get_inode(dentry->d_sb);
-	if (unlikely(!inode))
-		return failed_creating(dentry);
-
-	inode->i_mode = mode;
 	inode->i_fop = fops ? fops : &tracefs_file_operations;
-	inode->i_private = data;
-	d_instantiate(dentry, inode);
-	fsnotify_create(dentry->d_parent->d_inode, dentry);
-	return end_creating(dentry);
+	return simplefs_finish_dentry(dentry, inode);
 }
 
 static struct dentry *__create_dir(const char *name, struct dentry *parent,
 				   const struct inode_operations *ops)
 {
-	struct dentry *dentry = start_creating(name, parent);
+	struct dentry *dentry;
 	struct inode *inode;
 
+	dentry = simplefs_create_dir(&tracefs, &trace_fs_type,
+				     name, 0755, parent, &inode);
 	if (IS_ERR(dentry))
 		return NULL;
 
-	inode = tracefs_get_inode(dentry->d_sb);
-	if (unlikely(!inode))
-		return failed_creating(dentry);
-
-	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
 	inode->i_op = ops;
-	inode->i_fop = &simple_dir_operations;
-
-	/* directory inodes start off with i_nlink == 2 (for "." entry) */
-	inc_nlink(inode);
-	d_instantiate(dentry, inode);
-	inc_nlink(dentry->d_parent->d_inode);
-	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
-	return end_creating(dentry);
+	return simplefs_finish_dentry(dentry, inode);
 }
 
 /**
-- 
2.25.2

