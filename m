Return-Path: <linux-fsdevel+bounces-11814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0652B857585
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 06:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3FC1C22553
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 05:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF9E1429B;
	Fri, 16 Feb 2024 05:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qg9xQ89A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B713AE2;
	Fri, 16 Feb 2024 05:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708060620; cv=none; b=E+j9Dn7BbhQjRFtsRwPRLXxq/UahZcy15l9OTTu38V1v8jCsW3OXmi6qjwdz8l0X9jQ9aK55haaBZTHQD2oGyoX8jJhRQQvdldH3Y6kauSve5xY0ryopbGO9wpgYdUVUJbGNyI30Yab3SrClqXJZCvWJRNhu/CjOA0efNJl7bmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708060620; c=relaxed/simple;
	bh=r47PztbsN/xdHZ1e4Vw9ogIQSHZ/xcydjlXY6bRNRc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Be3nhbZO2mmjxvgkd8w9aPhvues/88bMN1Ea5isrOOAjCJ8Ez75KgiXA724nd1w+c15BHRbKgX1zCdICSHGNZzc+WK+LeSxxVa1Pr+oxsKJDuPg0vY5sztnj3nAiVVt9flc5xKOex3IHFMFztGFRPlNoPTEdUGYknEzMIsTJbFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qg9xQ89A; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708060618; x=1739596618;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r47PztbsN/xdHZ1e4Vw9ogIQSHZ/xcydjlXY6bRNRc0=;
  b=Qg9xQ89AjPJ+BuPHAYeeEvq47xbVznxebseBD35+L+R8ALPBkdrAwv+6
   sK3m4HLRNlwJXwx2oP2LG1ide1SQz1+VMyQD9uboLY7gA2gILhJd1FGoJ
   q+h6VGrxJldIqAUNIgOFhF8R4C0X2mGa7Fa1b7TTe7NuwfzIFdXAxxyQX
   Q3lDc39xMojbmhMX2YMGjAko1jUOrMZWu3Gu9gBjKQ3vtWNo/QZB58cVh
   xWXanrWz6xdvElH3WJNYV0iXwauPAxfEsscRBEvTq6pfXWhOl4idXlWdC
   jxWZOmdMiig6yPuqEaLE+sKqBkTJvShwG0maEv30FyuTlnzdKOd3JxjUF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5149338"
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="5149338"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 21:16:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="4063882"
Received: from lvngo-mobl1.amr.corp.intel.com (HELO vcostago-mobl3.intel.com) ([10.125.17.186])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 21:16:56 -0800
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
Subject: [RFC v3 0/5] overlayfs: Optimize override/revert creds
Date: Thu, 15 Feb 2024 21:16:35 -0800
Message-ID: <20240216051640.197378-1-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Hi,

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

Vinicius Costa Gomes (5):
  cleanup: Fix discarded const warning when defining lock guard
  cleanup: Fix discarded const warning when defining guard
  cred: Add a light version of override/revert_creds()
  fs: Optimize credentials reference count for backing file ops
  overlayfs: Optimize credentials usage

 fs/backing-file.c       | 27 +++++--------------
 fs/overlayfs/copy_up.c  |  4 +--
 fs/overlayfs/dir.c      | 23 +++++++---------
 fs/overlayfs/file.c     | 28 +++++--------------
 fs/overlayfs/inode.c    | 59 +++++++++++++++--------------------------
 fs/overlayfs/namei.c    | 20 ++++----------
 fs/overlayfs/readdir.c  | 16 +++--------
 fs/overlayfs/util.c     | 10 +++----
 fs/overlayfs/xattrs.c   | 33 +++++++++--------------
 include/linux/cleanup.h |  4 +--
 include/linux/cred.h    | 21 +++++++++++++++
 kernel/cred.c           |  6 ++---
 12 files changed, 97 insertions(+), 154 deletions(-)

-- 
2.43.0


