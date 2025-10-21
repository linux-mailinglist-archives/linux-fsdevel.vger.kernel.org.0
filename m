Return-Path: <linux-fsdevel+bounces-64838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D933BF57B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1032118937AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7633B32AAD8;
	Tue, 21 Oct 2025 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wIo5oCUa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZUGe23PS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zknEK/zc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kPU+3C/Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092D1328B67
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038552; cv=none; b=e7wvCaKje3JvBY8VIl+7sRJbdzdNoUDxrkACNxRrSoIkvK/ZmPUDuzgTWFPIbyeoLfhbTKM5dFxKP4KQnj9AxeIevs5xO0tKrp4xZLwFmA2WQAXwKMWLSmFLL9K+NRMLsBKC+Kh/vgO9JekrFoA476E5z7KLrgaAG1zTupPu8Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038552; c=relaxed/simple;
	bh=gJAoVD9cju/1QVu+U4Azd3fptDN/X0ouQarhkAlBbwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/GJS+U4I5/mJ1BgXb1IhlL+cvUk6yHBiSJRYojzN+aXZpp6KSfJlKl8yW8kFr2Pj7kTXKkqGBUtfAe1lnc/ZsQz90ioKpfkWUJeRJAoxvq+vpWn23LtJGdjObSW1ayO1K5jZpPuyzn6dIfRxGanMwqvfObWWMKu9Y2R0FDExnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wIo5oCUa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZUGe23PS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zknEK/zc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kPU+3C/Y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 14C5A1F445;
	Tue, 21 Oct 2025 09:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761038545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aAlZsLpmZR4ppbAmqbxDqov94GN0TMQzZ5ttVOeE6Qg=;
	b=wIo5oCUa2Zf6G/b0DE8QuyA+165ilNoG6Td2Qi4HjGX9sJzbMwWLg/e2M+kyyGbM6Ds07f
	cSfr7fAh8edu7gMHsAzEAJWI+d74RfJ7DFit0Z2j6difanldXOGRK9casSAWZBWrGOVlLs
	8UxQ+xl1xFvdecu9KYCrVB6XFkAYOyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761038545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aAlZsLpmZR4ppbAmqbxDqov94GN0TMQzZ5ttVOeE6Qg=;
	b=ZUGe23PSGWx1vK7/4Jv6B2vxq/TLQ7rOdCDZIKb1LmySP/5zaStEv4m1wLAa0kzyGtcd6d
	VaHXSCps+TFIy2Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="zknEK/zc";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="kPU+3C/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761038541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aAlZsLpmZR4ppbAmqbxDqov94GN0TMQzZ5ttVOeE6Qg=;
	b=zknEK/zc7CEYMwKxbENGVk7jGMw3bjyuGtCZn9IcWRGlybq7iQmHt5lN58n4/OMjuNou5W
	HVtTO+f7TsnPkfgFyllmcwRa65KdqqnXvoZNPGg/j4wYkZG/wUz0VVcsoO9UQV+Ui3CTDP
	DBsyHI7OST7PQifcontK6lwoUXHBvOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761038541;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aAlZsLpmZR4ppbAmqbxDqov94GN0TMQzZ5ttVOeE6Qg=;
	b=kPU+3C/YjFWWX0UvEImfaygoAOL4KZLRLoIVZmxPI41j8uiYELf8HzIepXlft+4PX0ZqlJ
	8+YAZu8pue5iQLAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2222139D2;
	Tue, 21 Oct 2025 09:22:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5JsZO8xQ92joQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Oct 2025 09:22:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 979FEA0990; Tue, 21 Oct 2025 11:22:20 +0200 (CEST)
Date: Tue, 21 Oct 2025 11:22:20 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	djwong@kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, martin.petersen@oracle.com, jack@suse.com
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
Message-ID: <rlu3rbmpktq5f3vgex3zlfjhivyohkhr5whpdmv3lscsgcjs7r@4zqutcey7kib>
References: <1ee861df6fbd8bf45ab42154f429a31819294352.1760951886.git.wqu@suse.com>
 <aPYIS5rDfXhNNDHP@infradead.org>
 <56o3re2wspflt32t6mrfg66dec4hneuixheroax2lmo2ilcgay@zehhm5yaupav>
 <aPYgm3ey4eiFB4_o@infradead.org>
 <mciqzktudhier5d2wvjmh4odwqdszvbtcixbthiuuwrufrw3cj@5s2ffnffu4gc>
 <aPZOO3dFv61blHBz@casper.infradead.org>
 <xc2orfhavfqaxrmxtsbf4kepglfujjodvhfzhzfawwaxlyrhlb@gammchkzoh2m>
 <5bd1d360-bee0-4fa2-80c8-476519e98b00@redhat.com>
 <aPc7HVRJYXA1hT8h@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPc7HVRJYXA1hT8h@infradead.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 14C5A1F445
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
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Tue 21-10-25 00:49:49, Christoph Hellwig wrote:
> On Mon, Oct 20, 2025 at 09:00:50PM +0200, David Hildenbrand wrote:
> > Just FYI, because it might be interesting in this context.
> > 
> > For anonymous memory we have this working by only writing the folio out if
> > it is completely unmapped and there are no unexpected folio references/pins
> > (see pageout()), and only allowing to write to such a folio ("reuse") if
> > SWP_STABLE_WRITES is not set (see do_swap_page()).
> > 
> > So once we start writeback the folio has no writable page table mappings
> > (unmapped) and no GUP pins. Consequently, when trying to write to it we can
> > just fallback to creating a page copy without causing trouble with GUP pins.
> 
> Yeah.  But anonymous is the easy case, the pain is direct I/O to file
> mappings.  Mapping the right answer is to just fail pinning them and fall 
> back to (dontcache) buffered I/O.

I agree file mappings are more painful but we can also have interesting
cases with anon pages:

P - anon page

Thread 1				Thread 2
setup DIO read to P			setup DIO write from P

And now you can get checksum failures for the write unless the write is
bounced (falling back to dontcache). Similarly with reads:

Thread 1				Thread 2
setup DIO read to P			setup DIO read to P

you can get read checksum mismatch unless both reads are bounced (bouncing
one of the reads is not enough because the memcpy from the bounce page to
the final buffer may break checksum computation of the IO going directly).

So to avoid checksum failures even if user screws up and buffers overlap we
need to bounce every IO even to/from anon memory. Or we need to block one
of the IOs until the other one completes - a scheme that could work is we'd
try to acquire kind of exclusive pin to all the pages (page lock?). If we
succeed, we run the IO directly. If we don't succeed, we wait for the
exclusive pins to be released, acquire standard pin (to block exclusive
pinning) and *then* submit uncached IO. But it is all rather complex and
I'm not sure it's worth it...

For file mappings things get even more complex because you can do:

P - file mapping page

Thread 1				Thread 2
setup DIO write from P			setup buffered write from Q to P

and you get checksum failures for the DIO write. So if we don't bounce the
DIO, we'd also have to teach buffered IO to avoid corrupting buffers of DIO
in flight.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

