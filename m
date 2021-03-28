Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C14334BDE0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Mar 2021 20:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhC1SH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Mar 2021 14:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhC1SHF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Mar 2021 14:07:05 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB0DC061756;
        Sun, 28 Mar 2021 11:07:05 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lQZoU-000UU0-Fw; Sun, 28 Mar 2021 18:07:02 +0000
Date:   Sun, 28 Mar 2021 18:07:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/18] vfs: add fileattr ops
Message-ID: <YGDFxh7+724niztd@zeniv-ca.linux.org.uk>
References: <20210325193755.294925-1-mszeredi@redhat.com>
 <20210325193755.294925-2-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325193755.294925-2-mszeredi@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 08:37:38PM +0100, Miklos Szeredi wrote:

> +int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
> +{
> +	struct inode *inode = d_inode(dentry);
> +
> +	if (d_is_special(dentry))
> +		return -ENOTTY;

FWIW - why?  For uses via ioctl() you simply won't get there with
device nodes et.al. - they have file_operations of their own.
If we add syscall(s) for getting/setting those, there's no reason
for e.g. a device node not to have those attributes...

> +static int ioctl_getflags(struct file *file, void __user *argp)

unsigned int __user *argp, surely?

> +{
> +	struct fileattr fa = { .flags_valid = true }; /* hint only */
> +	unsigned int flags;
> +	int err;
> +
> +	err = vfs_fileattr_get(file->f_path.dentry, &fa);
> +	if (!err) {
> +		flags = fa.flags;
> +		if (copy_to_user(argp, &flags, sizeof(flags)))
> +			err = -EFAULT;

... and put_user() here.

> +	}
> +	return err;
> +}
> +
> +static int ioctl_setflags(struct file *file, void __user *argp)
> +{
> +	struct fileattr fa;
> +	unsigned int flags;
> +	int err;
> +
> +	if (copy_from_user(&flags, argp, sizeof(flags)))
> +		return -EFAULT;
> +
> +	err = mnt_want_write_file(file);
> +	if (!err) {
> +		fileattr_fill_flags(&fa, flags);
> +		err = vfs_fileattr_set(file_mnt_user_ns(file), file_dentry(file), &fa);
> +		mnt_drop_write_file(file);
> +	}
> +	return err;
> +}

Similar here.
