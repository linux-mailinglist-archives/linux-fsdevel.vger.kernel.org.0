Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A1AAFF88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 17:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfIKPGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 11:06:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbfIKPGH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:06:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2CB510576C6;
        Wed, 11 Sep 2019 15:06:06 +0000 (UTC)
Received: from llong.com (ovpn-125-196.rdu2.redhat.com [10.10.125.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 848AD1FB;
        Wed, 11 Sep 2019 15:06:01 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/5] hugetlbfs: Disable PMD sharing for large systems
Date:   Wed, 11 Sep 2019 16:05:32 +0100
Message-Id: <20190911150537.19527-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Wed, 11 Sep 2019 15:06:07 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A customer with large SMP systems (up to 16 sockets) with application
that uses large amount of static hugepages (~500-1500GB) are experiencing
random multisecond delays. These delays was caused by the long time it
took to scan the VMA interval tree with mmap_sem held.

To fix this problem while perserving existing behavior as much as
possible, we need to allow timeout in down_write() and disabling PMD
sharing when it is taking too long to do so. Since a transaction can
involving touching multiple huge pages, timing out for each of the huge
page interactions does not completely solve the problem. So a threshold
is set to completely disable PMD sharing if too many timeouts happen.

The first 4 patches of this 5-patch series adds a new
down_write_timedlock() API which accepts a timeout argument and return
true is locking is successful or false otherwise. It works more or less
than a down_write_trylock() but the calling thread may sleep.

The last patch implements the timeout mechanism as described above. With
the patched kernel installed, the customer confirmed that the problem
was gone.

Waiman Long (5):
  locking/rwsem: Add down_write_timedlock()
  locking/rwsem: Enable timeout check when spinning on owner
  locking/osq: Allow early break from OSQ
  locking/rwsem: Enable timeout check when staying in the OSQ
  hugetlbfs: Limit wait time when trying to share huge PMD

 include/linux/fs.h                |   7 ++
 include/linux/osq_lock.h          |  13 +--
 include/linux/rwsem.h             |   4 +-
 kernel/locking/lock_events_list.h |   1 +
 kernel/locking/mutex.c            |   2 +-
 kernel/locking/osq_lock.c         |  12 +-
 kernel/locking/rwsem.c            | 183 +++++++++++++++++++++++++-----
 mm/hugetlb.c                      |  24 +++-
 8 files changed, 201 insertions(+), 45 deletions(-)

-- 
2.18.1

