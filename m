Return-Path: <linux-fsdevel+bounces-33855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5679B9BFB0F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 01:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DCB1F24C22
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 00:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA6E17BA1;
	Thu,  7 Nov 2024 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MsAEQlVo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9109C6FBF;
	Thu,  7 Nov 2024 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730941066; cv=none; b=s/Vwzjss5E3fQSiDRfXBDhAg+O5o8wfCnQJFrFNtuVmDVCY/d+avDkTArf9nQ3MKXhjzZtsSUrEbjqODtIzPVEGYQBcOuumVb5gwPIb8bU+yyPRyXZ612JI2MX3+ko/eP7gfkvw+nQPEV4Yzr8+GXdg3oXVRFmgAYbqJS8irTKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730941066; c=relaxed/simple;
	bh=yXnjhj48kAogV/Vpr5GpaoxupRV7kAxAz1bKzhx7+sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJrcEWwGNqUCB2/mc7HN2h1HUvh5yVMqbXFt4kN3P7mwhu8ZXtNEx0/LNEsQcUrtTnqNRfvd68QPFB3ZYyA6sklMhXOoc2VCzuyx1gKDu/oWVK3ufrkXjHd1KV3+GcooQd/8ea4plA1jKJwQiCzkq7BSxsArAtZxq93lWwcY2dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MsAEQlVo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730941064; x=1762477064;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yXnjhj48kAogV/Vpr5GpaoxupRV7kAxAz1bKzhx7+sw=;
  b=MsAEQlVoAfGScpLrTlalB10yeIAP3D6VIWfd4M6e7qetYE5DdO0UFMPo
   FQESKEKD3USyqVhbyUrMUQCvgTskuemt+NZPTbVKvH1HlTd1z4nf4Zfgj
   dZfcq5YoXYf63vIzwGMmQKhuN+8MOwHTzZUa8hd4ltnb+VRVod4G2bai/
   4NR6dHbIjZeuQ9ZKIH1OJZUVqs7C+XZn3+VmEtoUxmu7PIpbn/cMx6/0W
   Rrbv4tLOPyIE2OdU2e4kjzrlQ5jxf8ZO0kgBT7L3yuBB4Rw4A0EqzTz7L
   85GNl5J3LshtIqR++hvtgTD/gM9kpz2wmpJ4MkgHHyhEv+6Kw3blNa1CQ
   A==;
X-CSE-ConnectionGUID: 5bMUHnnPTvO5JkshUb7xUA==
X-CSE-MsgGUID: xWmfr0JxQQyBP5ypW/kTaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41320179"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41320179"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 16:57:42 -0800
X-CSE-ConnectionGUID: Wzt6AK+2SEu78jNOCWDREA==
X-CSE-MsgGUID: 6MMxIEy5TrCFyxGbxKPHZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="85193415"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO vcostago-mobl3.lan) ([10.124.222.105])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 16:57:41 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: brauner@kernel.org,
	amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH v4 0/4] overlayfs: Optimize override/revert creds
Date: Wed,  6 Nov 2024 16:57:16 -0800
Message-ID: <20241107005720.901335-1-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changes from v3:
 - Another reorganization of the series: separate the pure mechanical
   changes into their own (Amir Goldstein)

The series now reads:

Patch 1: Introduce the _light() version of the override/revert cred operations;
Patch 2: Convert backing-file.c to use those;
Patch 3: Mechanical change to introduce the ovl_revert_creds() helper;
Patch 4: Make the ovl_{override,convert}_creds() use the _light()
  creds helpers, and fix the reference counting issue that would happen;

Changes from v2:
 - Removed the "convert to guard()/scoped_guard()" patches (Miklos Szeredi);
 - In the overlayfs code, convert all users of override_creds()/revert_creds() to the _light() versions by:
      1. making ovl_override_creds() use override_creds_light();
      2. introduce ovl_revert_creds() which calls revert_creds_light();
      3. convert revert_creds() to ovl_revert_creds()
   (Amir Goldstein);
 - Fix an potential reference counting issue, as the lifetime
   expectations of the mounter credentials are different (Christian
   Brauner);

The series is now much simpler:

Patch 1: Introduce the _light() version of the override/revert cred operations;
Patch 2: Convert backing-file.c to use those;
Patch 3: Do the conversion to use the _light() version internally;
Patch 4: Fix a potential refcounting issue

Changes from v1:
 - Re-organized the series to be easier to follow, more details below
   (Miklos Szeredi and Amir Goldstein);

The series now reads as follows:

Patch 1: Introduce the _light() version of the override/revert cred operations;
Patch 2: Convert backing-file.c to use those;
Patch 3: Introduce the overlayfs specific _light() helper;
Patch 4: Document the cases that the helper cannot be used (critical
      section may change the cred->usage counter);
Patch 5: Convert the "rest" of overlayfs to the _light() helpers (mostly mechanical);
Patch 6: Introduce the GUARD() helpers;
Patch 7: Convert backing-file.c to the GUARD() helpers;
Patch 8-15: Convert each overlayfs/ file to use the GUARD() helpers,
      also explain the cases in which the scoped_guard() helper is
      used. Note that a 'goto' jump that crosses the guard() should
      fail to compile, gcc has a bug that fails to detect the
      error[1].
Patch 16: Remove the helper introduced in Patch 3 to close the series,
      as it is no longer used, everything was converted to use the
      safer/shorter GUARD() helpers.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91951

This bug was also noticed here:

https://lore.kernel.org/all/20240730050927.GC5334@ZenIV/

Link to v1:

https://lore.kernel.org/r/20240403021808.309900-1-vinicius.gomes@intel.com/

Changes from RFC v3:
 - Removed the warning "fixes" patches, as they could hide potencial
   bugs (Christian Brauner);
 - Added "cred-specific" macros (Christian Brauner), from my side,
   added a few '_' to the guards to signify that the newly introduced
   helper macros are preferred.
 - Changed a few guard() to scoped_guard() to fix the clang (17.0.6)
   compilation error about 'goto' bypassing variable initialization;

Link to RFC v3:

https://lore.kernel.org/r/20240216051640.197378-1-vinicius.gomes@intel.com/

Changes from RFC v2:
 - Added separate patches for the warnings for the discarded const
   when using the cleanup macros: one for DEFINE_GUARD() and one for
   DEFINE_LOCK_GUARD_1() (I am uncertain if it's better to squash them
   together);
 - Reordered the series so the backing file patch is the first user of
   the introduced helpers (Amir Goldstein);
 - Change the definition of the cleanup "class" from a GUARD to a
   LOCK_GUARD_1, which defines an implicit container, that allows us
   to remove some variable declarations to store the overriden
   credentials (Amir Goldstein);
 - Replaced most of the uses of scoped_guard() with guard(), to reduce
   the code churn, the remaining ones I wasn't sure if I was changing
   the behavior: either they were nested (overrides "inside"
   overrides) or something calls current_cred() (Amir Goldstein).

New questions:
 - The backing file callbacks are now called with the "light"
   overriden credentials, so they are kind of restricted in what they
   can do with their credentials, is this acceptable in general?
 - in ovl_rename() I had to manually call the "light" the overrides,
   both using the guard() macro or using the non-light version causes
   the workload to crash the kernel. I still have to investigate why
   this is happening. Hints are appreciated.

Link to the RFC v2:

https://lore.kernel.org/r/20240125235723.39507-1-vinicius.gomes@intel.com/

Original cover letter (lightly edited):

It was noticed that some workloads suffer from contention on
increasing/decrementing the ->usage counter in their credentials,
those refcount operations are associated with overriding/reverting the
current task credentials. (the linked thread adds more context)

In some specialized cases, overlayfs is one of them, the credentials
in question have a longer lifetime than the override/revert "critical
section". In the overlayfs case, the credentials are created when the
fs is mounted and destroyed when it's unmounted. In this case of long
lived credentials, the usage counter doesn't need to be
incremented/decremented.

Add a lighter version of credentials override/revert to be used in
these specialized cases. To make sure that the override/revert calls
are paired, add a cleanup guard macro. This was suggested here:

https://lore.kernel.org/all/20231219-marken-pochen-26d888fb9bb9@brauner/

With a small number of tweaks:
 - Used inline functions instead of macros;
 - A small change to store the credentials into the passed argument,
   the guard is now defined as (note the added '_T ='):

      DEFINE_GUARD(cred, const struct cred *, _T = override_creds_light(_T),
		  revert_creds_light(_T));

 - Allow "const" arguments to be used with these kind of guards;

Some comments:
 - If patch 1/5 and 2/5 are not a good idea (adding the cast), the
   alternative I can see is using some kind of container for the
   credentials;
 - The only user for the backing file ops is overlayfs, so these
   changes make sense, but may not make sense in the most general
   case;

For the numbers, some from 'perf c2c', before this series:
(edited to fit)

#
#        ----- HITM -----                                        Shared                          
#   Num  RmtHitm  LclHitm                      Symbol            Object         Source:Line  Node
# .....  .......  .......  ..........................  ................  ..................  ....
#
  -------------------------
      0      412     1028  
  -------------------------
	  41.50%   42.22%  [k] revert_creds            [kernel.vmlinux]  atomic64_64.h:39     0  1
	  15.05%   10.60%  [k] override_creds          [kernel.vmlinux]  atomic64_64.h:25     0  1
	   0.73%    0.58%  [k] init_file               [kernel.vmlinux]  atomic64_64.h:25     0  1
	   0.24%    0.10%  [k] revert_creds            [kernel.vmlinux]  cred.h:266           0  1
	  32.28%   37.16%  [k] generic_permission      [kernel.vmlinux]  mnt_idmapping.h:81   0  1
	   9.47%    8.75%  [k] generic_permission      [kernel.vmlinux]  mnt_idmapping.h:81   0  1
	   0.49%    0.58%  [k] inode_owner_or_capable  [kernel.vmlinux]  mnt_idmapping.h:81   0  1
	   0.24%    0.00%  [k] generic_permission      [kernel.vmlinux]  namei.c:354          0

  -------------------------
      1       50      103  
  -------------------------
	 100.00%  100.00%  [k] update_cfs_group  [kernel.vmlinux]  atomic64_64.h:15   0  1

  -------------------------
      2       50       98  
  -------------------------
	  96.00%   96.94%  [k] update_cfs_group  [kernel.vmlinux]  atomic64_64.h:15   0  1
	   2.00%    1.02%  [k] update_load_avg   [kernel.vmlinux]  atomic64_64.h:25   0  1
	   0.00%    2.04%  [k] update_load_avg   [kernel.vmlinux]  fair.c:4118        0
	   2.00%    0.00%  [k] update_cfs_group  [kernel.vmlinux]  fair.c:3932        0  1

after this series:

#
#        ----- HITM -----                                   Shared                        
#   Num  RmtHitm  LclHitm                 Symbol            Object       Source:Line  Node
# .....  .......  .......   ....................  ................  ................  ....
#
  -------------------------
      0       54       88  
  -------------------------
	 100.00%  100.00%   [k] update_cfs_group  [kernel.vmlinux]  atomic64_64.h:15   0  1

  -------------------------
      1       48       83  
  -------------------------
	  97.92%   97.59%   [k] update_cfs_group  [kernel.vmlinux]  atomic64_64.h:15   0  1
	   2.08%    1.20%   [k] update_load_avg   [kernel.vmlinux]  atomic64_64.h:25   0  1
	   0.00%    1.20%   [k] update_load_avg   [kernel.vmlinux]  fair.c:4118        0  1

  -------------------------
      2       28       44  
  -------------------------
	  85.71%   79.55%   [k] generic_permission      [kernel.vmlinux]  mnt_idmapping.h:81   0  1
	  14.29%   20.45%   [k] generic_permission      [kernel.vmlinux]  mnt_idmapping.h:81   0  1

The contention is practically gone.

Link: https://lore.kernel.org/all/20231018074553.41333-1-hu1.chen@intel.com/

Vinicius Costa Gomes (4):
  cred: Add a light version of override/revert_creds()
  fs/backing-file: Convert to revert/override_creds_light()
  ovl: use wrapper ovl_revert_creds()
  ovl: Optimize override/revert creds

 fs/backing-file.c        | 20 ++++++++++----------
 fs/overlayfs/copy_up.c   |  2 +-
 fs/overlayfs/dir.c       | 17 +++++++++++------
 fs/overlayfs/file.c      | 14 +++++++-------
 fs/overlayfs/inode.c     | 20 ++++++++++----------
 fs/overlayfs/namei.c     | 10 +++++-----
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/readdir.c   |  8 ++++----
 fs/overlayfs/util.c      | 11 ++++++++---
 fs/overlayfs/xattrs.c    |  9 ++++-----
 include/linux/cred.h     | 18 ++++++++++++++++++
 kernel/cred.c            |  6 +++---
 12 files changed, 82 insertions(+), 54 deletions(-)

-- 
2.47.0


