Return-Path: <linux-fsdevel+bounces-63761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 715C5BCD559
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 15:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39FED4E77D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD3D2F532C;
	Fri, 10 Oct 2025 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pXY51EHG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0+AtvTuZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sg+3iEnw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UUqxNBxW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22022EE61C
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104134; cv=none; b=PLysYFSbUPII0220foF38ILaoFoYn09Y38wrVuXfXtktQuk1F2sPWhA67aeCdyU1dc5jMIskOcT18/O2Ll25Whf++HriaEZofENPMjgUIYlfH1H4/JSW2V45UXVNnxGOoKG718Uv3taD4ceD3sE43DedynybYA/AyLM7MK9vP2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104134; c=relaxed/simple;
	bh=QsAwv6Nn2tamITT/ImGiQJewV6cUmybG5oeFODYldbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYNnG25RUJ8FBWrOvAbT7UKrn6/ZMEOAd+qAvKGK/bO9cvH7IDC4BkvaJIQS+1KYmIZO/YWghQ8DpldUGSsG7grfWysf1YfebINsjMfB8DwYL4clsIYRxXz0IFSEYYufhflVMx0LdH2CTl9vGYBlKjoxhpHt4eGnHXzrZZenelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pXY51EHG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0+AtvTuZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sg+3iEnw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UUqxNBxW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EE7291F397;
	Fri, 10 Oct 2025 13:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760104130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cv/PTISQGEuORcVGM2HqO43chsYeH6RDeKCSF0LXeJU=;
	b=pXY51EHGrWXlDBzn6Sdx/gAL2pqRRSQkrinUySxUyzz7JyPNKbgoXZV8LYqVDs9crw/C81
	K4pkJR5rRDxnKrRD3sLRyBwYOopbe+YuyPkvyVnKJVxbhi9WwlEElFyLsaLPOcAbEoOhWV
	TlqSZhSb9GRfjKpRsOhKpznKpataLus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760104130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cv/PTISQGEuORcVGM2HqO43chsYeH6RDeKCSF0LXeJU=;
	b=0+AtvTuZZ9BAW1TRnKhaIVd8qZakEnJSF8h0LILf8nce3HrOfFiLEjQSH5bFNENQg1Colg
	0Qoz4EwfYFIyEGDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760104129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cv/PTISQGEuORcVGM2HqO43chsYeH6RDeKCSF0LXeJU=;
	b=Sg+3iEnwb0jNqqaNsiynd62OHa/4soMd6oFnBJjmyBEfIH1azh78+LaaYlq4+hK1iIdknp
	aF2PyrLxDvfbM1UNfPaO0FZvaOFeQLntEsKiAGsMhJULmUXxXpcz0dme7/s/Oz4HsDyUlu
	oXx5WrD5CaETstRIECrRhIOg29OsBVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760104129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cv/PTISQGEuORcVGM2HqO43chsYeH6RDeKCSF0LXeJU=;
	b=UUqxNBxWa1GYEVE5do+5K2Q0Zlg1CHYIRJmrzCc/ghkWHq/jvbGhPFwUwI3KTqxcp2kQQt
	cm15y/kYg6kqcfCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7F801375D;
	Fri, 10 Oct 2025 13:48:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UL/cMMEO6WiEcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Oct 2025 13:48:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 32007A0A58; Fri, 10 Oct 2025 15:48:49 +0200 (CEST)
Date: Fri, 10 Oct 2025 15:48:49 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 02/14] fs: spell out fenced ->i_state accesses with
 explicit smp_wmb/smp_rmb
Message-ID: <qssdmjcp4fh2op7en3qinn4l24hivhf2vfuve674fvftcvrbfp@sf2lfrpx7cmo>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-3-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009075929.1203950-3-mjguzik@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,toxicpanda.com,fb.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu 09-10-25 09:59:16, Mateusz Guzik wrote:
> The incomming helpers don't ship with _release/_acquire variants, for
> the time being anyway.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c           | 5 +++--
>  include/linux/backing-dev.h | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 2b35e80037fe..9cda19a40ca2 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -476,10 +476,11 @@ static bool inode_do_switch_wbs(struct inode *inode,
>  	switched = true;
>  skip_switch:
>  	/*
> -	 * Paired with load_acquire in unlocked_inode_to_wb_begin() and
> +	 * Paired with an acquire fence in unlocked_inode_to_wb_begin() and
>  	 * ensures that the new wb is visible if they see !I_WB_SWITCH.
>  	 */
> -	smp_store_release(&inode->i_state, inode->i_state & ~I_WB_SWITCH);
> +	smp_wmb();
> +	inode->i_state &= ~I_WB_SWITCH;
>  
>  	xa_unlock_irq(&mapping->i_pages);
>  	spin_unlock(&inode->i_lock);
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 3e64f14739dd..065cba5dc111 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -277,10 +277,11 @@ unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
>  	rcu_read_lock();
>  
>  	/*
> -	 * Paired with store_release in inode_switch_wbs_work_fn() and
> +	 * Paired with a release fence in inode_do_switch_wbs() and
>  	 * ensures that we see the new wb if we see cleared I_WB_SWITCH.
>  	 */
> -	cookie->locked = smp_load_acquire(&inode->i_state) & I_WB_SWITCH;
> +	cookie->locked = inode->i_state & I_WB_SWITCH;
> +	smp_rmb();
>  
>  	if (unlikely(cookie->locked))
>  		xa_lock_irqsave(&inode->i_mapping->i_pages, cookie->flags);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

