Return-Path: <linux-fsdevel+bounces-63476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3E5BBDD65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 13:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BC73BC92F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 11:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB6B268C73;
	Mon,  6 Oct 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cq8Um2oz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P7RctlWI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BRy11FxP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XQy+fgeH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07819253B67
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759749067; cv=none; b=nYr7l/itEk+MTjPONMlPtxlM1RuIL97WNdcdm78mdI6vwFVcpjMtVWVog2fBN0zBjrS1lCrD2e7WGocDfgytE0XahI0euwPHFbUZkFwz6GDcZS1OvsVKHh1P3wA3cCFEd9QN0YFijvBJG9yNvo7BKg0zf0D8MwJxS77f2fUxRHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759749067; c=relaxed/simple;
	bh=r2fJQWs213vf7fQZg4ENeZkSVXH6oX3bSvbrioYWAOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q89mMM9zuidyp0Tla+QqKnfnBJ6rtzFHOnjzissT2ITu4cf8Hz6/bTy1nusPLbr+HcPDnAvGEQnYjcQp02nAh5yUE9LFyepXLGzTQs9j28rjBoIke9uV7MEJvWxrc6ySvta4f8mmF/5A8Drf/Boa0wpOOwEIGYOeUXsQHFzID6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cq8Um2oz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P7RctlWI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BRy11FxP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XQy+fgeH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E28B01F451;
	Mon,  6 Oct 2025 11:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759749062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D5bB7GLWgAspeNWVJr+t1ArUMHKwAEEmnJpjG+s7+wc=;
	b=Cq8Um2ozDfjw9w+erVYaxqEyrW7PaFPvtbH7timOds2h0PYIZqJaraibi6O76zjE4WMtM3
	3b/EUMoBvRVI9vUcXWwyimAfh/hLOs29klOgp+UqjxecdubGPudCT+cALa//Xb89rJvmd2
	+wK8k0AVxgKalVdcLxpmrKjiyvZHAJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759749062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D5bB7GLWgAspeNWVJr+t1ArUMHKwAEEmnJpjG+s7+wc=;
	b=P7RctlWIwLKyuuwDwPp9TmGoR3F29UJMfj0XQjjuILoYoHWrPJWxFne86NTtHJTL2xg0PQ
	k+HyxKcI9hcPX/DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BRy11FxP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XQy+fgeH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759749061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D5bB7GLWgAspeNWVJr+t1ArUMHKwAEEmnJpjG+s7+wc=;
	b=BRy11FxPdfdSV/DPxZLpM11dCkgRRpXOVFEC8QG8ARFaHUxfniqNcMeHPVPkTAlWwQZ6kc
	vutjIdd3pOqiQimW5PupRngLxmlxLDpnQ7itumliubtLWzASP9eqDpsBSKw0CyX2FWYzKI
	8UfsFGpWUoDgvibcgZMnqA2rp+lVpWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759749061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D5bB7GLWgAspeNWVJr+t1ArUMHKwAEEmnJpjG+s7+wc=;
	b=XQy+fgeHClAmetERJCKJVwem2r0MfV3mlzWQRi/8zci7g7+puUtewK7HxZxdkU9MQubEmY
	wqrLBQlwNlrUJ0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6C8213995;
	Mon,  6 Oct 2025 11:11:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /xxpNMWj42jEXgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Oct 2025 11:11:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7C845A0A48; Mon,  6 Oct 2025 13:11:01 +0200 (CEST)
Date: Mon, 6 Oct 2025 13:11:01 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] udf and quota fixes for 6.18-rc1
Message-ID: <j7z7rzbhnpfbnvhkthjbiqeiwrbemysvqgypxttfgysdnoyrv7@ptqxg2jwbkgk>
References: <6lzkazta75sjxv2wrxqmskzqzm36zxgbo7w7yjqqlaejbyjegn@tdxtdkkiqzks>
 <CAHk-=wicSxaRNJwTJqvCMCQjoL1KozAdVVq55jYcp-PfgsK2QQ@mail.gmail.com>
 <aOBEvrdMHCNSYVEt@slm.duckdns.org>
 <CAHk-=wiOfheWYqn9g1DFBUHbKsmCdCMsO+jgjBcxRFUVb=pwxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiOfheWYqn9g1DFBUHbKsmCdCMsO+jgjBcxRFUVb=pwxw@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: E28B01F451
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Fri 03-10-25 15:08:14, Linus Torvalds wrote:
> On Fri, 3 Oct 2025 at 14:48, Tejun Heo <tj@kernel.org> wrote:
> >
> > So, two subsystems can share a WQ_MEM_RECLAIM workqueue iff two two are
> > guaranteed to not stack. If e.g. ext4 uses quota and if an ext4 work item
> > can wait for quot_release_work() to finish, then putting them on the same
> > WQ_MEM_RECLAIM will lead to a dead lock.
> 
> Yes. However, in my experience - and this may be limited and buggy, so
> take that with a large pinch of salt - a number of these things are
> not the kind that waits for work, but more of a "fire off and forget".
> 
> So for example, the new quota user obviously ends up doing quota
> writebacks (->write_dquot), and in the process may need to get
> filesystem locks etc.
> 
> So it will certainly block and wait for other things.
> 
> And yes, it's not *entirely* a "fire-off and forget" situation: people
> will obviously wait for it occasionally.
> 
> But they'll wait for it in things like the 'sync()' path, which had
> better not hold any locks anyway.
> 
> So the quota case was perfectly happy using the system wq - except for
> the whole "WQ_MEM_RECLAIM" issue.

Generally, I agree people are not waiting for dquot freeing. But there are
some corner cases where they can - e.g. if freeing of dquot races with
someone trying to grab new reference to it through dqget(). Then dqget()
has to wait for freeing to complete. It is these corner cases where
usually syzbot manages to find some unexpected dependencies like in the
case this patch was fixing.

If we take the example this patch is fixing - writeback work ends up
depending on quota release work so to guarantee forward progress we need
separate workqueues for them. Quota release work may end up waiting for
some work in the filesystem to which we are writing back the quota
information. So again if quota release work would be using the "generic"
reclaim workqueue, none of these filesystem works could be using it. So I
tend to agree with Tejun that it seems somewhat fragile to have a generic
reclaim workqueue if we want to absolutely guarantee forward progress
without having to allocate new worker.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

