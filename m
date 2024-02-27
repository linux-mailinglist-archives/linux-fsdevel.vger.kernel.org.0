Return-Path: <linux-fsdevel+bounces-12920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE7B8689C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 08:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72868B25B9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 07:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1402654BC1;
	Tue, 27 Feb 2024 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pQljFJB8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A66555789
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709018533; cv=none; b=tpXv1JHCYDnU0mARP5IkHSEvJ4pIXlwKg83gBoOqpOhuwZpva3kNtFPTjuryH9B0LY220cc3/9nLdHu31eNaInDzXmPTjwOa0PAVFYI0kt42ohuVSqeR+A2vTEAm709lrdUH+4YiHGGGHNZS06FvAKo6AQZsRLqZWBVuCitwec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709018533; c=relaxed/simple;
	bh=JVUufRA/2bQwV9kkjpszA7OHKLV4zo7FXSh4pacKNnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSA8HOOqBDoEpvAnMayMjZvGnBhaL/CZAz0F/uKpxKD0AnrllLs/4/Wb/VMBpC1XuY8LLL54Cn4GbkCVIc9+zKdaD/Uwd1uQIGn7iYJFoIEI/zI/SDGfZyQvybtTxJf4649ZwKK38PYzWYI+lawhmc4goH8xNf7i1AwcQIzKgxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pQljFJB8; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Feb 2024 02:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709018524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMfdAXegzTyYmWBdsE3vSQo/M0tAqvtQy8vDu7ZYfmM=;
	b=pQljFJB8bLMK1tC7i7aqd9CROZS9PJS9VKwBQkWXxDVvnQjP1aOrghsG/Gt6Sq3FrXI3ln
	ZPjk3iIvmT7pLxinTy0t78s4rfAXHIgUDiURexfIo7JcMdRAvxQOk0YZn4G0KTjJq0Y00j
	yueGpCKunfGeMr8IpFmOi0ObsEkXqsI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <yfzkhghkh36ww5nzmkdrdpcjy6w5v6us55ccmnh2phjla25mmz@xomuheona22l>
References: <Zds8T9O4AYAmdS9d@casper.infradead.org>
 <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org>
 <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home>
 <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <CAHk-=wjOogaW0yLoUqQ0WfQ=etPA4cOFLy56VYCnHVU_DOMLrg@mail.gmail.com>
 <CAHk-=whFzKO+Vx2f8h72m7ysiEP2Thubp3EaZPa7kuoJb0k=ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whFzKO+Vx2f8h72m7ysiEP2Thubp3EaZPa7kuoJb0k=ig@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 26, 2024 at 03:48:35PM -0800, Linus Torvalds wrote:
> On Mon, 26 Feb 2024 at 14:46, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I really haven't tested this AT ALL. I'm much too scared.
> 
> "Courage is not the absence of fear, but acting in spite of it"
>          - Paddington Bear / Michal Scott
> 
> It seems to actually boot here.
> 
> That said, from a quick test with lots of threads all hammering on the
> same page - I'm still not entirely convinced it makes a difference.
> Sure, the kernel profile changes, but filemap_get_read_batch() wasn't
> very high up in the profile to begin with.
> 
> I didn't do any actual performance testing, I just did a 64-byte pread
> at offset 0 in a loop in 64 threads on my 32c/64t machine.

Only rough testing, but  this is looking like around a 25% performance
increase doing 4k random reads on a 1G file with fio, 8 jobs, on my
Ryzen 5950x - 16.7M -> 21.4M iops, very roughly. fio's a pig and we're
only spending half our cpu time in the kernel, so the buffered read path
is actually getting 40% or 50% faster.

So I'd say that's substantial.

RCU freeing of pagecache pages would be even better - I think that'd let
us completely get rid of the barrier & xarray recheck, and we wouldn't
have to do it as a silly special case.

