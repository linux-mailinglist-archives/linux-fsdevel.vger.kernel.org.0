Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9B3749DC9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 15:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjGFNck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 09:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGFNcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:32:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11F9102;
        Thu,  6 Jul 2023 06:32:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 857781F747;
        Thu,  6 Jul 2023 13:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688650357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v1zWkPjxofyirwLSy8PmvRVarB3Zj4LFxqS3FuAbPPw=;
        b=1ipBpFBOq0aPU0rsyblmSshjEeebB4NAWFrllg7xAw8PIKhFpmFRepBjoGxG2oxDny1Xsj
        K1yxYI4OwtrkDn3fxztds3Ss4LuV++qNeJIIiEOVkbv9U7ZRhFaCtl58b1+079Qs/9LLU3
        HGgNQgVeuVypcECWHVp2HacPYIqZj/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688650357;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v1zWkPjxofyirwLSy8PmvRVarB3Zj4LFxqS3FuAbPPw=;
        b=noYF8E+dszLjdAOqfsj1nzPL7JB3CbwXD0sgZcC3JRQllkLQroorWW+yLlCuJb47plAI5I
        OdoFcIiTpTzQZ7Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74B76138EE;
        Thu,  6 Jul 2023 13:32:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NyZ1HHXCpmRHWQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 13:32:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F0042A0707; Thu,  6 Jul 2023 15:32:36 +0200 (CEST)
Date:   Thu, 6 Jul 2023 15:32:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 56/92] kernfs: convert to ctime accessor functions
Message-ID: <20230706133236.vwvm4utsgnhty3mk@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-54-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-54-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:21, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

It looks like there are like three commits squashed into this patch -
kernfs, libfs, minix.

kernfs and libfs parts look good to me - feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

to them. For the minix part I have one nit:

> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> index e9fbb5303a22..3715a3940bd4 100644
> --- a/fs/minix/inode.c
> +++ b/fs/minix/inode.c
> @@ -501,10 +501,11 @@ static struct inode *V1_minix_iget(struct inode *inode)
>  	i_gid_write(inode, raw_inode->i_gid);
>  	set_nlink(inode, raw_inode->i_nlinks);
>  	inode->i_size = raw_inode->i_size;
> -	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode->i_ctime.tv_sec = raw_inode->i_time;
> +	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode_set_ctime(inode,
> +									raw_inode->i_time,
> +									0).tv_sec;
>  	inode->i_mtime.tv_nsec = 0;
>  	inode->i_atime.tv_nsec = 0;
> -	inode->i_ctime.tv_nsec = 0;

The usual simplification:
	inode->i_mtime = inode->i_atime = inode_set_ctime(inode,
							  raw_inode->i_time, 0);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
