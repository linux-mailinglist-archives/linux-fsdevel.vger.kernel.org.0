Return-Path: <linux-fsdevel+bounces-42986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E039CA4C9DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1773A188AF24
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6099E235346;
	Mon,  3 Mar 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsEv8Qry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCA6223714;
	Mon,  3 Mar 2025 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022314; cv=none; b=ZAYVBbE5LUzEp+tNgNR3eqVgpDiWiLo0XYbFvYqOLuHojdQ751AkkN+h5LORVrYmU22ebEoixAwmFR0f/Mnkt50G24u2f6Gzhc9JvXR5LWWmqKgk/RMi8gQ5pJgJ2BXMbylk8/ZPm3F9I6oPrP3NJ3epHuuwRljjvvUAos2ZXlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022314; c=relaxed/simple;
	bh=7GruPryj1ebXbmyCxe9ruKgfZnW01eyAO7E62PQT6Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNwMBtSHFS9CbfoYAD7octnF7GjqrWn+xvWK/rvUnSpM3PlORH5phpTUed7AG0yfHo9AfIuw30HGrp2+408jSalJDFAi8RE1OG/Qy9o4a8VM1wU96mjAJ6Nags6fpbFZZx1mIW5KojGJR619vpOEdCOWEGr++NEcHmwj8LVOP+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsEv8Qry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8E0C4CED6;
	Mon,  3 Mar 2025 17:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741022314;
	bh=7GruPryj1ebXbmyCxe9ruKgfZnW01eyAO7E62PQT6Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BsEv8Qry08DxrXqZoX3ldlf9ZuFDzoBW77dPNKiy8zN65VME6MUBqG3+kaRZdYMQ1
	 kXfiuasQksolAMDwaUcNJ4VaIGCaVmvCkGEnrUUQCiw5JYatszcw5EvStB3CmzInTT
	 t//E7p5sD8E5qLtB8yMyi5weSngZFhnFXhBmwIjv92Yii+E8oxff/uJv3PJS3fz94L
	 XGS+Isc+wb9wte+jEHOn4XM9DJVjE7BmrgNwpI2gms+tXexqek2F80W+Vx6x7qHhIh
	 YlaDtmUGejepy5BT8Qv2pjQt+0qy0eZ/xbsqEFKXNPbgFLsSmHpJtTZ2LcjbQasUE4
	 ojLFNiExJy4AQ==
Date: Mon, 3 Mar 2025 18:18:27 +0100
From: Alexey Gladkov <legion@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <Z8XkY5WnynjBJPDn@example.org>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com>
 <20250225115736.GA18523@redhat.com>
 <Z8Wn0nTvevLRG_4m@example.org>
 <30d35796-4687-440e-845f-b015d52fa4f0@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30d35796-4687-440e-845f-b015d52fa4f0@amd.com>

On Mon, Mar 03, 2025 at 09:16:08PM +0530, K Prateek Nayak wrote:
> Hello Legion,
> 
> On 3/3/2025 6:30 PM, Alexey Gladkov wrote:
> > On Tue, Feb 25, 2025 at 12:57:37PM +0100, Oleg Nesterov wrote:
> >> On 02/24, Oleg Nesterov wrote:
> >>>
> >>> Just in case, did you use
> >>>
> >>> 	https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/hackbench/hackbench.c
> >>>
> >>> ?
> >>
> >> Or did you use another version?
> >>
> >> Exactly what parameters did you use?
> >>
> >> If possible, please reproduce the hang again. How many threads/processes
> >> sleeping in pipe_read() or pipe_write() do you see? (you can look at
> >> /proc/$pid/stack).
> >>
> >> Please pick one sleeping writer, and do
> >>
> >> 	$ strace -p pidof_that_write
> >>
> >> this should wake this writer up. If a missed wakeup is the only problem,
> >> hackbench should continue.
> >>
> >> The more info you can provide the better ;)
> > 
> > I was also able to reproduce the hackbench hang with the parameters
> > mentioned earlier (threads and processes) on the kernel from master.
> > 
> 
> Thank you for reporting your observations!
> 
> If you are able to reproduce it reliably, could you please give the
> below diff posted by Swapnil from the parallel thread [1] a try:
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index ce1af7592780..a1931c817822 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -417,9 +417,19 @@ static inline int is_packetized(struct file *file)
>   /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
>   static inline bool pipe_writable(const struct pipe_inode_info *pipe)
>   {
> -    unsigned int head = READ_ONCE(pipe->head);
> -    unsigned int tail = READ_ONCE(pipe->tail);
>       unsigned int max_usage = READ_ONCE(pipe->max_usage);
> +    unsigned int head, tail;
> +
> +    tail = READ_ONCE(pipe->tail);
> +    /*
> +     * Since the unsigned arithmetic in this lockless preemptible context
> +     * relies on the fact that the tail can never be ahead of head, read
> +     * the head after the tail to ensure we've not missed any updates to
> +     * the head. Reordering the reads can cause wraparounds and give the
> +     * illusion that the pipe is full.
> +     */
> +    smp_rmb();
> +    head = READ_ONCE(pipe->head);
>   
>       return !pipe_full(head, tail, max_usage) ||
>           !READ_ONCE(pipe->readers);
> ---
> 
> We've been running hackbench for a while now with the above diff and we
> haven't run into a hang yet. Sorry for the troubles and thank you again.

No problem at all.

Along with the patch above, I tried reproducing the problem for about 40
minutes and no hangs found. Before that hackbench would hang within 5
minutes or so.

-- 
Rgrds, legion


