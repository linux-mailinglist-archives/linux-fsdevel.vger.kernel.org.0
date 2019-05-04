Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7FD13BFA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2019 21:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfEDTmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 May 2019 15:42:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfEDTmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 May 2019 15:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bWe+s64qLZIT8UOHJ03/sna3dE0MqHE8qjTUU4lqDwo=; b=eC+KXDyyCPKC4fKPCzLudAZsL
        wT8xze2iYVhDX69i8J5+fbIEgnCCqQnI0hLxqxRTbNngIgZlK+WDhXvgiyoFmpB7EHaPj3qk+0fNj
        dKUU+9ADvXOZBlPR7B4aLjA0M8Q1uTaH+PiyrLQ9X++mL5TCZE6Gs3/GVaVcB3iGxSDlVvZUOIs5j
        uX/hXJDW3QsCmPTXaYqp+tB/iWAoPuK63IqraHwaP76b2Vij/lQsBmeo1u9DUaTytCAOuVY0aeeKc
        TmAA86m5B8NdAC2TxH1XYap8weexEMb6B33/o7vWMEhsQtz6FFS50buBR0bVEFDnKKEuDaQx196wI
        StQbK4JPA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hN0Xx-0002XB-TW; Sat, 04 May 2019 19:42:09 +0000
Date:   Sat, 4 May 2019 12:42:09 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Barror, Robert" <robert.barror@intel.com>
Subject: Re: Hang / zombie process from Xarray page-fault conversion
 (bisected)
Message-ID: <20190504194209.GB16963@bombadil.infradead.org>
References: <CAPcyv4hwHpX-MkUEqxwdTj7wCCZCN4RV-L4jsnuwLGyL_UEG4A@mail.gmail.com>
 <20190311150947.GD19508@bombadil.infradead.org>
 <CAPcyv4jG5r2LOesxSx+Mdf+L_gQWqnhk+gKZyKAAPTHy1Drvqw@mail.gmail.com>
 <20190312043754.GD23020@dastard>
 <CAPcyv4i+z0RT7rTw+4w-h8dOyscVk1g3F+cu2pKHqqJjTgU++A@mail.gmail.com>
 <20190315022604.GO26298@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315022604.GO26298@dastard>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 15, 2019 at 01:26:04PM +1100, Dave Chinner wrote:
> On Thu, Mar 14, 2019 at 12:34:51AM -0700, Dan Williams wrote:
> > On Mon, Mar 11, 2019 at 9:38 PM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Mon, Mar 11, 2019 at 08:35:05PM -0700, Dan Williams wrote:
> > > > On Mon, Mar 11, 2019 at 8:10 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Thu, Mar 07, 2019 at 10:16:17PM -0800, Dan Williams wrote:
> > > > > > Hi Willy,
> > > > > >
> > > > > > We're seeing a case where RocksDB hangs and becomes defunct when
> > > > > > trying to kill the process. v4.19 succeeds and v4.20 fails. Robert was
> > > > > > able to bisect this to commit b15cd800682f "dax: Convert page fault
> > > > > > handlers to XArray".
> > > > > >
> > > > > > I see some direct usage of xa_index and wonder if there are some more
> > > > > > pmd fixups to do?
> > > > > >
> > > > > > Other thoughts?
> > > > >
> > > > > I don't see why killing a process would have much to do with PMD
> > > > > misalignment.  The symptoms (hanging on a signal) smell much more like
> > > > > leaving a locked entry in the tree.  Is this easy to reproduce?  Can you
> > > > > get /proc/$pid/stack for a hung task?
> > > >
> > > > It's fairly easy to reproduce, I'll see if I can package up all the
> > > > dependencies into something that fails in a VM.
> > > >
> > > > It's limited to xfs, no failure on ext4 to date.
> > > >
> > > > The hung process appears to be:
> > > >
> > > >      kworker/53:1-xfs-sync/pmem0
> > >
> > > That's completely internal to XFS. Every 30s the work is triggered
> > > and it either does a log flush (if the fs is active) or it syncs the
> > > superblock to clean the log and idle the filesystem. It has nothing
> > > to do with user processes, and I don't see why killing a process has
> > > any effect on what it does...
> > >
> > > > ...and then the rest of the database processes grind to a halt from there.
> > > >
> > > > Robert was kind enough to capture /proc/$pid/stack, but nothing interesting:
> > > >
> > > > [<0>] worker_thread+0xb2/0x380
> > > > [<0>] kthread+0x112/0x130
> > > > [<0>] ret_from_fork+0x1f/0x40
> > > > [<0>] 0xffffffffffffffff
> > >
> > > Much more useful would be:
> > >
> > > # echo w > /proc/sysrq-trigger
> > >
> > > And post the entire output of dmesg.
> > 
> > Here it is:
> > 
> > https://gist.github.com/djbw/ca7117023305f325aca6f8ef30e11556
> 
> Which tells us nothing. :(

Nothing from a filesystem side, perhaps, but I find it quite interesting.

We have a number of threads blocking in down_read() on mmap_sem.  That
means a task is holding the mmap_sem for write, or is blocked trying
to take the mmap_sem for write.  I think it's the latter; pid 4650
is blocked in munmap().  pid 4673 is blocking in get_unlocked_entry()
and will be holding the mmap_sem for read while doing so.

Since this is provoked by a fatal signal, it must have something to do
with a killable or interruptible sleep.  There's only one of those in the
DAX code; fatal_signal_pending() in dax_iomap_actor().  Does rocksdb do
I/O with write() or through a writable mmap()?  I'd like to know before
I chase too far down this fault tree analysis.

My current suspicion is that we have a PMD fault being not-woken by a PTE
modification, and the evidence seems to fit, but I don't quite see it yet.

(I meant to ask Dan about this while we were in San Juan, but with all
the other excitement, it slipped my mind).
