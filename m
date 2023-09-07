Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23B0797C9C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 21:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjIGTTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 15:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjIGTTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:19:14 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7044B9
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 12:19:09 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b962c226ceso22630801fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Sep 2023 12:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694114348; x=1694719148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fh9SxXdeDgiYefKxTuLt7vjL4MJYtZ0NR5+isE1gnSw=;
        b=fX4JUpH98MaatGFwJvBCp+4YmTfB8eaQAbr97oz+F3sDVb8/dbWP2441ZMqP0fSGSe
         gipKybCyp9rOqGoRtJ6RIsaOnzQkgU8Asf7233Wu0sAYtTq199RmuVM+ZTz/Etz/vm2U
         cTIapli+2fr/waBWD9+hLZ04dEpvYk0QilhMea3uQGK6rYjQEL/Ju4M02RJRvRezSkA7
         Ym5thSdN00R1d6768wQG4q2oLHTTR2zSL6GsM7G8rKyKBIp5GdLt+KHDaRZE4TXMpJsk
         1vCyui5uSIIOWXXG/JFKuLKWM3F9s9jO+R7U7ON3jKRtriuMYjwfE9vUfi9awA/39igK
         erjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694114348; x=1694719148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fh9SxXdeDgiYefKxTuLt7vjL4MJYtZ0NR5+isE1gnSw=;
        b=wHCV/Z+4PK+jNWevt+OPVnuDDTb9cji/D0/To+sgGXvC194vjykzaq0WjAWt+2qdyT
         DX82VHryPIkI0ZL6JTxm0VtNfU3WHfb/uYik5Idg2pkf446j0pLtJ5/0TPq2ZK8qXz8n
         a9+jqprhbuhGDXJcza20HQ7pbzJtHvCZsEQ6L1KaEllHUc85+QZzsembG4jEOrdVmDMi
         ksEDOrJBP4zLMXTyw7RHlqL69K3iK6PPD3HrC9GvWsQ43at5MEo0HUdUOXAQnnaY4DcE
         t+aeMoZooxmtygRmjRD48ZWTUI9Q19i3//7aUdAW1WZA6yqakSU6c8Kd7cAe1CaDsV2h
         PWfQ==
X-Gm-Message-State: AOJu0YxCGWdK1/6kM71imGV2/Bl2aoAgsrCIkG8qnPA+EFj5cFqvBwXD
        JhgpDyGxSc+wNaK/0I2Z9OjQHTs5808YD+4Ts5HVxA==
X-Google-Smtp-Source: AGHT+IHrXpMuSwQQQ03SPRDxfKGtSaY06C8ng9QkYeonij74hOQ5lKt2eSklQHKaLviUpJ2Pf2FzYgAOrtQ2pDDzcSs=
X-Received: by 2002:a2e:b0ee:0:b0:2be:4d40:f833 with SMTP id
 h14-20020a2eb0ee000000b002be4d40f833mr131512ljl.18.1694114347766; Thu, 07 Sep
 2023 12:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230905214235.320571-1-peterx@redhat.com>
In-Reply-To: <20230905214235.320571-1-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 7 Sep 2023 12:18:29 -0700
Message-ID: <CAJHvVcjQR95KVfu2qv3hepkLWkH5J8qRG_BazHKSXoGoGnUATg@mail.gmail.com>
Subject: Re: [PATCH 0/7] mm/userfaultfd/poll: Scale userfaultfd wakeups
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anish Moorthy <amoorthy@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 5, 2023 at 2:42=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> Userfaultfd is the type of file that doesn't need wake-all semantics: if
> there is a message enqueued (for either a fault address, or an event), we
> only need to wake up one service thread to handle it.  Waking up more
> normally means a waste of cpu cycles.  Besides that, and more importantly=
,
> that just doesn't scale.

Hi Peter,

I took a quick look over the series and didn't see anything
objectionable. I was planning to actually test the series out and then
send out R-b's, but it will take some additional time (next week).

In the meantime, I was curious about the use case. A design I've seen
for VM live migration is to have 1 thread reading events off the uffd,
and then have many threads actually resolving the fault events that
come in (e.g. fetching pages over the network, issuing UFFDIO_COPY or
UFFDIO_CONTINUE, or whatever). In that design, since we only have a
single reader anyway, I think this series doesn't help.

But, I'm curious if you have data indicating that > 1 reader is more
performant overall? I suspect it might be the case that, with "enough"
vCPUs, it makes sense to do so, but I don't have benchmark data to
tell me what that tipping point is yet.

OTOH, if one reader is plenty in ~all cases, optimizing this path is
less important.




>
> Andrea used to have one patch that made read() to be O(1) but never hit
> upstream.  This is my effort to try upstreaming that (which is a
> oneliner..), meanwhile on top of that I also made poll() O(1) on wakeup,
> too (more or less bring EPOLLEXCLUSIVE to poll()), with some tests showin=
g
> that effect.
>
> To verify this, I added a test called uffd-perf (leveraging the refactore=
d
> uffd selftest suite) that will measure the messaging channel latencies on
> wakeups, and the waitqueue optimizations can be reflected by the new test=
:
>
>         Constants: 40 uffd threads, on N_CPUS=3D40, memsize=3D512M
>         Units: milliseconds (to finish the test)
>         |-----------------+--------+-------+------------|
>         | test case       | before | after |   diff (%) |
>         |-----------------+--------+-------+------------|
>         | workers=3D8,poll  |   1762 |  1133 | -55.516328 |
>         | workers=3D8,read  |   1437 |   585 | -145.64103 |
>         | workers=3D16,poll |   1117 |  1097 | -1.8231541 |
>         | workers=3D16,read |   1159 |   759 | -52.700922 |
>         | workers=3D32,poll |   1001 |   973 | -2.8776978 |
>         | workers=3D32,read |    866 |   713 | -21.458626 |
>         |-----------------+--------+-------+------------|
>
> The more threads hanging on the fd_wqh, a bigger difference will be there
> shown in the numbers.  "8 worker threads" is the worst case here because =
it
> means there can be a worst case of 40-8=3D32 threads hanging idle on fd_w=
qh
> queue.
>
> In real life, workers can be more than this, but small number of active
> worker threads will cause similar effect.
>
> This is currently based on Andrew's mm-unstable branch, but assuming this
> is applicable to most of the not-so-old trees.
>
> Comments welcomed, thanks.
>
> Andrea Arcangeli (1):
>   mm/userfaultfd: Make uffd read() wait event exclusive
>
> Peter Xu (6):
>   poll: Add a poll_flags for poll_queue_proc()
>   poll: POLL_ENQUEUE_EXCLUSIVE
>   fs/userfaultfd: Use exclusive waitqueue for poll()
>   selftests/mm: Replace uffd_read_mutex with a semaphore
>   selftests/mm: Create uffd_fault_thread_create|join()
>   selftests/mm: uffd perf test
>
>  drivers/vfio/virqfd.c                    |   4 +-
>  drivers/vhost/vhost.c                    |   2 +-
>  drivers/virt/acrn/irqfd.c                |   2 +-
>  fs/aio.c                                 |   2 +-
>  fs/eventpoll.c                           |   2 +-
>  fs/select.c                              |   9 +-
>  fs/userfaultfd.c                         |   8 +-
>  include/linux/poll.h                     |  25 ++-
>  io_uring/poll.c                          |   4 +-
>  mm/memcontrol.c                          |   4 +-
>  net/9p/trans_fd.c                        |   3 +-
>  tools/testing/selftests/mm/Makefile      |   2 +
>  tools/testing/selftests/mm/uffd-common.c |  65 +++++++
>  tools/testing/selftests/mm/uffd-common.h |   7 +
>  tools/testing/selftests/mm/uffd-perf.c   | 207 +++++++++++++++++++++++
>  tools/testing/selftests/mm/uffd-stress.c |  53 +-----
>  virt/kvm/eventfd.c                       |   2 +-
>  17 files changed, 337 insertions(+), 64 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/uffd-perf.c
>
> --
> 2.41.0
>
