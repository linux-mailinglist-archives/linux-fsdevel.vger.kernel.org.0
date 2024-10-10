Return-Path: <linux-fsdevel+bounces-31614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68C9998EC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 19:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35BC71F2409B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 17:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622CC19D064;
	Thu, 10 Oct 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zllPLjR8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EYx4iYDN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zllPLjR8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EYx4iYDN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7D192D67;
	Thu, 10 Oct 2024 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582624; cv=none; b=YxpsGP4CIvXpVsgQR136cScYonDC32icO2sOXfcQAltR+WEOIz69wMr1MnMRS/Ya28s3TK94dvmO2mhT2edtGEHC7dw5q5CdJErToLiPw+dP8Ge6kB0qv+p67woF633CMHzO4xKxNqI+Vjo/T/d26kweKE95uyptI8jLMAKC/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582624; c=relaxed/simple;
	bh=iztxLkH+6QeNEq3pKGgSEMGZyZe5s+OlEO+YHMVWhMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNNaWMja4N9PhKzhWJFeip6TWpPNiCMULZGCI4Vb0havmC6PyaeTyN2Z2owsFY6hh6iTfrLUi8+HXl6edCMBGQQ+CvfbcjbT3OYWVe2lbR6i+TsDfdiyE7uYXYw+NykiqkwpR23spJqYYHvSvqDmv7Ox54yMfN7t+nWaqcZ35YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zllPLjR8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EYx4iYDN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zllPLjR8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EYx4iYDN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA9261FF0D;
	Thu, 10 Oct 2024 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728582620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zvXSIBVuGePrZ2AW5JUzbcF3MdB5n2e5htVDCCOf188=;
	b=zllPLjR8998NRT3mUgDJMpdQwfc55CEoT26Yx1+ORCRuPq0IKJLZfn+uhvXiQ6asQLLjAP
	vqWoYFFPeRc8jEkIjn76gMgXkL2otrXeLbdqoIneoGBZzt2NT6LOo8OPd/jnyhVa6KsFE7
	11jfaYeadlcH6Oa4G56qX6LqEJLZ7Wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728582620;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zvXSIBVuGePrZ2AW5JUzbcF3MdB5n2e5htVDCCOf188=;
	b=EYx4iYDNxr/bH6FrEDSg4+qqs6NQxCg9rpfH0pPGNgvFsVv7I+mgHe5LrXHS4EtJvhZsma
	1E4h5qBd8Q0NDRCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728582620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zvXSIBVuGePrZ2AW5JUzbcF3MdB5n2e5htVDCCOf188=;
	b=zllPLjR8998NRT3mUgDJMpdQwfc55CEoT26Yx1+ORCRuPq0IKJLZfn+uhvXiQ6asQLLjAP
	vqWoYFFPeRc8jEkIjn76gMgXkL2otrXeLbdqoIneoGBZzt2NT6LOo8OPd/jnyhVa6KsFE7
	11jfaYeadlcH6Oa4G56qX6LqEJLZ7Wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728582620;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zvXSIBVuGePrZ2AW5JUzbcF3MdB5n2e5htVDCCOf188=;
	b=EYx4iYDNxr/bH6FrEDSg4+qqs6NQxCg9rpfH0pPGNgvFsVv7I+mgHe5LrXHS4EtJvhZsma
	1E4h5qBd8Q0NDRCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F8D413A6E;
	Thu, 10 Oct 2024 17:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Zes9IdwTCGe/JgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Thu, 10 Oct 2024 17:50:20 +0000
Date: Thu, 10 Oct 2024 13:50:11 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH 05/12] iomap: Introduce IOMAP_ENCODED
Message-ID: <3g2onw33g6fsz53eaygt3mrlv3yuuqm3kj6fvnr2tcamk3m5xo@5exfubdurtr4>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <d886ab58b1754342797d84b1fa06fea98b6363f8.1728071257.git.rgoldwyn@suse.com>
 <ZwT_-7RGl6ygY6dz@infradead.org>
 <ZwehmQt52_iSMLeL@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwehmQt52_iSMLeL@infradead.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Level: 

On  2:42 10/10, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 02:48:43AM -0700, Christoph Hellwig wrote:
> > In general I'm not a huge fan of the encoded magic here, but I'll
> > need to take a closer look at the caller if I can come up with
> > something better.
> 
> I looked a bit more at the code.  I'm not entirely sure I fully
> understand it yet, but:
> 
> I think most of the read side special casing would be handled by
> always submitting the bio at the end of an iomap.  Ritesh was
> looking into that for supporting ext2-like file systems that
> read indirect block ondemand, but I think it actually is fundamentally
> the right thing to do anyway.
> 
> For the write we plan to add a new IOMAP_BOUNDARY flag to prevent
> merges as part of the XFS RT group series, and I think this should
> also solve your problems with keeping one bio per iomap?  The
> current patch is here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=djwong-wtf&id=91b5d7a52dab63732aee451bba0db315ae9bd09b
> 

Yes, this is helpful but it will solve only one of the three
requirements.

The first, compressed and uncompressed extents are to be dealth with
differently because of the additional step of uncompressing the bio
corresponding to the extent. So, iomap needs to inform btrfs that the
bio submitted (through newly created function submit_io()) is compressed
and needs to be read and decompressed.

The second, btrfs sets the bi_sector to the start of the extent map
and the assignment cannot go through iomap_sector(). Compressed extents
being smaller than regular one, iomap_sector would most of the times
overrun beyond the compressed extent. So, in this patchset, I am setting
this in ->submit_io()


-- 
Goldwyn

