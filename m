Return-Path: <linux-fsdevel+bounces-60742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3225FB510FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 10:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3DD3A5F0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 08:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EDA30C62B;
	Wed, 10 Sep 2025 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m2AjeCGD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ef5M89ks";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m2AjeCGD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ef5M89ks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935CC2D12ED
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492385; cv=none; b=hlrUSkbWt0LHXtZJ00RUTTrDnfwyF5xkyE3C+9afNkaLFAy9gsTB8BH2llaCwHJWCJjAiTk5zQFvwHuLs380423RzZ7zWiqaT2PijUfV3rBrRBCF1v6QOwzqZmc6398ivxXRBNUZoYmm8rG9erc5vFSBoCmkOcpqnTHhrqTqh3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492385; c=relaxed/simple;
	bh=LWZ8CAEpycyJFNkA6apWFOna88ZNw6ARdl3dLajeQhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AS+EQksCT2hpyjqCnLyVfgoE+xsOcmiz4jwdHpdcoeb//waVyLO48JJFjflDjV3hutkvq5aX+0i79eyZUBfnzvw1Ea/zGEj/FLSiQEwRpepaKPrfEL8i0Fp2+40vQg1zyIn575E8ZMdJ+dwtWvUsiwW6ZarTwgyuGD5uDLoYp+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m2AjeCGD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ef5M89ks; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m2AjeCGD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ef5M89ks; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 445501F7C5;
	Wed, 10 Sep 2025 08:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757492381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P12AVPddthVxDO0dr1bKrqjOMYMUa7VaeFUFW9pWgFU=;
	b=m2AjeCGDncU5WXYwZ0+wCS4oMrmsln8X3mVHctmsidEYwwEoMzXsApverbnOQ8KqPZDSAf
	UN32mN2sieWqFbvHWCKG7LTwgMeYNixd2MtCixa4kzByPij2G1OOjcTf6X3fP/qsOQp6W1
	eYZwoEiV1iyMSF1qyYT+JoF4nwcesac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757492381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P12AVPddthVxDO0dr1bKrqjOMYMUa7VaeFUFW9pWgFU=;
	b=ef5M89ksZ6gcLSHP7+URxlDX1MEyrgEn/Oq03umCs3DwQegGjkHmGdm9MOa0EOgnBGbCGg
	gCPn6o0hZHrQRbBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757492381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P12AVPddthVxDO0dr1bKrqjOMYMUa7VaeFUFW9pWgFU=;
	b=m2AjeCGDncU5WXYwZ0+wCS4oMrmsln8X3mVHctmsidEYwwEoMzXsApverbnOQ8KqPZDSAf
	UN32mN2sieWqFbvHWCKG7LTwgMeYNixd2MtCixa4kzByPij2G1OOjcTf6X3fP/qsOQp6W1
	eYZwoEiV1iyMSF1qyYT+JoF4nwcesac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757492381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P12AVPddthVxDO0dr1bKrqjOMYMUa7VaeFUFW9pWgFU=;
	b=ef5M89ksZ6gcLSHP7+URxlDX1MEyrgEn/Oq03umCs3DwQegGjkHmGdm9MOa0EOgnBGbCGg
	gCPn6o0hZHrQRbBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3851D13310;
	Wed, 10 Sep 2025 08:19:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nLi5DZ00wWjPKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Sep 2025 08:19:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C444AA0A2D; Wed, 10 Sep 2025 10:19:36 +0200 (CEST)
Date: Wed, 10 Sep 2025 10:19:36 +0200
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] writeback: Avoid contention on wb->list_lock when
 switching inodes
Message-ID: <6wl26xqf6kvaz4527m7dy2dng5tu22qxva2uf2fi4xtzuzqxwx@l5re7vgx6zlz>
References: <20250909143734.30801-1-jack@suse.cz>
 <20250909144400.2901-5-jack@suse.cz>
 <aMBbSxwwnvBvQw8C@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMBbSxwwnvBvQw8C@slm.duckdns.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

Hello Tejun,

On Tue 09-09-25 06:52:27, Tejun Heo wrote:
> On Tue, Sep 09, 2025 at 04:44:02PM +0200, Jan Kara wrote:
> > There can be multiple inode switch works that are trying to switch
> > inodes to / from the same wb. This can happen in particular if some
> > cgroup exits which owns many (thousands) inodes and we need to switch
> > them all. In this case several inode_switch_wbs_work_fn() instances will
> > be just spinning on the same wb->list_lock while only one of them makes
> > forward progress. This wastes CPU cycles and quickly leads to softlockup
> > reports and unusable system.
> > 
> > Instead of running several inode_switch_wbs_work_fn() instances in
> > parallel switching to the same wb and contending on wb->list_lock, run
> > just one instance and let the other isw items switching to this wb queue
> > behind the one being processed.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> ...
> > +static void inode_switch_wbs_work_fn(struct work_struct *work)
> > +{
> > +	struct inode_switch_wbs_context *isw =
> > +		container_of(to_rcu_work(work), struct inode_switch_wbs_context, work);
> > +	struct bdi_writeback *new_wb = isw->new_wb;
> > +	bool switch_running;
> > +
> > +	spin_lock_irq(&new_wb->work_lock);
> > +	switch_running = !list_empty(&new_wb->switch_wbs_ctxs);
> > +	list_add_tail(&isw->list, &new_wb->switch_wbs_ctxs);
> > +	spin_unlock_irq(&new_wb->work_lock);
> > +
> > +	/*
> > +	 * Let's leave the real work for the running worker since we'd just
> > +	 * contend with it on wb->list_lock anyway.
> > +	 */
> > +	if (switch_running)
> > +		return;
> > +
> > +	/* OK, we will be doing the switching work */
> > +	wb_get(new_wb);
> > +	spin_lock_irq(&new_wb->work_lock);
> > +	while (!list_empty(&new_wb->switch_wbs_ctxs)) {
> > +		isw = list_first_entry(&new_wb->switch_wbs_ctxs,
> > +				       struct inode_switch_wbs_context, list);
> > +		spin_unlock_irq(&new_wb->work_lock);
> > +		process_inode_switch_wbs_work(isw);
> > +		spin_lock_irq(&new_wb->work_lock);
> > +		list_del(&isw->list);
> > +		kfree(isw);
> > +	}
> > +	spin_unlock_irq(&new_wb->work_lock);
> > +	wb_put(new_wb);
> > +}
> 
> Would it be easier to achieve the same effect if we just reduced @max_active
> when creating inode_switch_wbs? If we update cgroup_writeback_init() to use
> the following instead:
> 
>         isw_wq = alloc_workqueue("inode_switch_wbs", WQ_UNBOUND, 1);
> 
> Wouldn't that achieve the same thing? Note the addition of WQ_UNBOUND isn't
> strictly necessary but we're in the process of defaulting to unbound
> workqueues, so might as well update it together. I can't think of any reason
> why this would require per-cpu behavior.

Well, reducing @max_active to 1 will certainly deal with the list_lock
contention as well. But I didn't want to do that as on a busy container
system I assume there can be switching happening between different pairs of
cgroups. With the approach in this patch switches with different target
cgroups can still run in parallel. I don't have any real world data to back
that assumption so if you think this parallelism isn't really needed and we
are fine with at most one switch happening in the system, switching
max_active to 1 is certainly simple enough.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

