Return-Path: <linux-fsdevel+bounces-61114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22949B554CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC49BAA4A74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 16:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F325731B126;
	Fri, 12 Sep 2025 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y0QX1k4T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mT1Hr0JC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y0QX1k4T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mT1Hr0JC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1B175A5
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695172; cv=none; b=c6AnKP5eWyGw61nWBHV8hMzhe42wqPFjiTNW/DfNP2vw0XAxtKqKYuJPBVe0qvoByfo6pdwR/CxfLzy9F6X4FDFWkxAXzQlcmjSpD6A+gnP+P5z+9gY3qTmbV2B1GF7sNNQxohyrGyi6QTWEhwXWaipQorMVQ6+cO6UkmMWcAXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695172; c=relaxed/simple;
	bh=i+F2caua5Q0vOpv52bekIffwCVwb+H7Q+aUOvUnfvRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jquBDSxpoFvgJm644Iad5coQkxca9qrq27e/1YgQ3LN+/QlwclyYs8UDNYIb9TBD62yR+wCvAUSSmj+CY9cQFhzO5CvS7p10kWKeye3wi4T+8Zt8M+E+RLJv0aE1SsYrlTDr0N3X5Tx6C/TpVL2nvFR2U3a1hKBlb/b/Bnov/uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y0QX1k4T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mT1Hr0JC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y0QX1k4T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mT1Hr0JC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A7C022265;
	Fri, 12 Sep 2025 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757695168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8dYKgwNlm1DOgJfBThDpnMv2z/1UiIuPN/GclU2y3BU=;
	b=y0QX1k4TwCKWuF8+x+Rv6vJvkNL/IVOltFgCmV/5Sa1Boutypi9lFz4zJLPnv6Kqh6I4MB
	KkKP7xWugd409lEBumajFO+si3m7jXHRFxTzWLyq8zWTuwIBpC4ZZDbrpP80/0eJVPpgd1
	tXP+bSeUOfWnWlNRC7+OmlzbRPGt9jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757695168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8dYKgwNlm1DOgJfBThDpnMv2z/1UiIuPN/GclU2y3BU=;
	b=mT1Hr0JCjmonPErNRYWO9DAril4j0tbhExANMMGQFGnrHyCeRWNwpgQ8nCqqmAMVcQYcKw
	x6jsJQpRoJbYLyCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757695168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8dYKgwNlm1DOgJfBThDpnMv2z/1UiIuPN/GclU2y3BU=;
	b=y0QX1k4TwCKWuF8+x+Rv6vJvkNL/IVOltFgCmV/5Sa1Boutypi9lFz4zJLPnv6Kqh6I4MB
	KkKP7xWugd409lEBumajFO+si3m7jXHRFxTzWLyq8zWTuwIBpC4ZZDbrpP80/0eJVPpgd1
	tXP+bSeUOfWnWlNRC7+OmlzbRPGt9jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757695168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8dYKgwNlm1DOgJfBThDpnMv2z/1UiIuPN/GclU2y3BU=;
	b=mT1Hr0JCjmonPErNRYWO9DAril4j0tbhExANMMGQFGnrHyCeRWNwpgQ8nCqqmAMVcQYcKw
	x6jsJQpRoJbYLyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80E3913869;
	Fri, 12 Sep 2025 16:39:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gcpwH8BMxGioTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Sep 2025 16:39:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2535FA0993; Fri, 12 Sep 2025 18:39:28 +0200 (CEST)
Date: Fri, 12 Sep 2025 18:39:28 +0200
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] writeback: Avoid contention on wb->list_lock when
 switching inodes
Message-ID: <2nhajeaf6gs3xcpk3jyua7qle7ltmtb4qr564pj4atb7ignofv@wopqday65jgr>
References: <20250912103522.2935-1-jack@suse.cz>
 <20250912103840.4844-5-jack@suse.cz>
 <aMRHNSDV4lXSsU9U@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMRHNSDV4lXSsU9U@slm.duckdns.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Fri 12-09-25 06:15:49, Tejun Heo wrote:
> Hello,
> 
> On Fri, Sep 12, 2025 at 12:38:35PM +0200, Jan Kara wrote:
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
> > just one work item per wb and manage a queue of isw items switching to
> > this wb.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Generally looks great to me, but
> 
> > +void inode_switch_wbs_work_fn(struct work_struct *work)
> > +{
> > +	struct bdi_writeback *new_wb = container_of(work, struct bdi_writeback,
> > +						    switch_work);
> > +	struct inode_switch_wbs_context *isw, *next_isw;
> > +	struct llist_node *list;
> > +
> > +	/*
> > +	 * Grab out reference to wb so that it cannot get freed under us
> > +	 * after we process all the isw items.
> > +	 */
> > +	wb_get(new_wb);
> 
> Shouldn't this ref put at the end of the function?

It is put:

> > +	while (1) {
> > +		list = llist_del_all(&new_wb->switch_wbs_ctxs);
> > +		/* Nothing to do? */
> > +		if (!list) {
> > +			wb_put(new_wb);
			^^^^ here
There's no other way how to exit the function... But I can put 'break' here
and do wb_put() at the end of the function. That will likely be less
subtle.

								Honza


> > +			return;
> > +		}
> > +		/*
> > +		 * In addition to synchronizing among switchers, I_WB_SWITCH
> > +		 * tells the RCU protected stat update paths to grab the i_page
> > +		 * lock so that stat transfer can synchronize against them.
> > +		 * Let's continue after I_WB_SWITCH is guaranteed to be
> > +		 * visible.
> > +		 */
> > +		synchronize_rcu();
> > +
> > +		llist_for_each_entry_safe(isw, next_isw, list, list)
> > +			process_inode_switch_wbs_work(new_wb, isw);
> > +	}
> > +}
> 
> Thanks.
> 
> -- 
> tejun
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

