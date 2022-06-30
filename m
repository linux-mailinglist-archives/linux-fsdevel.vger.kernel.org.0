Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9A85626C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 01:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiF3XKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 19:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiF3XKe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:10:34 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3371058FEC;
        Thu, 30 Jun 2022 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PLnX+GdiFq0h5m7XxJGkEoRQcXwyc8nFGHPUn3RIA68=; b=DONAnasQ0yvPgsBJkOz9zo+fop
        6HB95NCmxtbegAsvEMNEF/V90e76fDOkTxUK9lwlhAMa395kOpj33EYQqt3LVUiMdgebzjU8V3IfT
        kZD469AenC21vxxaaes2+2vhbayHa2Fq6Yuh3V1rS6GO0QdOvYc/SsGHHrDMsfxsTEScwXTDD3Epj
        rAL8mIesWjBOzYo5IF6JzwznaT4wqiNo0lRD3qYwYzrwUMiKLcOoc51vkCmo4sD2hteg7k9rqa3XI
        l3V8DefBid9ZOHUMLCllhBcb7pAycMYEXUOb+Ll5xs1q1AoMwx5VXgoO9AO+wHNaBKZU42Y7BmQYT
        dkdQB6rQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o73I3-006iv9-RN;
        Thu, 30 Jun 2022 23:09:40 +0000
Date:   Fri, 1 Jul 2022 00:09:39 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
Subject: Re: [PATCH v2 3/9] mm/mshare: make msharefs writable and support
 directories
Message-ID: <Yr4tM2oOF9rlwWdV@ZenIV>
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <397ad80630444b90877625a1e94dd81392fc678e.1656531090.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <397ad80630444b90877625a1e94dd81392fc678e.1656531090.git.khalid.aziz@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:53:54PM -0600, Khalid Aziz wrote:

> +static int
> +msharefs_open(struct inode *inode, struct file *file)
> +{
> +	return simple_open(inode, file);
> +}

Again, whatever for?

> +static struct dentry
> +*msharefs_alloc_dentry(struct dentry *parent, const char *name)
> +{
> +	struct dentry *d;
> +	struct qstr q;
> +	int err;
> +
> +	q.name = name;
> +	q.len = strlen(name);
> +
> +	err = msharefs_d_hash(parent, &q);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	d = d_alloc(parent, &q);
> +	if (d)
> +		return d;
> +
> +	return ERR_PTR(-ENOMEM);
> +}

And it's different from d_alloc_name() how, exactly?

> +		case S_IFLNK:
> +			inode->i_op = &page_symlink_inode_operations;
> +			break;

Really?  You've got symlinks here?

> +		default:
> +			discard_new_inode(inode);
> +			inode = NULL;

That's an odd way to spell BUG()...

> +static int
> +msharefs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
> +		struct dentry *dentry, umode_t mode, dev_t dev)
> +{
> +	struct inode *inode;
> +	int err = 0;
> +
> +	inode = msharefs_get_inode(dir->i_sb, dir, mode);
> +	if (IS_ERR(inode))
> +		return PTR_ERR(inode);
> +
> +	d_instantiate(dentry, inode);
> +	dget(dentry);
> +	dir->i_mtime = dir->i_ctime = current_time(dir);
> +
> +	return err;
> +}

BTW, what's the point of having device nodes on that thing?

> +static int
> +msharefs_create(struct user_namespace *mnt_userns, struct inode *dir,
> +		struct dentry *dentry, umode_t mode, bool excl)
> +{
> +	return msharefs_mknod(&init_user_ns, dir, dentry, mode | S_IFREG, 0);
> +}
> +
> +static int
> +msharefs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
> +		struct dentry *dentry, umode_t mode)
> +{
> +	int ret = msharefs_mknod(&init_user_ns, dir, dentry, mode | S_IFDIR, 0);
> +
> +	if (!ret)
> +		inc_nlink(dir);
> +	return ret;
> +}
> +
> +static const struct inode_operations msharefs_file_inode_ops = {
> +	.setattr	= simple_setattr,
> +	.getattr	= simple_getattr,
> +};
> +static const struct inode_operations msharefs_dir_inode_ops = {
> +	.create		= msharefs_create,
> +	.lookup		= simple_lookup,
> +	.link		= simple_link,
> +	.unlink		= simple_unlink,
> +	.mkdir		= msharefs_mkdir,
> +	.rmdir		= simple_rmdir,
> +	.mknod		= msharefs_mknod,
> +	.rename		= simple_rename,
> +};
> +
>  static void
>  mshare_evict_inode(struct inode *inode)
>  {
> @@ -58,7 +175,7 @@ mshare_info_read(struct file *file, char __user *buf, size_t nbytes,
>  {
>  	char s[80];
>  
> -	sprintf(s, "%ld", PGDIR_SIZE);
> +	sprintf(s, "%ld\n", PGDIR_SIZE);
>  	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
>  }
>  
> @@ -72,6 +189,38 @@ static const struct super_operations mshare_s_ops = {
>  	.evict_inode = mshare_evict_inode,
>  };
>  
> +static int
> +prepopulate_files(struct super_block *s, struct inode *dir,
> +			struct dentry *root, const struct tree_descr *files)
> +{
> +	int i;
> +	struct inode *inode;
> +	struct dentry *dentry;
> +
> +	for (i = 0; !files->name || files->name[0]; i++, files++) {
> +		if (!files->name)
> +			continue;
> +
> +		dentry = msharefs_alloc_dentry(root, files->name);
> +		if (!dentry)
> +			return -ENOMEM;
> +
> +		inode = msharefs_get_inode(s, dir, S_IFREG | files->mode);
> +		if (!inode) {
> +			dput(dentry);
> +			return -ENOMEM;
> +		}
> +		inode->i_mode = S_IFREG | files->mode;
> +		inode->i_atime = inode->i_mtime = inode->i_ctime
> +			= current_time(inode);
> +		inode->i_fop = files->ops;
> +		inode->i_ino = i;
> +		d_add(dentry, inode);
> +	}
> +
> +	return 0;
> +}

Looks remarkably similar to something I've seen somewhere... fs/libfs.c,
if I'm not mistaken...

Sarcasm aside, what's wrong with using simple_fill_super()?
