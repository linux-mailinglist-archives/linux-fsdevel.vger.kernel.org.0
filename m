Return-Path: <linux-fsdevel+bounces-8162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 650DA830830
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 15:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F5A284D80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 14:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EF420B21;
	Wed, 17 Jan 2024 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WzEDhvlN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KNR2Ef5+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WzEDhvlN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KNR2Ef5+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1819720308;
	Wed, 17 Jan 2024 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705502137; cv=none; b=btT6yNxikGTfApUZqIBSouvd7ufbkir0cCnhQV8GocrhGDJbBil8bP/wyg+gUogaGuubR6OTZ9solpkGE4alIuf5Hq4kJIlYFkXheELY838y0ImMAT2P1jfssk8kTzvPXF4pHddeumrBWVDUbIqjKqM1UaObHz3AwqxnDbcMFGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705502137; c=relaxed/simple;
	bh=ZMgJeIhj9LTBaaPOmPOWLfs14Y33hjhRU4gwsLGCvpw=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Level:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Flag; b=m1DyS4BIpX2x6IX7uA8K5tRWFXZxrbQJHAu06MYE0byAtwb38gaa7wuJLaZK/HCYVUaaVW1udG+s+Sq6+00HBPuBjA8nXMWl+crod2T3DRAnXv6uKRC4SN57cnRfSEhw7wKjQAXf0eGxxtEfptcD+BPtfrR1XwzOOHjQyJoxo4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WzEDhvlN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KNR2Ef5+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WzEDhvlN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KNR2Ef5+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B24C3220B6;
	Wed, 17 Jan 2024 14:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705502132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fmadxpqMu4C5DBMON/D+IvGv5Kr7MEI26W5sM9IrEes=;
	b=WzEDhvlNIHHx9adDBXGceN+LdYnU+FqlpoDH/rtQoawQbq9SQl0CQMwV3BhyonEXIbc5ti
	YlS8cEjzU5Qqs+knkBFSm05U+QOEFEOMUxhcUxHtnNpoEPlXhcMMBu4vc8CxRxZenNDNXl
	zrvgZGMslJiYHyE7DSzSc3BT0X4lbUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705502132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fmadxpqMu4C5DBMON/D+IvGv5Kr7MEI26W5sM9IrEes=;
	b=KNR2Ef5+zZYVRy8Nm1HsIcH3SxPY18Ona94DE7oJUNzfjsenh0g93qJQXWd4WsQb1viWBL
	kMOmfAELIvoSCwAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705502132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fmadxpqMu4C5DBMON/D+IvGv5Kr7MEI26W5sM9IrEes=;
	b=WzEDhvlNIHHx9adDBXGceN+LdYnU+FqlpoDH/rtQoawQbq9SQl0CQMwV3BhyonEXIbc5ti
	YlS8cEjzU5Qqs+knkBFSm05U+QOEFEOMUxhcUxHtnNpoEPlXhcMMBu4vc8CxRxZenNDNXl
	zrvgZGMslJiYHyE7DSzSc3BT0X4lbUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705502132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fmadxpqMu4C5DBMON/D+IvGv5Kr7MEI26W5sM9IrEes=;
	b=KNR2Ef5+zZYVRy8Nm1HsIcH3SxPY18Ona94DE7oJUNzfjsenh0g93qJQXWd4WsQb1viWBL
	kMOmfAELIvoSCwAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A51AB13800;
	Wed, 17 Jan 2024 14:35:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XmtHKLTlp2WuBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jan 2024 14:35:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 540BFA0803; Wed, 17 Jan 2024 15:35:28 +0100 (CET)
Date: Wed, 17 Jan 2024 15:35:28 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Message-ID: <20240117143528.idmyeadhf4yzs5ck@quack3>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <20240116114519.jcktectmk2thgagw@quack3>
 <20240117-tupfen-unqualifiziert-173af9bc68c8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117-tupfen-unqualifiziert-173af9bc68c8@brauner>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WzEDhvlN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KNR2Ef5+
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -5.51
X-Rspamd-Queue-Id: B24C3220B6
X-Spam-Flag: NO

On Wed 17-01-24 13:53:20, Christian Brauner wrote:
> On Tue, Jan 16, 2024 at 12:45:19PM +0100, Jan Kara wrote:
> > On Tue 16-01-24 11:50:32, Christian Brauner wrote:
> > 
> > <snip the usecase details>
> > 
> > > My initial reaction is to give userspace an API to drop the page cache
> > > of a specific filesystem which may have additional uses. I initially had
> > > started drafting an ioctl() and then got swayed towards a
> > > posix_fadvise() flag. I found out that this was already proposed a few
> > > years ago but got rejected as it was suspected this might just be
> > > someone toying around without a real world use-case. I think this here
> > > might qualify as a real-world use-case.
> > > 
> > > This may at least help securing users with a regular dm-crypt setup
> > > where dm-crypt is the top layer. Users that stack additional layers on
> > > top of dm-crypt may still leak plaintext of course if they introduce
> > > additional caching. But that's on them.
> > 
> > Well, your usecase has one substantial difference from drop_caches. You
> > actually *require* pages to be evicted from the page cache for security
> > purposes. And giving any kind of guarantees is going to be tough. Think for
> > example when someone grabs page cache folio reference through vmsplice(2),
> > then you initiate your dmSuspend and want to evict page cache. What are you
> > going to do? You cannot free the folio while the refcount is elevated, you
> > could possibly detach it from the page cache so it isn't at least visible
> > but that has side effects too - after you resume the folio would remain
> > detached so it will not see changes happening to the file anymore. So IMHO
> > the only thing you could do without problematic side-effects is report
> > error. Which would be user unfriendly and could be actually surprisingly
> > frequent due to trasient folio references taken by various code paths.
> 
> I wonder though, if you start suspending userspace and the filesystem
> how likely are you to encounter these transient errors?

Yeah, my expectation is it should not be frequent in that case. But there
could be surprises there - e.g. pages mapping running executable code are
practically unevictable. Userspace should be mostly sleeping so there
shouldn't be many but there would be some so in the worst case that could
result in always returning error from the page cache eviction which would
not be very useful.

> > Sure we could report error only if the page has pincount elevated, not only
> > refcount, but it needs some serious thinking how this would interact.
> > 
> > Also what is going to be the interaction with mlock(2)?
> > 
> > Overall this doesn't seem like "just tweak drop_caches a bit" kind of
> > work...
> 
> So when I talked to the Gnome people they were interested in an optimal
> or a best-effort solution. So returning an error might actually be useful.

OK. So could we then define the effect of your desired call as calling
posix_fadvise(..., POSIX_FADV_DONTNEED) for every file? This is kind of
best-effort eviction which is reasonably well understood by everybody.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

