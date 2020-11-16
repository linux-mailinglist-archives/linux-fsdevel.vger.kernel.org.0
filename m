Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7E32B51E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 21:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbgKPUEr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 15:04:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729869AbgKPUEr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:04:47 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48216221FD;
        Mon, 16 Nov 2020 20:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605557086;
        bh=6m3Hm0M7z8JLs3AXYQDdPFq1hJZ5K0jqwk59qapiEkg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wW4l1rpNZXB065nORFIwHSaDsYE/usuSPVeDzFkvvWLgfIPOxRJuigNB0u2DSOl/U
         T9nDeMHuL1+BwtLxtJYZTooAXUYosx2vIE6H5Vt/SOKYrLP+wH2zc42hBphSE9OH0B
         i5q/peQigXwQeY4WogtaT5k8IZyAgGURXijWqwQQ=
Date:   Mon, 16 Nov 2020 12:04:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, soheil.kdev@gmail.com, arnd@arndb.de,
        shuochen@google.com, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH v2] epoll: add nsec timeout support
Message-Id: <20201116120445.7359b0053778c1a4492d1057@linux-foundation.org>
In-Reply-To: <20201116161001.1606608-1-willemdebruijn.kernel@gmail.com>
References: <20201116161001.1606608-1-willemdebruijn.kernel@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 16 Nov 2020 11:10:01 -0500 Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> From: Willem de Bruijn <willemb@google.com>
> 
> Add epoll_create1 flag EPOLL_NSTIMEO. When passed, this changes the
> interpretation of argument timeout in epoll_wait from msec to nsec.
> 
> Use cases such as datacenter networking operate on timescales well
> below milliseconds. Shorter timeouts bounds their tail latency.
> The underlying hrtimer is already programmed with nsec resolution.

hm, maybe.  It's not very nice to be using one syscall to alter the
interpretation of another syscall's argument in this fashion.  For
example, one wonders how strace(1) is to properly interpret & display
this argument?

Did you consider adding epoll_wait2()/epoll_pwait2() syscalls which
take a nsec timeout?  Seems simpler.

Either way, we'd be interested in seeing the proposed manpage updates
alongside this change.

> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -225,6 +225,9 @@ struct eventpoll {
>  	unsigned int napi_id;
>  #endif
>  
> +	/* Accept timeout in ns resolution (EPOLL_NSTIMEO) */
> +	unsigned int nstimeout:1;
> +


Why a bitfield?  This invites other developers to add new bitfields to
the same word.  And if that happens, we'll need to consider the locking
rules for that word - I don't think the compiler provides any
protection against concurrent modifications to the bitfields which
share a machine word.  If we add a rule

/*
 * per eventpoll flags.  Initialized at creation time, never changes
 * thereafter
 */

then that would cover it.  Or just make the thing a `bool'?


