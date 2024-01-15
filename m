Return-Path: <linux-fsdevel+bounces-7959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F036482DF02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0237E1C21FDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 18:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08EF18628;
	Mon, 15 Jan 2024 18:19:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED126182AE;
	Mon, 15 Jan 2024 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TDKlf3TZhz9xGn4;
	Tue, 16 Jan 2024 02:04:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id BCD6F14065B;
	Tue, 16 Jan 2024 02:18:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAXBCjzdqVl8DKbAA--.57127S2;
	Mon, 15 Jan 2024 19:18:43 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	casey@schaufler-ca.com,
	shuah@kernel.org,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v9 00/25] security: Move IMA and EVM to the LSM infrastructure
Date: Mon, 15 Jan 2024 19:17:44 +0100
Message-Id: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAXBCjzdqVl8DKbAA--.57127S2
X-Coremail-Antispam: 1UD129KBjvAXoWfGw48tF1DGFyUArWxurykKrg_yoW8Gw15uo
	WI9397XFn8tF13AayF9F1xCFWxuaySgrWfAr9Yvw45G3ZFqr1UW34fWa15XFW5Xr4fWwnr
	G3srAas0qFWUt3Wfn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY07kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
	AIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBF1jj5SSXwABss

From: Roberto Sassu <roberto.sassu@huawei.com>

IMA and EVM are not effectively LSMs, especially due to the fact that in
the past they could not provide a security blob while there is another LSM
active.

That changed in the recent years, the LSM stacking feature now makes it
possible to stack together multiple LSMs, and allows them to provide a
security blob for most kernel objects. While the LSM stacking feature has
some limitations being worked out, it is already suitable to make IMA and
EVM as LSMs.

The main purpose of this patch set is to remove IMA and EVM function calls,
hardcoded in the LSM infrastructure and other places in the kernel, and to
register them as LSM hook implementations, so that those functions are
called by the LSM infrastructure like other regular LSMs.

This patch set introduces two new LSMs 'ima' and 'evm', so that functions
can be registered to their respective LSM, and removes the 'integrity' LSM.
integrity_kernel_module_request() was moved to IMA, since deadlock could
occur only there. integrity_inode_free() was replaced with ima_inode_free()
(EVM does not need to free memory).

In order to make 'ima' and 'evm' independent LSMs, it was necessary to
split integrity metadata used by both IMA and EVM, and to let them manage
their own. The special case of the IMA_NEW_FILE flag, managed by IMA and
used by EVM, was handled by introducing a new flag in EVM, EVM_NEW_FILE,
managed by two additional LSM hooks, evm_post_path_mknod() and
evm_file_release(), equivalent to their counterparts ima_post_path_mknod()
and ima_file_free().

In addition to splitting metadata, it was decided to embed the
evm_iint_inode structure into the inode security blob, since it is small
and because anyway it cannot rely on IMA anymore allocating it (since it
uses a different structure).

On the other hand, to avoid memory pressure concerns, only a pointer to the
ima_iint_cache structure is stored in the inode security blob, and the
structure is allocated on demand, like before.

Another follow-up change was removing the iint parameter from
evm_verifyxattr(), that IMA used to pass integrity metadata to EVM. After
splitting metadata, and aligning EVM_NEW_FILE with IMA_NEW_FILE, this
parameter was not necessary anymore.

The last part was to ensure that the order of IMA and EVM functions is
respected after they become LSMs. Since the order of lsm_info structures in
the .lsm_info.init section depends on the order object files containing
those structures are passed to the linker of the kernel image, and since
IMA is before EVM in the Makefile, that is sufficient to assert that IMA
functions are executed before EVM ones.

The patch set is organized as follows.

Patches 1-9 make IMA and EVM functions suitable to be registered to the LSM
infrastructure, by aligning function parameters.

Patches 10-18 add new LSM hooks in the same places where IMA and EVM
functions are called, if there is no LSM hook already.

Patch 19 moves integrity_kernel_module_request() to IMA, as a prerequisite
for removing the 'integrity' LSM.

Patches 20-22 introduce the new standalone LSMs 'ima' and 'evm', and move
hardcoded calls to IMA, EVM and integrity functions to those LSMs.

Patches 23-24 remove the dependency on the 'integrity' LSM by splitting
integrity metadata, so that the 'ima' and 'evm' LSMs can use their own.
They also duplicate iint_lockdep_annotate() in ima_main.c, since the mutex
field was moved from integrity_iint_cache to ima_iint_cache.

Patch 25 finally removes the 'integrity' LSM, since 'ima' and 'evm' are now
self-contained and independent. 

The patch set applies on top of lsm/dev, commit f1bb47a31dff ("lsm: new
security_file_ioctl_compat() hook"). The linux-integrity/next-integrity at
commit c00f94b3a5be ("overlay: disable EVM") was merged.

Changelog:

v8:
 - Restore dynamic allocation of IMA integrity metadata, and store only the
   pointer in the inode security blob
 - Select SECURITY_PATH both in IMA and EVM
 - Rename evm_file_free() to evm_file_release()
 - Unconditionally register evm_post_path_mknod()
 - Introduce the new ima_iint.c file for the management of IMA integrity
   metadata
 - Introduce ima_inode_set_iint()/ima_inode_get_iint() in ima.h to
   respectively store/retrieve the IMA integrity metadata pointer
 - Replace ima_iint_inode() with ima_inode_get() and ima_iint_find(), with
   same behavior of integrity_inode_get() and integrity_iint_find()
 - Initialize the ima_iint_cache in ima_iintcache_init() and call it from
   init_ima_lsm()
 - Move integrity_kernel_module_request() to IMA in a separate patch
   (suggested by Mimi)
 - Compile ima_kernel_module_request() if CONFIG_INTEGRITY_ASYMMETRIC_KEYS
   is enabled
 - Remove ima_inode_alloc_security() and ima_inode_free_security(), since
   the IMA integrity metadata is not fully embedded in the inode security
   blob
 - Fixed the missed initialization of ima_iint_cache in
   process_measurement() and __ima_inode_hash()
 - Add a sentence in 'evm: Move to LSM infrastructure' to mention about
   moving evm_inode_remove_acl(), evm_inode_post_remove_acl() and
   evm_inode_post_set_acl() to evm_main.c
 - Add a sentence in 'ima: Move IMA-Appraisal to LSM infrastructure' to
   mention about moving ima_inode_remove_acl() to ima_appraise.c

v7:
 - Use return instead of goto in __vfs_removexattr_locked() (suggested by
   Casey)
 - Clarify in security/integrity/Makefile that the order of 'ima' and 'evm'
   LSMs depends on the order in which IMA and EVM are compiled
 - Move integrity_iint_cache flags to ima.h and evm.h in security/ and
   duplicate IMA_NEW_FILE to EVM_NEW_FILE
 - Rename evm_inode_get_iint() to evm_iint_inode() and ima_inode_get_iint()
   to ima_iint_inode(), check if inode->i_security is NULL, and just return
   the pointer from the inode security blob
 - Restore the non-NULL checks after ima_iint_inode() and evm_iint_inode()
   (suggested by Casey)
 - Introduce evm_file_free() to clear EVM_NEW_FILE
 - Remove comment about LSM_ORDER_LAST not guaranteeing the order of 'ima'
   and 'evm' LSMs
 - Lock iint->mutex before reading IMA_COLLECTED flag in __ima_inode_hash()
   and restored ima_policy_flag check
 - Remove patch about the hardcoded ordering of 'ima' and 'evm' LSMs in
   security.c
 - Add missing ima_inode_free_security() to free iint->ima_hash
 - Add the cases for LSM_ID_IMA and LSM_ID_EVM in lsm_list_modules_test.c
 - Mention about the change in IMA and EVM post functions for private
   inodes

v6:
 - See v7

v5:
 - Rename security_file_pre_free() to security_file_release() and the LSM
   hook file_pre_free_security to file_release (suggested by Paul)
 - Move integrity_kernel_module_request() to ima_main.c (renamed to
   ima_kernel_module_request())
 - Split the integrity_iint_cache structure into ima_iint_cache and
   evm_iint_cache, so that IMA and EVM can use disjoint metadata and
   reserve space with the LSM infrastructure
 - Reserve space for the entire ima_iint_cache and evm_iint_cache
   structures, not just the pointer (suggested by Paul)
 - Introduce ima_inode_get_iint() and evm_inode_get_iint() to retrieve
   respectively the ima_iint_cache and evm_iint_cache structure from the
   security blob
 - Remove the various non-NULL checks for the ima_iint_cache and
   evm_iint_cache structures, since the LSM infrastructure ensure that they
   always exist
 - Remove the iint parameter from evm_verifyxattr() since IMA and EVM
   use disjoint integrity metaddata
 - Introduce the evm_post_path_mknod() to set the IMA_NEW_FILE flag
 - Register the inode_alloc_security LSM hook in IMA and EVM to
   initialize the respective integrity metadata structures
 - Remove the 'integrity' LSM completely and instead make 'ima' and 'evm'
   proper standalone LSMs
 - Add the inode parameter to ima_get_verity_digest(), since the inode
   field is not present in ima_iint_cache
 - Move iint_lockdep_annotate() to ima_main.c (renamed to
   ima_iint_lockdep_annotate())
 - Remove ima_get_lsm_id() and evm_get_lsm_id(), since IMA and EVM directly
   register the needed LSM hooks
 - Enforce 'ima' and 'evm' LSM ordering at LSM infrastructure level

v4:
 - Improve short and long description of
   security_inode_post_create_tmpfile(), security_inode_post_set_acl(),
   security_inode_post_remove_acl() and security_file_post_open()
   (suggested by Mimi)
 - Improve commit message of 'ima: Move to LSM infrastructure' (suggested
   by Mimi)

v3:
 - Drop 'ima: Align ima_post_path_mknod() definition with LSM
   infrastructure' and 'ima: Align ima_post_create_tmpfile() definition
   with LSM infrastructure', define the new LSM hooks with the same
   IMA parameters instead (suggested by Mimi)
 - Do IS_PRIVATE() check in security_path_post_mknod() and
   security_inode_post_create_tmpfile() on the new inode rather than the
   parent directory (in the post method it is available)
 - Don't export ima_file_check() (suggested by Stefan)
 - Remove redundant check of file mode in ima_post_path_mknod() (suggested
   by Mimi)
 - Mention that ima_post_path_mknod() is now conditionally invoked when
   CONFIG_SECURITY_PATH=y (suggested by Mimi)
 - Mention when a LSM hook will be introduced in the IMA/EVM alignment
   patches (suggested by Mimi)
 - Simplify the commit messages when introducing a new LSM hook
 - Still keep the 'extern' in the function declaration, until the
   declaration is removed (suggested by Mimi)
 - Improve documentation of security_file_pre_free()
 - Register 'ima' and 'evm' as standalone LSMs (suggested by Paul)
 - Initialize the 'ima' and 'evm' LSMs from 'integrity', to keep the
   original ordering of IMA and EVM functions as when they were hardcoded
 - Return the IMA and EVM LSM IDs to 'integrity' for registration of the
   integrity-specific hooks
 - Reserve an xattr slot from the 'evm' LSM instead of 'integrity'
 - Pass the LSM ID to init_ima_appraise_lsm()

v2:
 - Add description for newly introduced LSM hooks (suggested by Casey)
 - Clarify in the description of security_file_pre_free() that actions can
   be performed while the file is still open

v1:
 - Drop 'evm: Complete description of evm_inode_setattr()', 'fs: Fix
   description of vfs_tmpfile()' and 'security: Introduce LSM_ORDER_LAST',
   they were sent separately (suggested by Christian Brauner)
 - Replace dentry with file descriptor parameter for
   security_inode_post_create_tmpfile()
 - Introduce mode_stripped and pass it as mode argument to
   security_path_mknod() and security_path_post_mknod()
 - Use goto in do_mknodat() and __vfs_removexattr_locked() (suggested by
   Mimi)
 - Replace __lsm_ro_after_init with __ro_after_init
 - Modify short description of security_inode_post_create_tmpfile() and
   security_inode_post_set_acl() (suggested by Stefan)
 - Move security_inode_post_setattr() just after security_inode_setattr()
   (suggested by Mimi)
 - Modify short description of security_key_post_create_or_update()
   (suggested by Mimi)
 - Add back exported functions ima_file_check() and
   evm_inode_init_security() respectively to ima.h and evm.h (reported by
   kernel robot)
 - Remove extern from prototype declarations and fix style issues
 - Remove unnecessary include of linux/lsm_hooks.h in ima_main.c and
   ima_appraise.c

Roberto Sassu (25):
  ima: Align ima_inode_post_setattr() definition with LSM infrastructure
  ima: Align ima_file_mprotect() definition with LSM infrastructure
  ima: Align ima_inode_setxattr() definition with LSM infrastructure
  ima: Align ima_inode_removexattr() definition with LSM infrastructure
  ima: Align ima_post_read_file() definition with LSM infrastructure
  evm: Align evm_inode_post_setattr() definition with LSM infrastructure
  evm: Align evm_inode_setxattr() definition with LSM infrastructure
  evm: Align evm_inode_post_setxattr() definition with LSM
    infrastructure
  security: Align inode_setattr hook definition with EVM
  security: Introduce inode_post_setattr hook
  security: Introduce inode_post_removexattr hook
  security: Introduce file_post_open hook
  security: Introduce file_release hook
  security: Introduce path_post_mknod hook
  security: Introduce inode_post_create_tmpfile hook
  security: Introduce inode_post_set_acl hook
  security: Introduce inode_post_remove_acl hook
  security: Introduce key_post_create_or_update hook
  integrity: Move integrity_kernel_module_request() to IMA
  ima: Move to LSM infrastructure
  ima: Move IMA-Appraisal to LSM infrastructure
  evm: Move to LSM infrastructure
  evm: Make it independent from 'integrity' LSM
  ima: Make it independent from 'integrity' LSM
  integrity: Remove LSM

 fs/attr.c                                     |   5 +-
 fs/file_table.c                               |   3 +-
 fs/namei.c                                    |  12 +-
 fs/nfsd/vfs.c                                 |   3 +-
 fs/open.c                                     |   1 -
 fs/posix_acl.c                                |   5 +-
 fs/xattr.c                                    |   9 +-
 include/linux/evm.h                           | 117 +-------
 include/linux/ima.h                           | 142 ----------
 include/linux/integrity.h                     |  27 --
 include/linux/lsm_hook_defs.h                 |  20 +-
 include/linux/security.h                      |  59 ++++
 include/uapi/linux/lsm.h                      |   2 +
 security/integrity/Makefile                   |   1 +
 security/integrity/digsig_asymmetric.c        |  23 --
 security/integrity/evm/Kconfig                |   1 +
 security/integrity/evm/evm.h                  |  19 ++
 security/integrity/evm/evm_crypto.c           |   4 +-
 security/integrity/evm/evm_main.c             | 195 ++++++++++---
 security/integrity/iint.c                     | 197 +------------
 security/integrity/ima/Kconfig                |   1 +
 security/integrity/ima/Makefile               |   2 +-
 security/integrity/ima/ima.h                  | 148 ++++++++--
 security/integrity/ima/ima_api.c              |  23 +-
 security/integrity/ima/ima_appraise.c         |  66 +++--
 security/integrity/ima/ima_iint.c             | 142 ++++++++++
 security/integrity/ima/ima_init.c             |   2 +-
 security/integrity/ima/ima_main.c             | 144 +++++++---
 security/integrity/ima/ima_policy.c           |   2 +-
 security/integrity/integrity.h                |  80 +-----
 security/keys/key.c                           |  10 +-
 security/security.c                           | 263 +++++++++++-------
 security/selinux/hooks.c                      |   3 +-
 security/smack/smack_lsm.c                    |   4 +-
 .../selftests/lsm/lsm_list_modules_test.c     |   6 +
 35 files changed, 902 insertions(+), 839 deletions(-)
 create mode 100644 security/integrity/ima/ima_iint.c

-- 
2.34.1


