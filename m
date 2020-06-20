Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEC5202639
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 21:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgFTTju (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 15:39:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbgFTTju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 15:39:50 -0400
X-Greylist: delayed 1464 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jun 2020 15:39:50 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QHhdZsEwflik6dhlpG9lDRGf2hUbiRTywvrsqPNIe50=; b=Za6zjjv9SW/fcKUx1GQuuZ9KSj
        3wWuDUlczJhnxt7HcGZtrKs/RQAJ2AxNVABPlYlAUBMiiPlezmVC/KuFD6oTzv+hc1dMlkYzLmgp1
        BPrTo0wrA4qsogg8qYSC3XksacQyySS6ckSNjRripeZ512qO4mTc7KGXKNg8VQ5SVqp77jaNsBQCD
        +bna6zliSxrpte3Z5JYZigx6V/DCULCJaNKwASL42oxHzh09Glukgz997JBujOxmA6MEj2P223Zis
        hG0Xdtepr3u9WW7EyIJ91zJac8F2UV9HEp7UHIfZXswsSbuBZIPMuRls7H1qrI9KG2uToOIRL6u0B
        oFWJCYJg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmixW-0004zd-13; Sat, 20 Jun 2020 19:15:22 +0000
Date:   Sat, 20 Jun 2020 12:15:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Bypass filesystems for reading cached pages
Message-ID: <20200620191521.GG8681@bombadil.infradead.org>
References: <20200619155036.GZ8681@bombadil.infradead.org>
 <CAOQ4uxjy6JTAQqvK9pc+xNDfzGQ3ACefTrySXtKb_OcAYQrdzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjy6JTAQqvK9pc+xNDfzGQ3ACefTrySXtKb_OcAYQrdzw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 20, 2020 at 09:19:37AM +0300, Amir Goldstein wrote:
> On Fri, Jun 19, 2020 at 6:52 PM Matthew Wilcox <willy@infradead.org> wrote:
> > This patch lifts the IOCB_CACHED idea expressed by Andreas to the VFS.
> > The advantage of this patch is that we can avoid taking any filesystem
> > lock, as long as the pages being accessed are in the cache (and we don't
> > need to readahead any pages into the cache).  We also avoid an indirect
> > function call in these cases.
> 
> XFS is taking i_rwsem lock in read_iter() for a surprising reason:
> https://lore.kernel.org/linux-xfs/CAOQ4uxjpqDQP2AKA8Hrt4jDC65cTo4QdYDOKFE-C3cLxBBa6pQ@mail.gmail.com/
> In that post I claim that ocfs2 and cifs also do some work in read_iter().
> I didn't go back to check what, but it sounds like cache coherence among
> nodes.

That's out of date.  Here's POSIX-2017:

https://pubs.opengroup.org/onlinepubs/9699919799/functions/read.html

  "I/O is intended to be atomic to ordinary files and pipes and
  FIFOs. Atomic means that all the bytes from a single operation that
  started out together end up together, without interleaving from other
  I/O operations. It is a known attribute of terminals that this is not
  honored, and terminals are explicitly (and implicitly permanently)
  excepted, making the behavior unspecified. The behavior for other
  device types is also left unspecified, but the wording is intended to
  imply that future standards might choose to specify atomicity (or not)."

That _doesn't_ say "a read cannot observe a write in progress".  It says
"Two writes cannot interleave".  Indeed, further down in that section, it says:

  "Earlier versions of this standard allowed two very different behaviors
  with regard to the handling of interrupts. In order to minimize the
  resulting confusion, it was decided that POSIX.1-2017 should support
  only one of these behaviors. Historical practice on AT&T-derived systems
  was to have read() and write() return -1 and set errno to [EINTR] when
  interrupted after some, but not all, of the data requested had been
  transferred. However, the US Department of Commerce FIPS 151-1 and FIPS
  151-2 require the historical BSD behavior, in which read() and write()
  return the number of bytes actually transferred before the interrupt. If
  -1 is returned when any data is transferred, it is difficult to recover
  from the error on a seekable device and impossible on a non-seekable
  device. Most new implementations support this behavior. The behavior
  required by POSIX.1-2017 is to return the number of bytes transferred."

That explicitly allows for a write to be interrupted by a signal and
later resumed, allowing a read to observe a half-complete write.

> Because if I am not mistaken, even though this change has a potential
> to improve many workloads, it may also degrade some workloads in cases
> where case readahead is not properly tuned. Imagine reading a large file
> and getting only a few pages worth of data read on every syscall.
> Or did I misunderstand your patch's behavior in that case?

I think you did.  If the IOCB_CACHED read hits a readahead page,
it returns early.  Then call_read_iter() notices the read is not yet
complete, and calls ->read_iter() to finish the read.  So it's two
calls to generic_file_buffered_read() rather than one, but it's still
one syscall.
