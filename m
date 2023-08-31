Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8220E78EA5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 12:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245669AbjHaKmy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 06:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjHaKmx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:42:53 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FBFCF4;
        Thu, 31 Aug 2023 03:42:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rby9c3156z9xrdY;
        Thu, 31 Aug 2023 18:30:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBXC7t9bvBkiGfdAQ--.39787S2;
        Thu, 31 Aug 2023 11:42:20 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 00/25] security: Move IMA and EVM to the LSM infrastructure
Date:   Thu, 31 Aug 2023 12:41:11 +0200
Message-Id: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBXC7t9bvBkiGfdAQ--.39787S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF4xKr18uw15CrWrAr47Arb_yoW7Cr1fpF
        sIga15JrykJFy7WrWfAF4xuF4SgFWrWrWUJrsxtry0y3Z0yr1FqFWjyryF9ry5GFW8Xr1v
        q3W2v398ur1qvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
        0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
        rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x02
        62kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2
        z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07jzE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBF1jj5NcqQADsX
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

IMA and EVM are not effectively LSMs, especially due the fact that in the
past they could not provide a security blob while there is another LSM
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

More specifically, patches 1-11 make IMA and EVM functions suitable to
be registered to the LSM infrastructure, by aligning function parameters.

Patches 12-20 add new LSM hooks in the same places where IMA and EVM
functions are called, if there is no LSM hook already.

Patches 21-24 do the bulk of the work, remove hardcoded calls to IMA, EVM
and integrity functions, register those functions in the LSM
infrastructure, and let the latter call them. In addition, they also
reserve one slot for EVM to supply an xattr to the inode_init_security
hook.

Finally, patch 25 removes the rbtree used to bind metadata to the inodes,
and instead reserve a space in the inode security blob to store the pointer
to metadata. This also brings performance improvements due to retrieving
metadata in constant time, as opposed to logarithmic.

The patch set applies on top of lsm/next, commit 8e4672d6f902 ("lsm:
constify the 'file' parameter in security_binder_transfer_file()")

Changelog:

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
  ima: Align ima_post_path_mknod() definition with LSM infrastructure
  ima: Align ima_post_create_tmpfile() definition with LSM
    infrastructure
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
 fs/namei.c                            |  18 +-
 fs/nfsd/vfs.c                         |   3 +-
 fs/open.c                             |   1 -
 fs/posix_acl.c                        |   5 +-
 fs/xattr.c                            |   9 +-
 include/linux/evm.h                   | 103 ----------
 include/linux/ima.h                   | 136 -------------
 include/linux/integrity.h             |  26 ---
 include/linux/lsm_hook_defs.h         |  21 +-
 include/linux/security.h              |  65 +++++++
 security/integrity/evm/evm_main.c     | 104 ++++++++--
 security/integrity/iint.c             |  92 +++------
 security/integrity/ima/ima.h          |  11 ++
 security/integrity/ima/ima_appraise.c |  37 +++-
 security/integrity/ima/ima_main.c     |  76 ++++++--
 security/integrity/integrity.h        |  44 ++++-
 security/keys/key.c                   |  10 +-
 security/security.c                   | 265 ++++++++++++++++----------
 security/selinux/hooks.c              |   3 +-
 security/smack/smack_lsm.c            |   4 +-
 22 files changed, 540 insertions(+), 501 deletions(-)

-- 
2.34.1

