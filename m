Return-Path: <linux-fsdevel+bounces-1359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0FA7D95E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 13:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155111C21011
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 11:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA1A18050;
	Fri, 27 Oct 2023 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lr8hqvUs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JgFSgDtT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70711803D
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 11:03:21 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB08D9C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 04:03:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CCDC921AAD;
	Fri, 27 Oct 2023 11:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698404597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v0M7qN+7y9ihhAFBZyy+MhHXioKHighhLtShKKBJGjk=;
	b=Lr8hqvUsk0GZDenvfEACv4BBLhUEdWJp5SQQscBrY7SOizow/S7d3j7LVJOwpRCJgt9VL2
	oM4DTqv8QzBOhAponqoqEhpG+ha/Gxd77d3DHCo7i8VO2++aOeeYf/3+3hcQjPnzluoL8V
	k91yTFyYzqK0VgGRnVsGmlIo2fZm4JU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698404597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v0M7qN+7y9ihhAFBZyy+MhHXioKHighhLtShKKBJGjk=;
	b=JgFSgDtTHrtiNHrZeu6k4nmQifniNRlEdKvw5dwL8y2EClWmjitb0/3gYT8MuSmcNUqLB1
	EGEVjknv/4sqXJAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C06861358C;
	Fri, 27 Oct 2023 11:03:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Kfb0LvWYO2WGDwAAMHmgww
	(envelope-from <jack@suse.cz>); Fri, 27 Oct 2023 11:03:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5437EA05BC; Fri, 27 Oct 2023 13:03:17 +0200 (CEST)
Date: Fri, 27 Oct 2023 13:03:17 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] Implement freeze and thaw as holder operations
Message-ID: <20231027110317.7xpiiqkl4vdbhqvc@quack3>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
 <20231027064001.GA9469@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027064001.GA9469@lst.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.59
X-Spamd-Result: default: False [-6.59 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.99)[-0.985];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Fri 27-10-23 08:40:01, Christoph Hellwig wrote:
> Btw, while reviewing this I also noticed that thaw_super_locked feels
> unreasonably convoluted.  Maybe something like this would be a good
> addition for the branch?
> 
> 
> ---
> From f5cbee13dcca6b025c82b365042bc5fab7ac6642 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 27 Oct 2023 08:36:04 +0200
> Subject: fs: streamline thaw_super_locked
> 
> Add a new out_unlock label to share code that just releases s_umount
> and returns an error, and rename and reuse the out label that deactivates
> the sb for one more case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks like a nice simplification. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 43 ++++++++++++++++++++-----------------------
>  1 file changed, 20 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index b26b302f870d24..38381c4b76f09e 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -2098,34 +2098,28 @@ EXPORT_SYMBOL(freeze_super);
>   */
>  static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
>  {
> -	int error;
> +	int error = -EINVAL;
>  
> -	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
> -		if (!(sb->s_writers.freeze_holders & who)) {
> -			super_unlock_excl(sb);
> -			return -EINVAL;
> -		}
> +	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE)
> +		goto out_unlock;
> +	if (!(sb->s_writers.freeze_holders & who))
> +		goto out_unlock;
>  
> -		/*
> -		 * Freeze is shared with someone else.  Release our hold and
> -		 * drop the active ref that freeze_super assigned to the
> -		 * freezer.
> -		 */
> -		if (sb->s_writers.freeze_holders & ~who) {
> -			sb->s_writers.freeze_holders &= ~who;
> -			deactivate_locked_super(sb);
> -			return 0;
> -		}
> -	} else {
> -		super_unlock_excl(sb);
> -		return -EINVAL;
> +	/*
> +	 * Freeze is shared with someone else.  Release our hold and drop the
> +	 * active ref that freeze_super assigned to the freezer.
> +	 */
> +	error = 0;
> +	if (sb->s_writers.freeze_holders & ~who) {
> +		sb->s_writers.freeze_holders &= ~who;
> +		goto out_deactivate;
>  	}
>  
>  	if (sb_rdonly(sb)) {
>  		sb->s_writers.freeze_holders &= ~who;
>  		sb->s_writers.frozen = SB_UNFROZEN;
>  		wake_up_var(&sb->s_writers.frozen);
> -		goto out;
> +		goto out_deactivate;
>  	}
>  
>  	lockdep_sb_freeze_acquire(sb);
> @@ -2135,8 +2129,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
>  		if (error) {
>  			printk(KERN_ERR "VFS:Filesystem thaw failed\n");
>  			lockdep_sb_freeze_release(sb);
> -			super_unlock_excl(sb);
> -			return error;
> +			goto out_unlock;
>  		}
>  	}
>  
> @@ -2144,9 +2137,13 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
>  	sb->s_writers.frozen = SB_UNFROZEN;
>  	wake_up_var(&sb->s_writers.frozen);
>  	sb_freeze_unlock(sb, SB_FREEZE_FS);
> -out:
> +out_deactivate:
>  	deactivate_locked_super(sb);
>  	return 0;
> +
> +out_unlock:
> +	super_unlock_excl(sb);
> +	return error;
>  }
>  
>  /**
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

