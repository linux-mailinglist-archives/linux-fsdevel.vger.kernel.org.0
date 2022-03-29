Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101934EB0A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 17:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbiC2PcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 11:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbiC2Pbn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:31:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0B922BD65;
        Tue, 29 Mar 2022 08:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87864B81822;
        Tue, 29 Mar 2022 15:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F08C34100;
        Tue, 29 Mar 2022 15:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648567782;
        bh=s6QFngRKTdzfWqby9Q7qhm3LAPigtTrz8FN57k1o9Ek=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZfSO5Nsp7zhXyGAnehSrnslfin73EjMCIkg4UMuFiq2ZsmKslq6LxoPrVHxOjp1Q+
         GaZX8WCMeSge5ccKfAwcdsCcgeaK7buINLhp7+qWBDPjBjwJHRttnXq8lstvV/L5Zl
         guohsxrugbZ3Nt1lDVKbc2OtAQeS+/aiSebuzG0jU2LYlTqyh8jZBv/bzjoy/6TM8e
         YvDQoXQ0UQvukOBcrVLzBKGl8OOs6wQ0IIpR7WBPINHHdAqvgyXLT2qhyAlJfeGg45
         kJuOENP9EE7QgIUZB7NXpWfDrwpQA0Pi/VIBFJNj57P7r+7Lg4v8QuNjA7BgG59SgK
         rQ8idfRHHXuvw==
Message-ID: <5cd07fc3f5db2a082f3b3f8e412274f672b1317b.camel@kernel.org>
Subject: Re: [PATCH] VFS: filename_create(): fix incorrect intent.
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 29 Mar 2022 11:29:40 -0400
In-Reply-To: <164842900895.6096.10753358086437966517@noble.neil.brown.name>
References: <164842900895.6096.10753358086437966517@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-03-28 at 11:56 +1100, NeilBrown wrote:
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
> lookup, with the expectation that as subsequent call to create the
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
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/namei.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 3f1829b3ab5b..3ffb42e56a8e 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3676,7 +3676,6 @@ static struct dentry *filename_create(int dfd, struct filename *name,
>  	int type;
>  	int err2;
>  	int error;
> -	bool is_dir = (lookup_flags & LOOKUP_DIRECTORY);
>  
>  	/*
>  	 * Note that only LOOKUP_REVAL and LOOKUP_DIRECTORY matter here. Any
> @@ -3698,9 +3697,11 @@ static struct dentry *filename_create(int dfd, struct filename *name,
>  	/* don't fail immediately if it's r/o, at least try to report other errors */
>  	err2 = mnt_want_write(path->mnt);
>  	/*
> -	 * Do the final lookup.
> +	 * Do the final lookup.  Request 'create' only if there is no trailing
> +	 * '/', or if directory is requested.
>  	 */
> -	lookup_flags |= LOOKUP_CREATE | LOOKUP_EXCL;
> +	if (!last.name[last.len] || (lookup_flags & LOOKUP_DIRECTORY))
> +		lookup_flags |= LOOKUP_CREATE | LOOKUP_EXCL;
>  	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
>  	dentry = __lookup_hash(&last, path->dentry, lookup_flags);
>  	if (IS_ERR(dentry))
> @@ -3716,7 +3717,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
>  	 * all is fine. Let's be bastards - you had / on the end, you've
>  	 * been asking for (non-existent) directory. -ENOENT for you.
>  	 */
> -	if (unlikely(!is_dir && last.name[last.len])) {
> +	if (!likely(lookup_flags & LOOKUP_CREATE)) {
>  		error = -ENOENT;
>  		goto fail;
>  	}

Seems like a sane enough fix. Nice catch.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
