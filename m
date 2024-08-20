Return-Path: <linux-fsdevel+bounces-26337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A7F957C32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 06:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDB4281F97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 04:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0364C3D0;
	Tue, 20 Aug 2024 04:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eBICbZTu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7DC1BF58;
	Tue, 20 Aug 2024 04:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724126664; cv=none; b=Uo8ALmcZU/Sn9Zw66rlPk/nHZnaND/68b3Km81CUSmkKwAqXK3OurAMzd1Lw4LukSAnTzXADRvyKONzLXSaAV1XR5BAB0ZfxfZX4LSQgFoFpCGdYnEjYoGzrWbQBu/AHdn1n+OKqigltH3dophbgm78FTpBVSjrFhx96HZy75l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724126664; c=relaxed/simple;
	bh=0sFtDSupJllPOMg8yJaDlZVaf/6nLANvOo9VhC2y/JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsRBexRS1ikch3f8YBORbLrCi3QGm3urEtyLylEFC5EhLkTEW9f0XnwCoA30CtS1NI5cJq2bHMukuLX5C4HGZsZJOZeuKeAIZQtyDq/oXAnFz6ZbDIMQwYbttbZd02O9nMmsHs0b7b0ZSU8iAjx7Ur2abimncoQ8Gf/pWKFkAm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eBICbZTu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=g0kr17BvpHK+K763TfZEvwMzH1mETuoGOt5hOCx1Y7k=; b=eBICbZTu6xEdQOpQIV3sJuSJus
	bqJ2DzU2IhUvFyXJGuNrp3O3iVyHLz99xvqspIinIBapo0HVPu+viJdRclYMCjgnCit0xsiPv5ZRa
	Su6yumJ6IfcSn4k7YF2oa+10Hbdgzn96thr1zFWiFY3hqKXefp05difUSrqoBkwrw1KYTbCdB/fa7
	7JzthGU5glefm3U9n7NXYAtmTGl2ivNU5fD8vSRreTyed2+5Cdj1jtZw88qDc3NAUwmoHCm1gNlmp
	uBFcEwmpdnFQmmx0uhwHpZDOeh/Z3k/C//j7+24aX7xHpBoaNlwbpoLlDVIMkUE9mffAadJypFw4Y
	7bIaVHpw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgG6T-00000007VQP-3LM4;
	Tue, 20 Aug 2024 04:04:18 +0000
Date: Tue, 20 Aug 2024 05:04:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: Hui Guo <guohui.study@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Carlos Llamas <cmllamas@google.com>, Jens Axboe <axboe@kernel.dk>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: stack-out-of-bounds Write in end_buffer_read_sync
Message-ID: <ZsQVwUVdR5jQOPFJ@casper.infradead.org>
References: <CAHOo4gJyho_xXKRJB52qTJuCrrq9L-RL59XYyo_oS5+vN7Osiw@mail.gmail.com>
 <CANp29Y4UGksKhXi3CG5F=E2JOTLAiW4MuHirWfLAs2WG4zygCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y4UGksKhXi3CG5F=E2JOTLAiW4MuHirWfLAs2WG4zygCw@mail.gmail.com>

On Mon, Aug 19, 2024 at 03:28:13PM +0200, Aleksandr Nogikh wrote:
> On Mon, Aug 19, 2024 at 2:54 PM Hui Guo <guohui.study@gmail.com> wrote:
> >
> > Hi Kernel Maintainers,
> > Our tool found the following kernel bug "KASAN: stack-out-of-bounds
> > Write in end_buffer_read_sync" on:
> 
> Please note that the bug was already reported by syzbot in 2022:
> https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
> https://lore.kernel.org/all/0000000000005b04fa05dd71e0e0@google.com/T/

Oh, syzbot was more useful than Hui Guo.  It pointed out that it's
an NTFS problem, so nobody cared.  I'll go back to not caring.

