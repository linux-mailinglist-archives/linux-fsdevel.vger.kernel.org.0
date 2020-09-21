Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7A62718FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 03:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIUBU4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Sep 2020 21:20:56 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:36671 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbgIUBUz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Sep 2020 21:20:55 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 44A2F825B7A;
        Mon, 21 Sep 2020 11:20:49 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kKAVd-0005zd-6X; Mon, 21 Sep 2020 11:20:49 +1000
Date:   Mon, 21 Sep 2020 11:20:49 +1000
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
Message-ID: <20200921012049.GA12096@dread.disaster.area>
References: <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
 <20200917182314.GU5449@casper.infradead.org>
 <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
 <20200917185049.GV5449@casper.infradead.org>
 <CAHk-=wj6Ha=cNU4kL3z661CV+c2x2=DKzPrfH=XujMa378NhWQ@mail.gmail.com>
 <20200917192707.GW5449@casper.infradead.org>
 <CAHk-=wjp+KiZE2EM=f8Z1J_wmZSoq0MVZTJi=bMSXmfZ7Gx76w@mail.gmail.com>
 <20200920232303.GW12096@dread.disaster.area>
 <CAHk-=wgufDZzm7U38eG4EPvr7ctSFJBhKZpu51wYbgUbmBeECg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgufDZzm7U38eG4EPvr7ctSFJBhKZpu51wYbgUbmBeECg@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=esqhMbhX c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=7-415B0cAAAA:8
        a=aVRXyrEMW0HYF5mqrp0A:9 a=VHe0tgZn3GZCiNCm:21 a=t-v7aCJ-fs6V_JIX:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 20, 2020 at 04:31:57PM -0700, Linus Torvalds wrote:
> On Sun, Sep 20, 2020 at 4:23 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > FWIW, if the fs layer is already providing this level of IO
> > exclusion w.r.t. address space access, does it need to be replicated
> > at the address space level?
> 
> Honestly, I'd rather do it the other way, and go "if the vfs layer
> were to provide the IO exclusion, maybe the filesystems can drop it?

I'm not sure it can because of the diversity of filesystems and
their locking requirements. XFS spent many, many years ignoring the
VFS inode locking because it was a mutex and instead did all it's
own locking with rwsems internally.

> Because we end up having something like 60 different filesystems. It's
> *really* hard to know that "Yeah, this filesystem does it right".

Agreed, but I don't think moving the serialisation up to the VFS
will fix that because many filesysetms will still have to do their
own thing. e.g. cluster filesystems requiring cluster locks first,
not local inode rwsems....

> And if we do end up doing it at both levels, and end up having some of
> the locking duplicated, that's still better than "sometimes we don't
> do it at all", and have odd problems on the less usual (and often less
> well maintained) filesystems..

Sure.

However, the problem I'm trying to avoid arises when the filesystem
is able to do things concurrently that the new locking in the
VFS/address space can't do concurrently.

e.g. the range locking I'm working on for XFS allows truncate to run
concurrently with reads, writes, fallocate(), etc and it all just
works right now. Adding address space wide exclusive locking to the
page cache will likely defeat this - we can no longer run fallocate()
concurrently and so cannot solve the performance problems we have
with qemu+qcow2 where it uses fallocate() to initialise sparse
clusters and so fallocate() on a single uninitialised cluster
serialises all IO to the image file.

Hence I'd like to avoid introducing address-space wide serialisation
for invalidation at the page cache level just as we are about to
enable concurrency for operations that do page cache invalidation.
Range locking in the page cache would be fine, but global locking
will be .... problematic.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
