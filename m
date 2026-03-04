Return-Path: <linux-fsdevel+bounces-79404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLtxFTxFqGlOrwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:44:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CAD201D45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C980B3030EC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE22C3AE6E4;
	Wed,  4 Mar 2026 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mKMmQUcw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D28238166;
	Wed,  4 Mar 2026 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772635285; cv=none; b=MgwB3IE6rlKneF0GJoIgdIPVuUzAxpcU9erP1w9IVvEOAagYqT8azfgi7xoct3YToC5X0SWISjMMWaOEMLiT77nt0Qoca6Wak3Yo+T0JxBQ/zngxYMgrbbrafq6QuiugTCTS4nqXYKNGb8FrIJ94cMdv9ZgsZVf7LT0yAdDKqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772635285; c=relaxed/simple;
	bh=JHhe0b5uRCKPquKmKU3yU0f4u1yAgujqMlLfOipat70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HASmiUx1RBy9HjrLKUgx2pMj7dOzYHtCY+NMSjoLbBKn5te8TlgCzndcoEU14bS/3R4DFvAL5Rm7yo1myUz6faPE6DcWbIgOm3kN0KinNjK0lrX2xXxBmyw8sFLdsv8/NSY+QT9bFhj1lvZqYZqGkdrLtQ1leUbhkz1zWHP0TIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mKMmQUcw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CEBxN2sxgSUGncdU2S40J1gB4jfFBcffVwdcttPbgjY=; b=mKMmQUcwp+LppXXThRDay4A7qg
	xJqm1mSse/KAY9qnEiZcHRNaE7SrU+mBeznVnBiGNNahXNScCRdNMctyYT1AEgipUsrUux7WCt3Is
	lhL8XcBKtYgq1aq0NJu1YylM8obniSaez5kgYymqZa+CvshgM3a23kZgw+IvvIMFjglMG8wJgh40f
	dPlLYcYxmzdNumQej64RMvUGL1TlT1EXSenlhr68NKB87E1+JlteOAEl0aUnFgu8VQAjBsWJUdmWz
	qDzrL3iqRVjhLBTE2GMuK6c3zBFlTZ14/isdHNQzOd+QyJK+owTcRcW8uD9qZ5oyb3tVVBPt2Uo/8
	RTYaTxMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxnPf-0000000HQmR-0jaG;
	Wed, 04 Mar 2026 14:41:23 +0000
Date: Wed, 4 Mar 2026 06:41:23 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iomap, xfs: lift zero range hole mapping flush
 into xfs
Message-ID: <aahEk4yNqd15BIt7@infradead.org>
References: <20260129155028.141110-1-bfoster@redhat.com>
 <20260129155028.141110-2-bfoster@redhat.com>
 <aY6_eqkIrMkOr039@infradead.org>
 <aY9hY7TwgMXJNzkI@bfoster>
 <aaXesgEmu46X7OwD@bfoster>
 <aabyFY0l7GTEHnoQ@infradead.org>
 <aacv39AZ5P9ubOZ5@bfoster>
 <aagv8y96vGHvbOdX@infradead.org>
 <aag-_c8G_L5MQ42m@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aag-_c8G_L5MQ42m@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: B1CAD201D45
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_FROM(0.00)[bounces-79404-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 09:17:33AM -0500, Brian Foster wrote:
> I tested the change below but it ended up failing xfs/131. Some fast and
> loose (i.e. LLM assisted) trace analysis suggests the issue is that this
> particular situation is racy. I.e., we write to a sparse file range and
> add COW fork dellaloc, writeback kicks in and drops the delalloc
> mapping, then zeroing occurs over said range and finds holes in both
> forks, then zone I/O completion occurs and maps blocks into the data
> fork.

Yes, that can happen.  But the folio will be locked or have the
writeback bit set over that whole period, so I can't see how writeback
can actually race with that?


