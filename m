Return-Path: <linux-fsdevel+bounces-11880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CF58584FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 19:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CB71F23601
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 18:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934F81350E6;
	Fri, 16 Feb 2024 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2MlGymER"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91470134CCE;
	Fri, 16 Feb 2024 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107544; cv=none; b=SII+f6elpDjTUXbWZG8Y9kaobFwNBPi6hRbH/brTCdNcM5O3QImvucJn6Qdcz/pHnxfmhj6OI4xhHsyJHs9FXrpI53kqyJ+ntPjxTjP3i4F0cKzLPYk0/hTubdGff3RjMKLNNktf71U2IHp7+hufJneDD9e1e6D8bWnswpWsC9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107544; c=relaxed/simple;
	bh=fmSIUg9ra3TV1Jgu+CAyHWtpEE6Xwo6rwiKK8Hik5Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoHOgbUAwXD+ZjLCRDvLIfZGnwz+khp7w6G9GfFt8vuGtlI7al+N26oJP3BofyShmcpqhJxjEZx4eWIsGwKH3J8d1arYhHSY0m3PgOQ6syrQbgtRyGEJzRAjQnPfEUMRZndmYD/JugLuO3xZ70yZ9TeC3n0nOuC7k8eXGF3EGA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2MlGymER; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+xyP02XmDp0kulPeDQXa2YyH1efNEuwULDtAzfMe4cQ=; b=2MlGymERByjanyGip+2nYDOWuk
	XrvR6pntOTcr1Uw766BXnuQHEE4w3acrLwb9TeRk/a5+lXd2QyTIPUMZCVVB0sJ83Vt4YRMIGyw5U
	DMAc1CXjFCTAMQ5LaqerSbUz3O+s/5BwFpcqzJu/HqejvhBKhrwsxeLuXYK7KV7/UOhO47eyavGLl
	7Zft4iGqqbEnY3TEeTv7Wwkk3dHf42Unrcinr9+oC/EKZvjd8XfE8W1wK9G4g3+Cqy9ntlxy/5jZ4
	RqsN+Kghqh0L3rZT3nVn/YMgwVfgfQDQGLS18xkNEsIWL4vjxR7SWUbyKvacgxdyVUiLkdLUfb3lf
	pa80DUsw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb2nd-00000003J8I-3XxY;
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
Subject: [PATCH 2/3] check: add support for --list-group-tests
Date: Fri, 16 Feb 2024 10:18:58 -0800
Message-ID: <20240216181859.788521-3-mcgrof@kernel.org>
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

Since the prior commit adds the ability to list groups but is used
only when we use --start-after, let's add an option which leverages this
to also allow us to easily query which tests are part of the groups
specified.

This can be used for dynamic test configuration suites such as kdevops
which may want to take advantage of this information to deterministically
determine if a test falls part of a specific group.

Demo:

root@demo-xfs-reflink /var/lib/xfstests # ./check --list-group-tests -g soak

generic/019 generic/388 generic/475 generic/476 generic/521 generic/522 generic/616 generic/617 generic/642 generic/648 generic/650 xfs/285 xfs/517 xfs/560 xfs/561 xfs/562 xfs/565 xfs/570 xfs/571 xfs/572 xfs/573 xfs/574 xfs/575 xfs/576 xfs/577 xfs/578 xfs/579 xfs/580 xfs/581 xfs/582 xfs/583 xfs/584 xfs/585 xfs/586 xfs/587 xfs/588 xfs/589 xfs/590 xfs/591 xfs/592 xfs/593 xfs/594 xfs/595 xfs/727 xfs/729 xfs/800

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 check | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/check b/check
index f081bf8ce685..523cf024c139 100755
--- a/check
+++ b/check
@@ -19,6 +19,7 @@ have_test_arg=false
 randomize=false
 exact_order=false
 start_after_test=""
+list_group_tests=false
 export here=`pwd`
 xfile=""
 subdir_xfile=""
@@ -81,6 +82,7 @@ check options
     -b			brief test summary
     -R fmt[,fmt]	generate report in formats specified. Supported formats: xunit, xunit-quiet
     --large-fs		optimise scratch device for large filesystems
+    --list-group-tests	only list tests part of the groups you specified, do not run the tests
     --start-after	only start testing after the test specified
     -s section		run only specified section from config file
     -S section		exclude the specified section from the config file
@@ -276,8 +278,16 @@ _prepare_test_list()
 			done
 			group_all="$group_all $list"
 		done
+
+		group_all=$(echo $group_all | sed -e 's|tests/||g')
+
+		# Keep it simple, allow for easy machine scraping
+		if $list_group_tests ; then
+			echo $group_all
+			exit 0
+		fi
+
 		if [[ "$start_after_test" != "" && $start_after_found -ne 1 ]]; then
-			group_all=$(echo $group_all | sed -e 's|tests/||g')
 			echo "Start after test $start_after_test not found in any group specified."
 			echo "Be sure you specify a test present in one of your test run groups if using --start-after."
 			echo
@@ -366,6 +376,9 @@ while [ $# -gt 0 ]; do
 		start_after_test="$2"
 		shift
 		;;
+	--list-group-tests)
+		list_group_tests=true
+		;;
 	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
 	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
 	-l)	diff="diff" ;;
-- 
2.42.0


