Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F23E356A61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 12:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351601AbhDGKxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 06:53:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2784 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351592AbhDGKxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:53:15 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFh1p1dL2z686qw;
        Wed,  7 Apr 2021 18:47:58 +0800 (CST)
Received: from fraphisprd00473.huawei.com (7.182.8.141) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 12:53:03 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v5 00/12] evm: Improve usability of portable signatures
Date:   Wed, 7 Apr 2021 12:52:40 +0200
Message-ID: <20210407105252.30721-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [7.182.8.141]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

EVM portable signatures are particularly suitable for the protection of
metadata of immutable files where metadata is signed by a software vendor.
They can be used for example in conjunction with an IMA policy that
appraises only executed and memory mapped files.

However, some usability issues are still unsolved, especially when EVM is
used without loading an HMAC key. This patch set attempts to fix the open
issues.

Patch 1 allows EVM to be used without loading an HMAC key. Patch 2 avoids
appraisal verification of public keys (they are already verified by the key
subsystem).

Patches 3-5 allow metadata verification to be turned off when no HMAC key
is loaded and to use this mode in a safe way (by ensuring that IMA
revalidates metadata when there is a change).

Patches 6-9 make portable signatures more usable if metadata verification
is not turned off, by ignoring the INTEGRITY_NOLABEL and INTEGRITY_NOXATTS
errors when possible, by accepting any metadata modification until
signature verification succeeds (useful when xattrs/attrs are copied
sequentially from a source) and by allowing operations that don't change
metadata.

Patch 10 makes it possible to use portable signatures when the IMA policy
requires file signatures and patch 11 shows portable signatures in the
measurement list when the ima-sig template is selected.

Lastly, patch 12 avoids undesired removal of security.ima when a file is
not selected by the IMA policy.

Changelog

v4:
- add patch to pass mnt_userns to EVM inode set/remove xattr hooks
  (suggested by Christian Brauner)
- pass mnt_userns to posix_acl_update_mode()
- use IS_ERR_OR_NULL() in evm_xattr_acl_change() (suggested by Mimi)

v3:
- introduce evm_ignore_error_safe() to correctly ignore INTEGRITY_NOLABEL
  and INTEGRITY_NOXATTRS errors
- fix an error in evm_xattr_acl_change()
- replace #ifndef with !IS_ENABLED() in integrity_load_keys()
- reintroduce ima_inode_removexattr()
- adapt patches to apply on top of the idmapped mounts patch set

v2:
- replace EVM_RESET_STATUS flag with evm_status_revalidate()
- introduce IMA post hooks ima_inode_post_setxattr() and
  ima_inode_post_removexattr()
- remove ima_inode_removexattr()
- ignore INTEGRITY_NOLABEL error if the HMAC key is not loaded

v1:
- introduce EVM_RESET_STATUS integrity flag instead of clearing IMA flag
- introduce new template field evmsig
- add description of evm_xattr_acl_change() and evm_xattr_change()

Roberto Sassu (12):
  evm: Execute evm_inode_init_security() only when an HMAC key is loaded
  evm: Load EVM key in ima_load_x509() to avoid appraisal
  evm: Refuse EVM_ALLOW_METADATA_WRITES only if an HMAC key is loaded
  ima: Move ima_reset_appraise_flags() call to post hooks
  evm: Introduce evm_status_revalidate()
  evm: Ignore INTEGRITY_NOLABEL/INTEGRITY_NOXATTRS if conditions are
    safe
  evm: Allow xattr/attr operations for portable signatures
  evm: Pass user namespace to set/remove xattr hooks
  evm: Allow setxattr() and setattr() for unmodified metadata
  ima: Allow imasig requirement to be satisfied by EVM portable
    signatures
  ima: Introduce template field evmsig and write to field sig as
    fallback
  ima: Don't remove security.ima if file must not be appraised

 Documentation/ABI/testing/evm             |   5 +-
 Documentation/security/IMA-templates.rst  |   4 +-
 fs/xattr.c                                |   2 +
 include/linux/evm.h                       |  18 +-
 include/linux/ima.h                       |  18 ++
 include/linux/integrity.h                 |   1 +
 security/integrity/evm/evm_main.c         | 216 ++++++++++++++++++++--
 security/integrity/evm/evm_secfs.c        |   4 +-
 security/integrity/iint.c                 |   4 +-
 security/integrity/ima/ima_appraise.c     |  55 ++++--
 security/integrity/ima/ima_init.c         |   4 +
 security/integrity/ima/ima_template.c     |   2 +
 security/integrity/ima/ima_template_lib.c |  33 +++-
 security/integrity/ima/ima_template_lib.h |   2 +
 security/security.c                       |   5 +-
 15 files changed, 329 insertions(+), 44 deletions(-)

-- 
2.26.2

