Return-Path: <linux-fsdevel+bounces-12740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133678667AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 02:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A4B1C20EA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 01:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F2CDDDC;
	Mon, 26 Feb 2024 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pNnIfsoo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34677D502
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 01:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708912732; cv=none; b=Vr3zc3LAJsoa8g7L6zS9M26O/vkMF2DxZxPmCHHAeFx76bdmjyjsXhAi9o1jpwgFpsseXVPEmx5jRj5UKrT+H1DT4she2qfTS1FbZcz767w/qokDkZ8EBQWrI8UIhOmbluSuIvzqJ1QWIIZtl5eqiqWx/otTqYbAGInWQuJcfy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708912732; c=relaxed/simple;
	bh=A9cowzA1VzMDaO/xQ0GhCszigY8H5y3isrUzhFIiatI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MV5c96SHbnIKOpv5VzprbTrY1LTiEugNtnOXOYLFv3Kc7w+TjS3Kd99NcvP0exANiJOMDEOmsun4ipgt5nx0yZceBuNV33NmQQK9RDZkodLJk/hQ9xnkzzZMG+bhiwB+6WMEj46IAtEyUb8gHKDkTDotX+ok88EsC7irogZiWto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pNnIfsoo; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 25 Feb 2024 20:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708912728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=804cGcdfu0K0a3utkQagxhz2g70tjHQPhGhJk4xW09Q=;
	b=pNnIfsoonTZWx2IN0lH5l572ED1qgWbWXFIU4aSkZCoTI03mcTwSfuit9zJw0HRvhw6ua7
	JznOYP2lSB4Zx4GFvn7dTgno4NumBqKPB5qRppqm6rNiRz4tjp+8/dX0JB5b490ojChyLT
	ajwbY4beZ8oUYIfdSZkJMc7DfxdtEZM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <sfh6bvpihpbtwb7tgdkrhfd333qcxrqmvl52s5v5gbdpd2hvwl@p7aoxxndqk75>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
 <Zds8T9O4AYAmdS9d@casper.infradead.org>
 <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org>
 <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Feb 25, 2024 at 05:32:14PM -0800, Linus Torvalds wrote:
> On Sun, 25 Feb 2024 at 17:03, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > We could satisfy the posix atomic writes rule by just having a properly
> > vectorized buffered write path, no need for the inode lock - it really
> > should just be extending writes that have to hit the inode lock, same as
> > O_DIRECT.
> >
> > (whenever people bring up range locks, I keep trying to tell them - we
> > already have that in the form of the folio lock, if you'd just use it
> > properly...)
> 
> Sadly, that is *technically* not proper.
> 
> IOW, I actually agree with you that the folio lock is sufficient, and
> several filesystems do too.
> 
> BUT.
> 
> Technically, the POSIX requirements are that the atomicity of writes
> are "all or nothing" being visible, and so ext4, for example, will
> have the whole write operation inside the inode_lock.

...
 
> (It's not just ext2. It's all the old filesystems: anything that uses
> generic_file_write_iter() without doing inode_lock/unlock around it,
> which is actually most of them).

According to my reading just now, ext4 and btrfs (as well as bcachefs)
also don't take the inode lock in the read path - xfs is the only one
that does.

Perhaps we should just lift it to the VFS and make it controllable as a
mount/open option, as nice of a property as it is in theory I can't see
myself wanting to make everyone pay for it if ext4 and btrfs aren't
doing it and no one's screaming.

I think write vs. write consistency is the more interesting case; the
question there is does falling back to the inode lock when we can't lock
all the folios simultaneously work.

Consider thread A doing a 1 MB write, and it ends up in the path where
it locks the inode and it's allowed to write one folio at a time.

Then you have thread B doing some form of overlapping write, but without
the inode lock, and with all the folios locked simultaneously.

I think everything works; we need the end result to be consistent with
some total ordering of all the writes, IOW, thread B's write (if fully
within thread A's write) should be fully overwritten or not at all, and
that clearly is the case. But there may be situations involving more
than two threads where things get weirder.

