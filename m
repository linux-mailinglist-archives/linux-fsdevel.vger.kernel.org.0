Return-Path: <linux-fsdevel+bounces-11881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7082C8584FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 19:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964301C2115D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 18:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25EC1350F2;
	Fri, 16 Feb 2024 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b6O8Ul/y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B461339B1;
	Fri, 16 Feb 2024 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107544; cv=none; b=ckReEhGSIXnMAD1a/Ujs70NKA3Z/lTnIuBJp4YQeXHWVt0V4eYpm06d5IRMU7KZbibTZEkbJbqogc1334nhg+PztlPW2CqyYlh1C55HOvbf5UxYG0m5STkHnv5O/3f3OBl+lY1izL6KjtfEmgdkwif9A6TJGv12SQK/LurWdDSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107544; c=relaxed/simple;
	bh=jcVA3C45lPnzAqgEnAkcPMyiNt1XQubKk+Vaz7nKCDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlGMrD7mEw+ivsDG60nIpH02Ueg9vYs7ytC/lLCXf1Mcxz5YrTC7ljlNIyZGNWaUnsyWm1tjV/tj8Z/NJfGIaOT6opW8AjIRFIJJHR/uSQTPt3FSAj5AIFPjVDjsFgGjIzcXV8c2WXaRTGkEXWDRjp8PjvAdh2FHcMGKTDaTKxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b6O8Ul/y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Yj46dmU+i7vFXRU29fZjUxc290tVgLUnbk9MXA32B/w=; b=b6O8Ul/yWiVcqjuwwZQT/+W0vI
	2hFScFtgR1z3Kk58IV6xMGcak+jwQRKeRXVawCa55hBx+8ZQsOeZBKlCgF/ASw73QSXXcD4Zi2o2i
	w/5TOvDamiep+wdk+UmO/kHC8Ikt8sZChORnDR+RjWIeT9gxahzgBQ0Q+fgTjGSoRIEK6lGUcRGTE
	hoaKZqehYwtca+YfkagmtEw6YonJpstq2/oJ6SjqP5/uGjxY0DIj++GHhQetkUDznL5NnzwCAA4BX
	OHGctXsWXyMVfRgy0G/PIJSGflAIQEwQ6dQv+Jp+5f93a2n3DGf4E1eHW/86756B2Z5NgPofzikjX
	G575/P0A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb2nd-00000003J8E-3NVY;
	Fri, 16 Feb 2024 18:19:01 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: fstests@vger.kernel.org,
	anand.jain@oracle.com,
	aalbersh@redhat.com,
	djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	kdevops@lists.linux.dev,
	patches@lists.linux.dev,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/3] tests: augment soak test group
Date: Fri, 16 Feb 2024 10:18:57 -0800
Message-ID: <20240216181859.788521-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216181859.788521-1-mcgrof@kernel.org>
References: <20240216181859.788521-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Many tests are using SOAK_DURATION but they have not been added to the
soak group. We want to have a deterministic way to query which tests are
part of the soak group, so to enable test frameworks which use fstests
to get an idea when a test may have lapsed the expected amount of time
for the test to complete. Of course such a time is subjetive to a test
environment and system, however max variables are possible and are used
for an initial test run, and later an enhanced test environement can
leverage and also use prior known test times with check.time. That is
exactly what kdevops uses to determine a timeout.

In kdevops we have to maintain a list of static array of tests which
uses soak, with this, we shold be able to grow that set dynamically.

Tests either use SOAK_DURATION directly or they use the helper loop such as
_soak_loop_running(). XFS also uses SOAK_DURATION with helpers such as
_scratch_xfs_stress_scrub().

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tests/generic/019 | 2 +-
 tests/generic/388 | 2 +-
 tests/generic/475 | 2 +-
 tests/generic/642 | 2 +-
 tests/generic/648 | 2 +-
 tests/xfs/285     | 2 +-
 tests/xfs/517     | 2 +-
 tests/xfs/560     | 2 +-
 tests/xfs/561     | 2 +-
 tests/xfs/562     | 2 +-
 tests/xfs/565     | 2 +-
 tests/xfs/570     | 2 +-
 tests/xfs/571     | 2 +-
 tests/xfs/572     | 2 +-
 tests/xfs/573     | 2 +-
 tests/xfs/574     | 2 +-
 tests/xfs/575     | 2 +-
 tests/xfs/576     | 2 +-
 tests/xfs/577     | 2 +-
 tests/xfs/578     | 2 +-
 tests/xfs/579     | 2 +-
 tests/xfs/580     | 2 +-
 tests/xfs/581     | 2 +-
 tests/xfs/582     | 2 +-
 tests/xfs/583     | 2 +-
 tests/xfs/584     | 2 +-
 tests/xfs/585     | 2 +-
 tests/xfs/586     | 2 +-
 tests/xfs/587     | 2 +-
 tests/xfs/588     | 2 +-
 tests/xfs/589     | 2 +-
 tests/xfs/590     | 2 +-
 tests/xfs/591     | 2 +-
 tests/xfs/592     | 2 +-
 tests/xfs/593     | 2 +-
 tests/xfs/594     | 2 +-
 tests/xfs/595     | 2 +-
 tests/xfs/727     | 2 +-
 tests/xfs/729     | 2 +-
 tests/xfs/800     | 2 +-
 40 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tests/generic/019 b/tests/generic/019
index b81c1d17ba65..a77ce1e3dad6 100755
--- a/tests/generic/019
+++ b/tests/generic/019
@@ -8,7 +8,7 @@
 # check filesystem consistency at the end.
 #
 . ./common/preamble
-_begin_fstest aio dangerous enospc rw stress recoveryloop
+_begin_fstest aio dangerous enospc rw stress recoveryloop soak
 
 fio_config=$tmp.fio
 
diff --git a/tests/generic/388 b/tests/generic/388
index 4a5be6698cbd..523f4b310b8a 100755
--- a/tests/generic/388
+++ b/tests/generic/388
@@ -15,7 +15,7 @@
 # spurious corruption reports and/or mount failures.
 #
 . ./common/preamble
-_begin_fstest shutdown auto log metadata recoveryloop
+_begin_fstest shutdown auto log metadata recoveryloop soak
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/475 b/tests/generic/475
index ce7fe013b1fc..cfbbcedf80e2 100755
--- a/tests/generic/475
+++ b/tests/generic/475
@@ -12,7 +12,7 @@
 # testing efforts.
 #
 . ./common/preamble
-_begin_fstest shutdown auto log metadata eio recoveryloop smoketest
+_begin_fstest shutdown auto log metadata eio recoveryloop smoketest soak
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/642 b/tests/generic/642
index 4d0c41fd5d51..9c367c653807 100755
--- a/tests/generic/642
+++ b/tests/generic/642
@@ -8,7 +8,7 @@
 # bugs in the xattr code.
 #
 . ./common/preamble
-_begin_fstest auto soak attr long_rw stress smoketest
+_begin_fstest auto soak attr long_rw stress smoketest soak
 
 _cleanup()
 {
diff --git a/tests/generic/648 b/tests/generic/648
index 3b3544ff49c3..e3f4ce7af801 100755
--- a/tests/generic/648
+++ b/tests/generic/648
@@ -12,7 +12,7 @@
 # in writeback on the host that cause VM guests to fail to recover.
 #
 . ./common/preamble
-_begin_fstest shutdown auto log metadata eio recoveryloop
+_begin_fstest shutdown auto log metadata eio recoveryloop soak
 
 _cleanup()
 {
diff --git a/tests/xfs/285 b/tests/xfs/285
index 0056baeb1c73..e0510d7f6696 100755
--- a/tests/xfs/285
+++ b/tests/xfs/285
@@ -8,7 +8,7 @@
 # or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	cd /
diff --git a/tests/xfs/517 b/tests/xfs/517
index 68438e544ea0..815c1fb40cc1 100755
--- a/tests/xfs/517
+++ b/tests/xfs/517
@@ -7,7 +7,7 @@
 # Race freeze and fsmap for a while to see if we crash or livelock.
 #
 . ./common/preamble
-_begin_fstest auto quick fsmap freeze
+_begin_fstest auto quick fsmap freeze soak
 
 _register_cleanup "_cleanup" BUS
 
diff --git a/tests/xfs/560 b/tests/xfs/560
index 28b45d5f5e72..a931da7bc239 100755
--- a/tests/xfs/560
+++ b/tests/xfs/560
@@ -7,7 +7,7 @@
 # Race GETFSMAP and ro remount for a while to see if we crash or livelock.
 #
 . ./common/preamble
-_begin_fstest auto quick fsmap remount
+_begin_fstest auto quick fsmap remount soak
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/xfs/561 b/tests/xfs/561
index c1d68c6fe62c..10277e8a6d75 100755
--- a/tests/xfs/561
+++ b/tests/xfs/561
@@ -8,7 +8,7 @@
 # crash or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/xfs/562 b/tests/xfs/562
index a5c6e88875fc..a7304cd3b551 100755
--- a/tests/xfs/562
+++ b/tests/xfs/562
@@ -8,7 +8,7 @@
 # or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/xfs/565 b/tests/xfs/565
index 826bc5354a77..8000984bdee6 100755
--- a/tests/xfs/565
+++ b/tests/xfs/565
@@ -8,7 +8,7 @@
 # or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	cd /
diff --git a/tests/xfs/570 b/tests/xfs/570
index 9f3ba873ae3d..e8c3a315d325 100755
--- a/tests/xfs/570
+++ b/tests/xfs/570
@@ -7,7 +7,7 @@
 # Race fsstress and superblock scrub for a while to see if we crash or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/571 b/tests/xfs/571
index 9d22de8f45c5..4e5ad4b0460e 100755
--- a/tests/xfs/571
+++ b/tests/xfs/571
@@ -7,7 +7,7 @@
 # Race fsstress and AGF scrub for a while to see if we crash or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/572 b/tests/xfs/572
index b0e352af4e40..dfbed43ffa83 100755
--- a/tests/xfs/572
+++ b/tests/xfs/572
@@ -7,7 +7,7 @@
 # Race fsstress and AGFL scrub for a while to see if we crash or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/573 b/tests/xfs/573
index a2b6bef3cf3b..5be8fea7676e 100755
--- a/tests/xfs/573
+++ b/tests/xfs/573
@@ -7,7 +7,7 @@
 # Race fsstress and AGI scrub for a while to see if we crash or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/574 b/tests/xfs/574
index 5a4bad00162d..847a99bc01b7 100755
--- a/tests/xfs/574
+++ b/tests/xfs/574
@@ -8,7 +8,7 @@
 # crash or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/575 b/tests/xfs/575
index 3d29620f2c4b..66731af213eb 100755
--- a/tests/xfs/575
+++ b/tests/xfs/575
@@ -8,7 +8,7 @@
 # crash or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/576 b/tests/xfs/576
index e11476d452fd..d1b99b968068 100755
--- a/tests/xfs/576
+++ b/tests/xfs/576
@@ -8,7 +8,7 @@
 # livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/577 b/tests/xfs/577
index d1abe6fafb15..dad9b3f400cc 100755
--- a/tests/xfs/577
+++ b/tests/xfs/577
@@ -8,7 +8,7 @@
 # livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/578 b/tests/xfs/578
index 8160b7ef515e..28db2c53ba83 100755
--- a/tests/xfs/578
+++ b/tests/xfs/578
@@ -8,7 +8,7 @@
 # or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/579 b/tests/xfs/579
index a00ae02aa74e..bd187852419d 100755
--- a/tests/xfs/579
+++ b/tests/xfs/579
@@ -8,7 +8,7 @@
 # or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/580 b/tests/xfs/580
index f49cba6427c4..1094f04e730c 100755
--- a/tests/xfs/580
+++ b/tests/xfs/580
@@ -8,7 +8,7 @@
 # if we crash or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/581 b/tests/xfs/581
index 1d08bc7df3e6..e733bf3962ce 100755
--- a/tests/xfs/581
+++ b/tests/xfs/581
@@ -8,7 +8,7 @@
 # livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/582 b/tests/xfs/582
index 7a8c330befd1..97c2bfde1453 100755
--- a/tests/xfs/582
+++ b/tests/xfs/582
@@ -8,7 +8,7 @@
 # livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/583 b/tests/xfs/583
index a6121a83bb65..9eb4cefe05f0 100755
--- a/tests/xfs/583
+++ b/tests/xfs/583
@@ -8,7 +8,7 @@
 # livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/584 b/tests/xfs/584
index c80ba57550cb..81ab3e82120b 100755
--- a/tests/xfs/584
+++ b/tests/xfs/584
@@ -8,7 +8,7 @@
 # livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/585 b/tests/xfs/585
index ea47dada7bc3..74493ba1f3d7 100755
--- a/tests/xfs/585
+++ b/tests/xfs/585
@@ -8,7 +8,7 @@
 # livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/586 b/tests/xfs/586
index e802ee718887..8d1e960fe0d4 100755
--- a/tests/xfs/586
+++ b/tests/xfs/586
@@ -8,7 +8,7 @@
 # livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/587 b/tests/xfs/587
index 71e1ce69ae0b..dd9442c203ae 100755
--- a/tests/xfs/587
+++ b/tests/xfs/587
@@ -8,7 +8,7 @@
 # livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/588 b/tests/xfs/588
index f56c50ace5f2..824f47fc8d05 100755
--- a/tests/xfs/588
+++ b/tests/xfs/588
@@ -7,7 +7,7 @@
 # Race fsstress and data fork scrub for a while to see if we crash or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/589 b/tests/xfs/589
index d9cd81e02be8..2ca3dd3d0d41 100755
--- a/tests/xfs/589
+++ b/tests/xfs/589
@@ -7,7 +7,7 @@
 # Race fsstress and attr fork scrub for a while to see if we crash or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/590 b/tests/xfs/590
index 4e39109abd9a..587c0be19cca 100755
--- a/tests/xfs/590
+++ b/tests/xfs/590
@@ -7,7 +7,7 @@
 # Race fsstress and cow fork scrub for a while to see if we crash or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/591 b/tests/xfs/591
index 00d5114e06ef..79492e8aeefb 100755
--- a/tests/xfs/591
+++ b/tests/xfs/591
@@ -7,7 +7,7 @@
 # Race fsstress and directory scrub for a while to see if we crash or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/592 b/tests/xfs/592
index 02ac456b5e2b..aacd95cbfad4 100755
--- a/tests/xfs/592
+++ b/tests/xfs/592
@@ -8,7 +8,7 @@
 # livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/593 b/tests/xfs/593
index cf2ac506ca72..7a8b4a6010fc 100755
--- a/tests/xfs/593
+++ b/tests/xfs/593
@@ -8,7 +8,7 @@
 # livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/594 b/tests/xfs/594
index 323b191b59ae..2f6287396be1 100755
--- a/tests/xfs/594
+++ b/tests/xfs/594
@@ -8,7 +8,7 @@
 # We can't open symlink files directly for scrubbing, so we use xfs_scrub(8).
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/595 b/tests/xfs/595
index fc2a89ed8625..4e431258ce58 100755
--- a/tests/xfs/595
+++ b/tests/xfs/595
@@ -9,7 +9,7 @@
 # xfs_scrub(8).
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/727 b/tests/xfs/727
index 6c5ac7db5e47..81be43cc521d 100755
--- a/tests/xfs/727
+++ b/tests/xfs/727
@@ -8,7 +8,7 @@
 # livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/729 b/tests/xfs/729
index 235cb175d259..70ed67eb24f3 100755
--- a/tests/xfs/729
+++ b/tests/xfs/729
@@ -7,7 +7,7 @@
 # Race fsstress and nlinks scrub for a while to see if we crash or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	_scratch_xfs_stress_scrub_cleanup &> /dev/null
diff --git a/tests/xfs/800 b/tests/xfs/800
index a23e47338e59..6086a4ee2fa2 100755
--- a/tests/xfs/800
+++ b/tests/xfs/800
@@ -8,7 +8,7 @@
 # while to see if we crash or livelock.
 #
 . ./common/preamble
-_begin_fstest scrub dangerous_fsstress_scrub
+_begin_fstest scrub dangerous_fsstress_scrub soak
 
 _cleanup() {
 	cd /
-- 
2.42.0


