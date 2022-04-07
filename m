Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853514F8632
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 19:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346321AbiDGRaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 13:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347138AbiDGR3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:29:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EA81CC;
        Thu,  7 Apr 2022 10:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D988B82866;
        Thu,  7 Apr 2022 17:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309CEC385A0;
        Thu,  7 Apr 2022 17:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649352357;
        bh=Rp3AAoZEhUXKlTVXiDR+mPUkgeKRvkK4oqYwes7kndQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gWQ64C7AQq2qeuiSBgl1jzN4NKdMOKiOM1lCktHxNnt+ofZPc0ubfuIDzVi3nMged
         ICHE8PuoiY3tinYIvbjvCtWMVZZrt9bs7MxK3esTxrJY9BGu1zSLKNdTwy3kG4wFfT
         L6ttYBQ5VG7l1Z/J+id9AUzk8C6z3CsmThwb4eC7eIA8Myyny3lSGyXUN1c99tiLzl
         Coao53kPZU/PK2gLw5JMhSAJHGiYcfBJiZAVsrobY/5swxwb5bBJRPX8LoDkMOxZ4+
         8R1DF2o0IJpc5yfuCS5CcjvEWWfB0+fxeeHO8Dt81WJvw/uahMx9jB1MdimM3gFTXW
         llvTQ26Q6yEsg==
Message-ID: <1e94ae620fcd96f149dc025ceffc66119b70f473.camel@kernel.org>
Subject: Re: [PATCH v4] VFS: filename_create(): fix incorrect intent.
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Disseldorp <ddiss@suse.de>
Date:   Thu, 07 Apr 2022 13:25:55 -0400
In-Reply-To: <164878611050.25542.6758961460499392000@noble.neil.brown.name>
References: <164877264126.25542.1271530843099472952@noble.neil.brown.name>
         <164878611050.25542.6758961460499392000@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-04-01 at 15:08 +1100, NeilBrown wrote:
> When asked to create a path ending '/', but which is not to be a
> directory (LOOKUP_DIRECTORY not set), filename_create() will never try
> to create the file.  If it doesn't exist, -ENOENT is reported.
> 
> However, it still passes LOOKUP_CREATE|LOOKUP_EXCL to the filesystems
> ->lookup() function, even though there is no intent to create.  This is
> misleading and can cause incorrect behaviour.
> 
> If you try
>    ln -s foo /path/dir/
> 
> where 'dir' is a directory on an NFS filesystem which is not currently
> known in the dcache, this will fail with ENOENT.
> As the name is not in the dcache, nfs_lookup gets called with
> LOOKUP_CREATE|LOOKUP_EXCL and so it returns NULL without performing any
> lookup, with the expectation that a subsequent call to create the
> target will be made, and the lookup can be combined with the creation.
> In the case with a trailing '/' and no LOOKUP_DIRECTORY, that call is never
> made.  Instead filename_create() sees that the dentry is not (yet)
> positive and returns -ENOENT - even though the directory actually
> exists.
> 
> So only set LOOKUP_CREATE|LOOKUP_EXCL if there really is an intent
> to create, and use the absence of these flags to decide if -ENOENT
> should be returned.
> 
> Note that filename_parentat() is only interested in LOOKUP_REVAL, so we
> split that out and store it in 'reval_flag'.
> __looku_hash() then gets reval_flag combined with whatever create flags
> were determined to be needed.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/namei.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> ARG - v3 had a missing semi-colon.  Sorry.
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 3f1829b3ab5b..509657fdf4f5 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3673,18 +3673,14 @@ static struct dentry *filename_create(int dfd, struct filename *name,
>  {
>  	struct dentry *dentry = ERR_PTR(-EEXIST);
>  	struct qstr last;
> +	bool want_dir = lookup_flags & LOOKUP_DIRECTORY;
> +	unsigned int reval_flag = lookup_flags & LOOKUP_REVAL;
> +	unsigned int create_flags = LOOKUP_CREATE | LOOKUP_EXCL;
>  	int type;
>  	int err2;
>  	int error;
> -	bool is_dir = (lookup_flags & LOOKUP_DIRECTORY);
>  
> -	/*
> -	 * Note that only LOOKUP_REVAL and LOOKUP_DIRECTORY matter here. Any
> -	 * other flags passed in are ignored!
> -	 */
> -	lookup_flags &= LOOKUP_REVAL;
> -
> -	error = filename_parentat(dfd, name, lookup_flags, path, &last, &type);
> +	error = filename_parentat(dfd, name, reval_flag, path, &last, &type);
>  	if (error)
>  		return ERR_PTR(error);
>  
> @@ -3698,11 +3694,13 @@ static struct dentry *filename_create(int dfd, struct filename *name,
>  	/* don't fail immediately if it's r/o, at least try to report other errors */
>  	err2 = mnt_want_write(path->mnt);
>  	/*
> -	 * Do the final lookup.
> +	 * Do the final lookup.  Suppress 'create' if there is a trailing
> +	 * '/', and a directory wasn't requested.
>  	 */
> -	lookup_flags |= LOOKUP_CREATE | LOOKUP_EXCL;
> +	if (last.name[last.len] && !want_dir)
> +		create_flags = 0;
>  	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
> -	dentry = __lookup_hash(&last, path->dentry, lookup_flags);
> +	dentry = __lookup_hash(&last, path->dentry, reval_flag | create_flags);
>  	if (IS_ERR(dentry))
>  		goto unlock;
>  
> @@ -3716,7 +3714,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
>  	 * all is fine. Let's be bastards - you had / on the end, you've
>  	 * been asking for (non-existent) directory. -ENOENT for you.
>  	 */
> -	if (unlikely(!is_dir && last.name[last.len])) {
> +	if (unlikely(!create_flags)) {
>  		error = -ENOENT;
>  		goto fail;
>  	}

Reviewed-by: Jeff Layton <jlayton@kernel.org>
