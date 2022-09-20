Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9638D5BD9AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 03:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiITBu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 21:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiITBu6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:50:58 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D298501B0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 18:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hrph1pQA4/jXlka37+W3i3svomopuL8bSVintTjo46k=; b=CgxZLKmOzy6gODja9K5wQI1kwK
        xjrSt/mS9o9A203jX87IbfWDzqrJZh6oLmnc8j/xPWlQ+VVbQ+n/mrFEv8j/1Qihcu3nJioRZDJVB
        lFeyeTSnwIAvt/u54MxZ0uvnf/SulBMq0vxFistp4zVg5TjW0azzaTC8tdQYa6Bfhb7ahi1msaLBq
        ERePoNZAQNXqnX/1fHy9IHZ8Qru2gNs8HjrsN7fFTQsBVH887H+l1kDgLQw6/45OIeJSrmR/tdWEK
        UvMTc182cFMYgVIYeK38SJbxuz872pwvCF23t30o2PL5+hOsKqZnLRZKj5fO8r+MugoBDWNucnEBG
        Df5D+Mig==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oaSPW-001RUM-2Z;
        Tue, 20 Sep 2022 01:50:54 +0000
Date:   Tue, 20 Sep 2022 02:50:54 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v2 7/8] vfs: open inside ->tmpfile()
Message-ID: <YykcfkzECotV882O@ZenIV>
References: <20220919141031.1834447-1-mszeredi@redhat.com>
 <20220919141031.1834447-8-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919141031.1834447-8-mszeredi@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 19, 2022 at 04:10:30PM +0200, Miklos Szeredi wrote:
> This is in preparation for adding tmpfile support to fuse, which requires
> that the tmpfile creation and opening are done as a single operation.
> 
> Replace the 'struct dentry *' argument of i_op->tmpfile with
> 'struct file *'.
> 
> Call finish_open_simple() as the last thing in ->tmpfile() instances (may be
> omitted in the error case).
> 
> Change d_tmpfile() argument to 'struct file *' as well to make callers more
> readable.

It really needs to add to Documentation/filesystems/porting.

> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -889,7 +889,7 @@ static int do_hugetlbfs_mknod(struct inode *dir,
>  			struct dentry *dentry,
>  			umode_t mode,
>  			dev_t dev,
> -			bool tmpfile)
> +			struct file *tmpfile)
>  {
>  	struct inode *inode;
>  	int error = -ENOSPC;
> @@ -898,7 +898,7 @@ static int do_hugetlbfs_mknod(struct inode *dir,
>  	if (inode) {
>  		dir->i_ctime = dir->i_mtime = current_time(dir);
>  		if (tmpfile) {
> -			d_tmpfile(dentry, inode);
> +			d_tmpfile(tmpfile, inode);
>  		} else {
>  			d_instantiate(dentry, inode);
>  			dget(dentry);/* Extra count - pin the dentry in core */
> @@ -911,7 +911,7 @@ static int do_hugetlbfs_mknod(struct inode *dir,
>  static int hugetlbfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
>  			   struct dentry *dentry, umode_t mode, dev_t dev)
>  {
> -	return do_hugetlbfs_mknod(dir, dentry, mode, dev, false);
> +	return do_hugetlbfs_mknod(dir, dentry, mode, dev, NULL);
>  }
>  
>  static int hugetlbfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
> @@ -932,10 +932,12 @@ static int hugetlbfs_create(struct user_namespace *mnt_userns,
>  }
>  
>  static int hugetlbfs_tmpfile(struct user_namespace *mnt_userns,
> -			     struct inode *dir, struct dentry *dentry,
> +			     struct inode *dir, struct file *file,
>  			     umode_t mode)
>  {
> -	return do_hugetlbfs_mknod(dir, dentry, mode | S_IFREG, 0, true);
> +	int err = do_hugetlbfs_mknod(dir, file->f_path.dentry, mode | S_IFREG, 0, file);
> +
> +	return finish_open_simple(file, err);
>  }
>  
>  static int hugetlbfs_symlink(struct user_namespace *mnt_userns,

I would prefer to separate tmpfile from mknod in that one.  And to hell
with the last argument in do_hugetlbfs_mknod().  Something like (completely
untested) patch below as prereq:

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index f7a5b5124d8a..0b458beb318c 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -885,33 +885,18 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 /*
  * File creation. Allocate an inode, and we're done..
  */
-static int do_hugetlbfs_mknod(struct inode *dir,
-			struct dentry *dentry,
-			umode_t mode,
-			dev_t dev,
-			bool tmpfile)
+static int hugetlbfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+			   struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	struct inode *inode;
-	int error = -ENOSPC;
 
 	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode, dev);
-	if (inode) {
-		dir->i_ctime = dir->i_mtime = current_time(dir);
-		if (tmpfile) {
-			d_tmpfile(dentry, inode);
-		} else {
-			d_instantiate(dentry, inode);
-			dget(dentry);/* Extra count - pin the dentry in core */
-		}
-		error = 0;
-	}
-	return error;
-}
-
-static int hugetlbfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
-			   struct dentry *dentry, umode_t mode, dev_t dev)
-{
-	return do_hugetlbfs_mknod(dir, dentry, mode, dev, false);
+	if (!inode)
+		return -ENOSPC;
+	dir->i_ctime = dir->i_mtime = current_time(dir);
+	d_instantiate(dentry, inode);
+	dget(dentry);/* Extra count - pin the dentry in core */
+	return 0;
 }
 
 static int hugetlbfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
@@ -935,7 +920,14 @@ static int hugetlbfs_tmpfile(struct user_namespace *mnt_userns,
 			     struct inode *dir, struct dentry *dentry,
 			     umode_t mode)
 {
-	return do_hugetlbfs_mknod(dir, dentry, mode | S_IFREG, 0, true);
+	struct inode *inode;
+
+	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode | S_IFREG, 0);
+	if (!inode)
+		return -ENOSPC;
+	dir->i_ctime = dir->i_mtime = current_time(dir);
+	d_tmpfile(dentry, inode);
+	return 0;
 }
 
 static int hugetlbfs_symlink(struct user_namespace *mnt_userns,
