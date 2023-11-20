Return-Path: <linux-fsdevel+bounces-3227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6707C7F1A26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 18:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E311F2549F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA742230F;
	Mon, 20 Nov 2023 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B838110;
	Mon, 20 Nov 2023 09:34:04 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SYvMR6LK7z9xvrJ;
	Tue, 21 Nov 2023 01:17:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXU3NimFtlBH8KAQ--.51496S2;
	Mon, 20 Nov 2023 18:33:36 +0100 (CET)
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
	mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v6 00/25] security: Move IMA and EVM to the LSM infrastructure
Date: Mon, 20 Nov 2023 18:32:53 +0100
Message-Id: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAXU3NimFtlBH8KAQ--.51496S2
X-Coremail-Antispam: 1UD129KBjvJXoWfGF1ruw1UCFyDJF4kCFWruFg_yoWDWrWxpF
	saga15J34kAFy2grZ3AF4xuF4SgFZ5WFWUXr9xGry0y3ZIyr1FqFWFyr1rury5GFWrtF18
	t3W2v398ur1qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVWxJr0_GcWlIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv
	67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyT
	uYvjxUIUUUUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj5apawADsk
X-CFilter-Loop: Reflected

From: Roberto Sassu <roberto.sassu@huawei.com>

~~~~~
Note: this version is EXPERIMENTAL, I quickly tried to overcome outstanding
      issues (use disjoint metadata, enforce LSM ordering), to see if it is
      possible; tests pass, but a more careful review is still needed.
~~~~~

IMA and EVM are not effectively LSMs, especially due to the fact that in
the past they could not provide a security blob while there is another LSM
active.

That changed in the recent years, the LSM stacking feature now makes it
possible to stack together multiple LSMs, and allows them to provide a
security blob for most kernel objects. While the LSM stacking feature has
some limitations being worked out, it is already suitable to make IMA and
EVM as LSMs.

In short, while this patch set is big, it does not make any functional
change to IMA and EVM. IMA and EVM functions are called by the LSM
infrastructure in the same places as before (except ima_post_path_mknod()),
rather being hardcoded calls.

Since IMA and EVM mostly use disjoint metadata, the existing
integrity_iint_cache structure was split in two. Fields were added to the
new ima_iint_cache and evm_iint_cache. In case of overlap, such as for the
path_post_mknod LSM hook, the implementation was duplicated to have the
same state as before this patch set.

This patch set also enforces the ordering of the newly introduced LSMs
'ima' and 'evm' at LSM infrastructure level, to make the ordering
independent on how the LSMs are compiled.


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

Patch 25 enforces the ordering of the 'ima' and 'evm' LSMs at LSM
infrastructure level.

The patch set applies on top of lsm/dev, commit e246777e2a03 ("MAINTAINERS:
update the LSM entry"). The linux-integrity/next-integrity-testing at
commit 6918df3be02a ("ima: Remove EXPERIMENTAL from Kconfig") was merged.

Changelog:

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
  ima: Move to LSM infrastructure
  ima: Move IMA-Appraisal to LSM infrastructure
  evm: Move to LSM infrastructure
  ima: Remove dependency on 'integrity' LSM
  evm: Remove dependency on 'integrity' LSM
  integrity: Remove LSM
  security: Enforce ordering of 'ima' and 'evm' LSMs

 fs/attr.c                              |   5 +-
 fs/file_table.c                        |   3 +-
 fs/namei.c                             |  12 +-
 fs/nfsd/vfs.c                          |   3 +-
 fs/open.c                              |   1 -
 fs/posix_acl.c                         |   5 +-
 fs/xattr.c                             |   9 +-
 include/linux/evm.h                    | 111 +---------
 include/linux/fs.h                     |   2 -
 include/linux/ima.h                    | 142 ------------
 include/linux/integrity.h              |  27 ---
 include/linux/lsm_hook_defs.h          |  20 +-
 include/linux/security.h               |  59 +++++
 include/uapi/linux/lsm.h               |   2 +
 security/integrity/digsig_asymmetric.c |  23 --
 security/integrity/evm/evm.h           |  17 ++
 security/integrity/evm/evm_crypto.c    |   5 +-
 security/integrity/evm/evm_main.c      | 193 +++++++++++++----
 security/integrity/iint.c              | 197 +----------------
 security/integrity/ima/ima.h           |  68 ++++--
 security/integrity/ima/ima_api.c       |  15 +-
 security/integrity/ima/ima_appraise.c  |  72 ++++---
 security/integrity/ima/ima_init.c      |   2 +-
 security/integrity/ima/ima_main.c      | 222 +++++++++++++------
 security/integrity/ima/ima_policy.c    |   2 +-
 security/integrity/integrity.h         |  26 +--
 security/keys/key.c                    |  10 +-
 security/security.c                    | 286 ++++++++++++++++---------
 security/selinux/hooks.c               |   3 +-
 security/smack/smack_lsm.c             |   4 +-
 30 files changed, 730 insertions(+), 816 deletions(-)

-- 
2.34.1


