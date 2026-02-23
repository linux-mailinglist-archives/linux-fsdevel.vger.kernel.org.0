Return-Path: <linux-fsdevel+bounces-77931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOsKHulQnGktDwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:06:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B731768BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE06D3009F96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3459D35B655;
	Mon, 23 Feb 2026 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zShTbAnk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5B82BE03B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771851990; cv=none; b=hB5qOdSHZFrwIRRujtP5ZgYYWJGo3HQapyccSXmULrta+17nL+S48qYMqRcxxm1jw1YZdYjPIcp3siTmIlgvdfryk/VuiLR27r32+1QVk4AAiNeyh4VBJojQZaShGBgMeH6/S+VSMzA9XWQZkOgVAZHFwHb9aDaxxJPufrGw994=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771851990; c=relaxed/simple;
	bh=6yWyfnVxBepJosO0+FyQqNWsD/Z5LVr+Vi+Qp3IhJx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjJis53f1e0VjeM3PcaTuy7oSSPJtN3sV+eknguW7WY6i7H3fQa+3T1Pw89UR8R066Pap14UI+ySWuSXe79iWrBz0xqg/Xqe4FybcC1noKXpK1cA14RY9GCu+PkKno1TBmSO/1wV98mpL85UruvXS+mqIN7FrVr/dat6nBbuW4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zShTbAnk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jnu6mIDmIYHEiF+CXoY6QG8nXitFQtsDNI2o0rRrwxs=; b=zShTbAnkMBHdJCVem2DJpxXKtb
	i6htXawgsieaXmeE2HeBvFRI4oi+EZaqNL/hlWUNq/wNZK6kLhkC1neCOZwx67l4mfKKBbQGqgIR5
	A6BB4ssDd6Dq7srvMbxYqRi9SQ+6mN8f4HBD9Xp/qVDhHUnIcVndMKmPdFllQzEHqwZHLCoGRonNw
	5/ux69uCXd0uqJ6u3LYKDU42rAQUS9ld2hwkYi9NzbXGnQmJKh6Gjqc4pU0HAA75FejgguUkmUCq4
	gOT7i0A0VxbHfERMRycHbKhq89vreDEPu7g0vgRec3IHn1DtOXjLqhh6XXZvlfqXOOYi0IOVekLIe
	5I/tUbpg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuVdq-00000000KSU-1d4B;
	Mon, 23 Feb 2026 13:06:26 +0000
Date: Mon, 23 Feb 2026 05:06:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Nanzhe Zhao <nzzhao@126.com>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, willy@infradead.org,
	yi.zhang@huaweicloud.com, jaegeuk@kernel.org,
	Chao Yu <chao@kernel.org>, Barry Song <21cnbao@gmail.com>
Subject: Re: Iomap and compression? (Was "Re: [LSF/MM/BPF TOPIC] Large folio
 support: iomap framework changes versus filesystem-specific
 implementations")
Message-ID: <aZxQ0kwaDqknE8Gq@infradead.org>
References: <75f43184.d57.19c7b2269dd.Coremail.nzzhao@126.com>
 <8a66f4d4-601c-4e1c-97f0-0ba7781d6ae8@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a66f4d4-601c-4e1c-97f0-0ba7781d6ae8@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[126.com,lists.linux-foundation.org,vger.kernel.org,infradead.org,huaweicloud.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-77931-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: C3B731768BD
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 07:04:55PM +1030, Qu Wenruo wrote:
> And for the example of complexity, btrfs has a complex async extent
> submission at delalloc time (similar to iomap_begin time), where we keep the
> whole contig dirty range (can go beyond the current folio) locked, and do
> the compression in a workqueue, and submit them in that workqueue.

I still think btrfs would benefit greatly from killing the async
submission workqueue, and I hope that the multiple writeback thread
work going on currently will help with this.  I think you really should
talk to Kundan.


