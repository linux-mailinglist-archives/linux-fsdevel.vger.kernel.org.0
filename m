Return-Path: <linux-fsdevel+bounces-64839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 673ECBF5868
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A6434FF038
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F24A2DAFC0;
	Tue, 21 Oct 2025 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vsxheCdR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1XLWtYVd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cT5C10Rg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dA7tqWQ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6302D7802
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039199; cv=none; b=lKRAbyLi0NLWDirbf4Nh6DBTiu+xtHSoxQRNRSI0Xjfxc1fDTLFrgxYijaDW6upjV7hUq5mS/v/GugOtk6BtWpmIDJS5YyUDhOJivP2hILb2fvI3Xr6EtpyvgN1l3E6ypXOXsMdRQySZdEgmmYDmXGXl9Pin6JAbe4+mgzHl0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039199; c=relaxed/simple;
	bh=V1c1FKu6pUnn4HWUCVlSUqqZynYmbfJxktxfe0gWFRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Opz93DKn+gxBaxJ9ZMmwT/TwxSk1jd5xHzDDHxEzhX/d2hyPOs6ybNIk6RP4uYACV36QZ8TCjBjQ0ZRFV7j+9GhNJbPpDff44v57+ZpZzasRtdz9hHQwDxcczhdMrsrRX0jYCOeaIDb7DY57Uhd1DKyEuYohQLFYFeSc4WbIkOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vsxheCdR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1XLWtYVd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cT5C10Rg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dA7tqWQ0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 838F81F789;
	Tue, 21 Oct 2025 09:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761039191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l6jrOugP6myyf/5E3eorz/pv7W1Npv0nq8xpovchIB0=;
	b=vsxheCdRjrOHhnzU9sliWiF4N1NvoOQhIr4hyVbo6LiXsDs0Hkk9+OOkVI/H+JyMTFvXBE
	BaByXhHFIUJ0GznoGxDdH/9GOuS7Zm2MMgZQo3boWzU4G03jizOIuqNu9FrnwEDV3Iy/S5
	WXpNfyOV6nkfcoivEHiCH0398uo2qaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761039191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l6jrOugP6myyf/5E3eorz/pv7W1Npv0nq8xpovchIB0=;
	b=1XLWtYVd7w2SRA+Gd1uEk/ACLhQAyAR1CPT1894L0N4uV5JF0eEZS1tRZN/cCM3+KE85P+
	tc9mKrOAfVU8dYAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761039187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l6jrOugP6myyf/5E3eorz/pv7W1Npv0nq8xpovchIB0=;
	b=cT5C10RgzTrCqIKTEejIt3D16fqA5h0XfPqNjSWvFPHszuWGmEqQYe15/q6wRAXg8kewy+
	GbVaVYp5occgadJn+pv2rgZw9wwV7CUsTTvNC3spv4W5x0JBTzj2Ct4ZCRF272ve0v/pjx
	LZucASHxDmUeJpj+6TU0RIOu2lR8IJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761039187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l6jrOugP6myyf/5E3eorz/pv7W1Npv0nq8xpovchIB0=;
	b=dA7tqWQ0sKLRQ7FfVYSjol2Z/XT2xHVSi0VoLKONvL3WlMMwsLpcdBrpuzwlVsJ2aRUXlE
	bJ9NN2iW0zzeDvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7164813A38;
	Tue, 21 Oct 2025 09:33:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kCaqG1NT92hITQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Oct 2025 09:33:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 159C1A0990; Tue, 21 Oct 2025 11:33:03 +0200 (CEST)
Date: Tue, 21 Oct 2025 11:33:03 +0200
From: Jan Kara <jack@suse.cz>
To: David Hildenbrand <david@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	djwong@kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, martin.petersen@oracle.com, jack@suse.com
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
Message-ID: <rizci7wwm7ncrc6uf7ibtiap52rqghe7rt6ecrcoyp22otqwu4@bqksgiaxlc5v>
References: <1ee861df6fbd8bf45ab42154f429a31819294352.1760951886.git.wqu@suse.com>
 <aPYIS5rDfXhNNDHP@infradead.org>
 <56o3re2wspflt32t6mrfg66dec4hneuixheroax2lmo2ilcgay@zehhm5yaupav>
 <aPYgm3ey4eiFB4_o@infradead.org>
 <mciqzktudhier5d2wvjmh4odwqdszvbtcixbthiuuwrufrw3cj@5s2ffnffu4gc>
 <aPZOO3dFv61blHBz@casper.infradead.org>
 <xc2orfhavfqaxrmxtsbf4kepglfujjodvhfzhzfawwaxlyrhlb@gammchkzoh2m>
 <5bd1d360-bee0-4fa2-80c8-476519e98b00@redhat.com>
 <aPc7HVRJYXA1hT8h@infradead.org>
 <32a9b501-742d-4954-9207-bb7d0c08fccb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32a9b501-742d-4954-9207-bb7d0c08fccb@redhat.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 21-10-25 09:57:08, David Hildenbrand wrote:
> On 21.10.25 09:49, Christoph Hellwig wrote:
> > On Mon, Oct 20, 2025 at 09:00:50PM +0200, David Hildenbrand wrote:
> > > Just FYI, because it might be interesting in this context.
> > > 
> > > For anonymous memory we have this working by only writing the folio out if
> > > it is completely unmapped and there are no unexpected folio references/pins
> > > (see pageout()), and only allowing to write to such a folio ("reuse") if
> > > SWP_STABLE_WRITES is not set (see do_swap_page()).
> > > 
> > > So once we start writeback the folio has no writable page table mappings
> > > (unmapped) and no GUP pins. Consequently, when trying to write to it we can
> > > just fallback to creating a page copy without causing trouble with GUP pins.
> > 
> > Yeah.  But anonymous is the easy case, the pain is direct I/O to file
> > mappings.  Mapping the right answer is to just fail pinning them and fall
> > back to (dontcache) buffered I/O.
> 
> Right, I think the rules could likely be
> 
> a) Don't start writeback to such devices if there may be GUP pins (o
> writeble PTEs)
> 
> b) Don't allow FOLL_WRITE GUP pins if there is writeback to such a device
> 
> Regarding b), I would have thought that GUP would find the PTE to not be
> writable and consequently trigger a page fault first to make it writable?
> And I'd have thought that we cannot make such a PTE writable while there is
> writeback to such a device going on (otherwise the CPU could just cause
> trouble).

See some of the cases in my reply to Christoph. It is also stuff like:

c) Don't allow FOLL_WRITE GUP pins or writeable mapping if there are *any*
pins to the page.

And we'd have to write-protect the page in the page tables at the moment we
obtain the FOLL_WRITE GUP pin to make sure the pin owner is the only thread
able to modify that page contents while the DIO is running.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

