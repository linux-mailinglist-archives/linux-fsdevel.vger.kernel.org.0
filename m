Return-Path: <linux-fsdevel+bounces-26639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC1F95AA34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF1C1C22D5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52A8179AE;
	Thu, 22 Aug 2024 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRjhstY4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA3C1BC43;
	Thu, 22 Aug 2024 01:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289935; cv=none; b=NRHvo6DNkOSsiLqIChWyct7mlwF5uZeiNubtEsn7ylPu0Pugn6LsMKD7/dWIhWHSqmgijCUGUNUOQcrzh2OP6MbdCR29JLxWMjBok8ZyJb1cxPXkKAYCof0LZB1rDaoKJnfMPYi3ciUwcRicishSQItc77QXCQMWLQw2GrBeHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289935; c=relaxed/simple;
	bh=3nAzV8OXEFjCpYDcGDX5PpwOU7eV4Hm4imbTPt42bhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EvglKUYSoxPYdiZx4oJRdmiGIlyxnz1w1of3c9n9tfUrePvfr90zsq/kSjyi7yHMOkyEQzmg4+QUXlktIvmSTmcxSZzbf956qWj2630cPFH3c1MTlkE3QUskqptmdrJnZ1s/wQreHZuvncQc7CzT31eSk9zidPVqsOP7t+7mPd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRjhstY4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724289933; x=1755825933;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3nAzV8OXEFjCpYDcGDX5PpwOU7eV4Hm4imbTPt42bhM=;
  b=TRjhstY47ZJpis/XF2kAwW074Za53K4xEDZtbGKjpQvc9ns2z6SxrgF5
   nkBkOPxC0/tVISKlwY+LY5DHAw0wqRwG0arBQ4egzQkyk6z/F9JSLjcns
   G4h7bi9zlXDzZG7jFUgm1evm1hyCNMonQLk+MUqR5PPjhjySnNZ8fIHIp
   coQvDczhOts4StIj7zaHes93PVajv71IKji0QIs6bORC2+W6tSF7njY8U
   vvaig7hsPdzvnrNiFW6i91+N4RYLgnORCtBGHi1cyVpzxU8xUmvOTkTLg
   1spZOojSzw5xJEnvadl+Cs7iCdJqEvPqebrZY18m3sLyEqAY7PdnvuA/N
   w==;
X-CSE-ConnectionGUID: m+63nfhNShWmLzzWAYKNUg==
X-CSE-MsgGUID: NJXZgEEXRUWGDtBpd4cmyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25574718"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25574718"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:32 -0700
X-CSE-ConnectionGUID: SRcX0N8nSeGScyywQ4EFsg==
X-CSE-MsgGUID: Nv3gsHxeSsOk47numpR2KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61811013"
Received: from unknown (HELO vcostago-mobl3.jf.intel.com) ([10.241.225.92])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:31 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: brauner@kernel.org,
	amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH v2 00/16] overlayfs: Optimize override/revert creds
Date: Wed, 21 Aug 2024 18:25:07 -0700
Message-ID: <20240822012523.141846-1-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

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

Vinicius Costa Gomes (16):
  cred: Add a light version of override/revert_creds()
  fs/backing-file: Convert to revert/override_creds_light()
  fs/overlayfs: Introduce ovl_override_creds_light()
  overlayfs: Document critical override_creds() operations
  overlayfs: Use ovl_override_creds_light()/revert_creds_light()
  cred: Introduce cred_guard() and cred_scoped_guard() helpers
  fs/backing-file: Convert to cred_guard()
  overlayfs/copy_up: Convert to cred_guard()
  overlayfs/dir: Convert to cred_guard()
  overlayfs/file: Convert to cred_guard()
  overlayfs/inode: Convert to cred_guard()
  overlayfs/namei: Convert to cred_guard()
  overlayfs/readdir: Convert to cred_guard()
  overlayfs/xattrs: Convert to cred_guard()
  overlayfs/util: Convert to cred_guard()
  overlayfs: Remove ovl_override_creds_light()

 fs/backing-file.c      | 22 +++----------
 fs/overlayfs/copy_up.c | 10 +++---
 fs/overlayfs/dir.c     | 20 ++++++------
 fs/overlayfs/file.c    | 64 +++++++++++++++---------------------
 fs/overlayfs/inode.c   | 73 ++++++++++++++++--------------------------
 fs/overlayfs/namei.c   | 20 +++---------
 fs/overlayfs/readdir.c | 16 +++------
 fs/overlayfs/util.c    | 24 ++++++--------
 fs/overlayfs/xattrs.c  | 32 ++++++++----------
 include/linux/cred.h   | 25 +++++++++++++++
 kernel/cred.c          |  6 ++--
 11 files changed, 134 insertions(+), 178 deletions(-)

-- 
2.46.0


