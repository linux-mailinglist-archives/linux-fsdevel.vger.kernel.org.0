Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B5A36D01E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 02:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbhD1A7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 20:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhD1A7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 20:59:04 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E692C06175F
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 17:58:20 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id z5so7496198qts.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 17:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nnLhfKmay2hfrNFLJmZvY1slfDRvS1kILjvcSIZf/mg=;
        b=Hn5od4nTNCw0oO2WqwOMMft1NWsukPMlQRMrmwYFStQpXM9w0sZauP31fIdtDH/T7P
         h6jPwZVotyfrbiIrXeMGZ62TkyK6QIwX67ES+gfMl8OiTSmYJuZ52V6nA3KhnyVv4rVw
         CLhPSfyg0imxrZGzoaYi+sS4g6tNMPJ3cwXA+NwRZiLQFrWWez+EUg+fChxjLjtbljLC
         SuLpDsBsgIf4kUuDkMscPgXmS7pVdl1eULZREb5iRO8DH7rXP1kkBNdf923GNq8j4Vhg
         X/HUjp7hcqGBtAi6hqMpCMgABRm2cYcM1xijPrP0MlS4UfszukBRzBa7mfHZOl0IkXsI
         KAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=nnLhfKmay2hfrNFLJmZvY1slfDRvS1kILjvcSIZf/mg=;
        b=P1XgRG6oGDIr6+hW6gyCEJHHaFn+2wpQY4a8vlW1NMs6it0Uak4sgnQQ62ts4I+kjy
         Qld7ERDBuj71OV4UbuvVG6uh99HjnCY/tZyEBSyIwl3dn45IT0040TXUCbajL08GeQuq
         RK65eqXtW1u3WF1ZTuo9Irc8CxEhMPecsGlR1fyGLEpM7uGGh7blXA3EhTHufeV8FE1i
         uYxocrUObuaLUnbIuA2Sgx9I3p99+WPo83l1s8Amne9DAvDmExJvUNdaY+EndRHQY/he
         pfnCh6l6+L3KAxkmRV/dTyidJNaciw+tkckuq+rSGclFge3/xB3kAxy4o1VbvgRXFIsN
         7HaQ==
X-Gm-Message-State: AOAM531lvT6AxAL/XTKFvQlzYn2GMwVGKSaTmBqk7l3Dc59YXO1M1U/O
        l5dpdBjaB/iyAvhaanZ2etIHuA==
X-Google-Smtp-Source: ABdhPJxU7KyEA/ZmtPQITj+z73ELbtvuZj0UGvuPkYy8R3FVU9mHK9Cn432IolPH4dFuamCDIcAmLA==
X-Received: by 2002:ac8:6e89:: with SMTP id c9mr24352036qtv.268.1619571499536;
        Tue, 27 Apr 2021 17:58:19 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3sm3869819qko.120.2021.04.27.17.58.17
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 27 Apr 2021 17:58:19 -0700 (PDT)
Date:   Tue, 27 Apr 2021 17:58:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v5 06/10] userfaultfd/shmem: modify shmem_mcopy_atomic_pte
 to use install_pte()
In-Reply-To: <20210427225244.4326-7-axelrasmussen@google.com>
Message-ID: <alpine.LSU.2.11.2104271704110.7111@eggly.anvils>
References: <20210427225244.4326-1-axelrasmussen@google.com> <20210427225244.4326-7-axelrasmussen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 27 Apr 2021, Axel Rasmussen wrote:

> In a previous commit, we added the mcopy_atomic_install_pte() helper.
> This helper does the job of setting up PTEs for an existing page, to map
> it into a given VMA. It deals with both the anon and shmem cases, as
> well as the shared and private cases.
> 
> In other words, shmem_mcopy_atomic_pte() duplicates a case it already
> handles. So, expose it, and let shmem_mcopy_atomic_pte() use it
> directly, to reduce code duplication.
> 
> This requires that we refactor shmem_mcopy_atomic_pte() a bit:
> 
> Instead of doing accounting (shmem_recalc_inode() et al) part-way
> through the PTE setup, do it afterward. This frees up
> mcopy_atomic_install_pte() from having to care about this accounting,
> and means we don't need to e.g. shmem_uncharge() in the error path.
> 
> A side effect is this switches shmem_mcopy_atomic_pte() to use
> lru_cache_add_inactive_or_unevictable() instead of just lru_cache_add().
> This wrapper does some extra accounting in an exceptional case, if
> appropriate, so it's actually the more correct thing to use.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Not quite. Two things.

One, in this version, delete_from_page_cache(page) has vanished
from the particular error path which needs it.

Two, and I think this predates your changes (so needs a separate
fix patch first, for backport to stable? a user with bad intentions
might be able to trigger the BUG), in pondering the new error paths
and that /* don't free the page */ one in particular, isn't it the
case that the shmem_inode_acct_block() on entry might succeed the
first time, but atomic copy fail so -ENOENT, then something else
fill up the tmpfs before the retry comes in, so that retry then
fail with -ENOMEM, and hit the BUG_ON(page) in __mcopy_atomic()?

(As I understand it, the shmem_inode_unacct_blocks() has to be
done before returning, because the caller may be unable to retry.)

What the right fix is rather depends on other uses of __mcopy_atomic():
if they obviously cannot hit that BUG_ON(page), you may prefer to leave
it in, and fix it here where shmem_inode_acct_block() fails. Or you may
prefer instead to delete that "else BUG_ON(page);" - looks as if that
would end up doing the right thing.  Peter may have a preference.

(Or, we could consider doing the shmem_inode_acct_block() only after
the page has been copied in: its current placing reflects how shmem.c
does it elsewhere, and there's reason for that, but it doesn't always
work out right. Don't be surprised if I change the ordering in future,
but it's probably best not to mess with that ordering now.)

Sorry, if this is a pre-existing issue, then we are taking advantage
of you, in asking you to fix it: but I hope that while you're in there,
it will make sense to do so.

Thanks,
Hugh

> ---
>  include/linux/userfaultfd_k.h |  5 ++++
>  mm/shmem.c                    | 48 +++++------------------------------
>  mm/userfaultfd.c              | 17 +++++--------
>  3 files changed, 18 insertions(+), 52 deletions(-)
