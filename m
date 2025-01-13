Return-Path: <linux-fsdevel+bounces-39003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B493A0AE9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 06:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39525165EE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 05:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE350230D14;
	Mon, 13 Jan 2025 05:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SXDTj3A7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F76C76034;
	Mon, 13 Jan 2025 05:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736744781; cv=none; b=GdIDPfrBUavTvuAxeP090Pa142J8U4uI9Oex+KB4I4oo37xAcZFzQkfjKlZJcNd+iAJLgE31Sc5DA98G3YFqe8++Yc68HadjzF2LFYXkR/pq9sh6tgpAKQuUsmriy8YFBVNVYzgQYFaXySCmLNfSZ+UkSwudLsP242MZjSXTAOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736744781; c=relaxed/simple;
	bh=ygH9/M7p/iS5xQPOtTIa93dHmACp5Duz5qkkjoxlvEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jw93bM4h0AvVew8rMW658HBOHZGMr8WDB+IkBlq/pqMt+qyRtRQbNZ4KbY22kRfIM8xSNdhF2/kAVuDOWvkVb1ak4nRSGx+vuqvYDYHk8JAGYhAjAjpGXSOppjkfJh7binQTVcdIgekZaOkPnR0Rl+USGgX0YKqOtQ66Tk5eBvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SXDTj3A7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=QSzmq64LoHaVQGwwp1pbcdAm3sapkgAsTXC1sRTKWrY=; b=SXDTj3A7toNB9CyQ8A2w53vitf
	faLXR7IdnlE92oUrlDrJQu+D5jUTjjmNawkw+DDS6R22hQssrCeKNJ4hXeUiVBO516Ur5LF+3NIOa
	B18968e0p/VsSTkF9a4Z6ZaW4khaev+/ofoSfqhEuZMZd/KGOtyj0aOWa8hvegFixZ5bHjKmjeNjW
	3rfvH+0+8Z5Lc/iO8jDOH38ao8UjxyuJygURzaycqpo9kB1DTUqkzlQ5uqaRBkI1gD3jZQWs8OzIy
	BK4vQzCTjXrxmE6nJ8DzNIMmTPdthQNi+eXeE9ViM7Py5AKM89eeaXB2xCEJ2UkOVecI1aR23nAxQ
	0Ddn2A1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXCeK-000000005ag-1vNr;
	Mon, 13 Jan 2025 05:06:04 +0000
Date: Mon, 13 Jan 2025 05:06:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kun Hu <huk23@m.fudan.edu.cn>
Cc: hch@lst.de, jlayton@kernel.org, kirill.shutemov@linux.intel.com,
	vbabka@suse.cz, william.kucharski@oracle.com, rppt@linux.ibm.com,
	dhowells@redhat.com, akpm@linux-foundation.org, hughd@google.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: Bug: task hung in shmem_swapin_folio
Message-ID: <Z4SfPEeheA_Fd5pD@casper.infradead.org>
References: <F5B70018-2D83-4EA8-9321-D260C62BF5E3@m.fudan.edu.cn>
 <Z4OvQfse4hekeD-A@casper.infradead.org>
 <431D467D-10F3-4316-A34B-6C1315178B05@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <431D467D-10F3-4316-A34B-6C1315178B05@m.fudan.edu.cn>

On Sun, Jan 12, 2025 at 08:51:20PM +0800, Kun Hu wrote:
> > 2025年1月12日 20:02，Matthew Wilcox <willy@infradead.org> 写道：
> > 
> > On Sun, Jan 12, 2025 at 05:46:24PM +0800, Kun Hu wrote:
> >> Hello,
> >> 
> >> When using our customized fuzzer tool to fuzz the latest Linux kernel, the following crash (42s)
> >> was triggered.
> > 
> > It's not a crash.  It's a warning.  You've just configured your kernel
> > to crash when emitting a warning.
> > 
> > What you need to do is poke around in the reproducer you've found and
> > figure out what it is you're doing that causes this warning.  Are
> > you constraining your task with memory groups, for example?  Are you
> > doing a huge amount of I/O which is causing your disk to be
> > bottlenecked?  Something else?
> > 
> > It's all very well to automate finding bugs, but you're asking other
> > people to do a lot of the work for you.
> > 
> 
> Thank you very much and sorry at the same time.
> 
> We know that most of the work of locating a issue should be done by the reporter, but having just looked into fuzzing against the kernel, the background knowledge of the kernel is not very familiar at the moment. That's why we've taken the approach of sending out a report first, and after getting professional feedback from the maintainers, we're able to target test a particular subsystem or module for them to improve efficiency.
> 
> Our strategy seems to be incorrect and certainly due to our lack of Kernel expertise, again I apologize, we will improve and hopefully report really useful information.

I'm not asking you to analyse the kernel; that is indeed a hard task.
I'm asking you to analyse the reproducer.  What is it really doing to
create the problem?  Often syzkaller includes a lot of extraneous goop
that's not relevant.  So, you can try to minimise the reproducer.

If you're going to be fuzzing filesystems (and it seems like you've
sent a lot of filesystem reports), then you should probably say if the
reproducer uses a specially crafted image.  Most filesystem developers
will prioritise these bugs differently.

It's really hard to get a good workflow going with syzkaller.  Google
has been trained now, and syzbot mostly produces good quality bugs.
It's really frustrating to have to train a new group of people all
over again.  It would be much better if you worked with Google to get
your changes into syzbot.  Probably less work for you, too.

