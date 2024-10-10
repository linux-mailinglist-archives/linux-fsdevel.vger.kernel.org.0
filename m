Return-Path: <linux-fsdevel+bounces-31616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD82998F24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 20:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C6628A988
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38EB1CF5CA;
	Thu, 10 Oct 2024 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GaOyFUCl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lMNywhqu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GaOyFUCl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lMNywhqu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD27A1A303E;
	Thu, 10 Oct 2024 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583177; cv=none; b=rLFeLwVARnc/qYllr39019MTV1yMfn/eZmRhTqfEmyfKr34IYYlPi5E+WHwoB8Q1JC+2xreGD107EUeORBlU16/Q0Qr48lhziYiinzSanm3u8znYptvALk2D7q1HbjkrzYlW0UX7GDRymqznreoRKo9zbqZ4UKwBHC7Pfywt38Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583177; c=relaxed/simple;
	bh=LiD7vn9UaKuYu20gAZSRSctodlEXfQdvwAr+GwhvP6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7CW7qlEeh5LLd+nSyHgRzEOmUp94D9jXhPDk6Y/sp3kmX9w8Y9yvVecLC2b1tvExIoftQHq1sfuLvNUCM4V1L8+OGOh2F/ENo0x5bQz34Bxtz4JaucWCzxSFutTFM/XX5U92NONpeQfVaVIxUzIomCMjYe2w6l8hm++Nwz3wGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GaOyFUCl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lMNywhqu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GaOyFUCl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lMNywhqu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 076771F7CA;
	Thu, 10 Oct 2024 17:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728583174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OYloz41atnEU9KGvrudBHX1NHw+eyzBmtPQX70peJt8=;
	b=GaOyFUCl5KQQiNxrmlFjfrlZuw6U31aa9qJLlSM9sCuqDmDZMq37RCXUDk3XBdLcFvIhSc
	2G8N6Wz4p4Sw/JRB3Veeih121d3oNe5Fxxev3maOPOBR5NtWUQxb7BbYScJxe00t5YJeOa
	9O2fVLs91TnlIDt/2Mw+0BIiFooxtAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728583174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OYloz41atnEU9KGvrudBHX1NHw+eyzBmtPQX70peJt8=;
	b=lMNywhquqndwVq8EDLokjRfnsiq2xkh2NMXIzf3wM2Q+/I9+NXHBzikkOym2aslBkKD9lK
	CQ4hoBt2XKZ5vLBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728583174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OYloz41atnEU9KGvrudBHX1NHw+eyzBmtPQX70peJt8=;
	b=GaOyFUCl5KQQiNxrmlFjfrlZuw6U31aa9qJLlSM9sCuqDmDZMq37RCXUDk3XBdLcFvIhSc
	2G8N6Wz4p4Sw/JRB3Veeih121d3oNe5Fxxev3maOPOBR5NtWUQxb7BbYScJxe00t5YJeOa
	9O2fVLs91TnlIDt/2Mw+0BIiFooxtAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728583174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OYloz41atnEU9KGvrudBHX1NHw+eyzBmtPQX70peJt8=;
	b=lMNywhquqndwVq8EDLokjRfnsiq2xkh2NMXIzf3wM2Q+/I9+NXHBzikkOym2aslBkKD9lK
	CQ4hoBt2XKZ5vLBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4ABE13A6E;
	Thu, 10 Oct 2024 17:59:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZtBPKgUWCGd2KQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Thu, 10 Oct 2024 17:59:33 +0000
Date: Thu, 10 Oct 2024 13:59:32 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/12] iomap: check if folio size is equal to FS block
 size
Message-ID: <dsadzwqd4z7plotdv277kayokkffovjcsqzywyuln44hodiqou@3ptvfoj45t4m>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <b25b678264d02e411cb2c956207e2acd95188e4c.1728071257.git.rgoldwyn@suse.com>
 <ZwChy4jNCP6gJNJ0@casper.infradead.org>
 <20241007165701.GB21836@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007165701.GB21836@frogsfrogsfrogs>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On  9:57 07/10, Darrick J. Wong wrote:
> On Sat, Oct 05, 2024 at 03:17:47AM +0100, Matthew Wilcox wrote:
> > On Fri, Oct 04, 2024 at 04:04:28PM -0400, Goldwyn Rodrigues wrote:
> > > Filesystems such as BTRFS use folio->private so that they receive a
> > > callback while releasing folios. Add check if folio size is same as
> > > filesystem block size while evaluating iomap_folio_state from
> > > folio->private.
> > > 
> > > I am hoping this will be removed when all of btrfs code has moved to
> > > iomap and BTRFS uses iomap's subpage.
> > 
> > This seems like a terrible explanation for why you need this patch.
> > 
> > As I understand it, what you're really doing is saying that iomap only
> > uses folio->private for block size < folio size.  So if you add this
> > hack, iomap won't look at folio->private for block size == folio size
> > and that means that btrfs can continue to use it.
> > 
> > I don't think this is a good way to start the conversion.  I appreciate
> > that it's a long, complex procedure, and you can't do the whole
> > conversion in a single patchset.
> > 
> > Also, please stop calling this "subpage".  That's btrfs terminology,
> > it's confusing as hell, and it should be deleted from your brain.
> 
> I've long wondered if 'subpage' is shorthand for 'subpage blocksize'?
> If so then the term makes sense to me as a fs developer, but I can also
> see how it might not make sense to anyone from the mm side of things.

Yes, it is subpage blocksize.

> 
> Wait, is a btrfs sector the same as what ext4/xfs call a fs block?

Yup, fs_info->sectorsize.

> 
> > But I don't understand why you need it at all.  btrfs doesn't attach
> > private data to folios unless block size < page size.  Which is precisely
> > the case that you're not using.  So it seems like you could just drop
> > this patch and everything would still work.
> 
> I was also wondering this.  Given that the end of struct btrfs_subpage
> is an uptodate/dirty/ordered bitmap, maybe iomap_folio_ops should grow a
> method to allocate a struct iomap_folio_state object, and then you could
> embed one in the btrfs subpage object and provide that custom allocation
> function?
> 
> (and yes that makes for an ugly mess of pointer math crud to have two
> VLAs inside struct btrfs_subpage, so this might be too ugly to live in
> practice)
> 

btrfs does use iomap->private  and writes out EXTENT_FOLIO_PRIVATE. This
is not ideal, but it requires it to get a callback from mm before folios
are released. Refer set_folio_extent_mapped(). BTRFS does it for every
folio (for filesystems which is not a subpage blocksize). Perhaps there
is a better way to do this?

Ideally, after the move to iomap, we should not require btrfs_subpage
structures, and most (if not all) folio "handlings" will be done by
iomap but that is still far way off.

-- 
Goldwyn

