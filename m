Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591C96783B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjAWRzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjAWRzP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:55:15 -0500
X-Greylist: delayed 1023 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 09:55:12 PST
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63492B63F
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 09:55:11 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 3F89A5616BD1; Mon, 23 Jan 2023 09:37:56 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     linux-mm@kvack.org
Cc:     shr@devkernel.io, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v1 00/20] mm: process/cgroup ksm support
Date:   Mon, 23 Jan 2023 09:37:28 -0800
Message-Id: <20230123173748.1734238-1-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_NEUTRAL,SUSPICIOUS_RECIPS,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So far KSM can only be enabled by calling madvise for memory regions. Wha=
t is
required to enable KSM for more workloads is to enable / disable it at th=
e
process / cgroup level.

1. New options for prctl system command
This patch series adds two new options to the prctl system call. The firs=
t
one allows to enable KSM at the process level and the second one to query=
 the
setting.

The setting will be inherited by child processes.

With the above setting, KSM can be enabled for the seed process of a cgro=
up
and all processes in the cgroup will inherit the setting.

2. Changes to KSM processing
When KSM is enabled at the process level, the KSM code will iterate over =
all
the VMA's and enable KSM for the eligible VMA's.

When forking a process that has KSM enabled, the setting will be inherite=
d by
the new child process.

In addition when KSM is disabled for a process, KSM will be disabled for =
the
VMA's where KSM has been enabled.

3. Add tracepoints to KSM
Currently KSM has no tracepoints. This adds tracepoints to the key KSM fu=
nctions
to make it easier to debug KSM.

4. Add general_profit metric
The general_profit metric of KSM is specified in the documentation, but n=
ot
calculated. This adds the general profit metric to /sys/kernel/debug/mm/k=
sm.

5. Add more metrics to ksm_stat
This adds the process profit and ksm type metric to /proc/<pid>/ksm_stat.

6. Add more tests to ksm_tests
This adds an option to specify the merge type to the ksm_tests. This allo=
ws to
test madvise and prctl KSM. It also adds a new option to query if prctl K=
SM has
been enabled. It adds a fork test to verify that the KSM process setting =
is
inherited by client processes.


Stefan Roesch (20):
  mm: add new flag to enable ksm per process
  mm: add flag to __ksm_enter
  mm: add flag to __ksm_exit call
  mm: invoke madvise for all vmas in scan_get_next_rmap_item
  mm: support disabling of ksm for a process
  mm: add new prctl option to get and set ksm for a process
  mm: add tracepoints to ksm
  mm: split off pages_volatile function
  mm: expose general_profit metric
  docs: document general_profit sysfs knob
  mm: calculate ksm process profit metric
  mm: add ksm_merge_type() function
  mm: expose ksm process profit metric in ksm_stat
  mm: expose ksm merge type in ksm_stat
  docs: document new procfs ksm knobs
  tools: add new prctl flags to prctl in tools dir
  selftests/vm: add KSM prctl merge test
  selftests/vm: add KSM get merge type test
  selftests/vm: add KSM fork test
  selftests/vm: add two functions for debugging merge outcome

 Documentation/ABI/testing/sysfs-kernel-mm-ksm |   8 +
 Documentation/admin-guide/mm/ksm.rst          |   8 +-
 MAINTAINERS                                   |   1 +
 fs/proc/base.c                                |   5 +
 include/linux/ksm.h                           |  19 +-
 include/linux/sched/coredump.h                |   1 +
 include/trace/events/ksm.h                    | 257 ++++++++++++++++++
 include/uapi/linux/prctl.h                    |   2 +
 kernel/sys.c                                  |  29 ++
 mm/ksm.c                                      | 134 ++++++++-
 tools/include/uapi/linux/prctl.h              |   2 +
 tools/testing/selftests/vm/Makefile           |   3 +-
 tools/testing/selftests/vm/ksm_tests.c        | 254 ++++++++++++++---
 13 files changed, 665 insertions(+), 58 deletions(-)
 create mode 100644 include/trace/events/ksm.h


base-commit: c1649ec55708ae42091a2f1bca1ab49ecd722d55
--=20
2.30.2

