Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789C82AED68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 10:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgKKJYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 04:24:03 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2081 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgKKJYB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:24:01 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CWK4Z46Nvz67Jr3;
        Wed, 11 Nov 2020 17:22:06 +0800 (CST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.161)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 11 Nov 2020 10:23:58 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 00/11] evm: Improve usability of portable signatures
Date:   Wed, 11 Nov 2020 10:22:51 +0100
Message-ID: <20201111092302.1589-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.27.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.161]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
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

Patches 6-8 make portable signatures more usable if metadata verification
is not turned off, by ignoring the INTEGRITY_NOLABEL error when no HMAC key
is loaded, by accepting any metadata modification until signature
verification succeeds (useful when xattrs/attrs are copied sequentially
from a source) and by allowing operations that don't change metadata.

Patch 9 makes it possible to use portable signatures when the IMA policy
requires file signatures and patch 10 shows portable signatures in the
measurement list when the ima-sig template is selected.

Lastly, patch 11 avoids undesired removal of security.ima when a file is
not selected by the IMA policy.

Roberto Sassu (11):
  evm: Execute evm_inode_init_security() only when an HMAC key is loaded
  evm: Load EVM key in ima_load_x509() to avoid appraisal
  evm: Refuse EVM_ALLOW_METADATA_WRITES only if an HMAC key is loaded
  ima: Move ima_reset_appraise_flags() call to post hooks
  evm: Introduce evm_status_revalidate()
  evm: Ignore INTEGRITY_NOLABEL if no HMAC key is loaded
  evm: Allow xattr/attr operations for portable signatures
  evm: Allow setxattr() and setattr() for unmodified metadata
  ima: Allow imasig requirement to be satisfied by EVM portable
    signatures
  ima: Introduce template field evmsig and write to field sig as
    fallback
  ima: Don't remove security.ima if file must not be appraised

 Documentation/ABI/testing/evm             |   5 +-
 Documentation/security/IMA-templates.rst  |   4 +-
 fs/xattr.c                                |   2 +
 include/linux/evm.h                       |   6 +
 include/linux/ima.h                       |  19 ++-
 include/linux/integrity.h                 |   1 +
 security/integrity/evm/evm_main.c         | 178 ++++++++++++++++++++--
 security/integrity/evm/evm_secfs.c        |   2 +-
 security/integrity/iint.c                 |   2 +
 security/integrity/ima/ima_appraise.c     |  52 +++++--
 security/integrity/ima/ima_init.c         |   4 +
 security/integrity/ima/ima_template.c     |   2 +
 security/integrity/ima/ima_template_lib.c |  32 +++-
 security/integrity/ima/ima_template_lib.h |   2 +
 security/security.c                       |   4 +-
 15 files changed, 275 insertions(+), 40 deletions(-)

-- 
2.27.GIT

