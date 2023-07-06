Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDD1749A17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 12:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjGFK7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 06:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjGFK6t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:58:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB1C1FD4;
        Thu,  6 Jul 2023 03:57:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 07DFD20536;
        Thu,  6 Jul 2023 10:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688641066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kh98iBlRSQ1ufvp4r3Az47tKL7PDYVkN6lcsz+cADSY=;
        b=HQMwOJi32Azc/hFcFA9c5xeYYBwtitwjMXs/CuCvlEASxZjxtWlklj8o6ydIbh6O3HFQHG
        EOG/MM1XZXwGFlumP3EswIpok9zzKdpGQzYgZbgWoSPhfn25gdzMlYcfscMzTWoL+o4JOx
        Zlgiwon/FQpsX0KgMuFeYxiBS/ksA5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688641066;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kh98iBlRSQ1ufvp4r3Az47tKL7PDYVkN6lcsz+cADSY=;
        b=beY990vC29ahej6H7u1vbmS9dnm0pRko2+ebFtKZ+XnOBsytQBfSvWsVc2hyEcS8cHEYYn
        By5ZXzhcoRk/9iAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F099F138EE;
        Thu,  6 Jul 2023 10:57:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TL+7OimepmSmBgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 10:57:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 99CCBA0707; Thu,  6 Jul 2023 12:57:45 +0200 (CEST)
Date:   Thu, 6 Jul 2023 12:57:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 38/92] efs: convert to ctime accessor functions
Message-ID: <20230706105745.k2ozcfc2tmlbo3qc@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-36-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-36-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:03, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/efs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/efs/inode.c b/fs/efs/inode.c
> index 3ba94bb005a6..3789d22ba501 100644
> --- a/fs/efs/inode.c
> +++ b/fs/efs/inode.c
> @@ -105,8 +105,8 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
>  	inode->i_size  = be32_to_cpu(efs_inode->di_size);
>  	inode->i_atime.tv_sec = be32_to_cpu(efs_inode->di_atime);
>  	inode->i_mtime.tv_sec = be32_to_cpu(efs_inode->di_mtime);
> -	inode->i_ctime.tv_sec = be32_to_cpu(efs_inode->di_ctime);
> -	inode->i_atime.tv_nsec = inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec = 0;
> +	inode_set_ctime(inode, be32_to_cpu(efs_inode->di_ctime), 0);
> +	inode->i_atime.tv_nsec = inode->i_mtime.tv_nsec = 0;
>  
>  	/* this is the number of blocks in the file */
>  	if (inode->i_size == 0) {
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
