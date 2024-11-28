Return-Path: <linux-fsdevel+bounces-36053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352889DB540
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F3C1680A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 10:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33271946A0;
	Thu, 28 Nov 2024 10:07:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13ED192D82;
	Thu, 28 Nov 2024 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788437; cv=none; b=Y0mwtCJOXyctAx6z3FT5UqelT7IhrDbnbp5KJQf6u4oMfMnd3/J0UOdhuNB+2gx0CqlAYRAzS3sopL4JjOdsuBu1fAxN9lYweCgxF+ymse3lIqmVd1vvEQOHR7Bylj4g6M2yRqjAMLdbe05dqyRbda0Uxt+PQH4vrEFFFXlYxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788437; c=relaxed/simple;
	bh=wswVD2zp4CCUaT6ZSlru+V4x0SVt/us+3geDqb0tYP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wr1VnfI3vZ1D9FsO+xi0ABgdMXILCrKqaW2CVoDg8YXjoFS9A0cXAqFe043Lz9UHGSC+LghhaPfpsNUrQfkS07f131kh/JdAkHmkrkXwys623W1xUN/KWpndvEyDRygwRcQWKjLPgILhgl41ef8n9q9wtjkffe8DCq4ZGW7Yxxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XzWf05XKhz9v7Vp;
	Thu, 28 Nov 2024 17:46:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 5103F140535;
	Thu, 28 Nov 2024 18:06:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAnj365QEhn6eNzAg--.15234S2;
	Thu, 28 Nov 2024 11:06:57 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 0/7] ima: Remove unnecessary inode locks
Date: Thu, 28 Nov 2024 11:06:13 +0100
Message-ID: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.47.0.118.gfd3785337b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAnj365QEhn6eNzAg--.15234S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWfKr1fKF4DXFy3tw4fKrg_yoWrCw1kpa
	9Yg3W5Gr1DAryxurZaka13uaySkayrW3yUWwsxJw1UZF98ZF10qr4rCr1UuryxKr95C3Wq
	qr1agrn8u3WqyrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7Cj
	xVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUxGNtDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBGdH1TUCmAAAse

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
and make the latter and __ima_inode_hash() compete for the same lock.

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

Second, remove the inode lock around ima_appraise_measurement() by
postponing setting security.ima when IMA-Appraisal is in fix mode, to when
the file is closed (patch 5).

While testing the new functionality, two bugs were found and corrected.
Discard in IMA files opened with the O_PATH open flags, since no data are
accessed (the file descriptor is used for different purposes). Otherwise,
IMA ended up trying to read the files anyway, causing a kernel warning to
be printed in the kernel log (patch 6).

Do not reset the IMA_NEW_FILE flag as a result of setting inode attributes,
as it was before the patch to reintroduce the inode integrity metadata
mutex. By resetting the flag, IMA was not able to appraise new files with
modified metadata before security.ima was written to the disk (patch 7).

[1] https://lore.kernel.org/linux-security-module/66f7b10e.050a0220.46d20.0036.GAE@google.com/
[2] https://lore.kernel.org/linux-security-module/20241008165732.2603647-1-roberto.sassu@huaweicloud.com/
[3] https://lore.kernel.org/linux-security-module/20241018161415.3845146-1-roberto.sassu@huaweicloud.com/
[4] https://lore.kernel.org/linux-security-module/20240215103113.2369171-1-roberto.sassu@huaweicloud.com/

v1:
- New patches (1 suggested by Shu Han, 4-6)
- Remove ima_inode_get_iint() and ima_inode_set_iint() and access inode
  integrity metadata from the new ima_iint_cache_lock structure directly
- Return immediately in ima_inode_get() if the inode does not have a
  security blob (suggested by Paul Moore)

Roberto Sassu (7):
  fs: ima: Remove S_IMA and IS_IMA()
  ima: Remove inode lock
  ima: Ensure lock is held when setting iint pointer in inode security
    blob
  ima: Mark concurrent accesses to the iint pointer in the inode
    security blob
  ima: Set security.ima on file close when ima_appraise=fix
  ima: Discard files opened with O_PATH
  ima: Reset IMA_NONACTION_RULE_FLAGS after post_setattr

 include/linux/fs.h                    |  3 +-
 security/integrity/ima/ima.h          | 33 ++++------
 security/integrity/ima/ima_api.c      |  4 +-
 security/integrity/ima/ima_appraise.c |  7 +-
 security/integrity/ima/ima_iint.c     | 95 ++++++++++++++++++++++-----
 security/integrity/ima/ima_main.c     | 81 +++++++++++++----------
 6 files changed, 146 insertions(+), 77 deletions(-)

-- 
2.47.0.118.gfd3785337b


