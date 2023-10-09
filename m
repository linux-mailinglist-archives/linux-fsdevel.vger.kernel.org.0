Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29377BD496
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 09:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345414AbjJIHsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 03:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345320AbjJIHsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:48:21 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA2494;
        Mon,  9 Oct 2023 00:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vb1vjFzwjE9V8nM/BKjhlaTaIwglgMTOZCzTOnxL/M4=; b=C/BWyY4ujVAN6x/F583Mfpa5BN
        aHdK2b8m3F7M60A5C1AnEmSw4sYn62+ToWu9jEaHKh0oC243tztnwpkXxEHaIePWCd1TB7z54ySGs
        Du1yUj8leX6M1pzRaZKQSTaiHffAJx5JFdPl1C94aKHqhspgn5opm1cEbtIDZyom8JLtHxoI5DUUW
        VuC1ZbYPvzqn25YsVgZN2kUlz/RzZm6HoDQXhZ53Jmqn3O6wU1FkkDoGjwKdUL1VofehpxoNwe69R
        6IiqhP5uZ5iVLp1Km35MBriry9SWN6Uh6yoJt12P/mLkc2RSZkFBc3UELiGsGuLKlbQfZ4vzadoSl
        ybjG7s8A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qpkzp-00H89q-2L;
        Mon, 09 Oct 2023 07:48:09 +0000
Date:   Mon, 9 Oct 2023 08:48:09 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] fs: store real path instead of fake path in
 backing file f_path
Message-ID: <20231009074809.GH800259@ZenIV>
References: <20231007084433.1417887-1-amir73il@gmail.com>
 <20231007084433.1417887-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007084433.1417887-4-amir73il@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 07, 2023 at 11:44:33AM +0300, Amir Goldstein wrote:

> -		if (real_path->mnt)
> -			mnt_put_write_access(real_path->mnt);
> +		if (user_path->mnt)
> +			mnt_put_write_access(user_path->mnt);
>  	}
>  }

Again, how can the predicates be ever false here?  We should *not*
have struct path with NULL .mnt unless it's {NULL, NULL} pair.

For the record, struct path with NULL .dentry and non-NULL .mnt
*IS* possible, but only in a very narrow area - if, during
an attempt to fall back from rcu pathwalk to normal one we
have __legitimize_path() successfully validate (== grab) the
reference to mount, but fail to validate dentry.  In that
case we need to drop mount, but not dentry when we get to
cleanup (pretty much as soon as we drop rcu_read_lock()).
That gets indicated by clearing path->dentry, and only
while we are propagating the error back to the point where
references would be dropped.  No filesystem code should
ever see struct path instances in that state.

Please, don't make the things more confusing; "incomplete"
struct path like that are very much not normal (and this
variety is flat-out impossible).


> @@ -34,9 +34,18 @@ static struct dentry *ovl_d_real(struct dentry *dentry,
>  	struct dentry *real = NULL, *lower;
>  	int err;
>  
> -	/* It's an overlay file */
> +	/*
> +	 * vfs is only expected to call d_real() with NULL from d_real_inode()
> +	 * and with overlay inode from file_dentry() on an overlay file.
> +	 *
> +	 * TODO: remove @inode argument from d_real() API, remove code in this
> +	 * function that deals with non-NULL @inode and remove d_real() call
> +	 * from file_dentry().
> +	 */
>  	if (inode && d_inode(dentry) == inode)
>  		return dentry;
> +	else
> +		WARN_ON_ONCE(inode);
>  
>  	if (!d_is_reg(dentry)) {
>  		if (!inode || inode == d_inode(dentry))
		   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	BTW, that condition is confusing as hell (both before and
after this patch).  AFAICS, it's a pointlessly obfuscated
		if (!inode)
Look: we get to evaluating that test only if we hadn't buggered
off on
 	if (inode && d_inode(dentry) == inode)
 		return dentry;
above.  Which means that either inode is NULL (in which case the
evaluation yields true as soon as we see that !inode is true) or
it's neither NULL nor equal to d_inode(dentry).  In which case
we see that !inode is false and proceed yield false *after*
comparing inode with d_inode(dentry) and seeing that they
are not equal.

<checks history>
e8c985bace13 "ovl: deal with overlay files in ovl_d_real()"
had introduced the first check, and nobody noticed that the
older check below could've been simplified.  Oh, well...

> -static inline const struct path *file_real_path(struct file *f)
> +static inline const struct path *f_path(struct file *f)
>  {
> -	if (unlikely(f->f_mode & FMODE_BACKING))
> -		return backing_file_real_path(f);
>  	return &f->f_path;
>  }

Bad name, IMO - makes grepping harder and... what the hell do
we need it for, anyway?  You have only one caller, and no
obvious reason why it would be worse off as path = &file->f_path...
