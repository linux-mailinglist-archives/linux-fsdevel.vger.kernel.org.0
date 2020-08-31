Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECC3258390
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 23:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbgHaVbA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 17:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbgHaVa6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 17:30:58 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B99FC061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 14:30:58 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 3so1394877oih.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 14:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=bnaIia5oS8MuB3pY6/NNKF9MoOAGu1lOcEkyq7EGcCE=;
        b=Lxw9DyhLPXoljiCbYUrGe/QUHhYcQHzVXWecDHck8YbyqN1glk0RPA6rCmAmdUrWZz
         /nf5rWlPii1AeaXZe8I3mLTvYV/ALWVPrPDNTh2mE/Lfv4DMdYxf+AUsdEQCfiWGebFB
         cWTz8vb/fwHzgFrscf6f8n+nr/QaOH6jDsrTWKCWw6wM9bR/6DfqbWfXqWEcL3Dc+gIK
         rSVykb9ZtphwQxLmWsOysk9gC/TAR7vP/tIzv5T43pb58jB40OXmGIa7Zxh3+wm2UuYJ
         o9bBC236lYybm7P1CwX+GES45y41IizhLPvPk7VMufJHVN5NgTLbq992EVtyvTBY+CqT
         ahyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=bnaIia5oS8MuB3pY6/NNKF9MoOAGu1lOcEkyq7EGcCE=;
        b=lnU0nurJCdOR+zE3zsAEO7jRWaJIZayVkFJtdfhWNz6BPQ/s5On1ppb0nxG9Cp3RPE
         l7AmAKTQbd268CcPKxrptetQeP6p/XhZN/Evk5p0bjAUWftk5Ny+h9siYzL5Fj8pdHVx
         t+Cdlx32EsGNUQRXx9tqjesWLtf4aFyUjr2DOqmTLWGbbrljFwvgbcCqWqVu+9DQXnSx
         7IK8ixY3zH2ZcpAv1gOlFCMpTNvFuORrQeSf8HpCvCLqtcpEh25FK081XYguAibbULtO
         rinch0ThdhH/db/8PF/y7TbTUiBPMBOsFnCPLllOLvASMNzfiJluWyslU6i2SqCHx3S1
         BGMg==
X-Gm-Message-State: AOAM531rWWYFvWKykCyNIfKSGD9WPcHrjNMKFRBbhPXHKsZGPEd6sVNV
        YqyomfOympugqw2TrmOR5jL/xw==
X-Google-Smtp-Source: ABdhPJw+6EbNvjEhSkrjGy+dPMj04Y8EWSDxKm3IXyVSlJFNKRA2IZBWSEQT/UW0Y5wvu92R3PKMjQ==
X-Received: by 2002:aca:4b87:: with SMTP id y129mr817617oia.107.1598909456692;
        Mon, 31 Aug 2020 14:30:56 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l4sm2082614oop.13.2020.08.31.14.30.54
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 31 Aug 2020 14:30:55 -0700 (PDT)
Date:   Mon, 31 Aug 2020 14:30:42 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Jann Horn <jannh@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v5 7/7] mm: Remove the now-unnecessary mmget_still_valid()
 hack
In-Reply-To: <CAG48ez15Zxbkjv0WRChZZZ6F78pFVXPTu_Bn1Pqaxx=7Gk1gUg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2008311346370.3722@eggly.anvils>
References: <20200827114932.3572699-1-jannh@google.com> <20200827114932.3572699-8-jannh@google.com> <alpine.LSU.2.11.2008302225510.1934@eggly.anvils> <CAG48ez15Zxbkjv0WRChZZZ6F78pFVXPTu_Bn1Pqaxx=7Gk1gUg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I didn't answer your questions further down, sorry, resuming...

On Mon, 31 Aug 2020, Jann Horn wrote:
> On Mon, Aug 31, 2020 at 8:07 AM Hugh Dickins <hughd@google.com> wrote:
...
> > but the "pmd .. physical page 0" issue is explained better in its parent
> > 18e77600f7a1 ("khugepaged: retract_page_tables() remember to test exit")
...
> Just to clarify: This is an issue only between GUP's software page

Not just GUP's software page table walks: any of our software page
table walks that could occur concurrently (notably, unmapping when
exiting).

> table walks when running without mmap_lock and concurrent page table
> modifications from hugepage code, correct?

Correct.

> Hardware page table walks

Have no problem: the necessary TLB flush is already done.

> and get_user_pages_fast() are fine because they properly load PTEs
> atomically and are written to assume that the page tables can change
> arbitrarily under them, and the only guarantee is that disabling
> interrupts ensures that pages referenced by PTEs can't be freed,
> right?

mm/gup.c has changed a lot since I was familiar with it, and I'm
out of touch with the history of architectural variants.  I think
internal_get_user_pages_fast() is now the place to look, and I see

		local_irq_save(flags);
		gup_pgd_range(addr, end, fast_flags, pages, &nr_pinned);
		local_irq_restore(flags);

reassuringly there, which is how x86 always used to do it,
and the dependence of x86 TLB flush on IPIs made it all safe.

Looking at gup_pmd_range(), its operations on pmd (= READ_ONCE(*pmdp))
look correct to me, and where I said "any of our software page table
walks" above, there should be an exception for GUP_fast.

But the other software page table walks are more loosely coded, and
less able to fall back - if gup_pmd_range() catches sight of a fleeting
*pmdp 0, it rightly just gives up immediately on !pmd_present(pmd);
whereas tearing down a userspace mapping needs to wait or retry on
seeing a transient state (but mmap_lock happens to give protection
against that particular transient state).

I assume that all the architectures which support GUP_fast have now
been gathered into the same mechanism (perhaps by an otherwise
superfluous IPI on TLB flush?) and are equally safe.

Hugh
