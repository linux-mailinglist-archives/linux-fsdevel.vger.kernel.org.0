Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53DA6A9F15
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 19:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjCCSiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 13:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjCCSiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:38:03 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E6260D50;
        Fri,  3 Mar 2023 10:37:40 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PSwxM4lW4z9xtRk;
        Sat,  4 Mar 2023 02:10:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBnMVgKOgJk5iFpAQ--.12605S2;
        Fri, 03 Mar 2023 19:19:02 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        jlayton@kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 00/28] security: Move IMA and EVM to the LSM infrastructure
Date:   Fri,  3 Mar 2023 19:18:14 +0100
Message-Id: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBnMVgKOgJk5iFpAQ--.12605S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWUAw47GF4UXFW5uF4fuFg_yoWrKFW7pF
        s0ga15GrykJFyUurWfAF4xua1SgFWrWryUJrnxJw10v3Z0vr1FqFW0yryrury5GrW8JF1v
        q3ZFv3909r1DZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x
        0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
        rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x02
        62kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280
        aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43
        ZEXa7IU0bAw3UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBF1jj4otUwAAsF
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

This patch set depends on:
- https://lore.kernel.org/linux-integrity/20221201104125.919483-1-roberto.sassu@huaweicloud.com/ (there will be a v8 shortly)
- https://lore.kernel.org/linux-security-module/20230217032625.678457-1-paul@paul-moore.com/

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

More specifically, patches 1-13 make IMA and EVM functions suitable to
be registered to the LSM infrastructure, by aligning function parameters.

Patches 14-22 add new LSM hooks in the same places where IMA and EVM
functions are called, if there is no LSM hook already.

Patch 23 adds the 'last' ordering strategy for LSMs, so that IMA and EVM
functions are called in the same order as of today. Also, like with the
'first' strategy, LSMs using it are always enabled, so IMA and EVM
functions will be always called (if IMA and EVM are compiled built-in).

Patches 24-27 do the bulk of the work, remove hardcoded calls to IMA and
EVM functions, register those functions in the LSM infrastructure, and let
the latter call them. In addition, they also reserve one slot for EVM to 
supply an xattr to the inode_init_security hook.

Finally, patch 28 removes the rbtree used to bind metadata to the inodes,
and instead reserve a space in the inode security blob to store the pointer
to metadata. This also brings performance improvements due to retrieving
metadata in constant time, as opposed to logarithmic.

Roberto Sassu (28):
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
  evm: Complete description of evm_inode_setattr()
  fs: Fix description of vfs_tmpfile()
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
  security: Introduce LSM_ORDER_LAST
  ima: Move to LSM infrastructure
  ima: Move IMA-Appraisal to LSM infrastructure
  evm: Move to LSM infrastructure
  integrity: Move integrity functions to the LSM infrastructure
  integrity: Switch from rbtree to LSM-managed blob for
    integrity_iint_cache

 fs/attr.c                             |   5 +-
 fs/file_table.c                       |   3 +-
 fs/namei.c                            |  13 +-
 fs/nfsd/vfs.c                         |   3 +-
 fs/open.c                             |   1 -
 fs/posix_acl.c                        |   5 +-
 fs/xattr.c                            |   3 +-
 include/linux/evm.h                   | 112 -----------
 include/linux/ima.h                   | 142 -------------
 include/linux/integrity.h             |  26 ---
 include/linux/lsm_hook_defs.h         |  21 +-
 include/linux/lsm_hooks.h             |   1 +
 include/linux/security.h              |  65 ++++++
 security/integrity/evm/evm_main.c     | 109 ++++++++--
 security/integrity/iint.c             |  90 +++------
 security/integrity/ima/ima.h          |  12 ++
 security/integrity/ima/ima_appraise.c |  38 +++-
 security/integrity/ima/ima_main.c     |  77 +++++--
 security/integrity/integrity.h        |  44 +++-
 security/keys/key.c                   |  10 +-
 security/security.c                   | 276 ++++++++++++++++----------
 security/selinux/hooks.c              |   3 +-
 security/smack/smack_lsm.c            |   4 +-
 23 files changed, 550 insertions(+), 513 deletions(-)

-- 
2.25.1

