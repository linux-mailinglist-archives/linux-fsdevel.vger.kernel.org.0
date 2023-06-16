Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82FC732891
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 09:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbjFPHPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 03:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjFPHPk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:15:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4FA170E;
        Fri, 16 Jun 2023 00:15:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3588C6732D; Fri, 16 Jun 2023 09:15:35 +0200 (CEST)
Date:   Fri, 16 Jun 2023 09:15:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v5 4/5] fs: use backing_file container for internal
 files with "fake" f_path
Message-ID: <20230616071534.GD29590@lst.de>
References: <20230615112229.2143178-1-amir73il@gmail.com> <20230615112229.2143178-5-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615112229.2143178-5-amir73il@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -	if (!(f->f_mode & FMODE_NOACCOUNT))
> +	if (unlikely(f->f_mode & FMODE_BACKING))
> +		path_put(backing_file_real_path(f));
> +	else
>  		percpu_counter_dec(&nr_files);

This is still missing the earlier pointed out fix that we still need
the FMODE_NOACCOUNT check, isn't it?

> + * This is only for kernel internal use, and the allocate file must not be
> + * installed into file tables or such.

I'd use the same blurb I'd suggest for the previous patch here as well.

> +/**
> + * backing_file_open - open a backing file for kernel internal use
> + * @path:	path of the file to open
> + * @flags:	open flags
> + * @path:	path of the backing file
> + * @cred:	credentials for open
> + *
> + * Open a file whose f_inode != d_inode(f_path.dentry).
> + * the returned struct file is embedded inside a struct backing_file
> + * container which is used to store the @real_path of the inode.
> + * The @real_path can be accessed by backing_file_real_path() and the
> + * real dentry can be accessed with file_dentry().
> + * The kernel internal backing file is not accounted in nr_files.
> + * This is only for kernel internal use, and must not be installed into
> + * file tables or such.
> + */

I still find this comment not very descriptive.  Here is my counter
suggestion, which I'm also not totally happy with, and which might not
even be factually correct as I'm trying to understand the use case a bit
better by reading the code:

 * Open a backing file for a stackable file system (e.g. overlayfs).
 * For these backing files that reside on the underlying file system, we still
 * want to be able to return the path of the upper file in the stackable file
 * system.  This is done by embedding the returned file into a container
 * structure that also stores the path on the upper file system, which can be
 * retreived using backing_file_real_path().
 *
 * The return file is not accounted in nr_files and must not be installed
 * into the file descriptor table.

> +static inline const struct path *f_real_path(struct file *f)

Question from an earlier revision: why f_real_path and not file_real_path?

Also this really needs a kerneldoc comment explaining when it should
be used.
