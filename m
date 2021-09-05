Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD4F400FC4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Sep 2021 15:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhIENF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Sep 2021 09:05:29 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55996 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhIENF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Sep 2021 09:05:28 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 59FEE1C0B77; Sun,  5 Sep 2021 15:04:23 +0200 (CEST)
Date:   Sun, 5 Sep 2021 15:04:18 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Kees Cook <keescook@chromium.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        ccross@google.com, sumit.semwal@linaro.org, mhocko@suse.com,
        dave.hansen@intel.com, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, kaleshsingh@google.com, peterx@redhat.com,
        rppt@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, gorcunov@gmail.com,
        songmuchun@bytedance.com, viresh.kumar@linaro.org,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
Subject: Re: [PATCH v9 2/3] mm: add a field to store names for private
 anonymous memory
Message-ID: <20210905130418.GA7117@localhost>
References: <20210902231813.3597709-1-surenb@google.com>
 <20210902231813.3597709-2-surenb@google.com>
 <202109031420.2F17A2C9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109031420.2F17A2C9@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

> > the process is still running, so it has to have some sort of
> > synchronization with every layer of userspace.  Efficiently tracking
> > the ranges requires reimplementing something like the kernel vma
> > trees, and linking to it from every layer of userspace.  It requires
> > more memory, more syscalls, more runtime cost, and more complexity to
> > separately track regions that the kernel is already tracking.

Ok so far.

> > This patch adds a field to /proc/pid/maps and /proc/pid/smaps to show a
> > userspace-provided name for anonymous vmas.  The names of named anonymous
> > vmas are shown in /proc/pid/maps and /proc/pid/smaps as [anon:<name>].
> > 
> > Userspace can set the name for a region of memory by calling
> > prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, start, len, (unsigned
> > long)name);

Would setting a 64-bit integer instead of name be enough? Even if
each party would set it randomly, risk of collisions would be very
low... and we'd not have to deal with strings in kernel.

								Pavel


-- 
