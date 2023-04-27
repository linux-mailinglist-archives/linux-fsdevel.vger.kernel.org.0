Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131DF6F0526
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 13:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243694AbjD0Lsx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 07:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242961AbjD0Lsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:48:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC89FA8;
        Thu, 27 Apr 2023 04:48:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5709321AED;
        Thu, 27 Apr 2023 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682596130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9pShv+zjTWSRAZ+oHqUB7CbDWUj57qhhbL44EosO+l4=;
        b=clSFyKuyskXNCr4ylgVN0cfWefDtMgVHJ8w/QZqtoItFWC3zkS0RGfE01gyV4fCkKH9yK8
        +xkSGVH5eRIyMeVjHABYQ8IMJWJbUlQRHUr1iAvnXS1T/RBhvOEVt8vylnz/PEm1Flu0ut
        bwpCCJyOkoopL9E2QVxt7OVCUocypbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682596130;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9pShv+zjTWSRAZ+oHqUB7CbDWUj57qhhbL44EosO+l4=;
        b=98dWMwrzz8mIUciuXQbPUCemjR4t7zJ20i6vELna9tv3vzHgKQGxarYWJfGR9MzLpTXJfH
        cc+IHpmerGe3mJDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 483FA138F9;
        Thu, 27 Apr 2023 11:48:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xJShESJhSmTdQAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 27 Apr 2023 11:48:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D2C95A0729; Thu, 27 Apr 2023 13:48:49 +0200 (CEST)
Date:   Thu, 27 Apr 2023 13:48:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH 4/4] fanotify: support reporting non-decodeable file
 handles
Message-ID: <20230427114849.cv3kzxk7rvxpohjc@quack3>
References: <20230425130105.2606684-1-amir73il@gmail.com>
 <20230425130105.2606684-5-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425130105.2606684-5-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 25-04-23 16:01:05, Amir Goldstein wrote:
> fanotify users do not always need to decode the file handles reported
> with FAN_REPORT_FID.
> 
> Relax the restriction that filesystem needs to support NFS export and
> allow reporting file handles from filesystems that only support ecoding
> unique file handles.
> 
> For such filesystems, users will have to use the AT_HANDLE_FID of
> name_to_handle_at(2) if they want to compare the object in path to the
> object fid reported in an event.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
...
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 8f430bfad487..a5af84cbb30d 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1586,11 +1586,9 @@ static int fanotify_test_fid(struct dentry *dentry)
>  	 * We need to make sure that the file system supports at least
>  	 * encoding a file handle so user can use name_to_handle_at() to
>  	 * compare fid returned with event to the file handle of watched
> -	 * objects. However, name_to_handle_at() requires that the
> -	 * filesystem also supports decoding file handles.
> +	 * objects, but it does not need to support decoding file handles.
>  	 */
> -	if (!dentry->d_sb->s_export_op ||
> -	    !dentry->d_sb->s_export_op->fh_to_dentry)
> +	if (!dentry->d_sb->s_export_op)
>  		return -EOPNOTSUPP;

So AFAICS the only thing you require is that s_export_op is set to
*something* as exportfs_encode_inode_fh() can deal with NULL ->encode_fh
just fine without any filesystem cooperation. What is the reasoning behind
the dentry->d_sb->s_export_op check? Is there an implicit expectation that
if s_export_op is set to something, the filesystem has sensible
i_generation? Or is it just a caution that you don't want the functionality
to be enabled for unexpected filesystems? In either case it would be good
to capture the reasoning either in a comment or the changelog...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
