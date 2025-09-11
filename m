Return-Path: <linux-fsdevel+bounces-60935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5F0B53071
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 13:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CDB16ED23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE8931AF06;
	Thu, 11 Sep 2025 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nvKdu7lG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GIVO+7jA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R88s09a6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AWRcEncz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14549243367
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590218; cv=none; b=Y7l9scPuuNpztC72ez7435bWt3Ay806d60qHSBniMq/ye8GpUs04FkzHVYN6na+M/4PKJgWxq3vcPdld9qRDNHNqrfFQVVfvtwjiTYOQHn+j5ot5RM/1ydh9MWBELf5vvJoMxRb5utQjCngHl5yUhsybDUlhvDRHjdIZzEPH90c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590218; c=relaxed/simple;
	bh=B7ZbLWu0M2HrDQ1xdUufdhnXZ4ZbjHXBFfJE46V3iOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxcAPi9ki22PPorM8PebwIp7toJ+x2MNGQcC3gBgoizb1Jo+P6TnPiC91siKBRvRy2nh+IDQBJHq1nNDsPQMLZ19+NoqPHPDi8wCGtCVyTokpNeRBvzOiseAcescAEYXRrkm3yHe8w/4oIbDScwdr6BFhb3T6bBcPyDBIvfYY9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nvKdu7lG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GIVO+7jA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R88s09a6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AWRcEncz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DAD17352D8;
	Thu, 11 Sep 2025 11:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757590214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z29PhsfFejUvKXzXBhaatsqk5BAbvlYOO69nFWQ2U5A=;
	b=nvKdu7lGlEbn9Zj4yvlHHn3RVF4wljg0ZhcYle3utgxPO/VZ2eXsiccTN0MUnBowWPkKwm
	aDLksFn3vhnaMPjMmhPHhd626HqFm6TO7pO+VZv5vZDp7vWa51HE9nP+XNBiVlwjwirx5m
	xF5+8xjwspDaNTAQLZvdig4xdqeY9LU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757590214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z29PhsfFejUvKXzXBhaatsqk5BAbvlYOO69nFWQ2U5A=;
	b=GIVO+7jA9B0kepEoFReFaVSfvR6xyMNPS+r8TBC4t+YQDZMRZ36G65L9VrpNymS0rhFJV4
	x4d9Gq/fg+q4N0BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R88s09a6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AWRcEncz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757590213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z29PhsfFejUvKXzXBhaatsqk5BAbvlYOO69nFWQ2U5A=;
	b=R88s09a6ALh8dGQFOpOZY32OZBUL7PpBtl2HJNlKXBhtndbbYintz1X+u3sM/Uyeaf2iHg
	M+GUqMz6sq2GgjLzxQ4PVqeIwZpxk0U/uR5nKRMgHc+1iz16z4bcLuqd+Si+3RCwsDfxX6
	7zMph4Vv9v7kKMVbbUwD6DRdQkTn2O8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757590213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z29PhsfFejUvKXzXBhaatsqk5BAbvlYOO69nFWQ2U5A=;
	b=AWRcEncz+g0xflvTdQ6Txr6erZW65dOEsQeCyAHcKvNAeZOR254ESwmNZxUCzHleZ8Y1Jz
	q9no6hnM2Ep4f5DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE79113301;
	Thu, 11 Sep 2025 11:30:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iN0XMsWywmgYLwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Sep 2025 11:30:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6A055A0A2D; Thu, 11 Sep 2025 13:30:13 +0200 (CEST)
Date: Thu, 11 Sep 2025 13:30:13 +0200
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] writeback: Avoid contention on wb->list_lock when
 switching inodes
Message-ID: <7ilbnkfbhv5mtshehvphe4tfiuwg7o52cexd3x4thwizkpjgbt@dycc7ac677t7>
References: <20250909143734.30801-1-jack@suse.cz>
 <20250909144400.2901-5-jack@suse.cz>
 <aMBbSxwwnvBvQw8C@slm.duckdns.org>
 <6wl26xqf6kvaz4527m7dy2dng5tu22qxva2uf2fi4xtzuzqxwx@l5re7vgx6zlz>
 <aMGw9AjS11coqPF_@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMGw9AjS11coqPF_@slm.duckdns.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: DAD17352D8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.01

On Wed 10-09-25 07:10:12, Tejun Heo wrote:
> Hello, Jan.
> 
> On Wed, Sep 10, 2025 at 10:19:36AM +0200, Jan Kara wrote:
> > Well, reducing @max_active to 1 will certainly deal with the list_lock
> > contention as well. But I didn't want to do that as on a busy container
> > system I assume there can be switching happening between different pairs of
> > cgroups. With the approach in this patch switches with different target
> > cgroups can still run in parallel. I don't have any real world data to back
> > that assumption so if you think this parallelism isn't really needed and we
> > are fine with at most one switch happening in the system, switching
> > max_active to 1 is certainly simple enough.
> 
> What bothers me is that the concurrency doesn't match between the work items
> being scheduled and the actual execution and we're resolving that by early
> exiting from some work items. It just feels like an roundabout way to do it
> with extra code. I think there are better ways to achieve per-bdi_writeback
> concurrency:
> 
> - Move work_struct from isw to bdi_writeback and schedule the work item on
>   the target wb which processes isw's queued on the bdi_writeback.
> 
> - Or have a per-wb workqueue with max_active limit so that concurrency is
>   regulated per-wb.
> 
> The latter is a bit simpler but does cost more memory as workqueue_struct
> isn't tiny. The former is a bit more complicated but most likely less so
> than the current code. What do you think?

That's a fair objection and good idea. I'll rework the patch to go with
the first variant.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

