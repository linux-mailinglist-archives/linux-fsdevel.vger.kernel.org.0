Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66801BEDFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 03:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgD3B7w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 21:59:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51728 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgD3B7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:59:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F416F4999C;
        Wed, 29 Apr 2020 21:59:47 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=ErazowRay1P/AwFSRhYIU6Y2Vtg=; b=U/bgW7
        8LRuDwed7cFJI+OLHcNjS2azezYw4bDECsXxOtmXzamJa8j9tAdCdRFr37MXprd5
        ErxVxpe2KVIBpAKAVf2dKTwzyPiZ3RDGm+EfMP70RzW2Zf/0ARTOupK3h0F1z+hz
        mQJPY4L14N4+MX2vB7h1kvD7/e18IFTZLuIv8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA42A4999B;
        Wed, 29 Apr 2020 21:59:47 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=OH9QgA1zs57t3X+399BRoLLVjiVfyd9x67bP0Lvx9VY=; b=jpEXcJureDScwgQSTF9eHzcwhmQuFrOHxRs892SZDNVkINIFS5TbHDpabFpo7Gs7IHlBnmskokz8D4i2YY5ViibSy+NBswTJ776BfV1BmS29V/WPbozOzfLFQDTEEXWotrT//LfOGQVTKKoMRDg2y4UW+ua6jfMPr/mLDlS+tJQ=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E06D4999A;
        Wed, 29 Apr 2020 21:59:47 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 91EAD2DA0A91;
        Wed, 29 Apr 2020 21:59:46 -0400 (EDT)
Date:   Wed, 29 Apr 2020 21:59:46 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Christophe Lyon <christophe.lyon@linaro.org>
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem
 properly in there
In-Reply-To: <20200429215620.GM1551@shell.armlinux.org.uk>
Message-ID: <nycvar.YSQ.7.76.2004292153090.2671@knanqh.ubzr>
References: <20200429214954.44866-1-jannh@google.com> <20200429215620.GM1551@shell.armlinux.org.uk>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 44EB08B6-8A86-11EA-B6B5-D1361DBA3BAF-78420484!pb-smtp2.pobox.com
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 29 Apr 2020, Russell King - ARM Linux admin wrote:

> On Wed, Apr 29, 2020 at 11:49:49PM +0200, Jann Horn wrote:
> > At the moment, we have that rather ugly mmget_still_valid() helper to
> > work around <https://crbug.com/project-zero/1790>: ELF core dumping
> > doesn't take the mmap_sem while traversing the task's VMAs, and if
> > anything (like userfaultfd) then remotely messes with the VMA tree,
> > fireworks ensue. So at the moment we use mmget_still_valid() to bail
> > out in any writers that might be operating on a remote mm's VMAs.
> > 
> > With this series, I'm trying to get rid of the need for that as
> > cleanly as possible.
> > In particular, I want to avoid holding the mmap_sem across unbounded
> > sleeps.
> > 
> > 
> > Patches 1, 2 and 3 are relatively unrelated cleanups in the core
> > dumping code.
> > 
> > Patches 4 and 5 implement the main change: Instead of repeatedly
> > accessing the VMA list with sleeps in between, we snapshot it at the
> > start with proper locking, and then later we just use our copy of
> > the VMA list. This ensures that the kernel won't crash, that VMA
> > metadata in the coredump is consistent even in the presence of
> > concurrent modifications, and that any virtual addresses that aren't
> > being concurrently modified have their contents show up in the core
> > dump properly.
> > 
> > The disadvantage of this approach is that we need a bit more memory
> > during core dumping for storing metadata about all VMAs.
> > 
> > After this series has landed, we should be able to rip out
> > mmget_still_valid().
> > 
> > 
> > Testing done so far:
> > 
> >  - Creating a simple core dump on X86-64 still works.
> >  - The created coredump on X86-64 opens in GDB, and both the stack and the
> >    exectutable look vaguely plausible.
> >  - 32-bit ARM compiles with FDPIC support, both with MMU and !MMU config.
> > 
> > I'm CCing some folks from the architectures that use FDPIC in case
> > anyone wants to give this a spin.
> 
> I've never had any reason to use FDPIC, and I don't have any binaries
> that would use it.  Nicolas Pitre added ARM support, so I guess he
> would be the one to talk to about it.  (Added Nicolas.)

It's been a while since I worked with it. However Christophe Lyon (in 
CC) added support for ARM FDPIC to mainline gcc recently, so hopefully 
he might still be set up and able to help.


Nicolas
