Return-Path: <linux-fsdevel+bounces-20024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5E08CC85F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 23:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB14F282459
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 21:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C96149DEC;
	Wed, 22 May 2024 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PAgB0mL+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6531149DE6;
	Wed, 22 May 2024 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716415022; cv=none; b=FY8wqosP/XHU0g4rPhEZ6EzIYPSzAdmCSj/8r/qW8dC3mx5nYhe1A7XPw1O7FsJR9vGqHRJ6chH+UnpdaQ0ZOnjqNYeg7zHvSUJ24eRhGEHPJjqv2H2vh4xrRlIzpMb+WWKD2aawxgVol+Gvp6zo0M83ZCw4QYioyghREV5r0Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716415022; c=relaxed/simple;
	bh=N4qVpG58VKqKgZKyTkTeB1CudfqXIits3TVA1PWshf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjSYJ+J6pKShJXKnIg6IqQSRt7WHNjhyCoOZsn+GCdMtotQzSv2EAgD3TXfVbggzj/yQWwSmFU/XmqtZvn7xCcVDxRl0Dk950XBKiLiZ/rsnBY80Ev6b46TMhjoNb5uqta9tzStOCZc+PzfdDEdGD5594JB4HtHPyebRNCpoeII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PAgB0mL+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OtlyxkkzB2BjgfYbFdYm1Yvm8zkHcVIsiDANoj0QdIg=; b=PAgB0mL+L3w4fZSyf1x7yDLl/w
	+XtXEAgSQ4Tp3RSWdju1UUHftUS3ScXd+YO2y8ICZNubA8jiygpNZYPP4ifan1zfHWc6Oj42FOUaA
	Z+r37SPbuTaiUZJuJOMpRCg2qanunYYdB52ph2jlnVZV2OitmJcT9kRTL2G26gwEqk/W58rt77zbh
	Kfaky9WKflalU3s1Kt60l0flCR5WID5qeaFV0QD0b4MQRoHGN07fI6+XM6lfGVoNIK2Tx/iThycfT
	yySypAeMLhYtTGqSZnqa7fcHroQWlnNj7WPUHCpXCTiKohr3eyXOdSvjowd6VQvQgBnuQOCNG4kh8
	9HiVCYlQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9txB-00000004Cgh-2a85;
	Wed, 22 May 2024 21:56:57 +0000
Date: Wed, 22 May 2024 14:56:57 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>, David Bueso <dave@stgolabs.net>
Cc: Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] untorn buffered writes
Message-ID: <Zk5qKUJUOjGXEWus@bombadil.infradead.org>
References: <20240228061257.GA106651@mit.edu>
 <9e230104-4fb8-44f1-ae5a-a940f69b8d45@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e230104-4fb8-44f1-ae5a-a940f69b8d45@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, May 15, 2024 at 01:54:39PM -0600, John Garry wrote:
> On 27/02/2024 23:12, Theodore Ts'o wrote:
> > Last year, I talked about an interest to provide database such as
> > MySQL with the ability to issue writes that would not be torn as they
> > write 16k database pages[1].
> > 
> > [1] https://urldefense.com/v3/__https://lwn.net/Articles/932900/__;!!ACWV5N9M2RV99hQ!Ij_ZeSZrJ4uPL94Im73udLMjqpkcZwHmuNnznogL68ehu6TDTXqbMsC4xLUqh18hq2Ib77p1D8_4mV5Q$
> > 
> 
> After discussing this topic earlier this week, I would like to know if there
> are still objections or concerns with the untorn-writes userspace API
> proposed in https://lore.kernel.org/linux-block/20240326133813.3224593-1-john.g.garry@oracle.com/
> 
> I feel that the series for supporting direct-IO only, above, is stuck
> because of this topic of buffered IO.

I think it was good we had the discussions at LSFMM over it, however
I personally don't percieve it as stuck, however without any consensus
being obviated or written down anywhere it would not be clear to anyone
that we did reach any consensus at all. Hope is that lwn captures any
consensus if any was indeed reached as you're not making it clear any
was.

In case it helps, as we did with the LBS effort it may also be useful to
put together bi-monthly cabals to follow up progress, and divide and
conquer any pending work items.

> So I sent an RFC for buffered untorn-writes last month in https://lore.kernel.org/linux-fsdevel/20240422143923.3927601-1-john.g.garry@oracle.com/,
> which did leverage the bs > ps effort. Maybe it did not get noticed due to
> being an RFC. It works on the following principles:
> 
> - A buffered atomic write requires RWF_ATOMIC flag be set, same as
>   direct IO. The same other atomic writes rules apply.
> - For an inode, only a single size of buffered write is allowed. So for
>   statx, atomic_write_unit_min = atomic_write_unit_max always for
>   buffered atomic writes.
> - A single folio maps to an atomic write in the pagecache. So inode
>   address_space folio min order = max order = atomic_write_unit_min/max
> - A folio is tagged as "atomic" when atomically written and written back
>   to storage "atomically", same as direct-IO method would do for an
>   atomic write.
> - If userspace wants to guarantee a buffered atomic write is written to
>   storage atomically after the write syscall returns, it must use
>   RWF_SYNC or similar (along with RWF_ATOMIC).

From my perspective the above just needs the IOCB atomic support, and
the pending long term work item there is the near-write-through buffered
IO support. We could just wait for buffered-IO support until we have
support for that. I can't think of anying blocking DIO support though,
now that we at least have a mental model of how buffered IO *should*
work.

What about testing? Are you extending fstests, blktests?

  Luis

