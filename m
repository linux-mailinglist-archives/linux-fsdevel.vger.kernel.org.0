Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14E5271894
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 01:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgITXXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Sep 2020 19:23:12 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:52526 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgITXXK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Sep 2020 19:23:10 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6BDDF3A947F;
        Mon, 21 Sep 2020 09:23:04 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kK8ff-0005ho-3p; Mon, 21 Sep 2020 09:23:03 +1000
Date:   Mon, 21 Sep 2020 09:23:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Amir Goldstein <amir73il@gmail.com>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Kernel Benchmarking
Message-ID: <20200920232303.GW12096@dread.disaster.area>
References: <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com>
 <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
 <20200917182314.GU5449@casper.infradead.org>
 <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
 <20200917185049.GV5449@casper.infradead.org>
 <CAHk-=wj6Ha=cNU4kL3z661CV+c2x2=DKzPrfH=XujMa378NhWQ@mail.gmail.com>
 <20200917192707.GW5449@casper.infradead.org>
 <CAHk-=wjp+KiZE2EM=f8Z1J_wmZSoq0MVZTJi=bMSXmfZ7Gx76w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjp+KiZE2EM=f8Z1J_wmZSoq0MVZTJi=bMSXmfZ7Gx76w@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=KcmsTjQD c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=0GeCxqQQhTXT-xwZm_8A:9 a=47p4OUhJTF3BuhQa:21 a=NuZqm7rJd7u_Bnrh:21
        a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 12:47:16PM -0700, Linus Torvalds wrote:
> On Thu, Sep 17, 2020 at 12:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Ah, I see what you mean.  Hold the i_mmap_rwsem for write across,
> > basically, the entirety of truncate_inode_pages_range().
> 
> I really suspect that will be entirely unacceptable for latency
> reasons, but who knows. In practice, nobody actually truncates a file
> _while_ it's mapped, that's just crazy talk.
> 
> But almost every time I go "nobody actually does this", I tend to be
> surprised by just how crazy some loads are, and it turns out that
> _somebody_ does it, and has a really good reason for doing odd things,
> and has been doing it for years because it worked really well and
> solved some odd problem.
> 
> So the "hold it for the entirety of truncate_inode_pages_range()"
> thing seems to be a really simple approach, and nice and clean, but it
> makes me go "*somebody* is going to do bad things and complain about
> page fault latencies".

I don't think there's a major concern here because that's what we
are already doing at the filesystem level. In this case, it is
because some filesystems need to serialise IO to the inode -before-
calling truncate_setsize(). e.g.

- we have to wait for inflight direct IO that may be beyond the new
  EOF to drain before we start changing where EOF lies.

- we have data vs metadata ordering requirements that mean we have
  to ensure dirty data is stable before we change the inode size.

Hence we've already been locking out page faults for the entire
truncate operation for a few years on both XFS and ext4. We haven't
heard of any problems result from truncate-related page fault
latencies....

FWIW, if the fs layer is already providing this level of IO
exclusion w.r.t. address space access, does it need to be replicated
at the address space level?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
