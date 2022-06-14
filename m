Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC5454B84E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 20:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345152AbiFNSJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 14:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344504AbiFNSJz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FB8F3527C
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655230193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=p7xA8r1OE0G47J5o0Tq7Av5J26mdzQALVWbKTBBj4T4=;
        b=H0J2aw7Xh6nOgfAgfV1C6ZJ8NQrztaTz5t9D0/LUJz6YNlBAS6+j5DaVaOSJ2Tm7ZHu4qi
        s7Pu0+ihTRLwrWU1dL+YPhOqRu+4N9lLDHKdIkg96nTZPtu1Ntiiofehj8ALBmeVo6fiX/
        aElzeeD1aRombzUJbTTVMF05bUU7GyQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-rLl3PBpiOtCHmPMRsW5s2g-1; Tue, 14 Jun 2022 14:09:50 -0400
X-MC-Unique: rLl3PBpiOtCHmPMRsW5s2g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C492D3817A65;
        Tue, 14 Jun 2022 18:09:49 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.16.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 945BB492C3B;
        Tue, 14 Jun 2022 18:09:49 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ikent@redhat.com, onestero@redhat.com
Subject: [PATCH 0/3] proc: improve root readdir latency with many threads
Date:   Tue, 14 Jun 2022 14:09:46 -0400
Message-Id: <20220614180949.102914-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

We have a user who has reported performance problems related to
(presumably) custom task monitoring on Linux systems when running
processes with large numbers of threads. Unfortunately I don't have much
information around the practical workload and observations, but only
that the problem had been narrowed down to excessive readdir latency of
the /proc root dir in the presence of large numbers of threads in the
associated pid namespace.

This latency boils down to the inefficient pid_namespace walk down in
the proc_pid_readdir() path. More specifically, every thread/task
allocates an associated struct pid, and the procfs next_tgid()
implementation walks every pid in the namespace looking for those with
an associated PIDTYPE_TGID task to fill into the directory listing.

Given that ids are part of the idr radix-tree, it seemed fairly logical
that this could be improved using an internal tree tag. I started
playing around with an approach that tagged and untagged ids based on
actual task association (i.e., attach_pid() and friends), but after some
thought and feedback came to the realization that this could probably be
simplified to just tag the pid once on allocation and allow procfs to
use it as a hint for root dir population. This works because post-fork
tgid task disassociation (without an exit() and freeing the pid) seems
to be uncommon. The only tool I've seen in my testing so far that leaves
around a tagged, non-TGID pid is chronyd, which appears to do a fork()
-> setsid() -> fork() pattern where the intermediate task exits but the
associated pid hangs around for the lifetime of the process due to the
PIDTYPE_SID association.

Therefore, this series implements this tgid tag hinting approach. Patch
1 includes a couple tweaks to the idr tree to support traditional
radix-tree tag propagation. Patch 2 defines the new tag and sets it on
pid allocation. Patch 3 updates procfs to use the tag for the readdir
pid_namespace traversal.

As far as testing goes, I've thrown this at fstests (not for filesystem
testing purposes, but moreso just because I had the test env handy and
it's a longish running task creation workload), LTP and some of the
kernel internal tests in tools/testing/selftests (clone, proc,
pid_namespace) without any obvious regressions. From the performance
angle, the user who reported this problem has provided some synthetic
tools to create dummy tasks/threads and run repeated readdir iterations
of /proc, which is what they've been using to compare results on Linux
kernels with some $other OS. These tools show a notable improvement in
terms of the number of /proc readdir iterations possible per-second. For
example, on 5.19.0-rc2 running on a mostly idle system with an active
100k thread process, readdirs-per-second improves from a baseline of
~285 to ~7.3k with the series applied. More detailed getdents() latency
numbers are included in the commit log of patch 3.

Thoughts, reviews, flames appreciated.

Brian

Brian Foster (3):
  radix-tree: propagate all tags in idr tree
  pid: use idr tag to hint pids associated with group leader tasks
  proc: use idr tgid tag hint to iterate pids in readdir

 fs/proc/base.c      |  2 +-
 include/linux/idr.h | 25 +++++++++++++++++++++++++
 include/linux/pid.h |  2 +-
 kernel/fork.c       |  2 +-
 kernel/pid.c        |  9 ++++++++-
 lib/radix-tree.c    | 26 +++++++++++++++-----------
 6 files changed, 51 insertions(+), 15 deletions(-)

-- 
2.34.1

