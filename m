Return-Path: <linux-fsdevel+bounces-12681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03DC8627DE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 22:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648771F21937
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 21:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D654CE0F;
	Sat, 24 Feb 2024 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="DtSu/MfT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661632CCA0
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708811182; cv=none; b=skUmdDWZbO6XAE+KQqOlzttz6ShyS7LuXHn02f/xTD6eY4zf2JvBPE6KXKlSqOsk3fl64PduW6O72UeiDTJ2guPeqvli1SW6fKMpbEKAPLodVItTiNgye8f1Lr/IZn2PUN2gFM+oFa0j/5mDJ+7w6TIIzhqbTtkvb4yyUTnfYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708811182; c=relaxed/simple;
	bh=5F0rcS9DYrTXqleqGPUgaaK+MIubBHpV9eO9qScM2Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMp6I8oKYvWguebAeE5r577MwO7ljTsC9oXL057zB3E3YFaM1fvEy2Aaxf1Vvaam7imkwiS646WKfCOb8sc6g1FD8iFIXCbFpXJ+aEOXGUgU66jTpAxYJk87A4TFEVfkc85J2iemvMjQRXWiFBfgbbjQrAwc/PJUtqC6wS2Pzu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=DtSu/MfT; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-198.bstnma.fios.verizon.net [173.48.102.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41OLgjGc025054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Feb 2024 16:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1708810973; bh=EKDV6a7hz2m5AcuSayKUV1WIGuXUwrIk+koBmqoNks8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=DtSu/MfTv3syWdsKwGcgTlyiPDa5omJ24Jahuy3wlnGQgF6nHBHWNP7TIKGeFmw9a
	 3LfWldtW0adrLfY+Xcsc3vxTQkZO29YLZpvrWX6cCdw9gB/P5rLZ6/6JlK2NQMXlQl
	 Frw0TFMYzylICQa+Anv9NscYzkI/TN5OM++XZrD5dhMVKcRPU1JUwLvmr+IS+fGB6h
	 bUYDZL5vVMCReryr/0uKbxlKD7NIGGjIKTKqCHer0mun1aOQDlsuyayfkkhkRo37K+
	 SRcPgDTwggpwrP2NDieVQWYa2A531TPrgD5Dd12sSROCdT85PwK0SQfBEBvlfmMQy7
	 QVYP37e+Nbb9A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A279915C0336; Sat, 24 Feb 2024 16:42:45 -0500 (EST)
Date: Sat, 24 Feb 2024 16:42:45 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <20240224214245.GB744192@mit.edu>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <CAHk-=wj0_eGczsoTJska24Lf9Sk6VXUGrfHymcDZF_Q5ExQdxQ@mail.gmail.com>
 <CAHk-=wintzU7i5NCVAUY_es6_eo8Zpt=mD0PAyhFd0aCu65WfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wintzU7i5NCVAUY_es6_eo8Zpt=mD0PAyhFd0aCu65WfA@mail.gmail.com>

On Sat, Feb 24, 2024 at 11:11:28AM -0800, Linus Torvalds wrote:
> But it is possible that this work never went anywhere exactly because
> this is such a rare case. That kind of "write so much that you want to
> do something special" is often such a special thing that using
> O_DIRECT is generally the trivial solution.

Well, actually there's a relatively common workload where we do this
exact same thing --- and that's when we run mkfs.ext[234] / mke2fs.
We issue a huge number of buffered writes (at least, if the device
doesn't support a zeroing discard operation) to zero out the inode
table.  We rely on the mm subsystem putting mke2fs "into the penalty
box", or else some process (usually mke2fs) will get OOM-killed.

I don't consider it a "penalty" --- in fact, when write throttling
doesn't work, I've complained that it's an mm bug.  (Sometimes this
has broken when the mke2fs process runs out of physical memory, and
sometimes it has broken when the mke2fs runs into the memory cgroup
limit; it's one of those things that's seems to break every 3-5
years.)  But still, it's something which *must* work, because it's
really not reasonable for userspace to know what is a reasonable rate
to self-throttling buffered writes --- it's something the kernel
should do for the userspace process.

Because this is something that has broken more than once, we have two
workarounds in mke2fs; one is that we can call fsync(2) every N block
group's worth of inode tables, which is kind of a hack, and the other
is that we can use Direct I/O.  But using DIO has a worse user
experience (well, unless the alternative is mke2fs getting OOM-killed;
admittedly that's worse) than just using buffered I/O, since we
generally don't need to synchronously wait for the write requests to
complete.  Neither is enabled by default, because in my view, this is
something the mm should just get right, darn it.

In any case, I definitely don't consider write throttled to be a
performance "problem" --- it's actually a far worse problem when the
throttling doesn't happen, because it generally means someone is
getting OOM-killed.

						- Ted

