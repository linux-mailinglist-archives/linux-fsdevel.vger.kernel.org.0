Return-Path: <linux-fsdevel+bounces-39852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E550FA19781
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 18:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C42168D0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 17:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F97D21519A;
	Wed, 22 Jan 2025 17:25:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC521422F;
	Wed, 22 Jan 2025 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566726; cv=none; b=Abxz4i1pC/qXWXP+Cl/wzWbBS8vzHSAGVgifROnOIGhB1wl/FduQ9q1zHEpKFkaXy+TnCnlRF1KBXzfzEYjPdPZVEfZCGixyIWG4edNprlDG+spOPAtAEJO7cY7wIzVORDVDJOfFM/dFTad9hxEvvfFktaC4AE5xsBnMIUVi4yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566726; c=relaxed/simple;
	bh=xh+6UfzUhksUBh2mXDh33SYXs4ZlMgzjKAiE0jtkSLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UCPFV2O8ljThNhfrObmDjwEFdC3caqfGXIUMTumUKLTTPTkpNAlomwivIjoTmNoeDDKLREyCOG1f6JUxpPY/or1Crco8/GRH80391yPVs2AKEx2D+MJXprm9lEg95ROHdaBin0EP+AjDjShFsxP/U09/qus84XD6oE5lsRDv4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4YdVb04YC4z9v7JN;
	Thu, 23 Jan 2025 00:56:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 50212140721;
	Thu, 23 Jan 2025 01:25:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDnbEvkKZFnsGscAQ--.5068S2;
	Wed, 22 Jan 2025 18:25:06 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 0/6] ima: Remove unnecessary inode locks
Date: Wed, 22 Jan 2025 18:24:26 +0100
Message-Id: <20250122172432.3074180-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDnbEvkKZFnsGscAQ--.5068S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWfKr1fKF4DXFy3tw4fKrg_yoWrur17pa
	9Yga45Gr1DJFyxurZ2kF47ua1SkayrWrWUWwsxJw1UZas8ZF10qr4Skr17ur97KF95C3Wq
	qr1a9rn5u3WqyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUFku4UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBGeQmNMFKwAAsE

From: Roberto Sassu <roberto.sassu@huawei.com>

A recent syzbot report [1] showed a possible lock inversion between the
mmap lock and the inode lock. Paul Moore suggested to remove the inode lock
in IMA as a possible solution. A first patch set was made [2] to fulfill
that request, although incomplete due to not removing the inode lock around
the ima_appraise_measurement() call.

While the original report was fixed in a different way, by calling the
security_mmap_file() hook outside the mmap lock critical region in the
remap_file_pages() system call [3], the IMA patch set has benefits on its
own, since it merges two critical sections in one in process_measurement(),
and makes the latter and __ima_inode_hash() compete for the same lock.

Remove the inode lock in three phases (except from ima_update_xattr(), when
setting security.ima).

First, remove the S_IMA inode flag and the IS_IMA() macro, since S_IMA
needs to be set under the inode lock, and it is going to be removed. There
is no performance penalty in doing that, since the pointer of the inode
integrity metadata has been moved to the inode security blob when IMA was
made as a regular LSM [4], and retrieving such metadata can be done in
constant time (patch 1).

Second, move the mutex from the inode integrity metadata to the inode
security blob, so that the lock can be taken regardless of whether or not
the inode integrity metadata was allocated for that inode (patch 2).

Consequently, remove the inode lock just after the policy evaluation and
extend the critical region previously guarded by the integrity inode
metadata mutex to where the inode lock was.

Also, make sure that ima_inode_get() is called with the new mutex lock
held, to avoid non-atomic check/assignment of the integrity metadata in the
inode security blob (patch 3), and mark the pointer of inode integrity
metadata as a shared resource with READ_ONCE() and WRITE_ONCE() (patch 4).

Third, remove the inode lock around ima_appraise_measurement() by
postponing setting security.ima when IMA-Appraisal is in fix mode, to when
the file is closed (patch 5).

Finally, as a bug fix, do not reset the IMA_NEW_FILE flag when setting
inode attributes. By resetting the flag, IMA was not able to appraise new
files with modified metadata before security.ima was written to the disk
(patch 6).

This patch set applies on top of commit 4785ed362a24 ("ima: ignore suffixed
policy rule comments") of:

https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git


[1] https://lore.kernel.org/linux-security-module/66f7b10e.050a0220.46d20.0036.GAE@google.com/
[2] https://lore.kernel.org/linux-security-module/20241008165732.2603647-1-roberto.sassu@huaweicloud.com/
[3] https://lore.kernel.org/linux-security-module/20241018161415.3845146-1-roberto.sassu@huaweicloud.com/
[4] https://lore.kernel.org/linux-security-module/20240215103113.2369171-1-roberto.sassu@huaweicloud.com/

v2:
- Add recommendation to set evm=fix in the kernel command line (suggested
  by Mimi)
- Completely remove S_IMA definition (suggested by Jan Kara)
- Reverse mode and i_writecount checks in ima_check_last_writer()
  (suggested by Mimi)
- Drop O_PATH patch (ima_check_last_writer() was erroneously considering
  file descriptors with that open flag set due to a bug in the appraisal
  patch)

v1:
- New patches (1 suggested by Shu Han, 4-6)
- Remove ima_inode_get_iint() and ima_inode_set_iint() and access inode
  integrity metadata from the new ima_iint_cache_lock structure directly
- Return immediately in ima_inode_get() if the inode does not have a
  security blob (suggested by Paul Moore)

Roberto Sassu (6):
  fs: ima: Remove S_IMA and IS_IMA()
  ima: Remove inode lock
  ima: Detect if lock is held when iint pointer is set in inode security
    blob
  ima: Mark concurrent accesses to the iint pointer in the inode
    security blob
  ima: Defer fixing security.ima to __fput()
  ima: Reset IMA_NONACTION_RULE_FLAGS after post_setattr

 .../admin-guide/kernel-parameters.txt         |  3 +
 include/linux/fs.h                            |  2 -
 security/integrity/ima/ima.h                  | 33 +++----
 security/integrity/ima/ima_api.c              |  4 +-
 security/integrity/ima/ima_appraise.c         |  7 +-
 security/integrity/ima/ima_iint.c             | 95 +++++++++++++++----
 security/integrity/ima/ima_main.c             | 75 ++++++++-------
 7 files changed, 144 insertions(+), 75 deletions(-)

-- 
2.34.1


