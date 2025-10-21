Return-Path: <linux-fsdevel+bounces-64844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DA5BF5A60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F051883B97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1DC30216C;
	Tue, 21 Oct 2025 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cXu1hD3D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TqEsS6di";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BFA1XwD0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MQCft215"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9512E9EB9
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040365; cv=none; b=j4YXKEjPeAmIJ3XAMoyLCRxLLEF6yuxw83mG6eqcTW4sz+8JhkdVYJIkR2sic2VU24VhujUyQkAnQk/oncbumUMtcMZSUuPTeFMh6QwKbyhLKQcGMvZlZBr4zZ2z0h5AIPR+9EPqkXWEEBFSCDcPkotz4SIxUW8MuEg2DaBI4Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040365; c=relaxed/simple;
	bh=Z42OzteJF5QusmFJMGyrN4HZZnzGbMbHK+FJSwCsWCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ7B7QLFGGXVDGeiOAJE28cvc6XioPeqavsbrsApk2rl2hqePLfh12QSoR579lKLwmXe21MzpfqgZBLveVJd8TsTykpI7iZr3GeTrbokr60MGyVd+IIurrGm/GnVkD926Qi9fNXwchTMLDbigYyo78OMlgPhwGovJmD9Pz9zSsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cXu1hD3D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TqEsS6di; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BFA1XwD0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MQCft215; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41E8F211B8;
	Tue, 21 Oct 2025 09:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761040358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eBxxw3f33T7dC7DhUU8jalY0jdpMgHmW3egy3pJTZ98=;
	b=cXu1hD3DW0vdsQIk7D4cYPtyKnGahz5KGi60w+yB/LY4P0ia3EL66qhFFhiRJZL2x+JGnC
	UngbJYn453f1mnTcQKKXzt8ftBN0pT7u44fPCrMFgUR3Yj05EcMVC/vMkjn5xZ/dQeK7II
	PfJkMq/0CgC+tKKU3M5H51jyEi/c0KY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761040358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eBxxw3f33T7dC7DhUU8jalY0jdpMgHmW3egy3pJTZ98=;
	b=TqEsS6di4eGrYAmKVfQuYzjumkDaLTkO+A+kM3CmtI5sOnbV5l1hy98LF5gyL07lQCNwdH
	J1VbsQEB+zOmlJBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761040354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eBxxw3f33T7dC7DhUU8jalY0jdpMgHmW3egy3pJTZ98=;
	b=BFA1XwD0xHliRiWl4hKau00bDyfwzx+YxqUtwmgY/BhiiWBtONYJ670efAr6JHLjz1BxwL
	ZhPfnsDlexWzl4VlvF5IMfJA5KXAqRpxLYyuUFEJG7Kw/P5CRlKVHrkotKmD+WVuZJtvOo
	TMVC3XrLldJy78nw3xAP3q9xdfljN1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761040354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eBxxw3f33T7dC7DhUU8jalY0jdpMgHmW3egy3pJTZ98=;
	b=MQCft215cafvoyPNBAfugkI0jAdDJwgsSBHr6oWtBRJixDx74iu2UNt46hr2Lx7nIT5W0D
	MILGO04GH2nD+QAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 349C8139B1;
	Tue, 21 Oct 2025 09:52:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6qDZDOJX92gVYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Oct 2025 09:52:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D5389A0990; Tue, 21 Oct 2025 11:52:29 +0200 (CEST)
Date: Tue, 21 Oct 2025 11:52:29 +0200
From: Jan Kara <jack@suse.cz>
To: David Hildenbrand <david@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	Matthew Wilcox <willy@infradead.org>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	djwong@kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, martin.petersen@oracle.com, jack@suse.com
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
Message-ID: <ls6lz2ttduuwwtmmlzwfkybeuiqraymv7fon5crft6dv5gtst4@yh3noihpzvla>
References: <aPYIS5rDfXhNNDHP@infradead.org>
 <56o3re2wspflt32t6mrfg66dec4hneuixheroax2lmo2ilcgay@zehhm5yaupav>
 <aPYgm3ey4eiFB4_o@infradead.org>
 <mciqzktudhier5d2wvjmh4odwqdszvbtcixbthiuuwrufrw3cj@5s2ffnffu4gc>
 <aPZOO3dFv61blHBz@casper.infradead.org>
 <xc2orfhavfqaxrmxtsbf4kepglfujjodvhfzhzfawwaxlyrhlb@gammchkzoh2m>
 <5bd1d360-bee0-4fa2-80c8-476519e98b00@redhat.com>
 <aPc7HVRJYXA1hT8h@infradead.org>
 <rlu3rbmpktq5f3vgex3zlfjhivyohkhr5whpdmv3lscsgcjs7r@4zqutcey7kib>
 <750cfcac-e048-4fee-bba9-6e84edb7bbe0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <750cfcac-e048-4fee-bba9-6e84edb7bbe0@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 21-10-25 11:37:57, David Hildenbrand wrote:
> On 21.10.25 11:22, Jan Kara wrote:
> > On Tue 21-10-25 00:49:49, Christoph Hellwig wrote:
> > > On Mon, Oct 20, 2025 at 09:00:50PM +0200, David Hildenbrand wrote:
> > > > Just FYI, because it might be interesting in this context.
> > > > 
> > > > For anonymous memory we have this working by only writing the folio out if
> > > > it is completely unmapped and there are no unexpected folio references/pins
> > > > (see pageout()), and only allowing to write to such a folio ("reuse") if
> > > > SWP_STABLE_WRITES is not set (see do_swap_page()).
> > > > 
> > > > So once we start writeback the folio has no writable page table mappings
> > > > (unmapped) and no GUP pins. Consequently, when trying to write to it we can
> > > > just fallback to creating a page copy without causing trouble with GUP pins.
> > > 
> > > Yeah.  But anonymous is the easy case, the pain is direct I/O to file
> > > mappings.  Mapping the right answer is to just fail pinning them and fall
> > > back to (dontcache) buffered I/O.
> > 
> > I agree file mappings are more painful but we can also have interesting
> > cases with anon pages:
> > 
> > P - anon page
> > 
> > Thread 1				Thread 2
> > setup DIO read to P			setup DIO write from P
> 
> Ah, I was talking about the interaction between GUP and having
> BLK_FEAT_STABLE_WRITES set on the swap backend.
> 
> I guess what you mean here is: GUP from/to anon pages to/from a device that
> has BLK_FEAT_STABLE_WRITES?

Correct.

> So while we are writing to the device using the anon page as a source, the
> anon page will get modified.
> 
> I did not expect that to trigger checksum failures, but I can see the
> problem now.

Sadly it can because the checksum computation may end up using different
data than the DMA will send to the device a bit later. After all this is
why BLK_FEAT_STABLE_WRITES was invented...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

