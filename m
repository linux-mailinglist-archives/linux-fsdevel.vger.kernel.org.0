Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390F479311D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 23:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242830AbjIEVn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 17:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjIEVny (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4594A1AB
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 14:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693950159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2votGtQ/EmYNPgTamqeLYt96PKfJV24HUJfzovJnoxc=;
        b=TbwCBz8MIGGi2CjIVhfivGUCQWbOqqvNji/1te/8P6UH7lTSdYUAVsRhNSR4XwZNX6YPf7
        h6h21x25fUAUN36qMtt6TgoFRN3Fd7EmWj9RUMuRSeVAjTfnsbpShdDB8bet3kLPYkXQws
        9pazDYsvoOBlLY1FVDGuDSlaVw2WgpI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-TZZb8U5yMSOp9nCZpASSlw-1; Tue, 05 Sep 2023 17:42:38 -0400
X-MC-Unique: TZZb8U5yMSOp9nCZpASSlw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-637948b24bdso7829026d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Sep 2023 14:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693950158; x=1694554958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2votGtQ/EmYNPgTamqeLYt96PKfJV24HUJfzovJnoxc=;
        b=X6ZM4+iuHQUeRM4kX7xa3qMIt9IVc1jvJONHCBh5Lf3Ff/88V3dtQ08tPG8XPIjttc
         SPvaxU07Uy+eaZhbIxUVEq9TJ663U8VqK58WQSZ+Of52+lB+imh1XnkEmbDXVsLZX1/p
         yAhyBd69Aia++R+ly7Fs3FjUFJKcP6aLhytk5SJ2oZdMPImm0tk48tTaRphDzowI5VFr
         ocPkWeyNw7c1r1C00/hndGsla4PykLqoK6w7e8hjAEgogsH8aO5h848PcrF0I580XQsg
         EWr6Z08Ov/U3I8GgxEHInEk1DItht5DcLsd7BywfMOS9BvtO0pOPEzp9vQf5AWVT2lKi
         0EGg==
X-Gm-Message-State: AOJu0Yzz2bm7C/G3iUy/rsYQwnKgdln77ejj6vAy9OIGeW4fdB9s4K7j
        26RXo2AM4YQFqd5SNRfWG4KlcKdf9FECOZLemU00zArDZ1yW5QcLBKahnrSby12p8iYN0RbYKyh
        WpGTVgkuLZSsuAJ9IS5cU4m2qQQ==
X-Received: by 2002:a0c:e9d1:0:b0:653:576d:1ea with SMTP id q17-20020a0ce9d1000000b00653576d01eamr16086394qvo.1.1693950157738;
        Tue, 05 Sep 2023 14:42:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHBe5ptOe+VReq+OVr1GVxtc25t18NWKbckRbhhKeOXRYvyzzK/YbOev4YaqKhe9uOKa0FSQ==
X-Received: by 2002:a0c:e9d1:0:b0:653:576d:1ea with SMTP id q17-20020a0ce9d1000000b00653576d01eamr16086382qvo.1.1693950157387;
        Tue, 05 Sep 2023 14:42:37 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id i2-20020a37c202000000b007682af2c8aasm4396938qkm.126.2023.09.05.14.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:42:37 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Anish Moorthy <amoorthy@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Christian Brauner <brauner@kernel.org>, peterx@redhat.com,
        linux-fsdevel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 0/7] mm/userfaultfd/poll: Scale userfaultfd wakeups
Date:   Tue,  5 Sep 2023 17:42:28 -0400
Message-ID: <20230905214235.320571-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Userfaultfd is the type of file that doesn't need wake-all semantics: if
there is a message enqueued (for either a fault address, or an event), we
only need to wake up one service thread to handle it.  Waking up more
normally means a waste of cpu cycles.  Besides that, and more importantly,
that just doesn't scale.

Andrea used to have one patch that made read() to be O(1) but never hit
upstream.  This is my effort to try upstreaming that (which is a
oneliner..), meanwhile on top of that I also made poll() O(1) on wakeup,
too (more or less bring EPOLLEXCLUSIVE to poll()), with some tests showing
that effect.

To verify this, I added a test called uffd-perf (leveraging the refactored
uffd selftest suite) that will measure the messaging channel latencies on
wakeups, and the waitqueue optimizations can be reflected by the new test:

        Constants: 40 uffd threads, on N_CPUS=40, memsize=512M
        Units: milliseconds (to finish the test)
        |-----------------+--------+-------+------------|
        | test case       | before | after |   diff (%) |
        |-----------------+--------+-------+------------|
        | workers=8,poll  |   1762 |  1133 | -55.516328 |
        | workers=8,read  |   1437 |   585 | -145.64103 |
        | workers=16,poll |   1117 |  1097 | -1.8231541 |
        | workers=16,read |   1159 |   759 | -52.700922 |
        | workers=32,poll |   1001 |   973 | -2.8776978 |
        | workers=32,read |    866 |   713 | -21.458626 |
        |-----------------+--------+-------+------------|

The more threads hanging on the fd_wqh, a bigger difference will be there
shown in the numbers.  "8 worker threads" is the worst case here because it
means there can be a worst case of 40-8=32 threads hanging idle on fd_wqh
queue.

In real life, workers can be more than this, but small number of active
worker threads will cause similar effect.

This is currently based on Andrew's mm-unstable branch, but assuming this
is applicable to most of the not-so-old trees.

Comments welcomed, thanks.

Andrea Arcangeli (1):
  mm/userfaultfd: Make uffd read() wait event exclusive

Peter Xu (6):
  poll: Add a poll_flags for poll_queue_proc()
  poll: POLL_ENQUEUE_EXCLUSIVE
  fs/userfaultfd: Use exclusive waitqueue for poll()
  selftests/mm: Replace uffd_read_mutex with a semaphore
  selftests/mm: Create uffd_fault_thread_create|join()
  selftests/mm: uffd perf test

 drivers/vfio/virqfd.c                    |   4 +-
 drivers/vhost/vhost.c                    |   2 +-
 drivers/virt/acrn/irqfd.c                |   2 +-
 fs/aio.c                                 |   2 +-
 fs/eventpoll.c                           |   2 +-
 fs/select.c                              |   9 +-
 fs/userfaultfd.c                         |   8 +-
 include/linux/poll.h                     |  25 ++-
 io_uring/poll.c                          |   4 +-
 mm/memcontrol.c                          |   4 +-
 net/9p/trans_fd.c                        |   3 +-
 tools/testing/selftests/mm/Makefile      |   2 +
 tools/testing/selftests/mm/uffd-common.c |  65 +++++++
 tools/testing/selftests/mm/uffd-common.h |   7 +
 tools/testing/selftests/mm/uffd-perf.c   | 207 +++++++++++++++++++++++
 tools/testing/selftests/mm/uffd-stress.c |  53 +-----
 virt/kvm/eventfd.c                       |   2 +-
 17 files changed, 337 insertions(+), 64 deletions(-)
 create mode 100644 tools/testing/selftests/mm/uffd-perf.c

-- 
2.41.0

