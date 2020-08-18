Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18030248DAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 20:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHRSF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 14:05:59 -0400
Received: from verein.lst.de ([213.95.11.211]:34545 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgHRSF6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:05:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C0BB768AFE; Tue, 18 Aug 2020 20:05:55 +0200 (CEST)
Date:   Tue, 18 Aug 2020 20:05:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc
Message-ID: <20200818180555.GA29185@lst.de>
References: <20200817073212.830069-1-hch@lst.de> <319d15b1-cb4a-a7b4-3082-12bb30eb5143@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <319d15b1-cb4a-a7b4-3082-12bb30eb5143@csgroup.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 07:46:22PM +0200, Christophe Leroy wrote:
> I gave it a go on my powerpc mpc832x. I tested it on top of my newest 
> series that reworks the 32 bits signal handlers (see 
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=196278) with 
> the microbenchmark test used is that series.
>
> With KUAP activated, on top of signal32 rework, performance is boosted as 
> system time for the microbenchmark goes from 1.73s down to 1.56s, that is 
> 10% quicker
>
> Surprisingly, with the kernel as is today without my signal's series, your 
> series degrades performance slightly (from 2.55s to 2.64s ie 3.5% slower).
>
>
> I also observe, in both cases, a degradation on
>
> 	dd if=/dev/zero of=/dev/null count=1M
>
> Without your series, it runs in 5.29 seconds.
> With your series, it runs in 5.82 seconds, that is 10% more time.

That's pretty strage, I wonder if some kernel text cache line
effects come into play here?

The kernel access side is only used in slow path code, so it should
not make a difference, and the uaccess code is simplified and should be
(marginally) faster.

Btw, was this with the __{get,put}_user_allowed cockup that you noticed
fixed?
