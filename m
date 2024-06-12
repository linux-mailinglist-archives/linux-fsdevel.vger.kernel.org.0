Return-Path: <linux-fsdevel+bounces-21536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 202A59054FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 16:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB8A1F21C43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 14:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA5C17E442;
	Wed, 12 Jun 2024 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JJzYQ8VM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E313B169ACA
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201960; cv=none; b=FbMnlAan1qNtyx0EcKyfKuPcOT2Dpx9VoywSHDtiHzo1un/g89SqEAuJBQBEEJEeTV10B3UFSmMKIGn7cpTFk6dQtUlRRgwr0wI+AHW9BwFErbLUQ6F1/3UQ1oVhlLWv6UaTjMy+14q2xgdSL4jYp/muBkAVxnlxpCV4gtW3TCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201960; c=relaxed/simple;
	bh=/onCZr4Z+weTYzmsfq1IIbhJMXw4FaLJ6Jn3ovKITuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNyzt/DHK8d+ZxgVkGXrXP61SMMP5W02G3eF48+3hUikX7e/dNTZNoa0A4horFJILjWJpYzmWdHIL6MQZGyQcs7qsBBx4OEfMYRLQvQMO6+fV3dH1li66S22qfA1QY4RXiRhE3f2pzHY9/F9vJxHD3LVi6GdIgohwnS0spXw6X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JJzYQ8VM; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bernd.schubert@fastmail.fm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718201954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1qyUcDw4VUGrxahyrz6XNaVMu1zSkDs4ZdYN1kGuIwo=;
	b=JJzYQ8VM1uLxaZ8wS525J/R7Wmkdn1+cRTDkMVo79K6uogeKOKwB023Pr3vijy4zwQBOJZ
	gd4a5hwhf5JxwWVmhMRHHFSPicshx6yd/7x0e1gUGn3Lyx7uxc1ktOVccS9O3OLtjQ/LWW
	abF7CwJ+l66FtnWCMWWlfej2vRAvduo=
X-Envelope-To: miklos@szeredi.hu
X-Envelope-To: bschubert@ddn.com
X-Envelope-To: amir73il@gmail.com
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: mingo@redhat.com
X-Envelope-To: peterz@infradead.org
X-Envelope-To: avagin@google.com
X-Envelope-To: io-uring@vger.kernel.org
Date: Wed, 12 Jun 2024 10:19:07 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrei Vagin <avagin@google.com>, io-uring@vger.kernel.org
Subject: Re: [PATCH RFC v2 00/19] fuse: fuse-over-io-uring
Message-ID: <olaitdmh662osparvdobr267qgjitygkl7lt7zdiyyi6ee6jlc@xaashssdxwxm>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <CAJfpegurSNV3Tw1oKWL1DgnR-tST-JxSAxvTuK2jirm+L-odeQ@mail.gmail.com>
 <99d13ae4-8250-4308-b86d-14abd1de2867@fastmail.fm>
 <CAJfpegu7VwDEBsUG_ERLsN58msXUC14jcxRT_FqL53xm8FKcdg@mail.gmail.com>
 <62ecc4cf-97c8-43e6-84a1-72feddf07d29@fastmail.fm>
 <im6hqczm7qpr3oxndwupyydnclzne6nmpidln6wee4cer7i6up@hmpv4juppgii>
 <a5ab3ea8-f730-4087-a9ea-b3ac4c8e7919@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5ab3ea8-f730-4087-a9ea-b3ac4c8e7919@fastmail.fm>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 12, 2024 at 03:53:42PM GMT, Bernd Schubert wrote:
> I will definitely look at it this week. Although I don't like the idea
> to have a new kthread. We already have an application thread and have
> the fuse server thread, why do we need another one?

Ok, I hadn't found the fuse server thread - that should be fine.

> > 
> > The next thing I was going to look at is how you guys are using splice,
> > we want to get away from that too.
> 
> Well, Ming Lei is working on that for ublk_drv and I guess that new approach
> could be adapted as well onto the current way of io-uring.
> It _probably_ wouldn't work with IORING_OP_READV/IORING_OP_WRITEV.
> 
> https://lore.gnuweeb.org/io-uring/20240511001214.173711-6-ming.lei@redhat.com/T/
> 
> > 
> > Brian was also saying the fuse virtio_fs code may be worth
> > investigating, maybe that could be adapted?
> 
> I need to check, but really, the majority of the new additions
> is just to set up things, shutdown and to have sanity checks.
> Request sending/completing to/from the ring is not that much new lines.

What I'm wondering is how read/write requests are handled. Are the data
payloads going in the same ringbuffer as the commands? That could work,
if the ringbuffer is appropriately sized, but alignment is a an issue.

We just looked up the device DMA requirements and with modern NVME only
4 byte alignment is required, but the block layer likely isn't set up to
handle that.

So - prearranged buffer? Or are you using splice to get pages that
userspace has read into into the kernel pagecache?

