Return-Path: <linux-fsdevel+bounces-54568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB90B00F86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EACC1CA3352
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909AC2D320B;
	Thu, 10 Jul 2025 23:21:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C302528B507;
	Thu, 10 Jul 2025 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189692; cv=none; b=k0p5r+3WZJewgxDf3HPdG9txQw5XWS/49oHnGwggEQlfgCxoG2amjugA+4UvWp85NhUaKRpDmbNHMvzR6wXS61OoUGFKseRJFL+tEQm2wDRvj9+D8nI6rp/ejUPlQ6RgW+/hi2jUFrb2pVK/Z4k2q78nGwJ2XDgq12NRstEfbvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189692; c=relaxed/simple;
	bh=epRLjHu2O67EoIfoPYbYcrKgcilaScnP63/4ojsfUrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IMvmRCy5R0nt4FBoUSM73ICw9+F7GjcQl6GPT9uv/XrUhFtVXOlgoRBwMM80sB8wSlj/ETfJ2dfgMzESHSsm559hCeXp8kmEp53RgzgRXsAC8uUiRCWTIB/6WH5G0KULwTO85x+Yyv2s1bVIFFIdZiVuRfgb3zeKH7toqYOuLpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ua0Zp-001XFk-8w;
	Thu, 10 Jul 2025 23:21:19 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/20 v2] ovl: narrow regions protected by i_rw_sem
Date: Fri, 11 Jul 2025 09:03:30 +1000
Message-ID: <20250710232109.3014537-1-neil@brown.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a revised set of patches following helpful feedback.  There are
now more patches, but they should be a lot easier to review.

These patches are all in a git tree at
   https://github.com/neilbrown/linux/commits/pdirops
though there a lot more patches there too - demonstrating what is to come.
0eaa1c629788 ovl: rename ovl_cleanup_unlocked() to ovl_cleanup()
is the last in the series posted here.

I welcome further review.

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

I have tested this with fstests, both generic and unionfs tests.  I
wouldn't be surprised if I missed something though, so please review
carefully.

After this series (with any needed changes) lands I will resubmit my
change to vfs_rmdir() behaviour to have it drop the lock on error.  ovl
will be much better positioned to handle that change.  It will come with
the new "lookup_and_lock" API that I am proposing.

Thanks,
NeilBrown


 [PATCH 01/20] ovl: simplify an error path in ovl_copy_up_workdir()
 [PATCH 02/20] ovl: change ovl_create_index() to take write and dir
 [PATCH 03/20] ovl: Call ovl_create_temp() without lock held.
 [PATCH 04/20] ovl: narrow the locked region in ovl_copy_up_workdir()
 [PATCH 05/20] ovl: narrow locking in ovl_create_upper()
 [PATCH 06/20] ovl: narrow locking in ovl_clear_empty()
 [PATCH 07/20] ovl: narrow locking in ovl_create_over_whiteout()
 [PATCH 08/20] ovl: narrow locking in ovl_rename()
 [PATCH 09/20] ovl: narrow locking in ovl_cleanup_whiteouts()
 [PATCH 10/20] ovl: narrow locking in ovl_cleanup_index()
 [PATCH 11/20] ovl: narrow locking in ovl_workdir_create()
 [PATCH 12/20] ovl: narrow locking in ovl_indexdir_cleanup()
 [PATCH 13/20] ovl: narrow locking in ovl_workdir_cleanup_recurse()
 [PATCH 14/20] ovl: change ovl_workdir_cleanup() to take dir lock as
 [PATCH 15/20] ovl: narrow locking on ovl_remove_and_whiteout()
 [PATCH 16/20] ovl: change ovl_cleanup_and_whiteout() to take rename
 [PATCH 17/20] ovl: narrow locking in ovl_whiteout()
 [PATCH 18/20] ovl: narrow locking in ovl_check_rename_whiteout()
 [PATCH 19/20] ovl: change ovl_create_real() to receive dentry parent
 [PATCH 20/20] ovl: rename ovl_cleanup_unlocked() to ovl_cleanup()

