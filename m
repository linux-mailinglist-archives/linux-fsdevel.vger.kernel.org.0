Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4946F1BB806
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 09:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgD1Hse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 03:48:34 -0400
Received: from verein.lst.de ([213.95.11.211]:54693 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgD1Hsa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:48:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B772568CF0; Tue, 28 Apr 2020 09:48:27 +0200 (CEST)
Date:   Tue, 28 Apr 2020 09:48:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 2/7] signal: factor copy_siginfo_to_external32 from
 copy_siginfo_to_user32
Message-ID: <20200428074827.GA19846@lst.de>
References: <20200421154204.252921-1-hch@lst.de> <20200421154204.252921-3-hch@lst.de> <20200425214724.a9a00c76edceff7296df7874@linux-foundation.org> <20200426074039.GA31501@lst.de> <20200427154050.e431ad7fb228610cc6b95973@linux-foundation.org> <20200428070935.GE18754@lst.de> <ddbaba35-9cc5-dfb9-3cae-51b026de5b65@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddbaba35-9cc5-dfb9-3cae-51b026de5b65@c-s.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 09:45:46AM +0200, Christophe Leroy wrote:
>> I guess that might be a worthwhile middle ground.  Still not a fan of
>> all these ifdefs..
>>
>
> Can't we move the small X32 specific part out of 
> __copy_siginfo_to_user32(), in an arch specific helper that voids for other 
> architectures ?
>
> Something like:
>
> 		if (!arch_special_something(&new, from)) {
> 			new.si_utime = from->si_utime;
> 			new.si_stime = from->si_stime;
> 		}
>
> Then the arch_special_something() does what it wants in x86 and returns 1, 
> and for architectures not implementating it, a generic version return 0 all 
> the time.

The main issue is that we need an explicit paramter to select x32,
as it can't just be discovered from the calling context otherwise.
The rest is just sugarcoating.

