Return-Path: <linux-fsdevel+bounces-12741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697D88667B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 03:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1051C20C6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 02:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F847D53C;
	Mon, 26 Feb 2024 02:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fk8uEB6P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECDE4C8F
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 02:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708913226; cv=none; b=bRt5IpL92WOlrqh4CvsdFsCwA8fQeFHlcK1udirJbIosbSFTGqOiXadolH7HpreoBF46N1AucXS5/B85g8mfqt/X+nDXZrEWCdeMQZnYLtsAzOAxfg67bQqFn4FjBgedqxzrIbPZQ4Dn6Swv27Lj9NH68ywlSXoUoM+fKArwlaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708913226; c=relaxed/simple;
	bh=jAmgY4s3HFx39xiSnXMOYk06yyA50e5jCBkUUpJT4qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1eyE62tBXlfC41b6U5CPp2/Tj5BrBB+XAnaCx+aprjkd/9GNullqmh/8ecnaJdhAMSldSTDqcv9aHfZxO/PVn5DSbyRZBImfsGXEJP6gnKONK+Ih5ovUsvDsFhQnhaJNruu9w1/jy4ubUXLA2VPR76tY1Yc4+Zvq0ueW8eB7ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fk8uEB6P; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 25 Feb 2024 21:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708913221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jAmgY4s3HFx39xiSnXMOYk06yyA50e5jCBkUUpJT4qw=;
	b=fk8uEB6PEu8gnbs0JOpmniJmXrEtBw8eU+rbozU0UNrmC1QzOEJ30RYSmKtGSxHSPQeW4p
	Mdy2sfRfWFQRcA/Vl1IO3CkaPpgN8EVxn7gdfQ9djq+PxPda8mGE8YBgQeGQFdMFF/qJIP
	i0cdz85cMB0HzM8k2rCqkdbSYtPCzuk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <g62a54kr2qhpr6t6ajcjnqfq76qhostnvd6m436zki5t5o5ndq@zpmdldg65wo6>
References: <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
 <Zds8T9O4AYAmdS9d@casper.infradead.org>
 <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org>
 <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <sfh6bvpihpbtwb7tgdkrhfd333qcxrqmvl52s5v5gbdpd2hvwl@p7aoxxndqk75>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sfh6bvpihpbtwb7tgdkrhfd333qcxrqmvl52s5v5gbdpd2hvwl@p7aoxxndqk75>
X-Migadu-Flow: FLOW_OUT

On Sun, Feb 25, 2024 at 08:58:28PM -0500, Kent Overstreet wrote:
> I think everything works; we need the end result to be consistent with
> some total ordering of all the writes, IOW, thread B's write (if fully
> within thread A's write) should be fully overwritten or not at all, and
> that clearly is the case. But there may be situations involving more
> than two threads where things get weirder.

Not sure if there's anything interesting or deep here, but this
situations where sometimes we've got a global lock and sometimes we've
got little locks do seem to come up - it reminded me of Suren's work on
the mmap sem recently, and I think I've seen it in other places. Feels
like it should at least have a name...

