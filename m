Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A4A3EDDB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 21:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhHPTO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 15:14:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230231AbhHPTOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629141263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lWy3l2+IfO7xO6oKpqVQHj7y0vYczHZZ4SIluKLQLb8=;
        b=YJyhDttYZdTjcGRCCm6w9yFTHcwG8r/HoEac9mMvlxx7UtCgjfeKes8aFtyh1ixUN5fn5Z
        JdcjMdiAEd7K1ifY5QuMV1Oi5JZponCffUDVcGiXgmHc9I9e8TeiBWt0w/iIAW13Yz15y8
        7YbDF7xQJXld5QsPZ2UluZg8bykBwYg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-3WJOsJEhMVu3CMXpKcarSA-1; Mon, 16 Aug 2021 15:14:22 -0400
X-MC-Unique: 3WJOsJEhMVu3CMXpKcarSA-1
Received: by mail-wr1-f70.google.com with SMTP id n18-20020adfe792000000b00156ae576abdso2075055wrm.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Aug 2021 12:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWy3l2+IfO7xO6oKpqVQHj7y0vYczHZZ4SIluKLQLb8=;
        b=sSTs1mfptoNchaafAxkSNWQPyiSj+1F1pFgnlIK8ZOBL1gvL7cSyDqwUmQRFkwrRg8
         m/PjTnA6w8UAvZ7Rd2FIEJ1VKL3JzAMhGWJhizSThu3c37DmFXDQLlnsW/YRYv9hJDF/
         VCzuZqGV1GJDBHbcVMaONrW88MTY9WU3MN7HFLvgX4tUAZguTT/kavIbuOgm6O0+5mRn
         qUQkdOVRk7UJMhE1mHNIvDtWhfd3YkYIyFcfLO5iW8yExkqqY/jQIiPwySY7KpUKPT+f
         5GklDzMMHL4aegVxyHuZ2AS1iSh2L7VoIP/nVizN3JUhLK2DL2GYlOnOGHhNdetYbPoS
         bL1Q==
X-Gm-Message-State: AOAM531RCh4SN/gH1nSAjAXU+Ic6mNPXwAyhnCqpFz8mAhzkbeqi4gjY
        RzuvVwzUd0M1Ywc9ZBAsP9v7PPgcOizWFhDH5k01pw5MunwfUtdeJ0AztmlW2yBVkkEuume7gmV
        A6pnxbLdPArEvPPJubSeAY2eu43oyyE8q+mGoRCSeBg==
X-Received: by 2002:a5d:674b:: with SMTP id l11mr18978887wrw.357.1629141260957;
        Mon, 16 Aug 2021 12:14:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3e2hMfKU0iq3mIOu2m32crL3qBkqbuiWv8L806qkeQbGdArMICY3wU0R/Jc0O1nkrsAQGzAuFreIkqVtHZaU=
X-Received: by 2002:a5d:674b:: with SMTP id l11mr18978869wrw.357.1629141260774;
 Mon, 16 Aug 2021 12:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210803191818.993968-1-agruenba@redhat.com> <CAHk-=wj+_Y7NQ-NhhE0jk52c9ZB0VJbO1AjtMJFB8wP=PO+bdw@mail.gmail.com>
In-Reply-To: <CAHk-=wj+_Y7NQ-NhhE0jk52c9ZB0VJbO1AjtMJFB8wP=PO+bdw@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 16 Aug 2021 21:14:09 +0200
Message-ID: <CAHc6FU6H5q20qiQ5FX1726i0FJHyh=Y46huWkCBZTR3sk+3Dhg@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] gfs2: Fix mmap + page fault deadlocks
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 3, 2021 at 9:45 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Aug 3, 2021 at 12:18 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > With this patch queue, fstest generic/208 (aio-dio-invalidate-failure.c)
> > endlessly spins in gfs2_file_direct_write.  It looks as if there's a bug
> > in get_user_pages_fast when called with FOLL_FAST_ONLY:
> >
> >  (1) The test case performs an aio write into a 32 MB buffer.
> >
> >  (2) The buffer is initially not in memory, so when iomap_dio_rw() ->
> >      ... -> bio_iov_iter_get_pages() is called with the iter->noio flag
> >      set, we get to get_user_pages_fast() with FOLL_FAST_ONLY set.
> >      get_user_pages_fast() returns 0, which causes
> >      bio_iov_iter_get_pages to return -EFAULT.
> >
> >  (3) Then gfs2_file_direct_write faults in the entire buffer with
> >      fault_in_iov_iter_readable(), which succeeds.
> >
> >  (4) With the buffer in memory, we retry the iomap_dio_rw() ->
> >      ... -> bio_iov_iter_get_pages() -> ... -> get_user_pages_fast().
> >      This should succeed now, but get_user_pages_fast() still returns 0.
>
> Hmm. Have you tried to figure out why that "still returns 0" happens?

The call stack is:

gup_pte_range
gup_pmd_range
gup_pud_range
gup_p4d_range
gup_pgd_range
lockless_pages_from_mm
internal_get_user_pages_fast
get_user_pages_fast
iov_iter_get_pages
__bio_iov_iter_get_pages
bio_iov_iter_get_pages
iomap_dio_bio_actor
iomap_dio_actor
iomap_apply
iomap_dio_rw
gfs2_file_direct_write

In gup_pte_range, pte_special(pte) is true and so we return 0.

> One option - for debugging only - would be to introduce a new flag to
> get_user_pages_fast() that says "print out reason if failed" and make
> the retry (but not the original one) have that flag set.
>
> There are a couple of things of note when it comes to "get_user_pages_fast()":
>
>  (a) some architectures don't even enable it
>
>  (b) it can be very picky about the page table contents, and wants the
> accessed bit to already be set (or the dirty bit, in the case of a
> write).
>
> but (a) shouldn't be an issue on any common platform and (b) shouldn't
> be an issue with  fault_in_iov_iter_readable() that actually does a
> __get_user() so it will access through the page tables.
>
> (It might be more of an issue with fault_in_iov_iter_writable() due to
> walking the page tables by hand - if we don't do the proper
> access/dirty setting, I could see get_user_pages_fast() failing).
>
> Anyway, for reason (a) I do think that eventually we should probably
> introduce FOLL_NOFAULT, and allow the full "slow" page table walk -
> just not calling down to handle_mm_fault() if it fails.
>
> But (a) should be a non-issue in your test environment, and so it
> would be interesting to hear what it is that fails. Because scanning
> through the patches, they all _look_ fine to me (apart from the one
> comment about return values, which is more about being consistent with
> copy_to/from_user() and making the code simpler - not about
> correctness)
>
>                        Linus
>

Thanks,
Andreas

