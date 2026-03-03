Return-Path: <linux-fsdevel+bounces-79242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Md8IsjzpmkzawAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:44:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9101F1BA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16C213193AF2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 14:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13483B3BE9;
	Tue,  3 Mar 2026 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sZF5C3Hh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58E1430BBA;
	Tue,  3 Mar 2026 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548641; cv=none; b=GdAz3GzBupr4X2+MVXotwsFfccQ8LFCp9d1iTj7RFRCOqWoz205zYfTdUdbO3efOmloAoP73yIrbSqNAi9BNCkra4GF6sQRxzewqUZVamJirrIKf+8c5AUIQH11ECnKuR7FTNOeQqKDBZ2Ed01byo+6A8vnaRMxyACXVEOpo+AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548641; c=relaxed/simple;
	bh=jSW9+eytGEtkmitVtoPEoxlU0T6wDjF38zzCDPKXWFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lu1uB0aRtnsJrSQqKojXnvu7xFuNwpWTYdD+FBILWN3qALg8zSFyyC/1CAf0YQqoyUPcIZE0e5EpgjDGQHBUHaDwT4BmlpkeYrMwZ/qtdkHEBshnnoqltMLMlJ2FFoFBy4qvNhtcEkBrtz5Z/X3TNzgqWicEZMkfNkW4wOuG6dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sZF5C3Hh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=srOioLdU+MhT/muNv5h0T5v0JdnOgAAc/XvQpD6hWps=; b=sZF5C3HhHt2xqO3P2+9FLeg67C
	2LS909uYIig7JIA5ZDDdDoXuaC47rURaBqWQGZI1t6SXju2q8ZFv+GUdjGyVGKN/XR24jzbk3n88C
	UPGDCSFdqqdPw252SOvxznai7semOhP68884oeXUQx+TRELHqQk9F8BWQx1YiEhYpBaVEhKz05xze
	jzKYUaONemZCDcKZGC/SqZwE7EebHPnKMn6DEyH5JkvcoELcQqLFunWb+prUBpMeOMMzQXG43vzhm
	RcEC74u+O+Fq3R9jjrZ+2IY3B0I+dSJRCvdjYpqomO+sZx9KCpJ+SCxwvAkpUDGHrRQoG9Yhfa4ux
	aDHkYOSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxQs1-0000000FL2X-1Fxn;
	Tue, 03 Mar 2026 14:37:09 +0000
Date: Tue, 3 Mar 2026 06:37:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iomap, xfs: lift zero range hole mapping flush
 into xfs
Message-ID: <aabyFY0l7GTEHnoQ@infradead.org>
References: <20260129155028.141110-1-bfoster@redhat.com>
 <20260129155028.141110-2-bfoster@redhat.com>
 <aY6_eqkIrMkOr039@infradead.org>
 <aY9hY7TwgMXJNzkI@bfoster>
 <aaXesgEmu46X7OwD@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaXesgEmu46X7OwD@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 5A9101F1BA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_FROM(0.00)[bounces-79242-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 02:02:10PM -0500, Brian Foster wrote:
> I got a chance to look into this. Note that I don't reproduce a
> generic/127 failure (even after running a few iters), so I don't know if
> that might be related to something on your end. I reproduce the other
> two and those looked like straight failures to zero. From that I think
> the issue is just that xfs_zoned_buffered_write_iomap_begin() minimally
> needs the flush treatment from patch 1. I.e., something like the
> appended diff allows these tests to pass with -rzoned=1.
> 
> Technically this could use the folio batch helper, but given that we
> don't use that for the unwritten case (and thus already rely on the
> iomap flush), and that this is currently experimental, I think this is
> probably fine for now. Perhaps if we lift zeroing off into its own set
> of callbacks, that might be a good opportunity to clean this up in both
> places.

Note that unwritten extents aren't supported for zoned rt inodes, so
that case doesn't actually exist.

The changes themselves look good.  I kinda hate the very deep
indentation, but I can't really see a good way to fix that easily.


