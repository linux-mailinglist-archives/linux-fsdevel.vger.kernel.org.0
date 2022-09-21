Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8D65BF8A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 10:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiIUIJP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 04:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiIUIJO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:09:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBCC85ABF
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 01:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF1A162279
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 08:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59380C433D6;
        Wed, 21 Sep 2022 08:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663747752;
        bh=yxWPBFTmhWirCxjc383ICQlwv1Fs2k46dbh+XeCRdXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVQsxDZ6GjZnn975kQDfgeaGW5EbezWa7XGYV/dw/W5DOz4MgDdyUbf6zn4uyqYkc
         YV9zqD7gYzqjAxXQlohnVzrTIQrh8TOooI/PD+c06eyvuQFlBkck9AoDhC2BPaHycm
         /7n0WiC2JldmU6/64Di2HvrtMhxrHd1YkBErenAASsxvBw2shDttYMcP2GGFywcA/i
         Porus3ljPtcqMK9llthQUwbGlXroqgXVVthZweraGRbj2NspkTsYQ7qH1IlJaC4rmI
         QPpgcbUa8hdXruNV8Aukg84kIhpzXgPGTkJnT9ccC72ZG5gcKQRFIF5SF1JX7P6gMl
         5ul0KA5Q4F7IA==
Date:   Wed, 21 Sep 2022 10:09:02 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v3 3/9] vfs: add tmpfile_open() helper
Message-ID: <20220921080902.wbjbsrlwj3frrot3@wittgenstein>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
 <20220920193632.2215598-4-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920193632.2215598-4-mszeredi@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:36:26PM +0200, Miklos Szeredi wrote:
> This helper unifies tmpfile creation with opening.
> 
> Existing vfs_tmpfile() callers outside of fs/namei.c will be converted to
> using this helper.  There are two such callers: cachefile and overlayfs.
> 
> The cachefiles code currently uses the open_with_fake_path() helper to open
> the tmpfile, presumably to disable accounting of the open file.  Overlayfs
> uses tmpfile for copy_up, which means these struct file instances will be
> short lived, hence it doesn't really matter if they are accounted or not.
> Disable accounting in this helper to, which should be okay for both caller.
> 
> Add MAY_OPEN permission checking for consistency.  Like for create(2)
> read/write permissions are not checked.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/namei.c         | 41 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  4 ++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 53b4bc094db2..5e4a0c59eef6 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3624,6 +3624,47 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
>  }
>  EXPORT_SYMBOL(vfs_tmpfile);
>  
> +/**
> + * tmpfile_open - open a tmpfile for kernel internal use
> + * @mnt_userns:	user namespace of the mount the inode was found from
> + * @parentpath:	path of the base directory
> + * @mode:	mode of the new tmpfile
> + * @open_flag:	flags
> + * @cred:	credentials for open
> + *
> + * Create and open a temporary file.  The file is not accounted in nr_files,
> + * hence this is only for kernel internal use, and must not be installed into
> + * file tables or such.
> + */
> +struct file *tmpfile_open(struct user_namespace *mnt_userns,
> +			  const struct path *parentpath,
> +			  umode_t mode, int open_flag, const struct cred *cred)
> +{
> +	struct file *file;
> +	int error;
> +	struct path path = { .mnt = parentpath->mnt };
> +
> +	path.dentry = vfs_tmpfile(mnt_userns, parentpath->dentry, mode, open_flag);
> +	if (IS_ERR(path.dentry))
> +		return ERR_CAST(path.dentry);
> +
> +	error = may_open(mnt_userns, &path, 0, open_flag);
> +	file = ERR_PTR(error);
> +	if (error)
> +		goto out_dput;
> +
> +	/*
> +	 * This relies on the "noaccount" property of fake open, otherwise
> +	 * equivalent to dentry_open().
> +	 */
> +	file = open_with_fake_path(&path, open_flag, d_inode(path.dentry), cred);
> +out_dput:
> +	dput(path.dentry);
> +
> +	return file;
> +}
> +EXPORT_SYMBOL(tmpfile_open);

Feels like this could be simplified while being equally legible to
something like:

/**
 * tmpfile_open - open a tmpfile for kernel internal use
 * @mnt_userns:	user namespace of the mount the inode was found from
 * @parentpath:	path of the base directory
 * @mode:	mode of the new tmpfile
 * @open_flag:	flags
 * @cred:	credentials for open
 *
 * Create and open a temporary file.  The file is not accounted in nr_files,
 * hence this is only for kernel internal use, and must not be installed into
 * file tables or such.
 *
 * The helper relies on the "noaccount" property of open_with_fake_path().
 * Otherwise it is equivalent to dentry_open().
 *
 * Return: Opened tmpfile on success, error pointer on failure.
 */
struct file *tmpfile_open(struct user_namespace *mnt_userns,
			  const struct path *parentpath,
			  umode_t mode, int open_flag, const struct cred *cred)
{
	struct file *file;
	int error;
	struct path path = { .mnt = parentpath->mnt };

	path.dentry = vfs_tmpfile(mnt_userns, parentpath->dentry, mode, open_flag);
	if (IS_ERR(path.dentry))
		return ERR_CAST(path.dentry);

	error = may_open(mnt_userns, &path, 0, open_flag);
	if (!error)
		file = open_with_fake_path(&path, open_flag, d_inode(path.dentry), cred);
	else
		file = ERR_PTR(error);
	dput(path.dentry);
	return file;
}
EXPORT_SYMBOL(tmpfile_open);
