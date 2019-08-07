Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0CB854D5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 22:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389082AbfHGU6m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 16:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729714AbfHGU6m (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 16:58:42 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8357A2173C;
        Wed,  7 Aug 2019 20:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565211521;
        bh=BHNLhewizLMLp7YbdvNCnIzAyhkg8YnrouHHCEfoVa4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u8sRhP8bK815tFw7ifhBS4SB17zcgKZ47zrUXrczJIScpe3WeCh14v/46lx0CCeRW
         0rylwHRSL91S/Vbfj1YBHXKkOsfP1dbUn9GG5ygIrbrkQElQQjhhVbQw/U11jkcUcy
         /6UT11ZTtKTBTxqWUlh1WwFRaVjP4y6LQYMuaHYg=
Date:   Wed, 7 Aug 2019 13:58:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 1/6] mm/page_idle: Add per-pid idle page tracking
 using virtual index
Message-Id: <20190807135840.92b852e980a9593fe91fbf59@linux-foundation.org>
In-Reply-To: <20190807204530.GB90900@google.com>
References: <20190807171559.182301-1-joel@joelfernandes.org>
        <20190807130402.49c9ea8bf144d2f83bfeb353@linux-foundation.org>
        <20190807204530.GB90900@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 7 Aug 2019 16:45:30 -0400 Joel Fernandes <joel@joelfernandes.org> wrote:

> On Wed, Aug 07, 2019 at 01:04:02PM -0700, Andrew Morton wrote:
> > On Wed,  7 Aug 2019 13:15:54 -0400 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> > 
> > > In Android, we are using this for the heap profiler (heapprofd) which
> > > profiles and pin points code paths which allocates and leaves memory
> > > idle for long periods of time. This method solves the security issue
> > > with userspace learning the PFN, and while at it is also shown to yield
> > > better results than the pagemap lookup, the theory being that the window
> > > where the address space can change is reduced by eliminating the
> > > intermediate pagemap look up stage. In virtual address indexing, the
> > > process's mmap_sem is held for the duration of the access.
> > 
> > So is heapprofd a developer-only thing?  Is heapprofd included in
> > end-user android loads?  If not then, again, wouldn't it be better to
> > make the feature Kconfigurable so that Android developers can enable it
> > during development then disable it for production kernels?
> 
> Almost all of this code is already configurable with
> CONFIG_IDLE_PAGE_TRACKING. If you disable it, then all of this code gets
> disabled.
> 
> Or are you referring to something else that needs to be made configurable?

Yes - the 300+ lines of code which this patchset adds!

The impacted people will be those who use the existing
idle-page-tracking feature but who will not use the new feature.  I
guess we can assume this set is small...


