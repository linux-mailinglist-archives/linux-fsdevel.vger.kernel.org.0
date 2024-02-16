Return-Path: <linux-fsdevel+bounces-11878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E310C8584EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 19:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC9E1C219A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DCF135A5D;
	Fri, 16 Feb 2024 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3LC3jH9e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6BA1353E1;
	Fri, 16 Feb 2024 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106990; cv=none; b=a6Fx0Ua7ejsJYmF0yogqtbDAKpj6Qe0riluBJqsjdSNOvtf8tdml5DKfWA3pF6T4PwLgVmoDpb6q85lXKrHlAo+xybmVbWBnztfEsHTBm82F2ZZIsbuKAcIP2Nv1g+0rAYV2jpZO1lte4l4o4Ho9cAd1UMJzPWo6w/YYW6f2OPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106990; c=relaxed/simple;
	bh=Qgr33Jeu1S69irHgAh3c5ZEP+3H0Bz024KZZSc3/Q3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QtLlL1skggBKIlUSjS+RHDA0vmoqhCqRkHW3nGjU3MCIFxqntkEqVuOA/6zJPNFwXEDnjz9F6t2RZumEyItEeZerGckmnZikYhl3e+oZTDpWzl4w95f/FQWW0pK7gevbpnkFWKJEORw3g/ZmFq34/a3vXwOTEZufaCxqdZIB1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3LC3jH9e; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=E9SCw2jKdsE0vbeB36E0XXW5DJhdmDG95Jht2GvDVTI=; b=3LC3jH9eEPdjF/QS6q47metEqj
	WXH2qdP6wER4cOspitPbiPmJbnHbEewB15r3gbKOV17o29HVz1olVaz6MtbIVzfDqe8//cTn0iKya
	nAcqv21eIVZcY8hiH8p0qit1j/wztTjRjDtHcXFWimC0qV/cyxJqMFmddCWsZrDLcWVCo6ZGudy1R
	rDBhImsfUE9N7xBKfkk/upLCzxMVPHy84ARw6LQjdtr7YAgHX2pF6roMAh2Bg68Yst4lR9krbY8hc
	XRWEZEY2dQB9XV88fimoVg3c1UTmgAGtrNsGTE3sIDRFCrXPrw5k6geifFutk1qOTKKOgqB6KoIBE
	MlVFdRxA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb2eh-00000003IBm-2Ai5;
	Fri, 16 Feb 2024 18:09:47 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: fstests@vger.kernel.org,
	anand.jain@oracle.com,
	aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org,
	kdevops@lists.linux.dev,
	patches@lists.linux.dev,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 fstests] check: add support for --start-after
Date: Fri, 16 Feb 2024 10:09:46 -0800
Message-ID: <20240216180946.784869-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Often times one is running a new test baseline we want to continue to
start testing where we left off if the last test was a crash. This is
in particular useful if you are doing automation and want to kick off
where the last test crashed.

To do this the first thing that occurred to me was to use the check.time
file as an expunge file but that doesn't work so well if you crashed
as the file turns out empty.

So instead add super simple argument --start-after which let's you
skip all tests inclusive of the test you specified, letting you pick up
where you last left off testing from a crash. This is intended to work
if you are not using a random order.

If the target test is not found in your test list we complain and
bail. This is not as obvious when you specify groups, so likewise
we do a special check when you use groups to ensure the test is at
least part of one group.

Demo:

root@demo-xfs-reflink /var/lib/xfstests # ./check -s xfs_reflink -n -g soak --start-after generic/025
Start after test generic/025 not found in any group specified.
Be sure you specify a test present in one of your test run groups if using --start-after.

Your set of groups have these tests:

generic/476 generic/521 generic/522 generic/616 generic/617 generic/642 generic/650

root@demo-xfs-reflink /var/lib/xfstests # ./check -s xfs_reflink -n -g soak --start-after generic/522
SECTION       -- xfs_reflink
RECREATING    -- xfs on /dev/loop16
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 demo-xfs-reflink 6.5.0-5-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.5.13-1 (2023-11-29)
MKFS_OPTIONS  -- -f -f -m reflink=1,rmapbt=1, -i sparse=1, /dev/loop5
MOUNT_OPTIONS -- /dev/loop5 /media/scratch

generic/616
generic/617
generic/642
generic/650

Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

Changes since v2:

- Simplify to just one variable as requested by Zorro
- Remove the unused grep_start_after variable as pointed out by Andrey Albersht
- Make the conflict with randomize explicit, although we could support
  it, it is just odd to use it with randomize...
- Replace the not-needed echo -e, with just echo

Changes since v1:                                                                                                                                                                             
                                                                                                                                                                                              
This all addresses Anand Jain's feedback.                                                                                                                                                     
                                                                                                                                                                                              
 - Skip tests completely which are not going to be run                                                                                                                                        
 - Sanity test to ensure the test is part of a group, if you listed                                                                                                                           
   groups, and if not provide a useful output giving the list of all                                                                                                                          
   tests in your group so you can know better which one is a valid test                                                                                                                       
   to skip                                                                                                                                                                                    
 - Sanity test to ensure the test you specified is valid                                                                                                                                      
 - Moves the trim during file processing now using a routine                                                                                                                                  
   trim_start_after()  

 check | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/check b/check
index 71b9fbd07522..f081bf8ce685 100755
--- a/check
+++ b/check
@@ -18,6 +18,7 @@ showme=false
 have_test_arg=false
 randomize=false
 exact_order=false
+start_after_test=""
 export here=`pwd`
 xfile=""
 subdir_xfile=""
@@ -80,6 +81,7 @@ check options
     -b			brief test summary
     -R fmt[,fmt]	generate report in formats specified. Supported formats: xunit, xunit-quiet
     --large-fs		optimise scratch device for large filesystems
+    --start-after	only start testing after the test specified
     -s section		run only specified section from config file
     -S section		exclude the specified section from the config file
     -L <n>		loop tests <n> times following a failure, measuring aggregate pass/fail metrics
@@ -120,6 +122,8 @@ examples:
  check -x stress xfs/*
  check -X .exclude -g auto
  check -E ~/.xfstests.exclude
+ check --start-after btrfs/010
+ check -n -g soak --start-after generic/522
 '
 	    exit 1
 }
@@ -204,6 +208,23 @@ trim_test_list()
 	rm -f $tmp.grep
 }
 
+# takes the list of tests to run in $tmp.list and skips all tests until
+# the specified test is found. This will ensure the tests start after the
+# test specified, it skips the test specified.
+trim_start_after()
+{
+	local skip_test="$1"
+	local starts_regexp=$(echo $skip_test | sed -e 's|\/|\\/|')
+
+	if grep -q $skip_test $tmp.list ; then
+		rm -f $tmp.grep
+		awk 'f;/.*'$starts_regexp'/{f=1}' $tmp.list > $tmp.tmp
+		mv $tmp.tmp $tmp.list
+	else
+		echo "Test $skip_test not found in test list, be sure to use a valid test if using --start-after"
+		exit 1
+	fi
+}
 
 _wallclock()
 {
@@ -233,6 +254,9 @@ _prepare_test_list()
 		# no test numbers, do everything
 		get_all_tests
 	else
+		local group_all
+		local start_after_found=0
+		list=""
 		for group in $GROUP_LIST; do
 			list=$(get_group_list $group)
 			if [ -z "$list" ]; then
@@ -240,11 +264,28 @@ _prepare_test_list()
 				exit 1
 			fi
 
+			if [[ "$start_after_test" != "" && $start_after_found -ne 1 ]]; then
+				echo $list | grep -q $start_after_test
+				if [[ $? -eq 0 ]]; then
+					start_after_found=1
+				fi
+			fi
 			for t in $list; do
 				grep -s "^$t\$" $tmp.list >/dev/null || \
 							echo "$t" >>$tmp.list
 			done
+			group_all="$group_all $list"
 		done
+		if [[ "$start_after_test" != "" && $start_after_found -ne 1 ]]; then
+			group_all=$(echo $group_all | sed -e 's|tests/||g')
+			echo "Start after test $start_after_test not found in any group specified."
+			echo "Be sure you specify a test present in one of your test run groups if using --start-after."
+			echo
+			echo "Your set of groups have these tests:"
+			echo
+			echo $group_all
+			exit 1
+		fi
 	fi
 
 	# Specified groups to exclude
@@ -258,6 +299,10 @@ _prepare_test_list()
 		trim_test_list $list
 	done
 
+	if [[ "$start_after_test" != "" ]]; then
+		trim_start_after $start_after_test
+	fi
+
 	# sort the list of tests into numeric order unless we're running tests
 	# in the exact order specified
 	if ! $exact_order; then
@@ -313,6 +358,14 @@ while [ $# -gt 0 ]; do
 				<(sed "s/#.*$//" $xfile)
 		fi
 		;;
+	--start-after)
+		if $randomize; then
+			echo "Cannot specify -r and --start-after."
+			exit 1
+		fi
+		start_after_test="$2"
+		shift
+		;;
 	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
 	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
 	-l)	diff="diff" ;;
-- 
2.42.0


