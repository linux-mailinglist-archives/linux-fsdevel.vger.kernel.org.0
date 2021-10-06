Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29AC4242C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 18:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhJFQgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 12:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhJFQgP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:36:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 622A9610E5;
        Wed,  6 Oct 2021 16:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633538063;
        bh=ctlyh/MM/ZO1vAziMpXnSjbXLCBHhorGWU3Y4W6Lq/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RkNXjzbdX5MCmCfXVkHWaWb2gGEEnzx2z8pkKs/2PZ4y3s2bPvSbF2h8KpdKmLJ4W
         UUNUavhpVkKqZT7phW5nnNaBJ/vCNyikpZ9oY1Aiuooj/j23c4JLXYP5MtmiUTpY+i
         jFHtPAJmCZUsJoT4wdzEIaRrXpmKG+4Sp1U8AWT8W8FdiRMPZo9SE2JVqMgFVmX7De
         AfwzYccfPCXKRQUprMR1UZYU1qJzR4PlF/HKHzD5IFD8hmArQdGd7tefjG9WoC+RJt
         Zqx+CUv9YYa8Hhy9FjPpwEZ2uOXrivJ7VzlyV17aEWTir3IxFq8GTkJ9Z6y+QdyAAf
         C1jMib4pXElyw==
Date:   Wed, 6 Oct 2021 09:34:23 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Stephen <stephenackerman16@gmail.com>, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: kvm crash in 5.14.1?
Message-ID: <20211006163423.GB24266@magnolia>
References: <2b5ca6d3-fa7b-5e2f-c353-f07dcff993c1@gmail.com>
 <16c7a433-6e58-4213-bc00-5f6196fe22f5@gmail.com>
 <YVSEZTCbFZ+HD/f0@google.com>
 <20210930175957.GA10573@magnolia>
 <20211004165432.GA24266@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211004165432.GA24266@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 04, 2021 at 09:54:32AM -0700, Darrick J. Wong wrote:
> On Thu, Sep 30, 2021 at 10:59:57AM -0700, Darrick J. Wong wrote:
> > On Wed, Sep 29, 2021 at 03:21:09PM +0000, Sean Christopherson wrote:
> > > On Tue, Sep 28, 2021, Stephen wrote:
> > > > Hello,
> > > > 
> > > > I got this crash again on 5.14.7 in the early morning of the 27th.
> > > > Things hung up shortly after I'd gone to bed. Uptime was 1 day 9 hours 9
> > > > minutes.
> > > 
> > > ...
> > > 
> > > > BUG: kernel NULL pointer dereference, address: 0000000000000068
> > > > #PF: supervisor read access in kernel mode
> > > > #PF: error_code(0x0000) - not-present page
> > > > PGD 0 P4D 0
> > > > Oops: 0000 [#1] SMP NOPTI
> > > > CPU: 21 PID: 8494 Comm: CPU 7/KVM Tainted: G            E     5.14.7 #32
> > > > Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE WIFI/X570
> > > > AORUS ELITE WIFI, BIOS F35 07/08/2021
> > > > RIP: 0010:internal_get_user_pages_fast+0x738/0xda0
> > > > Code: 84 24 a0 00 00 00 65 48 2b 04 25 28 00 00 00 0f 85 54 06 00 00 48
> > > > 81 c4 a8 00 00 00 44 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <48> 81 78
> > > > 68 a0 a3 >
> > > 
> > > I haven't reproduced the crash, but the code signature (CMP against an absolute
> > > address) is quite distinct, and is consistent across all three crashes.  I'm pretty
> > > sure the issue is that page_is_secretmem() doesn't check for a null page->mapping,
> > > e.g. if the page is truncated, which IIUC can happen in parallel since gup() doesn't
> > > hold the lock.
> > > 
> > > I think this should fix the problems?
> > > 
> > > diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
> > > index 21c3771e6a56..988528b5da43 100644
> > > --- a/include/linux/secretmem.h
> > > +++ b/include/linux/secretmem.h
> > > @@ -23,7 +23,7 @@ static inline bool page_is_secretmem(struct page *page)
> > >         mapping = (struct address_space *)
> > >                 ((unsigned long)page->mapping & ~PAGE_MAPPING_FLAGS);
> > > 
> > > -       if (mapping != page->mapping)
> > > +       if (!mapping || mapping != page->mapping)
> > 
> > I'll roll this out on my vm host and try to re-run the mass fuzztest
> > overnight, though IT claims they're going to kill power to the whole
> > datacenter until Monday(!)...
> 
> ...which they did, 30 minutes after I sent this email. :(
> 
> I'll hopefully be able to report back to the list in a day or two.

Looks like everything went smoothly with the mass fuzz fstesting.
I'll let you know if I see any further failures, but for now:

Tested-by: Darrick J. Wong <djwong@kernel.org>

--D

> --D
> 
> > 
> > --D
> > 
> > >                 return false;
> > > 
> > >         return mapping->a_ops == &secretmem_aops;
