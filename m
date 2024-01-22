Return-Path: <linux-fsdevel+bounces-8459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA883836E36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 18:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6399328DF7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 17:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BB84BA90;
	Mon, 22 Jan 2024 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VfYbAlV6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F834A9BC;
	Mon, 22 Jan 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943554; cv=none; b=Bh7sXgf33Ijs/xEkNj329hwBpU1nE5MmISs+ZCy9MVsOdobRd7/pR1FBxMkwDn3nNMuawGMBFmLxkBml1bIrpS6UaauK10+0VSv6X0kRDo7pN9Ok52vmWOpPcVegudTANLwQP0/LPHfWDES7rlAg+CZt9+P9r//baL8yvtvxMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943554; c=relaxed/simple;
	bh=1e0c7h65C7Y9VUpkVImG0ZmRYTbDxV8hwPaGMflR99E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDLDUmIT/LhrszVckGPzEny7HyDlP0DCPGjkuC/CVkrwCisQghAghd1P+TPkTGY2jxwRBWR5Jrvuogm35kUTq71qc/ee/NwBEMmfZTfOxGu5FslXg1x4ZT56kIa6Tx60wyNov/3A21ZgQJmGzdgriJoRBcpslRmC47FIWp0BXkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VfYbAlV6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=OocAKhFNnuVz1CoUH7OyvE7TA9nNw+y+skld+4cN6dY=; b=VfYbAlV6K7QQZG9f9GC3tkEAyb
	TEf8WQcrE1W2XPzRzNH8asCUM7MGml3nQQ2CtWuQHQtvubEJJvrTO/ryyGS5xqBdBcN9EJ0imzMWe
	BXARefnokht4DEYts66ZIP7bchDA8iRMXFfsFygJ9t6FeFL1YTpSZyICQDl2yjVijDKCZJB1qpzQb
	MX9td3CHd7INswtLh0wMUT7Cptr0dcMDaPsgmWO4vKmpSPK58tITReXY9L6FI8WpPVuLf7WbxJIiS
	3ma82UEZ53WQp6PLnWaTD5y81ZoiCyoBvjZ233XsboBa8aDvabNvtwNLei4Cil7Bb/h2St041mwzN
	PVa5GRzw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRxqU-00000000Uz8-1SZ5;
	Mon, 22 Jan 2024 17:12:26 +0000
Date: Mon, 22 Jan 2024 17:12:26 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "zhangpeng (AS)" <zhangpeng362@huawei.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net, dsahern@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, arjunroy@google.com,
	wangkefeng.wang@huawei.com
Subject: Re: SECURITY PROBLEM: Any user can crash the kernel with TCP ZEROCOPY
Message-ID: <Za6h-tB7plgKje5r@casper.infradead.org>
References: <20240119092024.193066-1-zhangpeng362@huawei.com>
 <Zap7t9GOLTM1yqjT@casper.infradead.org>
 <5106a58e-04da-372a-b836-9d3d0bd2507b@huawei.com>
 <Za6SD48Zf0CXriLm@casper.infradead.org>
 <CANn89iL4qUXsVDRNGgBOweZbJ6ErWMsH+EpOj-55Lky8JEEhqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iL4qUXsVDRNGgBOweZbJ6ErWMsH+EpOj-55Lky8JEEhqQ@mail.gmail.com>

On Mon, Jan 22, 2024 at 05:30:18PM +0100, Eric Dumazet wrote:
> On Mon, Jan 22, 2024 at 5:04 PM Matthew Wilcox <willy@infradead.org> wrote:
> > I'm disappointed to have no reaction from netdev so far.  Let's see if a
> > more exciting subject line evinces some interest.
> 
> Hmm, perhaps some of us were enjoying their weekend ?

I am all in favour of people taking time off!  However the report came
in on Friday at 9am UTC so it had been more than a work day for anyone
anywhere in the world without response.

> I don't really know what changed recently, all I know is that TCP zero
> copy is for real network traffic.
> 
> Real trafic uses order-0 pages, 4K at a time.
> 
> If can_map_frag() needs to add another safety check, let's add it.

So it's your opinion that people don't actually use sendfile() from
a local file, and we can make this fail to zerocopy?  That's good
because I had a slew of questions about what expectations we had around
cache coherency between pages mapped this way and write()/mmap() of
the original file.  If we can just disallow this, we don't need to
have a discussion about it.

> syzbot is usually quite good at bisections, was a bug origin found ?

I have the impression that Huawei run syzkaller themselves without
syzbot.  I suspect this bug has been there for a good long time.
Wonder why nobody's found it before; it doesn't seem complicated for a
fuzzer to stumble into.

