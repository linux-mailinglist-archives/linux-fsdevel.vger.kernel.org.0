Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0CD45297A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 06:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhKPFWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 00:22:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:42120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233403AbhKPFWF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 00:22:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E471E60F6E;
        Tue, 16 Nov 2021 05:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637039948;
        bh=0+h5I2fETKUh6GKu9bzTHSm7jqJYMvkVoBdFhY2URtE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jg2HkZELTf65WPyR611JRctoeh08n8+NPdKweeTf7PMvxNchHTMDvWsc/5jZuQ/5i
         ZSHaM85TcRKSIWfX3oRQ5tTjfXwlBiVW017CXWo1I5M5IFi8nFXpWqtUBuoxXzgx65
         HJ94E1llTJD5T6zTl3FoH9Z3y20PLI77DAK7rqnM=
Date:   Mon, 15 Nov 2021 21:19:05 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        Chinwen Chang (=?UTF-8?Q?=E5=BC=B5=E9=8C=A6?= =?UTF-8?Q?=E6=96=87?=) 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        John Hubbard <jhubbard@nvidia.com>,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v11 2/3] mm: add a field to store names for private
 anonymous memory
Message-Id: <20211115211905.faef6f9db3ce4a6fb9ed66a2@linux-foundation.org>
In-Reply-To: <CAJuCfpGG-j00eDL8p3vNDh4ye2Ja4untoA20UdTkTubm3AfMEQ@mail.gmail.com>
References: <20211019215511.3771969-1-surenb@google.com>
        <20211019215511.3771969-2-surenb@google.com>
        <CAJuCfpGG-j00eDL8p3vNDh4ye2Ja4untoA20UdTkTubm3AfMEQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 19 Oct 2021 14:58:36 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> As Andrew suggested, I checked the image sizes with allnoconfig builds:
> 
> unpatched Linus' ToT
>    text    data     bss     dec     hex filename
> 1324759      32   73928 1398719 1557bf vmlinux
> 
> After the first patch is applied (madvise refactoring)
>    text    data     bss     dec     hex filename
> 1322346      32   73928 1396306 154e52 vmlinux
> >>> 2413 bytes decrease vs ToT <<<
> 
> After all patches applied with CONFIG_ANON_VMA_NAME=n
>    text    data     bss     dec     hex filename
> 1322337      32   73928 1396297 154e49 vmlinux
> >>> 2422 bytes decrease vs ToT <<<
> 
> After all patches applied with CONFIG_ANON_VMA_NAME=y
>    text    data     bss     dec     hex filename
> 1325228      32   73928 1399188 155994 vmlinux
> >>> 469 bytes increase vs ToT <<<

Nice.  Presumably there are memory savings from no longer duplicating
the vma names?

I fudged up a [0/n] changelog (please don't forget this) and merged it
all for testing.
