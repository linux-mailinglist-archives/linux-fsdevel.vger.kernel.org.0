Return-Path: <linux-fsdevel+bounces-76950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SII0JCSijGlhrwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 16:37:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8E9125BC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 16:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DCD5302A1B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 15:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D829A308F1A;
	Wed, 11 Feb 2026 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2/HL/RxV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CC53090FD;
	Wed, 11 Feb 2026 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824208; cv=none; b=MU7GYVl2yRb0KtIJyTUhjwfNznvzPfEHtFw5ymYgMFtxyKsf00S6fGlLy8f05b8e4+KxCHk/hTXPmGsr5cSlwr/01nFq5qBdmqPflMfqBTeqZkWImUHbZUxa3P6SkZh6zazRUEaZR/6XvHq/Z82CmsKdCviSHBcxKfosL6DOwdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824208; c=relaxed/simple;
	bh=WJMNgtnE+vQzEPPuQj/rzkJg5/49P1a0CePxDzH8Eas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWWTfcNWMtgB7bXWmBeBtBZvGPjxqT3WBHtqCCiw+lyH1a+3Rqil7AKP7TzMhC9Pgfg3VELOMmErEMBQpPbrKONcCnyF6Q1v5LqRHiurpoJ2WQ6czz9fE1rZFSY2TV+jrc/1GraLgNhhkDyOpMLlD207j3Z61UxEwbinZJkVhJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2/HL/RxV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PNLS7mztLDXxLkKANq73DYvkDuOVqy+KgvHA4yDgYDo=; b=2/HL/RxVaenA39ruff/dt6dEgO
	uPbaEhp6RFr9fSEacYjz19YMe+X9Ov+A9eT45pSSEnAGcPu/SJkZ7OudfZteLhX/gwiytIjc4l0xe
	TwxXSTO02y7W1e9kCmwWus2v/DtD9MQGrWQbjGz+mNc6LbSHpwCb95PEzXnYsLv+zQM5veshEGxcX
	GY6Uy/YAWvUuEy2XbjAHSDIdFQVF5aB+dq6/OszikAWt6lWPBa/3VYDKXErLowwuHSia1/IwIe7uf
	xNtuoZN5IJ4QQsyTRG5kbKDTaDdYMko++AMuGFT7s1UV6ekZf8O+ZdssyC46qWXQLFsliP/gt1lrc
	yAWMzXJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqCGb-00000000nRp-132k;
	Wed, 11 Feb 2026 15:36:37 +0000
Date: Wed, 11 Feb 2026 07:36:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iomap, xfs: lift zero range hole mapping flush
 into xfs
Message-ID: <aYyiBcTx2IwfZUm2@infradead.org>
References: <20260129155028.141110-1-bfoster@redhat.com>
 <20260129155028.141110-2-bfoster@redhat.com>
 <aYtZtuqy72C0VvnQ@infradead.org>
 <aYuDhQj_xw3ByeD5@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYuDhQj_xw3ByeD5@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76950-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 1B8E9125BC2
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 02:14:13PM -0500, Brian Foster wrote:
> On Tue, Feb 10, 2026 at 08:15:50AM -0800, Christoph Hellwig wrote:
> > This looks sensible to me.  I'll add it to my zoned xfs test queue
> > to make sure it doesn't break anything there, but as the zoned
> > iomap_begin always allocates new space it should be fine.
> > 
> > 
> 
> Thanks. As you've probably noticed from looking through the rest of the
> patches, this one is mainly a lift-and-shift initial step from iomap to
> xfs. Let me know if anything breaks.

Well, to one of the iomap_begin instances.  We have an entirely
separate one for zoned mode, and we also fall back to the direct I/O
one when a rtextsize is set.  I don't think either of the moved
handling, but I want to be sure.


