Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EA0444996
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 21:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhKCUgs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 16:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhKCUgp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 16:36:45 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B83C061203
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Nov 2021 13:34:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y1so3470040plk.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Nov 2021 13:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yInAWWmX6IbmZJ/wlq7G3j0MiE3+bSNug2mSaBSOXp8=;
        b=76cN/dMP7BqwBLUJnpcvyKqVcG+CC88CrdxlxKbuWcqgSNC4iPTXsV5pEiM/szthaN
         Xo89SOuuPuU5YXp+WcuZ7SKey/WjFrMFEsRcbrumh+FON7X9feOrs8wybo/qwPSQmfa3
         towr9do08xJMA1zWOME1jqPr3A7hxpwtRbDrM1SInoR0fsYb7PLlPGkUhsefH52nHFwO
         TVwBYtIuUDXEdU3dCPmJVGhNoO7PsHy0XvRS6W8OZhZcXv6RWtmKPrCPEmoZLTI+a1Oo
         qWr6rSOMVbiRYE8S0AYAKP1ze/0ZLmJst3S16f7RqQsq0qA65YaSBt0SYocldMoku4dm
         5CAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yInAWWmX6IbmZJ/wlq7G3j0MiE3+bSNug2mSaBSOXp8=;
        b=iMWYisZkt31KVQ0aF1eVvMgayWPvHPQXI9azxZ0y4thFaPAfs6L+eMTDKr0u1YSdhv
         vMPS91xxDbLn7mtG1ngYTR8NmQAJAVBJLbwn40pBOUyjBBIVSTh7gHjxwcQMI3vAQALh
         KSltyq25EQeu8DuxKnSltjZMyepm3g9kQXYg7TBkgo7zEZ25Jn6TJEVJ6RC9CnOB4gzl
         pBuCxT/xiidmhkjjgeXszq8M89QtMV0siznSlhT4S/HBOicHVEz+M7zmuE5o8sJU4cvM
         HAnaCvCbJLKIMmMvrsPqh2LOxuegoxCrDrF7tBblut1Skb3aZKa5Fq7lHWSCpzGu7G2d
         d7zA==
X-Gm-Message-State: AOAM532I47Q18M0+67BVQkI+5qBYud/IIATvyEbyzgJGMOMewfTw+1PN
        3/qgv2XKsMeiBY3Nqc2M6HRD41DjM/ggSFiaMfmPUg==
X-Google-Smtp-Source: ABdhPJzd7Z8lZ96OuyBaVsmPkzvXvAiMBjG+8ylo9BgB66C56AZdzDtCJhUvR3LVHaBpBpz3Mis5HNJMl34JvAiOnPA=
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr17053980pjb.220.1635971648063;
 Wed, 03 Nov 2021 13:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211021001059.438843-1-jane.chu@oracle.com> <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com> <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com> <YXj2lwrxRxHdr4hb@infradead.org>
 <20211028002451.GB2237511@magnolia> <YYDYUCCiEPXhZEw0@infradead.org>
 <CAPcyv4j8snuGpy=z6BAXogQkP5HmTbqzd6e22qyERoNBvFKROw@mail.gmail.com> <YYK/tGfpG0CnVIO4@infradead.org>
In-Reply-To: <YYK/tGfpG0CnVIO4@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 3 Nov 2021 13:33:58 -0700
Message-ID: <CAPcyv4it2_PVaM8z216AXm6+h93frg79WM-ziS9To59UtEQJTA@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with RWF_RECOVERY_DATA flag
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 3, 2021 at 9:58 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Nov 02, 2021 at 12:57:10PM -0700, Dan Williams wrote:
> > This goes back to one of the original DAX concerns of wanting a kernel
> > library for coordinating PMEM mmap I/O vs leaving userspace to wrap
> > PMEM semantics on top of a DAX mapping. The problem is that mmap-I/O
> > has this error-handling-API issue whether it is a DAX mapping or not.
>
> Semantics of writes through shared mmaps are a nightmare.  Agreed,
> including agreeing that this is neither new nor pmem specific.  But
> it also has absolutely nothing to do with the new RWF_ flag.

Ok.

> > CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE implies that processes will
> > receive SIGBUS + BUS_MCEERR_A{R,O} when memory failure is signalled
> > and then rely on readv(2)/writev(2) to recover. Do you see a readily
> > available way to improve upon that model without CPU instruction
> > changes? Even with CPU instructions changes, do you think it could
> > improve much upon the model of interrupting the process when a load
> > instruction aborts?
>
> The "only" think we need is something like the exception table we
> use in the kernel for the uaccess helpers (and the new _nofault
> kernel access helper).  But I suspect refitting that into userspace
> environments is probably non-trivial.

Is the exception table requirement not already fulfilled by:

sigaction(SIGBUS, &act, 0);
...
if (sigsetjmp(sj_env, 1)) {
...

...but yes, that's awkward when all you want is an error return from a
copy operation.

For _nofault I'll note that on the kernel side Linus was explicit
about not mixing fault handling and memory error exception handling in
the same accessor. That's why copy_mc_to_kernel() and
copy_{to,from}_kernel_nofault() are distinct. I only say that to probe
deeper about what a "copy_mc()" looks like in userspace? Perhaps an
interface to suppress SIGBUS generation and register a ring buffer
that gets filled with error-event records encountered over a given
MMAP I/O code sequence?

> > I do agree with you that DAX needs to separate itself from block, but
> > I don't think it follows that DAX also needs to separate itself from
> > readv/writev for when a kernel slow-path needs to get involved because
> > mmap I/O (just CPU instructions) does not have the proper semantics.
> > Even if you got one of the ARCH_SUPPORTS_MEMORY_FAILURE to implement
> > those semantics in new / augmented CPU instructions you will likely
> > not get all of them to move and certainly not in any near term
> > timeframe, so the kernel path will be around indefinitely.
>
> I think you misunderstood me.  I don't think pmem needs to be
> decoupled from the read/write path.  But I'm very skeptical of adding
> a new flag to the common read/write path for the special workaround
> that a plain old write will not actually clear errors unlike every
> other store interfac.

Ah, ok, yes, I agree with you there that needing to redirect writes to
a platform firmware call to clear errors, and notify the device that
its error-list has changed is exceedingly awkward. That said, even if
the device-side error-list auto-updated on write (like the promise of
MOVDIR64B) there's still the question about when to do management on
the software error lists in the driver and/or filesytem. I.e. given
that XFS at least wants to be aware of the error lists for block
allocation and "list errors" type features. More below...

> > Meanwhile, I think RWF_RECOVER_DATA is generically useful for other
> > storage besides PMEM and helps storage-drivers do better than large
> > blast radius "I/O error" completions with no other recourse.
>
> How?

Hasn't this been a perennial topic at LSF/MM, i.e. how to get an
interface for the filesystem to request "try harder" to return data?
If the device has a recovery slow-path, or error tracking granularity
is smaller than the I/O size, then RWF_RECOVER_DATA gives the
device/driver leeway to do better than the typical fast path. For
writes though, I can only come up with the use case of this being a
signal to the driver to take the opportunity to do error-list
management relative to the incoming write data.

However, if signaling that "now is the time to update error-lists" is
the requirement, I imagine the @kaddr returned from
dax_direct_access() could be made to point to an unmapped address
representing the poisoned page. Then, arrange for a pmem-driver fault
handler to emulate the copy operation and do the slow path updates
that would otherwise have been gated by RWF_RECOVER_DATA.

Although, I'm not excited about teaching every PMEM arch's fault
handler about this new source of kernel faults. Other ideas?
RWF_RECOVER_DATA still seems the most viable / cleanest option, but
I'm willing to do what it takes to move this error management
capability forward.
