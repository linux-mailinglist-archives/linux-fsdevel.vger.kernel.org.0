Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE5236619E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 23:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhDTV3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 17:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbhDTV3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:29:47 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EBAC06138A
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 14:29:14 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z14so6514315ioc.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHwmgbifuG0M3rXBM4pJp8JDF3uOD0QG+0y4qHiOLl4=;
        b=hzsFH1dcSvdXMaaExg5echKUbnVUhtWFFlovxS/9tgtjlHQ7oX8H+LYoQqDr0riOyP
         eUJNPystxhJIE1e/wCujS9Rtk91K9rflSyNWN28TpCYEWyb0JJcpWEFtY6zk3veuaMCz
         zMbsT8tstCP3uaSOv4YxtoFrY2s41iMOtWOW4UjtoLZK7dsd1Pq/+GCu6mHJJaL8koHh
         vpH2xaQh/SEPr1vHaPdcq4fgkN4ahwlMexYPQ4pKwVc/h9wurmsOocSALj9k7vEx5bbx
         5d8xcIt5BrGypmKvqBA2RU9476yza+rwF9qpDx9f+JGr4EM5S1lB7FsY9Y3dR8jYXC0Z
         7/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHwmgbifuG0M3rXBM4pJp8JDF3uOD0QG+0y4qHiOLl4=;
        b=C3Qtt+Btgq3gtVRyKrmHaCKpK5cxXuIFMm7hhRU5nUBlMl0ttkZjoFnwFggyrWXZJX
         PnWeYJbgLfpriaQaYmv4Hxy/psi14fKXQgNpBDT2A/0yX6XfOdOOaIiTJBSD4LfrpOjW
         Yfwpx2jDhaCxl2MM7RMMXe842jD5rcscocLnLbsCqVOFR6Np7VieQ8asEcCfyAoE01vq
         Br4sIbFLURP5WPmZQCaI+ZXJ4K0XpBLVryefa3qUFotsdZ91noQlATBwIRIdBhdMf3/0
         IUiZoWKvSzXSJJMUJuI+0f4sm1K60ILAm5Bi0jnU+kHVuQm5nEVQb+47oGWcnOwHoCZD
         zq8Q==
X-Gm-Message-State: AOAM531lKxUwdefa3I3vtt6zhYyE7h7Hp/McCsfIbXaET6DAmWOExy0z
        jrMZVqnpYfgYRiQXu8VIOboJusdY6NbPlLPPADPzvA==
X-Google-Smtp-Source: ABdhPJy5SRraaujh5o7+plqCW6pod/hZ3p9Z+ilGfwktMKl1zQ+uUmIXRpPydRmau3Fw8hTII4uYbt4h+6lqsFujgNc=
X-Received: by 2002:a02:4444:: with SMTP id o65mr17093204jaa.1.1618954154039;
 Tue, 20 Apr 2021 14:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210415184732.3410521-1-axelrasmussen@google.com> <alpine.LSU.2.11.2104151203320.15150@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2104151203320.15150@eggly.anvils>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 20 Apr 2021 14:28:36 -0700
Message-ID: <CAJHvVcifORTZx1tOrmPrqe5Ur9D1XqT9VFXHVzVrRYdEoJvhVA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] userfaultfd: add minor fault handling for shmem
To:     Hugh Dickins <hughd@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
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

On Thu, Apr 15, 2021 at 12:13 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Thu, 15 Apr 2021, Axel Rasmussen wrote:
>
> > Base
> > ====
> >
> > This series is based on (and therefore should apply cleanly to) the tag
> > "v5.12-rc7-mmots-2021-04-11-20-49", additionally with Peter's selftest cleanup
> > series applied first:
> >
> > https://lore.kernel.org/patchwork/cover/1412450/
> >
> > Changelog
> > =========
> >
> > v2->v3:
> > - Picked up {Reviewed,Acked}-by's.
> > - Reorder commits: introduce CONTINUE before MINOR registration. [Hugh, Peter]
> > - Don't try to {unlock,put}_page an xarray value in shmem_getpage_gfp. [Hugh]
> > - Move enum mcopy_atomic_mode forward declare out of CONFIG_HUGETLB_PAGE. [Hugh]
> > - Keep mistakenly removed UFFD_USER_MODE_ONLY in selftest. [Peter]
> > - Cleanup context management in self test (make clear implicit, remove unneeded
> >   return values now that we have err()). [Peter]
> > - Correct dst_pte argument to dst_pmd in shmem_mcopy_atomic_pte macro. [Hugh]
> > - Mention the new shmem support feature in documentation. [Hugh]
>
> I shall ignore this v3 completely: "git send-email" is a wonderful
> tool for mailing out patchsets in quick succession, but I have not
> yet mastered "git send-review" to do the thinking for me as quickly.
>
> Still deliberating on 4/9 and 9/9 of v2: they're very close,
> but raise userfaultfd questions I still have to answer myself.

No problem at all, I'll send a v4 with the 4/9 and 9/9 updates on top
of this, and we can proceed from there, ignoring this version.

Sorry if I seem too eager. I really appreciate your reviews - each
time they are very thorough, and I learn a lot from the process.

>
> Hugh
