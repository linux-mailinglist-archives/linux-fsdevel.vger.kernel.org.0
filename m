Return-Path: <linux-fsdevel+bounces-1157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B577D6CC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 15:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D28D281D25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 13:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599D327EEF;
	Wed, 25 Oct 2023 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aTSEzhzw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sPkw7EqG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD127ED0
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 13:10:30 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C160312F
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 06:10:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1A05F1FF5B;
	Wed, 25 Oct 2023 13:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698239427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KG9XRjmHb3zy05Zmp4tnwktujNWLJzhgtBpxg3w2xeE=;
	b=aTSEzhzwmmQ2bxIQAUPXpWsnR4Xw76APNgPr4J8huAQCW120ojrjVE1M8CqhYLx1UoAiJx
	yFhwxDPNS7vQ04OCKArZvbnvN/S49vtIcjbWLMxpm3shcnMXxyz8eYlGtHnVaYQjJ2fWaz
	cdcLsqcMX023kjJ3MxNQ+snF+PqS/w4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698239427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KG9XRjmHb3zy05Zmp4tnwktujNWLJzhgtBpxg3w2xeE=;
	b=sPkw7EqGPMPZ+Jb24svKRCikzsZQ+cFRy79RYiDilFgwu2+IIZa6xFgE025vtlqFTO9WeI
	ie59ozgdLuxVxACA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C6D913524;
	Wed, 25 Oct 2023 13:10:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id lejiAsMTOWXsbwAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 25 Oct 2023 13:10:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D4F4CA0679; Wed, 25 Oct 2023 14:34:49 +0200 (CEST)
Date: Wed, 25 Oct 2023 14:34:49 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] fs: massage locking helpers
Message-ID: <20231025123449.sek6wu5aafztfcwy@quack3>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
 <20231024-vfs-super-freeze-v2-1-599c19f4faac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-vfs-super-freeze-v2-1-599c19f4faac@kernel.org>
Authentication-Results: smtp-out2.suse.de;
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
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.99)[99.95%]

On Tue 24-10-23 15:01:07, Christian Brauner wrote:
> Multiple people have balked at the the fact that
> super_lock{_shared,_excluse}() return booleans and even if they return
> false hold s_umount. So let's change them to only hold s_umount when
> true is returned and change the code accordingly.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Yeah, it's easier to grasp calling convention I guess.

> @@ -1429,7 +1441,7 @@ static struct super_block *bdev_super_lock_shared(struct block_device *bdev)
>  	__releases(&bdev->bd_holder_lock)
>  {
>  	struct super_block *sb = bdev->bd_holder;
> -	bool born;
> +	bool locked;
>  
>  	lockdep_assert_held(&bdev->bd_holder_lock);
>  	lockdep_assert_not_held(&sb->s_umount);
> @@ -1441,9 +1453,8 @@ static struct super_block *bdev_super_lock_shared(struct block_device *bdev)
>  	spin_unlock(&sb_lock);
>  	mutex_unlock(&bdev->bd_holder_lock);
>  
> -	born = super_lock_shared(sb);
> -	if (!born || !sb->s_root || !(sb->s_flags & SB_ACTIVE)) {
> -		super_unlock_shared(sb);
> +	locked = super_lock_shared(sb);
> +	if (!locked || !sb->s_root || !(sb->s_flags & SB_ACTIVE)) {
>  		put_super(sb);
>  		return NULL;

Here if locked == true but say !(sb->s_flags & SB_ACTIVE), we fail to
unlock the superblock now AFAICT.

> @@ -1959,9 +1970,11 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
>  {
>  	int ret;
>  
> +	if (!super_lock_excl(sb)) {
> +		WARN_ON_ONCE("Dying superblock while freezing!");
> +		return -EINVAL;
> +	}
>  	atomic_inc(&sb->s_active);
> -	if (!super_lock_excl(sb))
> -		WARN(1, "Dying superblock while freezing!");
>  
>  retry:
>  	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
> @@ -2009,8 +2022,10 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
>  	/* Release s_umount to preserve sb_start_write -> s_umount ordering */
>  	super_unlock_excl(sb);
>  	sb_wait_write(sb, SB_FREEZE_WRITE);
> -	if (!super_lock_excl(sb))
> -		WARN(1, "Dying superblock while freezing!");
> +	if (!super_lock_excl(sb)) {
> +		WARN_ON_ONCE("Dying superblock while freezing!");
> +		return -EINVAL;
> +	}

And here if you really mean it with some kind of clean bail out, we should
somehow get rid of the s_active reference we have. But exactly because of
that getting super_lock_excl() failure here would be really weird...

Otherwise the patch looks good.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

