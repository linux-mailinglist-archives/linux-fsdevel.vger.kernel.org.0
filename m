Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2518622D1B9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jul 2020 00:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgGXWTi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 18:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgGXWTh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 18:19:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD70C0619D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 15:19:37 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u185so6050549pfu.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 15:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tKu6dCt613fdxShSr3MNQvN+Z3t8LPfma2vJHgkDUqY=;
        b=Ze0QOU71S5Saw5DycUmCZWwu7UDssrDQF0AErcq/xzaOBE1TTHJtT5cYe1fTHWoyWl
         Pi8XZrkpRL2pCy+E4BXKTi3GSskC48PI169avdr5aESBcn9w+NE+73qCkFsFwQqi+68m
         CjtpCokJcV0q7o35ec+JVuZSEC2yUmbNQpcXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tKu6dCt613fdxShSr3MNQvN+Z3t8LPfma2vJHgkDUqY=;
        b=bKj+ZopZSUjfzzRoJFZC3ZaWNTicxJ9yM6ivtJTxPVjtliMeG5tm2QR8pl1oarANjI
         adqkvCD8Rf9AkqhOBTv+N2RxDhcA4z4nFK3sa3euEG6IcHkJJ/p3wJ8vpPH95zETH3OG
         5LC9JlpTwFjR2B2VvIp4TsGiFuuyIkbXzb/E0TlQpgfLzT16JzTqikd+DhjEKY1qBJLT
         xkdLcJCbw09b+nsnN2qlL12QSkwvXTNnF7NhtEhHn37ZRmUpoZ1OfmoSPvgdnptM9Qwo
         snTUSR0Kbzsit5Mmw1b87TpQeb0ZMhUjejdy+6v+Y/uKcujCkUPmCX9surISuJwqvIs5
         R9aQ==
X-Gm-Message-State: AOAM530ViL2ECD45W2lsKMKhkVUH1+iHvP6KX5uAuF0Ca3aQbucnJbO9
        zwcpBQgPYS9ygsSBOdELcvxR4A==
X-Google-Smtp-Source: ABdhPJzXnphiLbThu5BAiaaTLpUONpLw/5HE6EjQi5PD4fOSq9f/Swuwb/PB3pgiv1W1TRcMVLRNEA==
X-Received: by 2002:a63:5906:: with SMTP id n6mr9883418pgb.278.1595629177336;
        Fri, 24 Jul 2020 15:19:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r25sm6938775pgv.88.2020.07.24.15.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 15:19:36 -0700 (PDT)
Date:   Fri, 24 Jul 2020 15:19:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     ira.weiny@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Igor Stoppa <igor.stoppa@gmail.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH RFC V2 00/17] PKS: Add Protection Keys Supervisor (PKS)
 support
Message-ID: <202007241455.010B049A@keescook>
References: <20200717072056.73134-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717072056.73134-1-ira.weiny@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 12:20:39AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> This RFC series has been reviewed by Dave Hansen.
> 
> Changes from RFC:
> 	Clean up commit messages based on Peter Zijlstra's and Dave Hansen's
> 		feedback
> 	Fix static branch anti-pattern
> 	New patch:
> 	(memremap: Convert devmap static branch to {inc,dec})
> 		This was the code I used as a model for my static branch which
> 		I believe is wrong now.
> 	New Patch:
> 	(x86/entry: Preserve PKRS MSR through exceptions)
> 		This attempts to preserve the per-logical-processor MSR, and
> 		reference counting during exceptions.  I'd really like feed
> 		back on this because I _think_ it should work but I'm afraid
> 		I'm missing something as my testing has shown a lot of spotty
> 		crashes which don't make sense to me.
> 
> This patch set introduces a new page protection mechanism for supervisor pages,
> Protection Key Supervisor (PKS) and an initial user of them, persistent memory,
> PMEM.
> 
> PKS enables protections on 'domains' of supervisor pages to limit supervisor
> mode access to those pages beyond the normal paging protections.  They work in
> a similar fashion to user space pkeys.  Like User page pkeys (PKU), supervisor
> pkeys are checked in addition to normal paging protections and Access or Writes
> can be disabled via a MSR update without TLB flushes when permissions change.
> A page mapping is assigned to a domain by setting a pkey in the page table
> entry.
> 
> Unlike User pkeys no new instructions are added; rather WRMSR/RDMSR are used to
> update the PKRS register.
> 
> XSAVE is not supported for the PKRS MSR.  To reduce software complexity the
> implementation saves/restores the MSR across context switches but not during
> irqs.  This is a compromise which results is a hardening of unwanted access
> without absolute restriction.
> 
> For consistent behavior with current paging protections, pkey 0 is reserved and
> configured to allow full access via the pkey mechanism, thus preserving the
> default paging protections on mappings with the default pkey value of 0.
> 
> Other keys, (1-15) are allocated by an allocator which prepares us for key
> contention from day one.  Kernel users should be prepared for the allocator to
> fail either because of key exhaustion or due to PKS not being supported on the
> arch and/or CPU instance.
> 
> Protecting against stray writes is particularly important for PMEM because,
> unlike writes to anonymous memory, writes to PMEM persists across a reboot.
> Thus data corruption could result in permanent loss of data.
> 
> The following attributes of PKS makes it perfect as a mechanism to protect PMEM
> from stray access within the kernel:
> 
>    1) Fast switching of permissions
>    2) Prevents access without page table manipulations
>    3) Works on a per thread basis
>    4) No TLB flushes required

Cool! This seems like it'd be very handy to make other types of kernel
data "read-only at rest" (as was long ago proposed via X86_CR0_WP[1],
which only provided to protection levels, not 15). For example, I think
at least a few other kinds of areas stand out to me that are in need
of PKS markings (i.e. only things that actually manipulate these areas
should gain temporary PK access):
- Page Tables themselves
- Identity mapping
- The "read-only at rest" stuff, though it'll need special plumbing to
  make it work with the slab allocator, etc (more like the later "static
  allocation" work[2]).

[1] https://lore.kernel.org/lkml/1490811363-93944-1-git-send-email-keescook@chromium.org/
[2] https://lore.kernel.org/lkml/cover.1550097697.git.igor.stoppa@huawei.com/

-- 
Kees Cook
