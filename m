Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6EA4F5C23
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 13:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242060AbiDFL1E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 07:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241115AbiDFL0f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:26:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D309355CFE8;
        Wed,  6 Apr 2022 01:13:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4DED31F38A;
        Wed,  6 Apr 2022 08:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649232794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/rBcyoDoTq/ouUuDrmZ5BU4RlZeCyQlpcb/fLfqi5+g=;
        b=dJ+xoXpY08wKZSxp4z1Y5Osm1Twl7YrbmzMZrDi+X2woMiKeABbNRwulYBc2qOF6dH3brs
        MNTVdkTWKIpEhYzVo45ZPk4swaf0E52Z+v/2uKVyVQI5xbozxEx46EpwHv1IkCHg1/P9MJ
        oeOBCZNuC7mWz+jnAtWnLkdd6TkHf0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649232794;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/rBcyoDoTq/ouUuDrmZ5BU4RlZeCyQlpcb/fLfqi5+g=;
        b=+cHhjmj0LF7iVvf9KUfF3wuUVkHwKWOHOJ0OtTa9gm6FBswBsRelBd0noj2RXLYYVFYpeZ
        Z7ZFBZ+7OjnqgnCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1266A13A8E;
        Wed,  6 Apr 2022 08:13:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ik0hA5pLTWJeYAAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 06 Apr 2022 08:13:14 +0000
Date:   Wed, 6 Apr 2022 10:13:11 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     "NeilBrown" <neilb@suse.de>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v4] VFS: filename_create(): fix incorrect intent.
Message-ID: <20220406101311.502aa172@suse.de>
In-Reply-To: <164878611050.25542.6758961460499392000@noble.neil.brown.name>
References: <164877264126.25542.1271530843099472952@noble.neil.brown.name>
        <164878611050.25542.6758961460499392000@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 01 Apr 2022 15:08:30 +1100, NeilBrown wrote:

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

It'd be helpful if we could run these sorts of tests from the xfstests
suite. I wonder whether some sort of other-client ssh backchannel would
be useful (for cifs.ko and cephfs too).

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

nit: __lookup_hash()

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

Looks good and works for me.
Reviewed-by: David Disseldorp <ddiss@suse.de>
