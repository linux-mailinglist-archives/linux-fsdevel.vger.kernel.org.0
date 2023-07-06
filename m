Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AB9749BF8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 14:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjGFMjY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 08:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGFMjX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:39:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C513125;
        Thu,  6 Jul 2023 05:39:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C9A0C1FE6D;
        Thu,  6 Jul 2023 12:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688647161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=erRXv7Iz/DE60QLZGLB2gYd8Mg9f7m888fcfhPG9cjA=;
        b=kyCYw/od6qROk/ejpXi8YR49cTYi0oTnQpaXgkDARnwB8WsTjRf0vS1/uk5JA1nCWep/xU
        NHKuK1uDXPnS7VK8lEDqbWInb6jOsWG/aOYQfwQL/Vvq5ZE+J6g/Zu6NayMIn7sjlxvlCG
        RI6atCCXcSfkDjEPBW6LAzwBtkc0TH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688647161;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=erRXv7Iz/DE60QLZGLB2gYd8Mg9f7m888fcfhPG9cjA=;
        b=PCRMfELn/YhB7Oe7g5JHcHDw3kov8VoIxxe5WPR7zTDcYosKuUgHQ/NK8w0hiJvH4AuyNk
        UktQ5sNzm/bZbtDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC480138FC;
        Thu,  6 Jul 2023 12:39:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R5jzLfm1pmRuPQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 12:39:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4F352A0707; Thu,  6 Jul 2023 14:39:21 +0200 (CEST)
Date:   Thu, 6 Jul 2023 14:39:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 53/92] isofs: convert to ctime accessor functions
Message-ID: <20230706123921.z4ckgxviewefzvqq@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-51-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-51-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:18, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/isofs/inode.c |  8 ++++----
>  fs/isofs/rock.c  | 16 +++++++---------
>  2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index df9d70588b60..98a78200cff1 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -1424,11 +1424,11 @@ static int isofs_read_inode(struct inode *inode, int relocated)
>  #endif
>  
>  	inode->i_mtime.tv_sec =
> -	inode->i_atime.tv_sec =
> -	inode->i_ctime.tv_sec = iso_date(de->date, high_sierra);
> +	inode->i_atime.tv_sec = inode_set_ctime(inode,
> +						iso_date(de->date, high_sierra),
> +						0).tv_sec;
>  	inode->i_mtime.tv_nsec =
> -	inode->i_atime.tv_nsec =
> -	inode->i_ctime.tv_nsec = 0;
> +	inode->i_atime.tv_nsec = 0;

This would be IMHO more readable as:

	inode->i_mtime = inode->i_atime =
		inode_set_ctime(inode, iso_date(de->date, high_sierra), 0);


Otherwise the patch looks good.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
