Return-Path: <linux-fsdevel+bounces-6087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A279281376A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 18:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1988CB21AF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 17:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2384763DF1;
	Thu, 14 Dec 2023 17:09:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24654A0;
	Thu, 14 Dec 2023 09:09:21 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Srdg21Bjjz9xvP9;
	Fri, 15 Dec 2023 00:51:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id AC45F140661;
	Fri, 15 Dec 2023 01:09:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBXlHSpNntl4xuLAg--.58219S2;
	Thu, 14 Dec 2023 18:09:12 +0100 (CET)
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
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	casey@schaufler-ca.com,
	shuah@kernel.org,
	mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v8 00/24] security: Move IMA and EVM to the LSM infrastructure
Date: Thu, 14 Dec 2023 18:08:10 +0100
Message-Id: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwBXlHSpNntl4xuLAg--.58219S2
X-Coremail-Antispam: 1UD129KBjvAXoWfGw48tF1DGFyUCrWkWryUWrg_yoW8Jr4xGo
	WIg397XFn8KF13A3yF9F1xCFWxuaySgrWfZr90vw45G3ZFq3WUG34fW3W5XFW5Xr4fWwnr
	GwnrAasYqFWUt3Wfn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY87kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgALBF1jj5OoDAABsK

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
integrity_kernel_module_request() was moved to IMA, since it was related to
appraisal. integrity_inode_free() was replaced with
ima_inode_free_security() (EVM does not need to free memory).

In order to make 'ima' and 'evm' independent LSMs, it was necessary to
split integrity metadata used by both IMA and EVM, and to let them manage
their own. The special case of the IMA_NEW_FILE flag, managed by IMA and
used by EVM, was handled by introducing a new flag in EVM, EVM_NEW_FILE,
managed by two additional LSM hooks, evm_post_path_mknod() and
evm_file_free(), equivalent to their counterparts ima_post_path_mknod() and
ima_file_free().

In addition to splitting metadata, it was decided to embed the full
structure into the inode security blob, rather than using a cache of
objects and allocating them on demand. This opens for new possibilities,
such as improving locking in IMA.

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

Patches 19-21 introduce the new standalone LSMs 'ima' and 'evm', and move
hardcoded calls to IMA, EVM and integrity functions to those LSMs.

Patches 22-23 remove the dependency on the 'integrity' LSM by splitting
integrity metadata, so that the 'ima' and 'evm' LSMs can use their own.
They also duplicate iint_lockdep_annotate() in ima_main.c, since the mutex
field was moved from integrity_iint_cache to ima_iint_cache.

Patch 24 finally removes the 'integrity' LSM, since 'ima' and 'evm' are now
self-contained and independent. 

The patch set applies on top of lsm/dev, commit 80b4ff1d2c9b ("selftests:
remove the LSM_ID_IMA check in lsm/lsm_list_modules_test"). The 
linux-integrity/next-integrity-testing at commit f17167bea279 ("ima: Remove
EXPERIMENTAL from Kconfig") was merged.

Changelog:

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

Roberto Sassu (24):
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
 include/linux/evm.h                           | 111 +-------
 include/linux/fs.h                            |   2 -
 include/linux/ima.h                           | 142 ----------
 include/linux/integrity.h                     |  27 --
 include/linux/lsm_hook_defs.h                 |  20 +-
 include/linux/security.h                      |  59 ++++
 include/uapi/linux/lsm.h                      |   2 +
 security/integrity/Makefile                   |   1 +
 security/integrity/digsig_asymmetric.c        |  23 --
 security/integrity/evm/evm.h                  |  19 ++
 security/integrity/evm/evm_crypto.c           |   4 +-
 security/integrity/evm/evm_main.c             | 195 ++++++++++---
 security/integrity/iint.c                     | 197 +------------
 security/integrity/ima/ima.h                  | 120 +++++++-
 security/integrity/ima/ima_api.c              |  15 +-
 security/integrity/ima/ima_appraise.c         |  64 +++--
 security/integrity/ima/ima_init.c             |   2 +-
 security/integrity/ima/ima_main.c             | 201 +++++++++++---
 security/integrity/ima/ima_policy.c           |   2 +-
 security/integrity/integrity.h                |  80 +-----
 security/keys/key.c                           |  10 +-
 security/security.c                           | 261 +++++++++++-------
 security/selinux/hooks.c                      |   3 +-
 security/smack/smack_lsm.c                    |   4 +-
 .../selftests/lsm/lsm_list_modules_test.c     |   6 +
 32 files changed, 783 insertions(+), 825 deletions(-)

-- 
2.34.1


