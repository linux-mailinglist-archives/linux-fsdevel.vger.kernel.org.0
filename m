Return-Path: <linux-fsdevel+bounces-22620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A5791A5BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 13:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6790A1C2131B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 11:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B9214E2F6;
	Thu, 27 Jun 2024 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V4/UyM1L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QFFUE996";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V4/UyM1L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QFFUE996"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFBA4500C;
	Thu, 27 Jun 2024 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489262; cv=none; b=N1L2zcrtFv3f/oDbYQ8nnPEXYANK4Ul4/W34YNthxIbUJPBvWx0JUkxtaRBSW2nqL5cR9lB6EQVsLA1zNCEKtvTV5CbM9lX0/S6nH9PfeodoQH42IXIxqzJLO1i5AZSWKJW1/OjjU64rNL3BogPiQ79WAK/DR0QUwYCLsdnCUPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489262; c=relaxed/simple;
	bh=v/u26e2TcJU2CzkREnNHemDFe6Ij2WyQarWvOjfphcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d28D7AtxfdUdOzjSJ13ANUD4PCMuPce7XoQYl+6YHY1ci5G0GViyUrEp0t+31KNyfeW8EWGctag2v0EX40IrHsbiJiXYx5EVXR6+bRRPPUR/dI327vnTDu3ogIwr4YxJdzmQZgD84Ma/qp1KWAJ4rxZrkcMSokaO6tdB8Ibg4Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V4/UyM1L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QFFUE996; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V4/UyM1L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QFFUE996; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 402EA21B53;
	Thu, 27 Jun 2024 11:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719489259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdXQk2vFvUmtcq++xw1NaePH3+00GFxwQqDOyma05bU=;
	b=V4/UyM1LRtpGxl1Oxq0pHO5+5QARmI5gPyO2e+zPkZQkMiSgaeqFegKjff2aMMTxyOcQYz
	88BpRrw8ySasaTK0SLUm+l9Q64EvMMVvpudJJ5Ic3tzi2OqpTm+1yru1WvoAEaOlidmoWz
	X+OhxWXF9nkjwzZsBu1MttIdJT0dx0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719489259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdXQk2vFvUmtcq++xw1NaePH3+00GFxwQqDOyma05bU=;
	b=QFFUE996kaeVoTyDxlHYN1O8TqwEl3fFfYEvcapWdpKrT3v7Ctl6tdoVf1IgtIycACDQfS
	v1jTdCDDAKc3ysAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="V4/UyM1L";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QFFUE996
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719489259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdXQk2vFvUmtcq++xw1NaePH3+00GFxwQqDOyma05bU=;
	b=V4/UyM1LRtpGxl1Oxq0pHO5+5QARmI5gPyO2e+zPkZQkMiSgaeqFegKjff2aMMTxyOcQYz
	88BpRrw8ySasaTK0SLUm+l9Q64EvMMVvpudJJ5Ic3tzi2OqpTm+1yru1WvoAEaOlidmoWz
	X+OhxWXF9nkjwzZsBu1MttIdJT0dx0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719489259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdXQk2vFvUmtcq++xw1NaePH3+00GFxwQqDOyma05bU=;
	b=QFFUE996kaeVoTyDxlHYN1O8TqwEl3fFfYEvcapWdpKrT3v7Ctl6tdoVf1IgtIycACDQfS
	v1jTdCDDAKc3ysAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32584137DF;
	Thu, 27 Jun 2024 11:54:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZSn9C+tSfWZSRQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Jun 2024 11:54:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C7375A08A2; Thu, 27 Jun 2024 13:54:18 +0200 (CEST)
Date: Thu, 27 Jun 2024 13:54:18 +0200
From: Jan Kara <jack@suse.cz>
To: Ian Kent <ikent@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Larsson <alexl@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
Message-ID: <20240627115418.lcnpctgailhlaffc@quack3>
References: <20240626201129.272750-2-lkarpins@redhat.com>
 <20240626201129.272750-3-lkarpins@redhat.com>
 <Znx-WGU5Wx6RaJyD@casper.infradead.org>
 <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
X-Rspamd-Queue-Id: 402EA21B53
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu 27-06-24 09:11:14, Ian Kent wrote:
> On 27/6/24 04:47, Matthew Wilcox wrote:
> > On Wed, Jun 26, 2024 at 04:07:49PM -0400, Lucas Karpinski wrote:
> > > +++ b/fs/namespace.c
> > > @@ -78,6 +78,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
> > >   static DECLARE_RWSEM(namespace_sem);
> > >   static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
> > >   static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
> > > +static bool lazy_unlock = false; /* protected by namespace_sem */
> > That's a pretty ugly way of doing it.  How about this?
> 
> Ha!
> 
> That was my original thought but I also didn't much like changing all the
> callers.
> 
> I don't really like the proliferation of these small helper functions either
> but if everyone
> 
> is happy to do this I think it's a great idea.

So I know you've suggested removing synchronize_rcu_expedited() call in
your comment to v2. But I wonder why is it safe? I *thought*
synchronize_rcu_expedited() is there to synchronize the dropping of the
last mnt reference (and maybe something else) - see the comment at the
beginning of mntput_no_expire() - and this change would break that?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

