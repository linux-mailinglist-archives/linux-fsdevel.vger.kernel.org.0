Return-Path: <linux-fsdevel+bounces-76715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCrSKJUDimluFQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 16:56:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F74112396
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 16:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26344302733C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C3237FF74;
	Mon,  9 Feb 2026 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GZW9+Yro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AFB284898
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652499; cv=none; b=BGSDHsF/1tjmEqiIHCMIRhVIOqhAKseuBmjJgTb3z6hPmJi9tdPYPLKJFZiHTj3y+g4cuoyp0rR7wSJtxFxAPiTdf6FW7fILz5WGqQmXpEGFenG2z7VfRPBvDCl+5hJX7HDGlzBu0ljamtsUEc4PKpqsISM3iBunUhgVPkB3hUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652499; c=relaxed/simple;
	bh=UXh2QxVZT3HQq2olekoy3RjQ2GmndiUc8ED5tEvKLtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=N2FRAouJ4ypSGPq2MS2VEvE+IoLoIyr7c+HJFjjpopsTsr8tTls+OJHZrIruM/Qci1phZWDAzUHYzMT3cQQwZ5qWm2CvHBnZiFu/oZvHHbehhM/FWO8PYtjLfCUyrcF2sCmPhAX2LZHIMFlxj9dJ2O4Acp/w4AM3ffVLp2AAgYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GZW9+Yro; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260209155456epoutp03ecc0f8db460a88ae61f690df2e578bcf~SnxBiPwI80158301583epoutp03H
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 15:54:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260209155456epoutp03ecc0f8db460a88ae61f690df2e578bcf~SnxBiPwI80158301583epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770652496;
	bh=SH6fKsCcHoZUpzqt+IdkVbwE8A8W9DShkgqGQvHxHVw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=GZW9+YrohBTSdV8WbG6g/CA1zl/LCSj5ruqdRYncptCw4GELMMbltx8RwBe3agSIt
	 pYkHEohrFnoW/pQrZwk9QAtmXBPXJzNpkEhaZnDIJpxE86lSrHKw63hzlkgYdFN7Er
	 2R1iAqWSgDDvvLDTvNRqsFPuxS7szNsp7h7IQCtw=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260209155455epcas5p1881af6ec338c4adc5a29870cdbc1beb4~SnxA1-tem2548425484epcas5p11;
	Mon,  9 Feb 2026 15:54:55 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4f8q5V3Yb5z6B9m5; Mon,  9 Feb
	2026 15:54:54 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260209155454epcas5p270af6d87208aae7466053be8520292c7~Snw-i_C9O1577615776epcas5p28;
	Mon,  9 Feb 2026 15:54:54 +0000 (GMT)
Received: from [107.111.86.57] (unknown [107.111.86.57]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260209155450epsmtip1ad4b5be51e3fd96ce54775e25682ded2~Snw8mdDYC0787207872epsmtip1I;
	Mon,  9 Feb 2026 15:54:50 +0000 (GMT)
Message-ID: <5b11145d-15e2-485c-a978-365b58854371@samsung.com>
Date: Mon, 9 Feb 2026 21:24:49 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] AG aware parallel writeback for XFS
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Brian Foster <bfoster@redhat.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, willy@infradead.org, mcgrof@kernel.org,
	clm@meta.com, david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk,
	ritesh.list@gmail.com, djwong@kernel.org, dave@stgolabs.net, cem@kernel.org,
	wangyufei@vivo.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com, anuj20.g@samsung.com,
	vishak.g@samsung.com, joshi.k@samsung.com
From: Kundan Kumar <kundan.kumar@samsung.com>
In-Reply-To: <20260206062527.GA25841@lst.de>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260209155454epcas5p270af6d87208aae7466053be8520292c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260116101236epcas5p12ba3de776976f4ea6666e16a33ab6ec4
References: <CGME20260116101236epcas5p12ba3de776976f4ea6666e16a33ab6ec4@epcas5p1.samsung.com>
	<20260116100818.7576-1-kundan.kumar@samsung.com> <aXEvAD5Rf5QLp4Ma@bfoster>
	<ca048ecf-5aec-4a0d-8faf-ad9fcd310e21@samsung.com>
	<aXN3EtxKFXX8DEbl@bfoster>
	<e7413e3b-3fae-4aab-90a1-4a6695156b2e@samsung.com>
	<20260206062527.GA25841@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-76715-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,stgolabs.net,vivo.com,vger.kernel.org,kvack.org,samsung.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kundan.kumar@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 21F74112396
X-Rspamd-Action: no action

On 2/6/2026 11:55 AM, Christoph Hellwig wrote:
> I fear we're deep down a rabbit hole solving the wrong problem here.
> Traditionally block allocation, in XFS and in general, was about finding
> the "best" location to avoid seeks.  With SSDs the seeks themselves are
> kinda pointless, although large sequential write streams are still very
> useful of course, as is avoiding both freespace and bmap fragmentation.
> On the other hand avoiding contention from multiple writers is a good
> thing.  (this is discounting the HDD case, where the industry is very
> rapidly moving to zoned device, for which zoned XFS has a totally
> different allocator)
> 
> With multi-threaded writeback this become important for writeback, but
> even before this would be useful for direct and uncached I/O.
> 
> So I think the first thing I'd look into it to tune the allocator to
> avoid that contention, by by spreading different allocation streams from
> different core to different AGs, and relax the very sophisticated and
> detailed placement done by the XFS allocator

Thanks, I’m going to restate what I think you are suggesting to make
sure I'm tracking correctly.

We will step back from per-folio tagging and instead align coarse
sharding with a simpler allocation policy:

- Create a bounded number of bdi wb contexts at mount time (capped,
e.g. ≤ agcount).
- Store a per-inode stream/shard id (no per-folio state).
- Assign the stream id once and use it to select the wb context for
writeback.
- In the delalloc allocator, bias AG selection from the stream id by
partitioning AG space into per-stream "bands" and rotating the start
AG within that band; fall back to the existing allocator when
allocation can't be satisfied.

Does this align with what you have in mind?

