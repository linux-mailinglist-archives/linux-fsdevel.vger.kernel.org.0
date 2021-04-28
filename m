Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B5E36DC96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 18:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbhD1QBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 12:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhD1QBQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:01:16 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81E8C061573
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 09:00:30 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l1so7224751qtr.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2SuF9mSmF53oX7jF/kwRpkLK22JzuM8F0Omk1lKrm3U=;
        b=c91OhnqmUMdrp5NwBmhDw0TWIKfd7cy5vfjKAMC5+iO+8WsXa/1iWeYeOn3iiAdnee
         K687+nQwR9YSd0rPz34NBcYSpywzjMxeDXC53/Pb4AEGt7HZEY5Icnr0ahoHBsonGrbg
         HXyuj//ZVjv22KpBoGWMZ2LFIIXIny1zBaq8Ckc7R2iE49O+5QqGx11lTuePdNiVNZQe
         kuJ5UJThxkM79QHzgt2Li5You3M+/fDQ8yIHwND0dIhYaufGJNCSGtpVdCHwu6nPhiZQ
         W8SjrEQQJNQEUo944EZmAwLRIc9DO2ZQpaS+Vg8i61WI8H2F5Vmk/5l5GjuPT/zghXGr
         DYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SuF9mSmF53oX7jF/kwRpkLK22JzuM8F0Omk1lKrm3U=;
        b=dsVN+JrOzcFX5vAQVyxniluH0f2LW0m0LQv0zp7nlTQMSM4xoCrn8ugaHc1QEQQnJG
         gJKrxMNHJoF6PHl/ftdTIb8kL1R6UEO+8RmlWkCbsV/PcbnHccW8fnj0De/kEm5BZHs6
         W0+mSVXKXj4qNgHHALCHq40frYn2bPC54nnpBfdE/KN1cez/eZXoouOwK1Vp+aQ9S1Lh
         xSoDK9s3l6vqYBBfLbJfovgVFVbcS0e37h7odUi3LvQYM3RH6y/af0ZSLVaUlJ/4MTXw
         gjhCLJktDFTH5krtfjyvAYwudFPyK4zrh6h8wJyQ6C+HzlQ8VfXQX2pkEls5u7ZQtQc1
         lbSQ==
X-Gm-Message-State: AOAM530viUpdGGBdq8o65YJsVkwCGz/2LAUjWFitnCA02pmUzeZqZcwr
        k6S8N6L+JwhHzFKvRgRz+Cm+kQ22MckuBRZOgx9vvQ==
X-Google-Smtp-Source: ABdhPJxw/1TATKg60w/SjCaCBhfHoT8ss0Bn6ygLRSzh2SsIWTbTBD0bqD3Zs2Gx7AOSnVSgCP23TbUXpGj11qrDJVs=
X-Received: by 2002:ac8:51d3:: with SMTP id d19mr26641416qtn.358.1619625629931;
 Wed, 28 Apr 2021 09:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210427225244.4326-1-axelrasmussen@google.com>
 <20210427225244.4326-7-axelrasmussen@google.com> <alpine.LSU.2.11.2104271704110.7111@eggly.anvils>
 <20210428155638.GD6584@xz-x1>
In-Reply-To: <20210428155638.GD6584@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 28 Apr 2021 08:59:53 -0700
Message-ID: <CAJHvVcg6mt-FH0vn3ZApYU1tdtyu_8pgGtnKxrX5m2OjiCeApw@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] userfaultfd/shmem: modify shmem_mcopy_atomic_pte
 to use install_pte()
To:     Peter Xu <peterx@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 8:56 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Apr 27, 2021 at 05:58:16PM -0700, Hugh Dickins wrote:
> > On Tue, 27 Apr 2021, Axel Rasmussen wrote:
> >
> > > In a previous commit, we added the mcopy_atomic_install_pte() helper.
> > > This helper does the job of setting up PTEs for an existing page, to map
> > > it into a given VMA. It deals with both the anon and shmem cases, as
> > > well as the shared and private cases.
> > >
> > > In other words, shmem_mcopy_atomic_pte() duplicates a case it already
> > > handles. So, expose it, and let shmem_mcopy_atomic_pte() use it
> > > directly, to reduce code duplication.
> > >
> > > This requires that we refactor shmem_mcopy_atomic_pte() a bit:
> > >
> > > Instead of doing accounting (shmem_recalc_inode() et al) part-way
> > > through the PTE setup, do it afterward. This frees up
> > > mcopy_atomic_install_pte() from having to care about this accounting,
> > > and means we don't need to e.g. shmem_uncharge() in the error path.
> > >
> > > A side effect is this switches shmem_mcopy_atomic_pte() to use
> > > lru_cache_add_inactive_or_unevictable() instead of just lru_cache_add().
> > > This wrapper does some extra accounting in an exceptional case, if
> > > appropriate, so it's actually the more correct thing to use.
> > >
> > > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> >
> > Not quite. Two things.
> >
> > One, in this version, delete_from_page_cache(page) has vanished
> > from the particular error path which needs it.
>
> Agreed.  I also spotted that the set_page_dirty() seems to have been overlooked
> when reusing mcopy_atomic_install_pte(), which afaiu should be move into the
> helper.

I think this is covered: we explicitly call SetPageDirty() just before
returning in shmem_mcopy_atomic_pte(). If I remember correctly from a
couple of revisions ago, we consciously put it here instead of in the
helper because it resulted in simpler code (error handling in
particular, I think?), and not all callers of the new helper need it.

>
> >
> > Two, and I think this predates your changes (so needs a separate
> > fix patch first, for backport to stable? a user with bad intentions
> > might be able to trigger the BUG), in pondering the new error paths
> > and that /* don't free the page */ one in particular, isn't it the
> > case that the shmem_inode_acct_block() on entry might succeed the
> > first time, but atomic copy fail so -ENOENT, then something else
> > fill up the tmpfs before the retry comes in, so that retry then
> > fail with -ENOMEM, and hit the BUG_ON(page) in __mcopy_atomic()?
> >
> > (As I understand it, the shmem_inode_unacct_blocks() has to be
> > done before returning, because the caller may be unable to retry.)
> >
> > What the right fix is rather depends on other uses of __mcopy_atomic():
> > if they obviously cannot hit that BUG_ON(page), you may prefer to leave
> > it in, and fix it here where shmem_inode_acct_block() fails. Or you may
> > prefer instead to delete that "else BUG_ON(page);" - looks as if that
> > would end up doing the right thing.  Peter may have a preference.
>
> To me, the BUG_ON(page) wanted to guarantee mfill_atomic_pte() should have
> consumed the page properly when possible.  Removing the BUG_ON() looks good
> already, it will just stop covering the case when e.g. ret==0.
>
> So maybe slightly better to release the page when shmem_inode_acct_block()
> fails (so as to still keep some guard on the page)?

This second issue, I will take some more time to investigate. :)

>
> Thanks,
>
> --
> Peter Xu
>
