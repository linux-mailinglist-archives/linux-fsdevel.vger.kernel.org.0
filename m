Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA0D2CA251
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 13:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgLAMKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 07:10:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730755AbgLAMKh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:10:37 -0500
Received: from mail.kernel.org (ip5f5ad5d9.dynamic.kabel-deutschland.de [95.90.213.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66E8D221FD;
        Tue,  1 Dec 2020 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606824555;
        bh=CKU7nFOSsbN/XW/BnFcmO1V7GANr6/4MKPOejaVqscI=;
        h=From:To:Cc:Subject:Date:From;
        b=eqagvTWutTLcVFzb95Ciee9q0qDa5UFPbM5AAbFexOp5sfH7FAIDQn0oGeWvCXuev
         TL7qtQMzvXDryh4IscT9uizp2JYQMu8M7zg6S2cpSqSmJfU9hbX12hd/de4h/liUaU
         ksZGda6OQGzAGoKB9pYow+AqPj198CvdI0OsA+3E=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kk4T2-00DGcs-P1; Tue, 01 Dec 2020 13:09:12 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Vorontsov <anton@enomsg.org>,
        Ben Segall <bsegall@google.com>,
        Colin Cross <ccross@android.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Mel Gorman <mgorman@suse.de>, Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Gong <richard.gong@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Drewry <wad@chromium.org>, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org
Subject: [PATCH v5 00/16]Fix several bad kernel-doc markups
Date:   Tue,  1 Dec 2020 13:08:53 +0100
Message-Id: <cover.1606823973.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kernel-doc has always be limited to a probably bad documented
rule:

The kernel-doc markups should appear *imediatelly before* the
function or data structure that it documents.

On other words, if a C file would contain something like this:

	/**
	 * foo - function foo
	 * @args: foo args
	 */
	static inline void bar(int args);

	/**
	 * bar - function bar
	 * @args: foo args
	 */
	static inline void foo(void *args);


The output (in ReST format) will be:

	.. c:function:: void bar (int args)

	   function foo

	**Parameters**

	``int args``
	  foo args


	.. c:function:: void foo (void *args)

	   function bar

	**Parameters**

	``void *args``
	  foo args

Which is clearly a wrong result.  Before this changeset, 
not even a warning is produced on such cases.

As placing such markups just before the documented
data is a common practice, on most cases this is fine.

However, as patches touch things, identifiers may be
renamed, and people may forget to update the kernel-doc
markups to follow such changes.

This has been happening for quite a while, as there are
lots of files with kernel-doc problems.

This series address those issues and add a file at the
end that will enforce that the identifier will match the
kernel-doc markup, avoiding this problem from
keep happening as time goes by.

This series is based on current upstream tree.

@maintainers: feel free to pick the patches and
apply them directly on your trees, as all patches on 
this series are independent from the other ones.

--

v5:
  - The completion.h patch was replaced by another one which drops
    an obsolete macro;
  - Some typos got fixed and review tags got added;
  - Dropped patches that were already merged at linux-next.

v4:

  - Patches got rebased and got some acks.

Mauro Carvalho Chehab (16):
  HSI: fix a kernel-doc markup
  IB: fix kernel-doc markups
  parport: fix a kernel-doc markup
  rapidio: fix kernel-doc a markup
  fs: fix kernel-doc markups
  pstore/zone: fix a kernel-doc markup
  completion: drop init_completion define
  firmware: stratix10-svc: fix kernel-doc markups
  connector: fix a kernel-doc markup
  lib/crc7: fix a kernel-doc markup
  memblock: fix kernel-doc markups
  w1: fix a kernel-doc markup
  sched: fix kernel-doc markup
  selftests: kselftest_harness.h: partially fix kernel-doc markups
  refcount.h: fix a kernel-doc markup
  scripts: kernel-doc: validate kernel-doc markup with the actual names

 drivers/hsi/hsi_core.c                        |  2 +-
 drivers/infiniband/core/cm.c                  |  5 +-
 drivers/infiniband/core/cq.c                  |  4 +-
 drivers/infiniband/core/iwpm_util.h           |  2 +-
 drivers/infiniband/core/sa_query.c            |  3 +-
 drivers/infiniband/core/verbs.c               |  4 +-
 drivers/infiniband/sw/rdmavt/ah.c             |  2 +-
 drivers/infiniband/sw/rdmavt/mcast.c          | 12 ++--
 drivers/infiniband/sw/rdmavt/qp.c             |  8 +--
 drivers/infiniband/ulp/iser/iscsi_iser.c      |  2 +-
 .../infiniband/ulp/opa_vnic/opa_vnic_encap.h  |  2 +-
 .../ulp/opa_vnic/opa_vnic_vema_iface.c        |  2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.h         |  2 +-
 drivers/parport/share.c                       |  2 +-
 drivers/rapidio/rio.c                         |  2 +-
 fs/dcache.c                                   | 72 +++++++++----------
 fs/inode.c                                    |  4 +-
 fs/pstore/zone.c                              |  2 +-
 fs/seq_file.c                                 |  5 +-
 fs/super.c                                    | 12 ++--
 include/linux/completion.h                    |  5 +-
 include/linux/connector.h                     |  2 +-
 .../firmware/intel/stratix10-svc-client.h     | 10 +--
 include/linux/memblock.h                      |  4 +-
 include/linux/parport.h                       | 31 ++++++++
 include/linux/refcount.h                      |  2 +-
 include/linux/w1.h                            |  2 +-
 include/rdma/ib_verbs.h                       | 11 +++
 kernel/sched/core.c                           | 16 ++---
 kernel/sched/fair.c                           |  2 +-
 lib/crc7.c                                    |  2 +-
 scripts/kernel-doc                            | 62 +++++++++++-----
 tools/testing/selftests/kselftest_harness.h   | 22 +++---
 33 files changed, 197 insertions(+), 123 deletions(-)

-- 
2.28.0


