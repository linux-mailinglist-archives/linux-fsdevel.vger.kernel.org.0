Return-Path: <linux-fsdevel+bounces-12964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04545869A92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877431F23CE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 15:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3E0145B20;
	Tue, 27 Feb 2024 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EuI5RUCn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69E145333
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048382; cv=none; b=nKT9NzCDhP0EDXzKDSLsPTTLTkvaMUBG6DNcI+nPjVynEZNcr6HSsiLfUe/CqavL/kMsI0ZOp5Dd8cDoYnItFmEqQUirh88LhEkYXQ85wLNuAegFMedMG816doaGHnUICYkSQnzoUsX4TP+mHLm1vYSCtFb8hci2XZT9gphbKlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048382; c=relaxed/simple;
	bh=EFNSfAg1Hh4nrvQsU9c8halob8VdW4XnpEM2DauNGFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKKjkqyU2KDpVNlQykxVNLGTu/03dtmxM/5xzg6UrCj0RHZ0Fbano/rCbf06dLhHKOivm8/fy8jfJMPkIcVY8ud3c9K8mQXJVEDr2gYrJc5JpYqyt1z0lP4qf4jbzK/4AtiZWAbIhCJbII9JqAHe94VkXra49WZtKXAOqEjIyyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EuI5RUCn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AQvzgn1rG61oJxPsvlLuZ9J5yULpvwG8z501seE5+PA=; b=EuI5RUCnDrS4X3XJn/MZhpVK/u
	vqKX3+4UKWJbuzCzylsJuzrud5oxV3Kh95Xf6/+aGmbZEpdMAzR5RlIJGUJe3og+Iir//HI/BIjuc
	2Q3+qREK3jT+J6SaPnDPpf+jc02LOe6DklnUsNmZOaEeUxZMwQXCfIXtNlPBw4yq4a36eEMIbLoCZ
	2VLoBhdVohvZQwJNQGkFsrIQctHrM4AVUiL3n0qu4A3AvyFNGXFmcKW3zNFo5IQt+AyMa4I9wDNio
	x/4Si2TD/dK/KmA8kg+7t7LDsrq430sNB0Ry3iGe1bH9EhCZV+iqm8sCP1nxJrB51Lxziwj1LwLyE
	fTRisv0w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rezYN-00000002kPD-2LO3;
	Tue, 27 Feb 2024 15:39:35 +0000
Date: Tue, 27 Feb 2024 15:39:35 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <Zd4CN3x2RzSfKEtm@casper.infradead.org>
References: <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org>
 <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home>
 <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <CAHk-=wjOogaW0yLoUqQ0WfQ=etPA4cOFLy56VYCnHVU_DOMLrg@mail.gmail.com>
 <CAHk-=whFzKO+Vx2f8h72m7ysiEP2Thubp3EaZPa7kuoJb0k=ig@mail.gmail.com>
 <yfzkhghkh36ww5nzmkdrdpcjy6w5v6us55ccmnh2phjla25mmz@xomuheona22l>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yfzkhghkh36ww5nzmkdrdpcjy6w5v6us55ccmnh2phjla25mmz@xomuheona22l>

On Tue, Feb 27, 2024 at 02:21:59AM -0500, Kent Overstreet wrote:
> On Mon, Feb 26, 2024 at 03:48:35PM -0800, Linus Torvalds wrote:
> > On Mon, 26 Feb 2024 at 14:46, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > I really haven't tested this AT ALL. I'm much too scared.
> > 
> > "Courage is not the absence of fear, but acting in spite of it"
> >          - Paddington Bear / Michal Scott
> > 
> > It seems to actually boot here.
> > 
> > That said, from a quick test with lots of threads all hammering on the
> > same page - I'm still not entirely convinced it makes a difference.
> > Sure, the kernel profile changes, but filemap_get_read_batch() wasn't
> > very high up in the profile to begin with.
> > 
> > I didn't do any actual performance testing, I just did a 64-byte pread
> > at offset 0 in a loop in 64 threads on my 32c/64t machine.
> 
> Only rough testing, but  this is looking like around a 25% performance
> increase doing 4k random reads on a 1G file with fio, 8 jobs, on my
> Ryzen 5950x - 16.7M -> 21.4M iops, very roughly. fio's a pig and we're
> only spending half our cpu time in the kernel, so the buffered read path
> is actually getting 40% or 50% faster.

Linus' patch only kicks in for 128 bytes or smaller.  So what are you
measuring?

