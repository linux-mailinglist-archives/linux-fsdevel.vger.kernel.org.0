Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A368345366
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 00:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhCVXz7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 19:55:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbhCVXzi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 19:55:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C5CC619AA;
        Mon, 22 Mar 2021 23:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616457335;
        bh=VpDFohQxZdeFwzTLulapaQ9fKZPYsThIcB9QTDxJKwU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QjJkDa1ggtnBvgZYRVevMK5DtzMSwdnqcL2IKwZNwVfebXPzXeq9bh5HrmauMIZe8
         mcpJ7h1wQ0QtVr1jaT0DnvTITGyr8fywLW3VM8C4i6QW5DhWU0t2SWeCVR0r4gukWU
         9/17UjRe8DYBqbSDpZfn4SqYrJoLgOkl04B/FvlY0QiVd6X5tFbgN7L2oD4ARXGiqQ
         WtgLk2AwqjVl1Ml0zSLMa3uTottJk1yldu7BM2jyTNnG+tibj/vSd53fJHXjvGWp4u
         1tLmi3b75wXhCSsF8ttTGxmdaoZEznXWc3HV/ORwpC5KUHm4Qlk762BzsmTW5pl1dY
         SAoZsLAPI9QwQ==
Received: by mail-lj1-f176.google.com with SMTP id f16so23338361ljm.1;
        Mon, 22 Mar 2021 16:55:35 -0700 (PDT)
X-Gm-Message-State: AOAM531xTjZOBhahIGgkkWP+SNdsfd/q2gFvoliQHQ4OLK/JcC0jnVqP
        ysx7x6BRz2DeD5Q1K5MM85M+EPT/e1EWbnEOj84=
X-Google-Smtp-Source: ABdhPJzeuDx4meNjAF010eIArHffcCcwi/lqemEghn1bNqVX2DsgrA2WhfpeQE44SL87Y1AtRWN2vRbBH+tikm56WU8=
X-Received: by 2002:a05:651c:200b:: with SMTP id s11mr1143822ljo.177.1616457333463;
 Mon, 22 Mar 2021 16:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210322215823.962758-1-cfijalkovich@google.com>
In-Reply-To: <20210322215823.962758-1-cfijalkovich@google.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 22 Mar 2021 16:55:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4RK9-yWrFmoUzi09bquxr_K16LqeZBYWoJXM0t=qo+Gw@mail.gmail.com>
Message-ID: <CAPhsuW4RK9-yWrFmoUzi09bquxr_K16LqeZBYWoJXM0t=qo+Gw@mail.gmail.com>
Subject: Re: [PATCH] mm, thp: Relax the VM_DENYWRITE constraint on file-backed THPs
To:     Collin Fijalkovich <cfijalkovich@google.com>
Cc:     Song Liu <songliubraving@fb.com>, surenb@google.com,
        hridya@google.com, kaleshsingh@google.com,
        Hugh Dickins <hughd@google.com>, timmurray@google.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 3:00 PM Collin Fijalkovich
<cfijalkovich@google.com> wrote:
>
> Transparent huge pages are supported for read-only non-shmem filesystems,
> but are only used for vmas with VM_DENYWRITE. This condition ensures that
> file THPs are protected from writes while an application is running
> (ETXTBSY).  Any existing file THPs are then dropped from the page cache
> when a file is opened for write in do_dentry_open(). Since sys_mmap
> ignores MAP_DENYWRITE, this constrains the use of file THPs to vmas
> produced by execve().
>
> Systems that make heavy use of shared libraries (e.g. Android) are unable
> to apply VM_DENYWRITE through the dynamic linker, preventing them from
> benefiting from the resultant reduced contention on the TLB.
>
> This patch reduces the constraint on file THPs allowing use with any
> executable mapping from a file not opened for write (see
> inode_is_open_for_write()). It also introduces additional conditions to
> ensure that files opened for write will never be backed by file THPs.

Thanks for working on this. We could also use this in many data center
workloads.

Question: when we use this on shared library, the library is still
writable. When the
shared library is opened for write, these pages will refault in as 4kB
pages, right?

Thanks,
Song
