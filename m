Return-Path: <linux-fsdevel+bounces-73421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E75FD189F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 13:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A841304A7D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 12:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379F62FC876;
	Tue, 13 Jan 2026 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JFqecNvs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R+eFA9Mk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JFqecNvs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R+eFA9Mk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F45D2BD58A
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768305776; cv=none; b=ctewheEnegHmXEbZkuO1wURtweqQtTiIZVSbJ8DtbW6hb7mUfpU6TvayJc/xLpr0vi1byOP9cJaDQM6ZXZGKkiGZGfveqr5zRVGUxCxs/8S/QO/EBufhXZEv2r8NMNHur42EAQBwlP7DdSHsYAAgVYbvYZNXw1yFFOWR8NwbtY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768305776; c=relaxed/simple;
	bh=HpoDaUrvXKO/vMiKw0KXXyW0rOtoOCsbl/mokc7lZhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTarCHk1yOqlG6fxJ1SlErWgcntueJpYEsdQTnS3EKc9sLakwtB8grokKry2h8gK8QVUejvRpBteB6avGzQ/2uXKmuKhe1vgwUNiGMhFtqTdNGfKHpaaRokRWZ3D8MvFWE0MsJM/q7Pa98/6qnjBZ9lr2LUdRMtxmKsB8vq34B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JFqecNvs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R+eFA9Mk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JFqecNvs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R+eFA9Mk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82495336A4;
	Tue, 13 Jan 2026 12:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768305773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=quWB+ncw16QigYIMJTO3AxPEs75h+kf19eNvkCeDQ4U=;
	b=JFqecNvstZ2gTQoUc1R3vwruf/dQsmsfcTTxCKKHSHn5WfcLpsgjxRHrPp3GrNCcXJzcE/
	7QqsJmVqFrsRAzc+mKqlWoVL4IrNAMIiw6OLc/eRlFCCYvBYE2d5XKcYhEGIhvTBzlKJwC
	FUUs7nDkRl771/Ont2SJuHLnZEiahUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768305773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=quWB+ncw16QigYIMJTO3AxPEs75h+kf19eNvkCeDQ4U=;
	b=R+eFA9MkY6IAwFtT4kUJ1qKU7l2ZTQCQd1PsYer4bpeOXvEX6jRChQljWL9nhtn9aWUhEN
	qpOOp43O2ZEIEABg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768305773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=quWB+ncw16QigYIMJTO3AxPEs75h+kf19eNvkCeDQ4U=;
	b=JFqecNvstZ2gTQoUc1R3vwruf/dQsmsfcTTxCKKHSHn5WfcLpsgjxRHrPp3GrNCcXJzcE/
	7QqsJmVqFrsRAzc+mKqlWoVL4IrNAMIiw6OLc/eRlFCCYvBYE2d5XKcYhEGIhvTBzlKJwC
	FUUs7nDkRl771/Ont2SJuHLnZEiahUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768305773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=quWB+ncw16QigYIMJTO3AxPEs75h+kf19eNvkCeDQ4U=;
	b=R+eFA9MkY6IAwFtT4kUJ1qKU7l2ZTQCQd1PsYer4bpeOXvEX6jRChQljWL9nhtn9aWUhEN
	qpOOp43O2ZEIEABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 784DB3EA63;
	Tue, 13 Jan 2026 12:02:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XpBUHW00ZmmPOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 13 Jan 2026 12:02:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3D508A08CF; Tue, 13 Jan 2026 13:02:53 +0100 (CET)
Date: Tue, 13 Jan 2026 13:02:53 +0100
From: Jan Kara <jack@suse.cz>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [REGRESSION] 6.12: Workqueue lockups in inode_switch_wbs_work_fn
 (suspect commit 66c14dccd810)
Message-ID: <xyivos2a76rpgmyp6kvvpskmuhheo2wtaqs5s4qvvbn6p3f3lb@3sc7xufujt57>
References: <20260112111804.3773280-1-matt@readmodwrite.com>
 <isa6ohzad6b6l55kbdqa35r5fsp4wnifpncx3kit6m35266d7z@463ckwplt5w3>
 <eiilrap7jcpk7bneqvovbrqu6hdtzo2xra5tgqbg3wje2emzha@q3may6rqs5zl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eiilrap7jcpk7bneqvovbrqu6hdtzo2xra5tgqbg3wje2emzha@q3may6rqs5zl>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO

On Tue 13-01-26 11:46:35, Matt Fleming wrote:
> On Mon, Jan 12, 2026 at 06:04:50PM +0100, Jan Kara wrote:
> > 
> > I agree we are CPU bound in inode_switch_wbs_work_fn() but I don't think we
> > are really hogging the CPU. The backtrace below indicates the worker just
> > got rescheduled in cond_resched() to give other tasks a chance to run. Is
> > the machine dying completely or does it eventually finish the cgroup
> > teardown?
>  
> Yeah you're right, the CPU isn't hogged but the interaction with the
> workqueue subsystem leads to the machine choking. I've seen 150+
> instances of inode_switch_wbs_work_fn() queued up in the workqueue
> subsystem:
> 
>   [1437017.446174][    C0]     in-flight: 3139338:inode_switch_wbs_work_fn ,2420392:inode_switch_wbs_work_fn ,2914179:inode_switch_wbs_work_fn
>   [1437017.446181][    C0]     pending: 11*inode_switch_wbs_work_fn
>   [1437017.446185][    C0]   pwq 6: cpus=1 node=0 flags=0x2 nice=0 active=23 refcnt=24
>   [1437017.446186][    C0]     in-flight: 2723771:inode_switch_wbs_work_fn ,1710617:inode_switch_wbs_work_fn ,3228683:inode_switch_wbs_work_fn ,3149692:inode_switch_wbs_work_fn ,3224195:inode_switch_wbs_work_fn
>   [1437017.446193][    C0]     pending: 18*inode_switch_wbs_work_fn
>   [1437017.446195][    C0]   pwq 10: cpus=2 node=0 flags=0x2 nice=0 active=17 refcnt=18
>   [1437017.446196][    C0]     in-flight: 3224135:inode_switch_wbs_work_fn ,3193118:inode_switch_wbs_work_fn ,3224106:inode_switch_wbs_work_fn ,3228725:inode_switch_wbs_work_fn ,3087195:inode_switch_wbs_work_fn ,1853835:inode_switch_wbs_work_fn
>   [1437017.446204][    C0]     pending: 11*inode_switch_wbs_work_fn
> 
> It sometimes finishes the cgroup teardown and sometimes hard locks up.
> When workqueue items aren't completing things get really bad :) 
> 
> > Well, these changes were introduced because some services are switching
> > over 1m inodes on their exit and they were softlocking up the machine :).
> > So there's some commonality, just something in that setup behaves
> > differently from your setup. Are the inodes clean, dirty, or only with
> > dirty timestamps?
> 
> Good question. I don't know but I'll get back to you.
> 
> > Also since you mention 6.12 kernel but this series was
> > only merged in 6.18, do you carry full series ending with merge commit
> > 9426414f0d42f?
>  
> We always run the latest 6.12 LTS release and it looks like only these
> two commits got backported:
> 
>   9a6ebbdbd412 ("writeback: Avoid excessively long inode switching times")
>   66c14dccd810 ("writeback: Avoid softlockup when switching many inodes")

Ah, OK. Then you're missing e1b849cfa6b61f ("writeback: Avoid contention on
wb->list_lock when switching inodes") which might explain why my system
behaves differently from your one because that commit *heavily* reduces
contention on wb->list_lock when switching inodes and also avoids hogging
multiple workers with the switching works when only one of them can proceed
at a time (others are just spinning on the list_lock). So I'd suggest you
backport that commit and try whether it fixes your issues.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

