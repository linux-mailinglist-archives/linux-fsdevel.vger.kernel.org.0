Return-Path: <linux-fsdevel+bounces-43110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABF3A4E0C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 15:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C443A611C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9102063DC;
	Tue,  4 Mar 2025 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V1+4LOaa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D612063D4;
	Tue,  4 Mar 2025 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097994; cv=none; b=Lib7Xy8oLYBkPF8aIMUVvNIGXHyijajJuxOZcMkr2ODx+VnmRtXaaYbAyYYao6JH3IIrhG4Vl33EBrCsHkhDNIV0JoDzvGvrZfH/Hw3YnAVNiDNktsMhK07LyETQNUaPytwHIPdiviB+PUJ0zCwEEtSAXh7swke4n3SjOVotEFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097994; c=relaxed/simple;
	bh=eW/BH5xdYgTnVucRpMBD38oXu14JZEDpk7xHv3pnMPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTWNqUBxtnTSKRXjMLWoS2sqD0HwOFVctWxThDBJSpRzu5w7+0VGoJ9Y4NX/QZ7K16Z3PO+MnhqauzftUVv/HNHQ50CipF2wc2Ul0UiOvkg5tVCehAJ4syHaXhYzt9oSTNdLvdPb0LG6fI3nIDFnMQFTzmthDSLYa6MD2pIUbsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V1+4LOaa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xB7zfs9vBA01MkucBv8sONovW2cj9kiT9SekubVkEDM=; b=V1+4LOaaI1eyqOxn8lKz1dAkQa
	+FfbnIGFKmzkmNp+m/ggUMDUg5bq0PYl3ZvItFzQ5KnZ881kEWkGSm2fNZ7te0tSK7jys2RiZVtpC
	ja9qUvGl72A+6IBBXgSlxwYyaU6oX2Wit0ChyeqPBTzm9ChIt2L9/rdZ0ElzAbQ52YvVSFIL5M14D
	uZb8dV9YkhK+31B/9D7jX/92pBfSnHzeBDeTtgav49GutiFjFPmjRFZ7gLFKP5grHNAtL44cunRtB
	yKiP5pTxf2LqsbjMu5Fn9ABNp768yY+Uvu/6fwrMP/3oaFanqCc/TJ82sjhhvDiCUMrEpfzj+jbmT
	8QghvWZg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tpT7b-00000000weR-1mqG;
	Tue, 04 Mar 2025 14:19:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BA70530049D; Tue,  4 Mar 2025 15:19:46 +0100 (CET)
Date: Tue, 4 Mar 2025 15:19:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: torvalds@linux-foundation.org, oleg@redhat.com, brauner@kernel.org,
	mingo@redhat.com, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] wait: avoid spurious calls to
 prepare_to_wait_event() in ___wait_event()
Message-ID: <20250304141946.GM5880@noisy.programming.kicks-ass.net>
References: <20250303230409.452687-1-mjguzik@gmail.com>
 <20250303230409.452687-4-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303230409.452687-4-mjguzik@gmail.com>

On Tue, Mar 04, 2025 at 12:04:09AM +0100, Mateusz Guzik wrote:
> In vast majority of cases the condition determining whether the thread
> can proceed is true after the first wake up.
> 
> However, even in that case the thread ends up calling into
> prepare_to_wait_event() again, suffering a spurious irq + lock trip.
> 
> Then it calls into finish_wait() to unlink itself.
> 
> Note that in case of a pending signal the work done by
> prepare_to_wait_event() gets ignored even without the change.
> 
> pre-check the condition after waking up instead.
> 
> Stats gathared during a kernel build:
> bpftrace -e 'kprobe:prepare_to_wait_event,kprobe:finish_wait \
> 		 { @[probe] = count(); }'
> 
> @[kprobe:finish_wait]: 392483
> @[kprobe:prepare_to_wait_event]: 778690
> 
> As in calls to prepare_to_wait_event() almost double calls to
> finish_wait(). This evens out with the patch.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> One may worry about using "condition" twice. However, macros leading up
> to this one already do it, so it should be fine.
> 
> Also one may wonder about fences -- to my understanding going off and on
> CPU guarantees a full fence, so the now avoided lock trip changes
> nothing.

so it always helps if you provide actual numbers. Supposedly this makes
it go faster?

Also, how much bytes does it add to the image?

Anyway, no real objection, but it would be good to have better
substantiation etc.

>  include/linux/wait.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index 2bdc8f47963b..965a19809c7e 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -316,6 +316,9 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
>  		}								\
>  										\
>  		cmd;								\
> +										\
> +		if (condition)							\
> +			break;							\
>  	}									\
>  	finish_wait(&wq_head, &__wq_entry);					\
>  __out:	__ret;									\
> -- 
> 2.43.0
> 

