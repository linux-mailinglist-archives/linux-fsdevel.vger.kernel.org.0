Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AE3457BE4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Nov 2021 06:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhKTFet (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Nov 2021 00:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhKTFet (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Nov 2021 00:34:49 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D4BC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 21:31:46 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id m9so15615140iop.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 21:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnmw4S1Oo24l/mBbjqvIPUjrCN4SWt+nkM7iPySscsw=;
        b=Is6GD84hBb9QY3j8VzxArUzIWg27YUxT7W2u8JsLG3BXkUJFEhtGH+/3LaqHJ5lj/u
         JzOdhu6c+qD1Xp46nfqUBMqM5YcXolH3Cm0gWBAhTvrL0U9Sok39SsnwM/M2fwM+giyC
         b2mttp9GnYCE5IXirYkv7ApZasb6lnRTh/4SvBkwmuuRhjox12DYv/wiXsJzFyxaUtGk
         uFkheaWF/Y6auNhbt4lN5qsa4bH56/C5qdfXXV9rqxo89VHFtgoxWLBWBqz2HwwYGX43
         ZM+LFt1omvXDOHm9TfIFtQhEIiZpdGzRiDJ/sbcSz0UqKLsNZpP+biDAuPXg8bW6HMzh
         5O2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnmw4S1Oo24l/mBbjqvIPUjrCN4SWt+nkM7iPySscsw=;
        b=zm+JB6ooWLjpP0xPG3s7MhI2gEqz4uIMSqJ9WBVbIot5ViN/QHaK3hEbRelGNKAmPK
         xZIubJ4dehaG512oPbi4TZFEs9xefxKF8Qdh5aVtHK3M/P1jw8JcxDDasl1kX36bSPdN
         o/vQh8ka9CCPMmuI3TW7BuUVLkjmSfeejstG+T5CMlCyDegdaQoXRhF6y3oGsDSfNFcV
         vQNVNuyqHp3hNGPjAQOm4v6/EFXGYuPSTwLTW7MKjL3yuULQ0JeCX71U19mpNlFYB0vd
         W9MxaSCCxsEBhHVqkDR8K50K4Jjo34ScLEmA91fZW6MRj6nSWmmnk4ugG8wjeK7/srLN
         9Zzw==
X-Gm-Message-State: AOAM531rmIKZ03AV3ccy47eADBh6rYMY8Dvse1WgDqxiB7y3vxLo18IX
        r4J2Tl7r0zSlP9ppdZGT0w56kkC4M6ZKl/BM2BU5Eg==
X-Google-Smtp-Source: ABdhPJxBhvbOju0exRZ4gxIwv3a9pAvTn8srl8n5iLbXQAIxlrh8tvJvvtpWyzDjocNGmv1/aE1w6IUOj7TJiV6KpFE=
X-Received: by 2002:a05:6638:4183:: with SMTP id az3mr33251237jab.56.1637386305661;
 Fri, 19 Nov 2021 21:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20211120045011.3074840-1-almasrymina@google.com>
 <20211120045011.3074840-3-almasrymina@google.com> <YZiCgrTzcl/QQC+N@casper.infradead.org>
In-Reply-To: <YZiCgrTzcl/QQC+N@casper.infradead.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 19 Nov 2021 21:31:34 -0800
Message-ID: <CAHS8izNJ7-7EKsfFancHw3iNJzBWdHT_GwcJUaMU1_2LQMwX9g@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] mm/oom: handle remote ooms
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Roman Gushchin <guro@fb.com>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 19, 2021 at 9:07 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Nov 19, 2021 at 08:50:08PM -0800, Mina Almasry wrote:
> > On remote ooms (OOMs due to remote charging), the oom-killer will attempt
> > to find a task to kill in the memcg under oom. The oom-killer may be
> > unable to find a process to kill if there are no killable processes in
> > the remote memcg. In this case, the oom-killer (out_of_memory()) will return
> > false, and depending on the gfp, that will generally get bubbled up to
> > mem_cgroup_charge_mapping() as an ENOMEM.
>
> Why doesn't it try to run the shrinkers to get back some page cache /
> slab cache memory from this memcg?  I understand it might not be able
> to (eg if the memory is mlocked), but surely that's rare.
>

Please correct me if I'm wrong, but AFAICT I haven't disabled any
shrinkers from running or disabled any reclaim mechanism on remote
charges. What I see in the code is that when the remote memcg runs out
of memory is that try_to_free_mem_cgroup_pages() gets called as normal
and we do the MAX_RECLAIM_RETRIES as normal.

It's only in the (rare as you point out) case where the kernel is
completely unable to find memory in the remote memcg that we need to
do the special handling that's described in this patch. Although this
situation is probably quite rare in real-world scenarios, it's easily
reproducible (and the attached test in the series does so), so my
feeling is that it needs some sane handling, which I'm attempting to
do in this patch.
