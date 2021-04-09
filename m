Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21C235927C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 05:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhDIDIg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 23:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbhDIDIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:08:35 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B6FC061761
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 20:08:23 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id n140so4361208oig.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 20:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=9uthe1FxOzaDy+lszfFzdCpFcyILmV2zQJPxB5oi21c=;
        b=DpTO01Wvt3BiLQVzhjRo0O2uCjpzLu70Np53FubkoZ5Wdd4qB2TR4aq3G9EAuD5kxF
         oKF1DQSbaeH0Wsxv1mpYjNa8XRaKmzmSNp+vwuza6oodi2c2AAqBt3OD47SqSSS0tFI+
         K8jBnnpO/rDXkTN3+NWWKrz9bwvrhtEGv5yrBReSjvO+JY9IFv16d59VPPOw02lRkAhs
         r/nWyOyUH2x3myijAHfpBX7wXT2scNBUXRNVhtTADzi4YG989Y465H+/RBYqs3ljSd4H
         EPWJuyGBLUvAy+2/j+FPNu1synqnp1lefptHLDgoGHKqKglfmH32ligoKuhKT5My+M2X
         2WUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=9uthe1FxOzaDy+lszfFzdCpFcyILmV2zQJPxB5oi21c=;
        b=eCahriCfxxGzcR93WRoMBOapCiG9PAEdawDgoK93yHP7x845I9VFWdp2hdudQawZyd
         l2tKRXyVRVfOEwZdmMJh9BTmHx1bhwzdTfPZ9dRqFopXQtCago4gY8wqn9Ix4K9MOPtS
         TO6CV1FOfB3Mt0Sxu/8ukMDYoK3ep8YbvlCZ14f+ejUqbGb1IejeHHZU87D2rBugerXD
         cJXPMInLKtqaC4R8chhsGKVfCtZR4NkgTGQ4Z4x4DVLx29Qhb5NQvoVuRwvWMybjFDk8
         gKr9ow0nOUZIfdW6J/HrkbOFxLsbUz9lPLFOEa2GWeyH5r+o1Ca6qE2yv30VDrfKjwFF
         xO+g==
X-Gm-Message-State: AOAM532innxgVeptGcsHqi62isPbzMK6vVUmgZK50d2iV9LDs1k4EosL
        DJq4/Zgj2gkkc8i7fobaY6v4ww==
X-Google-Smtp-Source: ABdhPJwuyOcM3WhiOtVZEWdmStl8yBE9r5JSQp/xMohf6HKVzzwFaVwovIdg+etJ8w9iw+UpuDnMSw==
X-Received: by 2002:aca:db41:: with SMTP id s62mr8559824oig.54.1617937702431;
        Thu, 08 Apr 2021 20:08:22 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f29sm327464ots.22.2021.04.08.20.08.20
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 08 Apr 2021 20:08:21 -0700 (PDT)
Date:   Thu, 8 Apr 2021 20:08:07 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v5] userfaultfd/shmem: fix MCOPY_ATOMIC_CONTINUE
 behavior
In-Reply-To: <CAJHvVcjqu7XymFBOMJTuF03Tts7=pOcs0nTZy25Y=t6sYQPJrw@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2104081912360.19277@eggly.anvils>
References: <20210405171917.2423068-1-axelrasmussen@google.com> <20210406234949.GN628002@xz-x1> <CAJHvVcjqu7XymFBOMJTuF03Tts7=pOcs0nTZy25Y=t6sYQPJrw@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 8 Apr 2021, Axel Rasmussen wrote:
> On Tue, Apr 6, 2021 at 4:49 PM Peter Xu <peterx@redhat.com> wrote:
> > On Mon, Apr 05, 2021 at 10:19:17AM -0700, Axel Rasmussen wrote:
...
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
...
> > > +
> > > +     if (is_file_backed) {
> > > +             /* The shmem MAP_PRIVATE case requires checking the i_size */
> > > +             inode = dst_vma->vm_file->f_inode;
> > > +             offset = linear_page_index(dst_vma, dst_addr);
> > > +             max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> > > +             ret = -EFAULT;
> > > +             if (unlikely(offset >= max_off))
> > > +                     goto out_unlock;
> >
> > Frankly I don't really know why this must be put into pgtable lock..  Since if
> > not required then it can be moved into UFFDIO_COPY path, as CONTINUE doesn't
> > need it iiuc.  Just raise it up as a pure question.
> 
> It's not clear to me either. shmem_getpage_gfp() does check this twice
> kinda like we're doing, but it doesn't ever touch the PTL. What it
> seems to be worried about is, what happens if a concurrent
> FALLOC_FL_PUNCH_HOLE happens somewhere in the middle of whatever
> manipulation we're doing? From looking at shmem_fallocate(), I think
> the basic point is that truncation happens while "inode_lock(inode)"
> is held, but neither shmem_mcopy_atomic_pte() or the new
> mcopy_atomic_install_ptes() take that lock.
> 
> I'm a bit hesitant to just remove it, run some tests, and then declare
> victory, because it seems plausible it's there to catch some
> semi-hard-to-induce race. I'm not sure how to prove that *isn't*
> needed, so my inclination is to just keep it?
> 
> I'll send a series addressing the feedback so far this afternoon, and
> I'll leave this alone for now - at least, it doesn't seem to hurt
> anything. Maybe Hugh or someone else has some more advice about it. If
> so, I'm happy to remove it in a follow-up.

It takes some thinking about, but the i_size check is required to be
under the pagetable lock, for the MAP_PRIVATE UFFDIO_COPY path, where
it is inserting an anonymous page into the file-backed vma (skipping
actually inserting a page into page cache, as an ordinary fault would).

Not because of FALLOC_FL_PUNCH_HOLE (which makes no change to i_size;
and it's okay if a race fills in the hole immediately afterwards),
but because of truncation (which must remove all beyond i_size).

In the MAP_SHARED case, with a locked page inserted into page cache,
the page lock is enough to exclude concurrent truncation.  But even
in that case the second i_size check (I'm looking at 5.12-rc's
shmem_mfill_atomic_pte(), rather than recent patches which might differ)
is required: because the first i_size check was done before the page
became visible in page cache, so a concurrent truncation could miss it).

Maybe that first check is redundant, though I'm definitely for doing it;
or maybe shmem_add_to_page_cache() would be better if it made that check
itself, under xas_lock (I think the reason it does not is historical).
The second check, in the MAP_SHARED case, does not need to be under
pagetable lock - the page lock on the page cache page is enough -
but probably Andrea placed it there to resemble the anonymous case.

You might then question, how come there is no i_size check in all of
mm/memory.c, where ordinary faulting is handled.  I'll answer that
the pte_same() check, under pagetable lock in wp_page_copy(), is
where the equivalent to userfaultfd's MAP_PRIVATE UFFDIO_COPY check
is made: if the page cache page has already been truncated, that pte
will have been cleared.

Or, if the page cache page is truncated an instant after wp_page_copy()
drops page table lock, then the unmap_mapping_range(,,, even_cows = 1)
which follows truncation has to clean it up.  Er, does that mean that
the i_size check I started off insisting is required, actually is not
required?  Um, maybe, but let's just keep it and say goodnight!

Hugh
