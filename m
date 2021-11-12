Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B749344E6A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 13:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhKLMrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 07:47:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4085 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhKLMre (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:47:34 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HrJ7j1z46z67bYH;
        Fri, 12 Nov 2021 20:39:45 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 12 Nov 2021 13:44:39 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ebiggers@kernel.org>, <tytso@mit.edu>, <corbet@lwn.net>,
        <viro@zeniv.linux.org.uk>, <hughd@google.com>,
        <akpm@linux-foundation.org>
CC:     <linux-fscrypt@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 0/5] shmem/fsverity: Prepare for mandatory integrity enforcement
Date:   Fri, 12 Nov 2021 13:44:06 +0100
Message-ID: <20211112124411.1948809-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The biggest advantage of fsverity compared to file-based solutions like IMA
is the lower overhead added for integrity measurement and enforcement.
Although fsverity offers the same file representation as a digest, it works
instead at page granularity rather than file granularity. Only the pages
that are going to be used will be evaluated by fsverity, while IMA has to
read the whole file.

Although fsverity has a built-in enforcement mechanism, it is basically
discretionary, it can be enabled (or disabled by replacing the file) by
the user himself. A mandatory mechanism could be used to impose fsverity
protection for files involved in certain events, defined with a policy.

Integrity Policy Enforcement (IPE) is one of such mandatory mechanisms
designed to work in conjunction with fsverity (IMA integration is planned).
However, at this stage (v7), IPE is storing fsverity data at file
instantiation time rather than at usage time. One disadvantage of such
approach is that a security blob needs to be allocated and maintained for
such purpose, which makes the code unnecessarily more complex. A much
better approach would be to retrieve the information when needed, without
storing it in a security blob.

Another gap that currently limits the applicability of fsverity is the
missing support for the tmpfs filesystem. Files could still be executed
from it (e.g. during the boot process) and would still need to be verified
by IPE. Not verifying those files would considerably reduce the
effectiveness of the integrity protection. Alternatively, requiring that
the initial ram disk is signed limits the applicability of the solution
only to embedded systems, where the initial ram disk can be also
distributed. General purpose OSes instead regenerate it locally depending
on the system configuration, and after critical packages changes.

Given that tmpfs is not persistent, the question is if support should be
implemented in a similar way of persistent filesystems, such as ext4. And,
while fsverity protection needs to be enabled on a file each time a tmpfs
filesystem is mounted, probably implementing fsverity support in the same
way is simpler.

Another question is whether and when pages should be checked. In a
preliminary test, checking a page after it was swapped in resulted in the
page not being considered valid by fsverity. For now there are no calls to
fsverity_verify_page().

The implementation in this patch set is not necessarily the most efficient,
and does not consider the specific features of tmpfs. The goal was to aim
at correctness, by following closely the implementation for f2fs, doing the
minimal changes necessary to make it work for tmpfs (e.g. replacing
read_mapping_page() with shmem_read_mapping_page()).

Other than with trivial operations, this patch set has been tested with
the xfstests-dev testsuite, also under severe memory pressure to ensure
that everything still works when a page is swapped out.

Make the following changes: provide the fsverity_get_file_digest() and
fsverity_sig_validated() for IPE to retrieve fsverity information at usage
time, and additionally revalidate the signature at every file open
(patches 1, 2); make fsverity suitable to protect files in the rootfs
filesystem (patch 3); fix a small problem in shmem_read_mapping_page_gfp()
(patch 4) and finally add support for fsverity in tmpfs (patch 5).

An open point, not addressed by this patch set, is how to enable the
fsverity protection for files in the rootfs filesystem, given that it is
too early for user space to invoke the ioctl() system call. It should not
be a problem to enable fsverity from the kernel, depending on a labelling
policy.

Roberto Sassu (5):
  fsverity: Introduce fsverity_get_file_digest()
  fsverity: Revalidate built-in signatures at file open
  fsverity: Do initialization earlier
  shmem: Avoid segfault in shmem_read_mapping_page_gfp()
  shmem: Add fsverity support

 Documentation/filesystems/fsverity.rst |  18 ++
 MAINTAINERS                            |   1 +
 fs/Kconfig                             |   7 +
 fs/verity/enable.c                     |   6 +-
 fs/verity/fsverity_private.h           |   7 +-
 fs/verity/init.c                       |   2 +-
 fs/verity/open.c                       |  43 +++-
 fs/verity/signature.c                  |   6 +-
 include/linux/fsverity.h               |  16 ++
 include/linux/shmem_fs.h               |  27 +++
 mm/Makefile                            |   2 +
 mm/shmem.c                             |  71 ++++++-
 mm/shmem_verity.c                      | 267 +++++++++++++++++++++++++
 13 files changed, 463 insertions(+), 10 deletions(-)
 create mode 100644 mm/shmem_verity.c

-- 
2.32.0

