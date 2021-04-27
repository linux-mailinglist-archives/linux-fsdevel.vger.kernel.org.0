Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9052436C54E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 13:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbhD0Lil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 07:38:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2929 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbhD0Lig (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:38:36 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FV01561M5z71ffd;
        Tue, 27 Apr 2021 19:30:01 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 13:37:45 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <jmorris@namei.org>, <paul@paul-moore.com>,
        <casey@schaufler-ca.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <reiserfs-devel@vger.kernel.org>, <selinux@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 0/6] evm: Prepare for moving to the LSM infrastructure
Date:   Tue, 27 Apr 2021 13:37:26 +0200
Message-ID: <20210427113732.471066-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch set depends on:

https://lore.kernel.org/linux-integrity/20210409114313.4073-1-roberto.sassu@huawei.com/
https://lore.kernel.org/linux-integrity/20210407105252.30721-1-roberto.sassu@huawei.com/

One of the challenges that must be tackled to move IMA and EVM to the LSM
infrastructure is to ensure that EVM is capable to correctly handle
multiple stacked LSMs providing an xattr at file creation. At the moment,
there are few issues that would prevent a correct integration. This patch
set aims at solving them.

From the LSM infrastructure side, the LSM stacking feature added the
possibility of registering multiple implementations of the security hooks,
that are called sequentially whenever someone calls the corresponding
security hook. However, security_inode_init_security() and
security_old_inode_init_security() are currently limited to support one
xattr provided by LSM and one by EVM.

In addition, using the call_int_hook() macro causes some issues. According
to the documentation in include/linux/lsm_hooks.h, it is a legitimate case
that an LSM returns -EOPNOTSUPP when it does not want to provide an xattr.
However, the loop defined in the macro would stop calling subsequent LSMs
if that happens. In the case of security_old_inode_init_security(), using
the macro would also cause a memory leak due to replacing the *value
pointer, if multiple LSMs provide an xattr.

From EVM side, the first operation to be done is to change the definition
of evm_inode_init_security() to be compatible with the security hook
definition. Unfortunately, the current definition does not provide enough
information for EVM, as it must have visibility of all xattrs provided by
LSMs to correctly calculate the HMAC. This patch set changes the security
hook definition by replacing the name, value and len triple with the xattr
array allocated by security_inode_init_security().

Secondly, EVM must know how many elements are in the xattr array. EVM can
rely on the fact that the xattr array must be terminated with an element
with name field set to NULL, but can also benefit from the enhancements
that have been included in this version of the patch set.

Casey suggested to use the reservation mechanism currently implemented for
other security blobs, for xattrs. In this way,
security_inode_init_security() can know after LSM initialization how many
slots for xattrs should be allocated, and LSMs know the offset in the
array from where they can start writing xattrs.

One of the problem was that LSMs can decide at run-time, although they
reserved a slot, to not use it (for example because they were not
initialized). Given that the initxattrs() method implemented by filesystems
expect that the array is continuous, they would miss the slots after the
one not being initialized. security_inode_init_security() should have been
modified to compact the array.

Instead, the preferred solution was to introduce the base slot as a
parameter, in addition to the xattr array, containing the up to date
information about the slots used by previous LSMs. The correctness of the
update of the slot is ensured by both the LSMs, if they use the new helper
lsm_find_xattr_slot(), and by security_inode_init_security() which checks
the slot each time after an LSM executes the inode_init_security hook.

This patch set has been tested by introducing several instances of a
TestLSM (some providing an xattr, some not, one with a wrong implementation
to see how the LSM infrastructure handles it). The patch is not included
in this set but it is available here:

https://github.com/robertosassu/linux/commit/c7e01af6cb2c6780f0b143070269fff7e30053f9

The test, added to ima-evm-utils, is available here:

https://github.com/robertosassu/ima-evm-utils/blob/evm-multiple-lsms-v3-devel-v7/tests/evm_multiple_lsms.test

The test takes a UML kernel built by Travis and launches it several times,
each time with a different combination of LSMs. After boot, it first checks
that there is an xattr for each LSM providing it, and then calculates the
HMAC in user space and compares it with the HMAC calculated by EVM in
kernel space.

A test report can be obtained here:

https://travis-ci.com/github/robertosassu/ima-evm-utils/jobs/501101861

SELinux Test Suite result (diff 5.11.14-200.fc33.x86_64 5.12.0-rc8+):
-Files=70, Tests=1099, 82 wallclock secs ( 0.35 usr  0.09 sys +  7.39 cusr 10.14 csys = 17.97 CPU)
+Files=70, Tests=1108, 85 wallclock secs ( 0.34 usr  0.10 sys +  7.25 cusr 11.39 csys = 19.08 CPU)
 Result: FAIL
-Failed 2/70 test programs. 5/1099 subtests failed.
+Failed 2/70 test programs. 5/1108 subtests failed.

Smack Test Suite result:
smack_set_ambient 1 TPASS: Test "smack_set_ambient" success.
smack_set_current 1 TPASS: Test "smack_set_current" success.
smack_set_doi 1 TPASS: Test "smack_set_doi" success.
smack_set_netlabel 1 TPASS: Test "smack_set_netlabel" success.
smack_set_socket_labels    1  TPASS  :  Test smack_set_socket_labels success.
smack_set_cipso 1 TPASS: Test "smack_set_cipso" success.
smack_set_direct 1 TPASS: Test "smack_set_direct" success.
smack_set_load 1 TPASS: Test "smack_set_load" success.
smack_set_onlycap 1 TFAIL: The smack label reported for "/smack/onlycap"

Lastly, running the test on reiserfs to check
security_old_inode_init_security(), some issues have been discovered: a
free of xattr->name which is not correct after commit 9548906b2bb7 ('xattr:
Constify ->name member of "struct xattr"'), missing calls to
reiserfs_security_free() and a misalignment with
security_inode_init_security() (the old version expects the full xattr name
with the security. prefix, the new version just the suffix). The last issue
has not been fixed yet.

Changelog

v2:
- rewrite selinux_old_inode_init_security() to use
  security_inode_init_security()
- add lbs_xattr field to lsm_blob_sizes structure, to give the ability to
  LSMs to reserve slots in the xattr array (suggested by Casey)
- add new parameter base_slot to inode_init_security hook definition

v1:
- add calls to reiserfs_security_free() and initialize sec->value to NULL
  (suggested by Tetsuo and Mimi)
- change definition of inode_init_security hook, replace the name, value
  and len triple with the xattr array (suggested by Casey)
- introduce lsm_find_xattr_slot() helper for LSMs to find an unused slot in
  the passed xattr array

Roberto Sassu (6):
  reiserfs: Add missing calls to reiserfs_security_free()
  security: Rewrite security_old_inode_init_security()
  security: Pass xattrs allocated by LSMs to the inode_init_security
    hook
  security: Support multiple LSMs implementing the inode_init_security
    hook
  evm: Align evm_inode_init_security() definition with LSM
    infrastructure
  evm: Support multiple LSMs providing an xattr

 fs/reiserfs/namei.c                 |   4 +
 fs/reiserfs/xattr_security.c        |   1 +
 include/linux/evm.h                 |  19 +++--
 include/linux/lsm_hook_defs.h       |   4 +-
 include/linux/lsm_hooks.h           |  22 +++++-
 security/integrity/evm/evm.h        |   2 +
 security/integrity/evm/evm_crypto.c |   9 ++-
 security/integrity/evm/evm_main.c   |  30 +++++--
 security/security.c                 | 116 +++++++++++++++++++++++-----
 security/selinux/hooks.c            |  18 +++--
 security/smack/smack_lsm.c          |  27 ++++---
 11 files changed, 194 insertions(+), 58 deletions(-)

-- 
2.25.1

