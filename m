Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4776016CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 21:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiJQTA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 15:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiJQTA4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:00:56 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AAE73C1D
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 12:00:51 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id k3so14353907ybk.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 12:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zrBdXCGWEkZBYVNoEyJxyq+fpdRwHofZyOq3MApTRzA=;
        b=Qy4aW4IxLYuY4fhWzWgC8zbtTgnr9crlSLX3+OQ1Kq6xvzSVGoddw6q1fLdnxi9v+r
         l5QsSant8Lk6tQeAUEOFeAWieCVxDqxVQ9h4ZUiVI7aCc1DdSYi0ZwTw48yzciNQaR8f
         /sQzaWGLFIlu4BtBlkSIBl5dSK3G2nxivNW3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrBdXCGWEkZBYVNoEyJxyq+fpdRwHofZyOq3MApTRzA=;
        b=i8vVRJnbiGIHmp+E5Oc76aDN1wsl7VYPrHuTsI6LJgz/EYCx/o0yUvmhDRlhvspPSh
         m3VCEZhHUuDYb1/vZj+cuoniJHqEMVQrnERK82IjmKMM6U2al6l/C6Yvf0+PUTmV4KAU
         EY7RR46/SVETj7YwjrLCxBpEMuJ+diO+GWFdukIG7gcQK1HeUHPW8CL/Q0K4nF6SHQsh
         DZQyiBP0fS1hWPDNaDmavarnGbZE5ZNAfT9rX8gWZmgLZX0Yz2F6vDXG4vI7Lo2U4nYe
         nyBZmXc6/D9kca5b9fzUlnkBJAW4/266zGdC7LdWqBtcxrVSZjQJ/BPfh6tg7q3t+yli
         8BZQ==
X-Gm-Message-State: ACrzQf2rmt6dmGfWFcViqmjioVBrL3x8nquwIFMOuRY5TIdDF4FS+81o
        MnBATTYUJnm9nSXUYFLnluZtp7E2BCYkeYGVnDKzOg+qBcg=
X-Google-Smtp-Source: AMsMyM79bnBB8gY4Dcf0aEdZ+FcBVkoXwioB96WQVpiWNzhKeJBhgpT/SnlEB1he/lsT6oRwki9hFHl837MAQ0P10iA=
X-Received: by 2002:a25:9207:0:b0:6c0:b858:d601 with SMTP id
 b7-20020a259207000000b006c0b858d601mr11297743ybo.459.1666033250500; Mon, 17
 Oct 2022 12:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220922224027.59266-1-ivan@cloudflare.com>
In-Reply-To: <20220922224027.59266-1-ivan@cloudflare.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 17 Oct 2022 12:00:39 -0700
Message-ID: <CABWYdi2so7xn860asjr=n9reoFm90X0kGLm7eH_bnYYw8MKg3w@mail.gmail.com>
Subject: Re: [PATCH v2] proc: report open files as size in stat() for /proc/pid/fd
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 3:40 PM Ivan Babrou <ivan@cloudflare.com> wrote:
>
> Many monitoring tools include open file count as a metric. Currently
> the only way to get this number is to enumerate the files in /proc/pid/fd.
>
> The problem with the current approach is that it does many things people
> generally don't care about when they need one number for a metric.
> In our tests for cadvisor, which reports open file counts per cgroup,
> we observed that reading the number of open files is slow. Out of 35.23%
> of CPU time spent in `proc_readfd_common`, we see 29.43% spent in
> `proc_fill_cache`, which is responsible for filling dentry info.
> Some of this extra time is spinlock contention, but it's a contention
> for the lock we don't want to take to begin with.
>
> We considered putting the number of open files in /proc/pid/status.
> Unfortunately, counting the number of fds involves iterating the open_files
> bitmap, which has a linear complexity in proportion with the number
> of open files (bitmap slots really, but it's close). We don't want
> to make /proc/pid/status any slower, so instead we put this info
> in /proc/pid/fd as a size member of the stat syscall result.
> Previously the reported number was zero, so there's very little
> risk of breaking anything, while still providing a somewhat logical
> way to count the open files with a fallback if it's zero.
>
> RFC for this patch included iterating open fds under RCU. Thanks
> to Frank Hofmann for the suggestion to use the bitmap instead.
>
> Previously:
>
> ```
> $ sudo stat /proc/1/fd | head -n2
>   File: /proc/1/fd
>   Size: 0               Blocks: 0          IO Block: 1024   directory
> ```
>
> With this patch:
>
> ```
> $ sudo stat /proc/1/fd | head -n2
>   File: /proc/1/fd
>   Size: 65              Blocks: 0          IO Block: 1024   directory
> ```
>
> Correctness check:
>
> ```
> $ sudo ls /proc/1/fd | wc -l
> 65
> ```
>
> I added the docs for /proc/<pid>/fd while I'm at it.
>
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
>
> ---
> v2: Added missing rcu_read_lock() / rcu_read_unlock(),
>     task_lock() / task_unlock() and put_task_struct().
> ---
>  Documentation/filesystems/proc.rst | 17 ++++++++++++
>  fs/proc/fd.c                       | 44 ++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)

Now that Linux 6.1-rc1 is out, should this patch be looked at for
inclusion? I see that the net-next tree has opened, not sure if the
same rules apply here.

We've been running the v2 version of this patch in production
successfully for some time now.
