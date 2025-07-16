Return-Path: <linux-fsdevel+bounces-55047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9033CB06ABF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6ED2170D45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FCF18CBE1;
	Wed, 16 Jul 2025 00:47:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1BD376F1;
	Wed, 16 Jul 2025 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626854; cv=none; b=mBxEcoyj86cy6Xe4y0EnjmSdohczH83B7tWnjG1k1RLu4fUG6V+sP8bxAwnrUlAckWbv47ceDSJe4sVKxw9gbc8/3cDdRqSprJGJ5elJBdBekq34Q4wiekHFTWQVg9kxJJFQFQu4FYwRZRm2Pnd0+Fn/QsPT46hSDKMxsBzyGrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626854; c=relaxed/simple;
	bh=kyqCeObT4NUOESGNT8iLnG6woN09ctzGI1o3aDHJ6Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OmgSjvKjWgVXwuRcIA7d3RCO64fYDpMzS7yLcgi2MolAeD0/iw6ky4h7yNxidLf+a24kaDo7Fc9wFGeHIvr8w7XjGfm0jxHcDa0W9KfKdaFOTlLyM52O0r8AeKDJbmvhHglOjHL51afdnCqkR/Pg1G9Ae73+dpo2VhlQRA3P4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqIy-002AAF-Rj;
	Wed, 16 Jul 2025 00:47:30 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 00/21] ovl: narrow regions protected by i_rw_sem
Date: Wed, 16 Jul 2025 10:44:11 +1000
Message-ID: <20250716004725.1206467-1-neil@brown.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

More excellent review feedback - more patches :-)

I've chosen to use ovl_parent_lock() here as a temporary and leave the
debate over naming for the VFS version of the function until all the new
names are introduced later.


Original description:

This series of patches for overlayfs is primarily focussed on preparing
for some proposed changes to directory locking.  In the new scheme we
will lock individual dentries in a directory rather than the whole
directory.

ovl currently will sometimes lock a directory on the upper filesystem
and do a few different things while holding the lock.  This is
incompatible with the new scheme.

This series narrows the region of code protected by the directory lock,
taking it multiple times when necessary.  This theoretically open up the
possibilty of other changes happening on the upper filesytem between the
unlock and the lock.  To some extent the patches guard against that by
checking the dentries still have the expect parent after retaking the
lock.  In general, I think ovl would have trouble if upperfs were being
changed independantly, and I don't think the changes here increase the
problem in any important way.

After this series (with any needed changes) lands I will resubmit my
change to vfs_rmdir() behaviour to have it drop the lock on error.  ovl
will be much better positioned to handle that change.  It will come with
the new "lookup_and_lock" API that I am proposing.

Thanks,
NeilBrown

 [PATCH v3 01/21] ovl: simplify an error path in ovl_copy_up_workdir()
 [PATCH v3 02/21] ovl: change ovl_create_index() to take dir locks
 [PATCH v3 03/21] ovl: Call ovl_create_temp() without lock held.
 [PATCH v3 04/21] ovl: narrow the locked region in
 [PATCH v3 05/21] ovl: narrow locking in ovl_create_upper()
 [PATCH v3 06/21] ovl: narrow locking in ovl_clear_empty()
 [PATCH v3 07/21] ovl: narrow locking in ovl_create_over_whiteout()
 [PATCH v3 08/21] ovl: simplify gotos in ovl_rename()
 [PATCH v3 09/21] ovl: narrow locking in ovl_rename()
 [PATCH v3 10/21] ovl: narrow locking in ovl_cleanup_whiteouts()
 [PATCH v3 11/21] ovl: narrow locking in ovl_cleanup_index()
 [PATCH v3 12/21] ovl: narrow locking in ovl_workdir_create()
 [PATCH v3 13/21] ovl: narrow locking in ovl_indexdir_cleanup()
 [PATCH v3 14/21] ovl: narrow locking in ovl_workdir_cleanup_recurse()
 [PATCH v3 15/21] ovl: change ovl_workdir_cleanup() to take dir lock
 [PATCH v3 16/21] ovl: narrow locking on ovl_remove_and_whiteout()
 [PATCH v3 17/21] ovl: change ovl_cleanup_and_whiteout() to take
 [PATCH v3 18/21] ovl: narrow locking in ovl_whiteout()
 [PATCH v3 19/21] ovl: narrow locking in ovl_check_rename_whiteout()
 [PATCH v3 20/21] ovl: change ovl_create_real() to receive dentry
 [PATCH v3 21/21] ovl: rename ovl_cleanup_unlocked() to ovl_cleanup()

