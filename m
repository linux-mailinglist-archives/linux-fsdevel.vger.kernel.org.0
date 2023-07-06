Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58AC749FC5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 16:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjGFOvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 10:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbjGFOvH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:51:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338052102;
        Thu,  6 Jul 2023 07:50:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E70E71F747;
        Thu,  6 Jul 2023 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688655026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k71VEl92h9wPnVX4HfzsYmDmgtJ9ey/yoxaeqe+wio8=;
        b=VIevfzqnKBO0G7IEaeCYCww0PuLb40TWdRtsgSi9I2dklSs97TcayZIkR/Z/B7ltLQaPeR
        hyOgf6k5DTtVMeKTWeKDACefdDdvxLhGc6hBtGsUzgMShMxc/gTKaHH1n1crMjVviLZzl6
        f7EA68yoS7CrGtGEI7/J9yHKHn9QkXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688655026;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k71VEl92h9wPnVX4HfzsYmDmgtJ9ey/yoxaeqe+wio8=;
        b=/DjFQff2DIKqgxw5Yi+GC4ZodetFfoC7Hri/HfmGfaUPbf4RzOYYSNMBHqsHFNQZumA9i6
        LzzoIBRDzibSbEBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8E33138FC;
        Thu,  6 Jul 2023 14:50:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7MXvNLLUpmTuAQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 14:50:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 712E3A0707; Thu,  6 Jul 2023 16:50:26 +0200 (CEST)
Date:   Thu, 6 Jul 2023 16:50:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 81/92] vboxsf: convert to ctime accessor functions
Message-ID: <20230706145026.4uucnmyswq7mmvni@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-79-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-79-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:46, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/vboxsf/utils.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
> index dd0ae1188e87..576b91d571c5 100644
> --- a/fs/vboxsf/utils.c
> +++ b/fs/vboxsf/utils.c
> @@ -128,8 +128,8 @@ int vboxsf_init_inode(struct vboxsf_sbi *sbi, struct inode *inode,
>  
>  	inode->i_atime = ns_to_timespec64(
>  				 info->access_time.ns_relative_to_unix_epoch);
> -	inode->i_ctime = ns_to_timespec64(
> -				 info->change_time.ns_relative_to_unix_epoch);
> +	inode_set_ctime_to_ts(inode,
> +			      ns_to_timespec64(info->change_time.ns_relative_to_unix_epoch));
>  	inode->i_mtime = ns_to_timespec64(
>  			   info->modification_time.ns_relative_to_unix_epoch);
>  	return 0;
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
