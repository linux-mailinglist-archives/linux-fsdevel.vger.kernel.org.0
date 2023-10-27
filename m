Return-Path: <linux-fsdevel+bounces-1328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD81A7D91B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 10:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ABA21C21049
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13959156E2;
	Fri, 27 Oct 2023 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A233156DC
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 08:37:45 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E827106;
	Fri, 27 Oct 2023 01:37:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SGwgg2ZWrz9xqcl;
	Fri, 27 Oct 2023 16:24:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCX8JGqdjtlDvIBAw--.29710S2;
	Fri, 27 Oct 2023 09:37:13 +0100 (CET)
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
Subject: [PATCH v4 00/23] security: Move IMA and EVM to the LSM infrastructure
Date: Fri, 27 Oct 2023 10:35:35 +0200
Message-Id: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwCX8JGqdjtlDvIBAw--.29710S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF4xKr18uw15CrWrAr47Arb_yoW3XFW8pF
	saga15A34DJFy7KrZ3AF4xu3WSgFZ5WrWUXr9xGry8A3Z0yr1FqFWjkryruryrGFWrXr10
	q3ZFv3s8ur1qyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBF1jj5WUHAABsr
X-CFilter-Loop: Reflected

From: Roberto Sassu <roberto.sassu@huawei.com>

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
rather being hardcoded calls, and the inode metadata pointer is directly
stored in the inode security blob rather than in a separate rbtree.

To avoid functional changes, it was necessary to keep the 'integrity' LSM
in addition to the newly introduced 'ima' and 'evm' LSMs, despite there is
no LSM ID assigned to it. There are two reasons: first, IMA and EVM still
share the same inode metadata, and thus cannot directly reserve space in
the security blob for it; second, someone needs to initialize 'ima' and
'evm' exactly in this order, as the LSM infrastructure cannot guarantee
that.

The patch set is organized as follows.

Patches 1-9 make IMA and EVM functions suitable to be registered to the LSM
infrastructure, by aligning function parameters.

Patches 10-18 add new LSM hooks in the same places where IMA and EVM
functions are called, if there is no LSM hook already.

Patches 19-22 do the bulk of the work, introduce the new LSMs 'ima' and
'evm', and move hardcoded calls to IMA, EVM and integrity functions to
those LSMs. In addition, they reserve one slot for the 'evm' LSM to supply
an xattr with the inode_init_security hook.

Finally, patch 23 removes the rbtree used to bind integrity metadata to the
inodes, and instead reserves a space in the inode security blob to store
the pointer to that metadata. This also brings performance improvements due
to retrieving metadata in constant time, as opposed to logarithmic.

The patch set applies on top of lsm/next-queue, commit 0310640b00d2 ("lsm:
don't yet account for IMA in LSM_CONFIG_COUNT calculation"), plus commits
in linux-integrity/next-integrity-testing up to bc4532e9cd3b ("ima: detect
changes to the backing overlay file").

Changelog:

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

Roberto Sassu (23):
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
  security: Introduce file_pre_free_security hook
  security: Introduce path_post_mknod hook
  security: Introduce inode_post_create_tmpfile hook
  security: Introduce inode_post_set_acl hook
  security: Introduce inode_post_remove_acl hook
  security: Introduce key_post_create_or_update hook
  ima: Move to LSM infrastructure
  ima: Move IMA-Appraisal to LSM infrastructure
  evm: Move to LSM infrastructure
  integrity: Move integrity functions to the LSM infrastructure
  integrity: Switch from rbtree to LSM-managed blob for
    integrity_iint_cache

 fs/attr.c                             |   5 +-
 fs/file_table.c                       |   3 +-
 fs/namei.c                            |  12 +-
 fs/nfsd/vfs.c                         |   3 +-
 fs/open.c                             |   1 -
 fs/posix_acl.c                        |   5 +-
 fs/xattr.c                            |   9 +-
 include/linux/evm.h                   | 103 ----------
 include/linux/ima.h                   | 142 --------------
 include/linux/integrity.h             |  26 ---
 include/linux/lsm_hook_defs.h         |  20 +-
 include/linux/security.h              |  59 ++++++
 include/uapi/linux/lsm.h              |   2 +
 security/integrity/evm/evm_main.c     | 138 ++++++++++++--
 security/integrity/iint.c             | 113 +++++------
 security/integrity/ima/ima.h          |  11 ++
 security/integrity/ima/ima_appraise.c |  37 +++-
 security/integrity/ima/ima_main.c     |  96 ++++++++--
 security/integrity/integrity.h        |  58 +++++-
 security/keys/key.c                   |  10 +-
 security/security.c                   | 261 ++++++++++++++++----------
 security/selinux/hooks.c              |   3 +-
 security/smack/smack_lsm.c            |   4 +-
 23 files changed, 614 insertions(+), 507 deletions(-)

-- 
2.34.1


