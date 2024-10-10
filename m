Return-Path: <linux-fsdevel+bounces-31615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73968998ED8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 19:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A9B286567
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 17:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B0F1C9EBA;
	Thu, 10 Oct 2024 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cVV9CWOd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XGVeQmfK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cVV9CWOd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XGVeQmfK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2464198831;
	Thu, 10 Oct 2024 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582679; cv=none; b=g/7o9EWyMSX7IrwSOfX69CWzIT1ZTvhtaYlArgX78FSi84zH9HtjKkV/cqAY4YuvPhT8OjjySRISnx9dQXkBq3UzQ8QEfeT8280Lfgssc+yCYCPur488ooeZFv78mFIZrIRjYdFEJTUrLKBVWs65L8r6CjaruREIHuWHt14+f1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582679; c=relaxed/simple;
	bh=jobFgPk37rqd3MarI9UadU6Ux0ibFBTduuVRuzoynUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAjbhFI/WminpCSduFVFtqEZhJs4ZW8Aex3jLykhLHFixCRlUdvYFCfLF0o01h0I8TJNAcMBw8flukP+pS/WtAtTRTBb5J4Cu+JSFQpQJMS1hpqFbvVPUoL75dqzJXuoL/REpdDQOZmsu1v+zmlBUpoIlhd3UUw8KiEXoSg3BpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cVV9CWOd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XGVeQmfK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cVV9CWOd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XGVeQmfK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 456C61FF0D;
	Thu, 10 Oct 2024 17:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728582676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEHVi7P5uqK9yzIu2JIFbFt6nNGwYO1WCrMyPid421o=;
	b=cVV9CWOd0wJ+FWjjPvP4VYovviTTPMGu45G5XNaHqXkwnySHdZHVrk+p6xCChHngQijf+d
	MfUMzeH2Ojc43/ijaXLogD2WaUJaTMr8ln7Ugn+eWc1nvm9s21oNzNkQhAvww94HUQf6ZH
	HgaAvl/L/IEW7Qq+JrpCqvFWKTXv/6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728582676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEHVi7P5uqK9yzIu2JIFbFt6nNGwYO1WCrMyPid421o=;
	b=XGVeQmfKMm20SrDiAkHVezgQsHdtImS8NaT+aY4CfHL486ORizUU8U5xVHd6vjDvjWoGob
	cQULAk87GmU5GfBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728582676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEHVi7P5uqK9yzIu2JIFbFt6nNGwYO1WCrMyPid421o=;
	b=cVV9CWOd0wJ+FWjjPvP4VYovviTTPMGu45G5XNaHqXkwnySHdZHVrk+p6xCChHngQijf+d
	MfUMzeH2Ojc43/ijaXLogD2WaUJaTMr8ln7Ugn+eWc1nvm9s21oNzNkQhAvww94HUQf6ZH
	HgaAvl/L/IEW7Qq+JrpCqvFWKTXv/6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728582676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEHVi7P5uqK9yzIu2JIFbFt6nNGwYO1WCrMyPid421o=;
	b=XGVeQmfKMm20SrDiAkHVezgQsHdtImS8NaT+aY4CfHL486ORizUU8U5xVHd6vjDvjWoGob
	cQULAk87GmU5GfBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FB1B13A6E;
	Thu, 10 Oct 2024 17:51:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SLKnORMUCGcNJwAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Thu, 10 Oct 2024 17:51:15 +0000
Date: Thu, 10 Oct 2024 13:51:06 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/12] iomap: add bioset in iomap_read_folio_ops for
 filesystems to use own bioset
Message-ID: <culcdpzjq7dhe2rvyalc4rfyucvcyijyttwtuoeqfayxm3ssbo@3l2zpexykayn>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <95262994f8ba468ab26f1e855224c54c2a439669.1728071257.git.rgoldwyn@suse.com>
 <ZwT_OwN9MOZSEseE@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwT_OwN9MOZSEseE@infradead.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On  2:45 08/10, Christoph Hellwig wrote:
> >  	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
> > +		struct bio_set *bioset;
> >  		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
> >  		gfp_t orig_gfp = gfp;
> >  		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
> 
> Nit: I try to keep variables just declared and not initialized after
> those initialized at declaration time.
> 
> > +
> > +		if (ctx->ops && ctx->ops->bio_set)
> > +			bioset = ctx->ops->bio_set;
> > +		else
> > +			bioset = &fs_bio_set;
> > +
> > +		ctx->bio = bio_alloc_bioset(iomap->bdev, bio_max_segs(nr_vecs),
> > +				REQ_OP_READ, gfp, bioset);
> > +
> 
> But it would be nice to move this logic into a helper, similar to what
> is done in the direct I/O code.  That should robably include
> picking the gfp flags from the ctx.
> 

Agree. I will put this in the next version.

-- 
Goldwyn

