Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38458749E5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 15:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjGFN67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 09:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjGFN65 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:58:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF6419A0;
        Thu,  6 Jul 2023 06:58:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 310B41F747;
        Thu,  6 Jul 2023 13:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688651933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4YpAOh1KUc/8SwCmgMknakKRwe3WRAiEtk1nkMRs2RY=;
        b=qyTP93qGh1511R28uAImof/+U+mdWEitBfzOWN1SsrqTH7AZsYFU7nczmOrph0mxOC5F16
        YPyQeiSMXLcf5QosHHtNHIGcwpNRNzhzFd2dgFkxf4RfMnmm5VvIjq/0amIkfxZfK19Xnn
        Ya82sGG/IkybQDvI4gUUR5lfGVCAVks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688651933;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4YpAOh1KUc/8SwCmgMknakKRwe3WRAiEtk1nkMRs2RY=;
        b=zofd70NQo0aI51QYn4w8ojAGBuX7s7Dq/MPZndgstrcT6gkGVOOVgAAwReaMHNSKPnpA1m
        9HzpqmftfXmXoeCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DF83138EE;
        Thu,  6 Jul 2023 13:58:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 77YwA53IpmSZZgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 13:58:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 72895A0707; Thu,  6 Jul 2023 15:58:52 +0200 (CEST)
Date:   Thu, 6 Jul 2023 15:58:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 66/92] overlayfs: convert to ctime accessor functions
Message-ID: <20230706135852.l2yu7xzffrhbctbb@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-64-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-64-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:31, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
...
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 21245b00722a..7acd3e3fe790 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
...
> @@ -249,10 +250,12 @@ static void ovl_file_accessed(struct file *file)
>  	if (!upperinode)
>  		return;
>  
> +	ctime = inode_get_ctime(inode);
> +	uctime = inode_get_ctime(upperinode);
>  	if ((!timespec64_equal(&inode->i_mtime, &upperinode->i_mtime) ||
> -	     !timespec64_equal(&inode->i_ctime, &upperinode->i_ctime))) {
> +	     !timespec64_equal(&ctime, &uctime))) {
>  		inode->i_mtime = upperinode->i_mtime;
> -		inode->i_ctime = upperinode->i_ctime;
> +		inode_set_ctime_to_ts(inode, inode_get_ctime(upperinode));

I think you can use uctime here instead of inode_get_ctime(upperinode)?
Otherwise the patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
