Return-Path: <linux-fsdevel+bounces-9873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95976845957
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 14:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82371C27E1B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 13:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A138C5D49B;
	Thu,  1 Feb 2024 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wnr/ij3c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ObB0qpuj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wnr/ij3c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ObB0qpuj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FE45CDEC;
	Thu,  1 Feb 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795556; cv=none; b=UIsHoVhZFBv3EcETzPIjj5JkioeW85lvQO2Of2yv58zpT6hLBYPs1V/sE5TSnimAz4kdaNn9dWPnIJD1fQ9Wa4kAtUPmYg6kkKxibNnkYwJFhb3dF4psDZU2unpUHOujNixaHzmR3Ctcg3f5MFAl2mRKvMz2r4RGKRPIXVAM/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795556; c=relaxed/simple;
	bh=rEX9GUMW7rfBrCx8VpRtb1mBFzM/kN0JmS9EePHlTC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiK++uqfZGKTyI356LKM5xCocOusZZ5wG86VABv3V1nUrXmnzDenFiSgXoedNFSO9RUmRpiORrxtNjEQL6JstfafVXmJPHr+TcL9fijbB4XSMe25bw6ETlh+fZmbQIWMRAXJn5AdrP3ZlDNaNZhRCMgQ4w3KfSxOXNbceT/V7/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wnr/ij3c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ObB0qpuj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wnr/ij3c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ObB0qpuj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25C8E2216C;
	Thu,  1 Feb 2024 13:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706795552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXLAKSzHX3H7LPzmvOeu1w9fqDyHIC6pdFRLsbYn6qU=;
	b=Wnr/ij3cMxbQLn1J5JeiEN3JP3xSrwMxBG7wen/9M+eXezXyuPZuf/P+usPZaJlgzx0vI2
	dsT/79GLcdEicmUXpa7/V0nK09Y2hjYPAd3lDtcFYQB71aq0X7wUFladF7H7NutqtZrK8R
	bEN3lTZURBQtT6H1FUL5y/aAovSYJGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706795552;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXLAKSzHX3H7LPzmvOeu1w9fqDyHIC6pdFRLsbYn6qU=;
	b=ObB0qpujeoxkArOyrTmPv46kyZCeJVO+CPQl6xTZopBwm6HvYMYNwh+As6rGhyHXDogBoS
	buDTjdUv61uYcABg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706795552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXLAKSzHX3H7LPzmvOeu1w9fqDyHIC6pdFRLsbYn6qU=;
	b=Wnr/ij3cMxbQLn1J5JeiEN3JP3xSrwMxBG7wen/9M+eXezXyuPZuf/P+usPZaJlgzx0vI2
	dsT/79GLcdEicmUXpa7/V0nK09Y2hjYPAd3lDtcFYQB71aq0X7wUFladF7H7NutqtZrK8R
	bEN3lTZURBQtT6H1FUL5y/aAovSYJGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706795552;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXLAKSzHX3H7LPzmvOeu1w9fqDyHIC6pdFRLsbYn6qU=;
	b=ObB0qpujeoxkArOyrTmPv46kyZCeJVO+CPQl6xTZopBwm6HvYMYNwh+As6rGhyHXDogBoS
	buDTjdUv61uYcABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 185C313672;
	Thu,  1 Feb 2024 13:52:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ajPtBSCiu2XWSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 13:52:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A6C19A0809; Thu,  1 Feb 2024 14:52:31 +0100 (CET)
Date: Thu, 1 Feb 2024 14:52:31 +0100
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Liu Shixin <liushixin2@huawei.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/readahead: stop readahead loop if memcg charge
 fails
Message-ID: <20240201135231.tgnn7cnlmtqh5n4f@quack3>
References: <20240201100835.1626685-1-liushixin2@huawei.com>
 <20240201100835.1626685-2-liushixin2@huawei.com>
 <Zbug14NoOHFmfLst@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbug14NoOHFmfLst@casper.infradead.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[10.62%]
X-Spam-Flag: NO

On Thu 01-02-24 13:47:03, Matthew Wilcox wrote:
> On Thu, Feb 01, 2024 at 06:08:34PM +0800, Liu Shixin wrote:
> > @@ -247,9 +248,12 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> >  		folio = filemap_alloc_folio(gfp_mask, 0);
> >  		if (!folio)
> >  			break;
> > -		if (filemap_add_folio(mapping, folio, index + i,
> > -					gfp_mask) < 0) {
> > +
> > +		ret = filemap_add_folio(mapping, folio, index + i, gfp_mask);
> > +		if (ret < 0) {
> >  			folio_put(folio);
> > +			if (ret == -ENOMEM)
> > +				break;
> 
> No, that's too early.  You've still got a batch of pages which were
> successfully added; you have to read them.  You were only off by one
> line though ;-)

There's a read_pages() call just outside of the loop so this break is
actually fine AFAICT.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

