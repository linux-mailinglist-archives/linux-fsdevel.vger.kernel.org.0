Return-Path: <linux-fsdevel+bounces-77242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lIMbMLNHkWk1hAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 05:12:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCA913DFBE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 05:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12EF23004DDD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 04:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753F52356BE;
	Sun, 15 Feb 2026 04:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Em1nwyyZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019158635D;
	Sun, 15 Feb 2026 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771128750; cv=none; b=RVvF8Kdvx7asdlnCQZlYmfn2jyG0LfF0nHl0zUGoIl61kc0k1pXAWsicA90HGubggKc74GDd+GPpMeiOcXiWccQEA3ZuEBttPpZxgvJUoaovmNPtdjRm0Obm89GvEt1v5vNI4qgQSnk999gk21EBzeSucb5yB5tHPibwjORLXS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771128750; c=relaxed/simple;
	bh=telMDwDPYXHk0p8H0dvNwmjCHle76BNL6efnVxd1yE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkSMbTVE1qxz435r8rCHJSBcmZR2bDlYCPtKkanjAMSyj5pEM69QH1Hi4tf/FSDXksopcON6x1VaS+Q1Zfju/h9Sv73HF4yM1KaPU0XFGPXujSHJzueByVLracS55GjmMA+Rxexs1jp8SJgVRjYmPEMi/PhD60d+kmH1YzZeB28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Em1nwyyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE5CC4CEF7;
	Sun, 15 Feb 2026 04:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771128749;
	bh=telMDwDPYXHk0p8H0dvNwmjCHle76BNL6efnVxd1yE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Em1nwyyZfplfO493edWfqF6KMKAJDtrqRdpWxquXEZ8GiawBrZxK2D8RWa5ZPgdUC
	 rvFJOAF4YgbgWv6UWhU+BAKq0WLlcoZM5XlBjipTi5dmnnT2QCRGWNRD4iedkINvsa
	 Ndcc6UKHw9lQgFXtdUj5oQi7cqhiXoIbNROHkdU6skhV4NIYAooQXHQnX9Su7Xp2i8
	 3jf3yI5ItLVXjqjZaUlVHW7SGTn6HNsKnrsKZ7P2nzOGdCbRo5aJ5UX2hBVFKu4bld
	 2fHdbxaX+/W/E2MNsKr8DgGikX5pmQM5tH5GrP3yV18hrcXp444KOj2/O4dsD+sfd+
	 q8app8lKVU8/A==
Date: Sat, 14 Feb 2026 20:11:44 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: fsverity@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2 1/2] f2fs: use fsverity_verify_blocks() instead of
 fsverity_verify_page()
Message-ID: <20260215041144.GA2872@sol>
References: <20260214211830.15437-1-ebiggers@kernel.org>
 <20260214211830.15437-2-ebiggers@kernel.org>
 <20260214215008.GA15997@quark>
 <aZE_rKsOAgYqTjZ_@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZE_rKsOAgYqTjZ_@casper.infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77242-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4DCA913DFBE
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 03:38:20AM +0000, Matthew Wilcox wrote:
> On Sat, Feb 14, 2026 at 01:50:08PM -0800, Eric Biggers wrote:
> > On Sat, Feb 14, 2026 at 01:18:29PM -0800, Eric Biggers wrote:
> > > +++ b/fs/f2fs/compress.c
> > > @@ -1811,15 +1811,19 @@ static void f2fs_verify_cluster(struct work_struct *work)
> > >  	int i;
> > >  
> > >  	/* Verify, update, and unlock the decompressed pages. */
> > >  	for (i = 0; i < dic->cluster_size; i++) {
> > >  		struct page *rpage = dic->rpages[i];
> > > +		struct folio *rfolio;
> > > +		size_t offset;
> > >  
> > >  		if (!rpage)
> > >  			continue;
> > > +		rfolio = page_folio(rpage);
> > > +		offset = folio_page_idx(rfolio, rpage) * PAGE_SIZE;
> > >  
> > > -		if (fsverity_verify_page(dic->vi, rpage))
> > > +		if (fsverity_verify_blocks(dic->vi, rfolio, PAGE_SIZE, offset))
> > >  			SetPageUptodate(rpage);
> 
> Yeah, no.
> 
> 		if (fsverity_verify_blocks(dic->vi, rfolio,
> 				folio_size(rfolio), 0));
> 			folio_mark_uptodate(rfolio);
> 
> > >  		else
> > >  			ClearPageUptodate(rpage);
> 
> This never needed to be here.  The folio must already be !uptodate.
> Just delete these two lines.
> 
> > >  		unlock_page(rpage);
> 
> folio_unlock(rfolio);

Sure.  This kind of scope creep is why I wanted to just do the
straightforward conversion for now.

- Eric

