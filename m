Return-Path: <linux-fsdevel+bounces-12967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6342E869B5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956871C24251
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 15:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14728148316;
	Tue, 27 Feb 2024 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A2Ic5Mky"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F891482F6
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049264; cv=none; b=k9MQdFMmZAODwCnFn+NMAtzBrmV8+2fzl25gwQZGb4ET84+vjv7nVzbbxERcSDkA08FGLtFHxTpGkU4X6UZFGKbReExulb5OxQcA3ui6VhlwyDL77cXnONXPQfCw6fSlLIxfvmGo72dC/z99kCuuun7BD9+GM21z1i4LlA0uN8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049264; c=relaxed/simple;
	bh=3PC5/chu/8vzo0p5x3WTUM6LMWaUQUOid7FzVz78cFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cENF3iy6lC12Cup6aJa6S5bORKRo+Bc06D/e0zFiP/jLl3CvrBlJRBn1FYT6cXUU7NLD+fcUIQ80AGTAATusj0ZGJ9V/9ND/OmKFFY+ToyUtL5r8qwN0yoeoz6f4c2hCkj5KJYDww7uMjWA/IZ/Q1FiOcT6G4IRNXRh8rNj9CWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A2Ic5Mky; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Feb 2024 10:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709049260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HgLcPpLzMNm/kS7Wj/38u2p6bSK1Q1OBJlosZYNa5T8=;
	b=A2Ic5MkyApuFMAg+DEqU72TRgCvjVnleibCuC8GVzpPfbYYF2S/XpHA513kVGFeeFMUauz
	ZscboWNOVgniVIPHCjCjFoJpxCFlyxPHV0RP1Jb/01jYEh5DZfWiRztJQGApP4/Uk0HTSc
	iDeqKylHl8dwA8RAGShDYLICuxvWRjI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <o2vu5g3dxygf6ufi2jorescu37izl34qq276utcjsjhuuz2w6l@gljkhtn6uowy>
References: <Zduto30LUEqIHg4h@casper.infradead.org>
 <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home>
 <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <CAHk-=wjOogaW0yLoUqQ0WfQ=etPA4cOFLy56VYCnHVU_DOMLrg@mail.gmail.com>
 <CAHk-=whFzKO+Vx2f8h72m7ysiEP2Thubp3EaZPa7kuoJb0k=ig@mail.gmail.com>
 <yfzkhghkh36ww5nzmkdrdpcjy6w5v6us55ccmnh2phjla25mmz@xomuheona22l>
 <Zd4CN3x2RzSfKEtm@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd4CN3x2RzSfKEtm@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 27, 2024 at 03:39:35PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 27, 2024 at 02:21:59AM -0500, Kent Overstreet wrote:
> > On Mon, Feb 26, 2024 at 03:48:35PM -0800, Linus Torvalds wrote:
> > > On Mon, 26 Feb 2024 at 14:46, Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > I really haven't tested this AT ALL. I'm much too scared.
> > > 
> > > "Courage is not the absence of fear, but acting in spite of it"
> > >          - Paddington Bear / Michal Scott
> > > 
> > > It seems to actually boot here.
> > > 
> > > That said, from a quick test with lots of threads all hammering on the
> > > same page - I'm still not entirely convinced it makes a difference.
> > > Sure, the kernel profile changes, but filemap_get_read_batch() wasn't
> > > very high up in the profile to begin with.
> > > 
> > > I didn't do any actual performance testing, I just did a 64-byte pread
> > > at offset 0 in a loop in 64 threads on my 32c/64t machine.
> > 
> > Only rough testing, but  this is looking like around a 25% performance
> > increase doing 4k random reads on a 1G file with fio, 8 jobs, on my
> > Ryzen 5950x - 16.7M -> 21.4M iops, very roughly. fio's a pig and we're
> > only spending half our cpu time in the kernel, so the buffered read path
> > is actually getting 40% or 50% faster.
> 
> Linus' patch only kicks in for 128 bytes or smaller.  So what are you
> measuring?

64 byte reads

