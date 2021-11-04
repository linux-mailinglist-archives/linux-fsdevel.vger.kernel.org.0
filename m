Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1645844505B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 09:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhKDIdj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 04:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKDIdi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 04:33:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E03C061714;
        Thu,  4 Nov 2021 01:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HvPPZaYKI38YNmuRJM5hzuQ/Myh4zSSZv1Dpza7E2EE=; b=rgd2aQd0E7KFmWYzh6XuxmWQ/a
        2nuIGl6b/tYqHs5nx2qXDFOkr2opwjn+i9gckjBg5UHQTZ1wLWMn54rmp0o9V/6SoOFS4Wpn7c5FA
        urGoX7G3JA8sqCmiKKl64pSiZ5yu2jvosA35R8rXyjj5LB+3mGc4/wXLwfXkKycwRjOCsLdHgWbUO
        y+xfWQF9xGg6NgJN+PqeACSXXuDQ7QJZiZ8TL6lJtSaShXTB7Yu7tMZ6Kjke02kAY7Xipc91PRVI1
        ravx8elM5ndKgTlYyl6yD664dIe4upAG3HBbVrcmT3YQYEB5lQPQZ4SvvEXl6JggIkmrKH7ZpY1EC
        MYz7JaFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miY92-008IOw-BM; Thu, 04 Nov 2021 08:30:48 +0000
Date:   Thu, 4 Nov 2021 01:30:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jane Chu <jane.chu@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with
 RWF_RECOVERY_DATA flag
Message-ID: <YYOaOBKgFQYzT/s/@infradead.org>
References: <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
 <YXj2lwrxRxHdr4hb@infradead.org>
 <20211028002451.GB2237511@magnolia>
 <YYDYUCCiEPXhZEw0@infradead.org>
 <CAPcyv4j8snuGpy=z6BAXogQkP5HmTbqzd6e22qyERoNBvFKROw@mail.gmail.com>
 <YYK/tGfpG0CnVIO4@infradead.org>
 <CAPcyv4it2_PVaM8z216AXm6+h93frg79WM-ziS9To59UtEQJTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4it2_PVaM8z216AXm6+h93frg79WM-ziS9To59UtEQJTA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 03, 2021 at 01:33:58PM -0700, Dan Williams wrote:
> Is the exception table requirement not already fulfilled by:
> 
> sigaction(SIGBUS, &act, 0);
> ...
> if (sigsetjmp(sj_env, 1)) {
> ...
> 
> ...but yes, that's awkward when all you want is an error return from a
> copy operation.

Yeah.  The nice thing about the kernel uaccess / _nofault helpers is
that they allow normal error handling flows.

> For _nofault I'll note that on the kernel side Linus was explicit
> about not mixing fault handling and memory error exception handling in
> the same accessor. That's why copy_mc_to_kernel() and
> copy_{to,from}_kernel_nofault() are distinct.

I've always wondered why we need all this mess.  But if the head
penguin wants it..

> I only say that to probe
> deeper about what a "copy_mc()" looks like in userspace? Perhaps an
> interface to suppress SIGBUS generation and register a ring buffer
> that gets filled with error-event records encountered over a given
> MMAP I/O code sequence?

Well, the equivalent to the kernel uaccess model would be to register
a SIGBUS handler that uses an exception table like the kernel, and then
if you use the right helpers to load/store they can return errors.

The other option would be something more like the Windows Structured
Exception Handling:

https://docs.microsoft.com/en-us/cpp/cpp/structured-exception-handling-c-cpp?view=msvc-160


> > I think you misunderstood me.  I don't think pmem needs to be
> > decoupled from the read/write path.  But I'm very skeptical of adding
> > a new flag to the common read/write path for the special workaround
> > that a plain old write will not actually clear errors unlike every
> > other store interfac.
> 
> Ah, ok, yes, I agree with you there that needing to redirect writes to
> a platform firmware call to clear errors, and notify the device that
> its error-list has changed is exceedingly awkward.

Yes.  And that is the big difference to every other modern storage
device.  SSDs always write out of place and will just not reuse bad
blocks, and all drivers built in the last 25-30 years will also do
internal bad block remapping.

> That said, even if
> the device-side error-list auto-updated on write (like the promise of
> MOVDIR64B) there's still the question about when to do management on
> the software error lists in the driver and/or filesytem. I.e. given
> that XFS at least wants to be aware of the error lists for block
> allocation and "list errors" type features. More below...

Well, the whole problem is that we should not have to manage this at
all, and this is where I blame Intel.  There is no good reason to not
slightly overprovision the nvdimms and just do internal bad page
remapping like every other modern storage device.

> Hasn't this been a perennial topic at LSF/MM, i.e. how to get an
> interface for the filesystem to request "try harder" to return data?

Trying harder to _get_ data or to _store_ data?  All the discussion
here seems to be able about actually writing data.

> If the device has a recovery slow-path, or error tracking granularity
> is smaller than the I/O size, then RWF_RECOVER_DATA gives the
> device/driver leeway to do better than the typical fast path. For
> writes though, I can only come up with the use case of this being a
> signal to the driver to take the opportunity to do error-list
> management relative to the incoming write data.

Well, while devices have data recovery slow path they tend to use those
automatically.  What I'm actually seeing in practice is flags in the
storage interfaces to skip this slow path recovery because the higher
level software would prefer to instead recover e.g. from remote copies.

> However, if signaling that "now is the time to update error-lists" is
> the requirement, I imagine the @kaddr returned from
> dax_direct_access() could be made to point to an unmapped address
> representing the poisoned page. Then, arrange for a pmem-driver fault
> handler to emulate the copy operation and do the slow path updates
> that would otherwise have been gated by RWF_RECOVER_DATA.

That does sound like a much better interface than most of what we've
discussed so far. 

> Although, I'm not excited about teaching every PMEM arch's fault
> handler about this new source of kernel faults. Other ideas?
> RWF_RECOVER_DATA still seems the most viable / cleanest option, but
> I'm willing to do what it takes to move this error management
> capability forward.

So far out of the low instrusiveness options Janes' previous series
to automatically retry after calling a clear_poison operation seems
like the best idea so far.  We just need to also think about what
we want to do for direct users of ->direct_access that do not use
the mcsafe iov_iter helpers.
