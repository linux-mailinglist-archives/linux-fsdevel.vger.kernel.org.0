Return-Path: <linux-fsdevel+bounces-11867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC568582CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 17:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657222829F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 16:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A289130ACA;
	Fri, 16 Feb 2024 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eNChAris"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F312EBC8;
	Fri, 16 Feb 2024 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101717; cv=none; b=lm7SMc3txE8UFzk+jaGan5dgr0AgS49sEr/3X+OSvsjSw84JxD/tFgcKut4CtMGCekadfN8ebc+eC35sBKfkDTNcL7z0YJ9qxl3LRs2d7RKfQEa0Bshmi7CyNBwbUDJh5oBPfAZV0hqMqYnISjOqzXRRWy0+ImKPh9pQ/oygAP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101717; c=relaxed/simple;
	bh=lk6cazMY7bINlHC/Mcpt2DmUOaSf+FCwwiPwGdqRLbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCEwElZ4FBRLBSdtqwlIh0Np0o7jPtXKQ/R3/f3N0q5LBTNP5NcNq1jXh0wGDnnFNafCQ+lgzX5XfINob99YiK2oUJzRjlQPVB4a4UnxChC+eRSPgnYj2cjw+Sw4+RvLOspfME01SqGKgtZwNpEu8Q5hhEGh1fjZeXBHrMvvAIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eNChAris; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Yk1HolHXPWN9hgYOAzyuhKeVjYPro7ng/mtemAfIEp4=; b=eNChArisJY4N+lAXV+ujOG0m3+
	0qSbiugTwFI1bUCErPC06iWsDJyj2ZXOBUtBOwbOwWF89B7sur2UcgJzd4Xtp1CEldFEOhYqf2gIC
	iKHbmq1takivCEPqC/QQdSxz7xMV/looUFzZIs4MhreYAuTCbMPT2GR6RrDI0fJq0vbKCWFIYOj21
	cm6yyrNOdX8JHj0V1328TApfF0xd8yz+VuIRmO+7UpGgBuziXXZXACxd8VLCrci/WOLNnokrxhMgz
	7x3xjnTdSkCtTwxp3YVyzJLIlf1RGHbBCPG4eLXyJ+0XM8XOq8uYV69p6u29CjOo6RQNp7w9vC2+o
	W8w1r4/w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb1Hf-000000031tg-20Zp;
	Fri, 16 Feb 2024 16:41:55 +0000
Date: Fri, 16 Feb 2024 08:41:55 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fstests@vger.kernel.org, anand.jain@oracle.com,
	linux-fsdevel@vger.kernel.org, kdevops@lists.linux.dev,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 fstests] check: add support for --start-after
Message-ID: <Zc-QUziNTR3Bw9r2@bombadil.infradead.org>
References: <20240216010803.164750-1-mcgrof@kernel.org>
 <avlvdgunqc4hf5p2gzrb22cptsybskifpejylpehzcofkpbkm3@mvnva74o4boy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avlvdgunqc4hf5p2gzrb22cptsybskifpejylpehzcofkpbkm3@mvnva74o4boy>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Feb 16, 2024 at 10:03:31AM +0100, Andrey Albershteyn wrote:
> On 2024-02-15 17:08:02, Luis Chamberlain wrote:
> > Often times one is running a new test baseline we want to continue to
> > start testing where we left off if the last test was a crash. To do
> > this the first thing that occurred to me was to use the check.time
> > file as an expunge file but that doesn't work so well if you crashed
> > as the file turns out empty.
> > 
> > So instead add super simple argument --start-after which let's you
> > skip all tests until the test infrastructure has "seen" the test
> > you want to skip. This does obviously work best if you are not using
> > a random order, but that is rather implied. If you do use a random
> > order --start-after still works, the final output will however just
> > be randomized of course, but it should let you skip a failed known
> > crash at least. The real value to --start-after though is for when
> > you use a non-randomized order.
> > 
> > If the target test is not found in your test list we complain and
> > bail. This is not as obvious when you specify groups, so likewise
> > we do a special check when you use groups to ensure the test is at
> > least part of one group.
> > 
> > Demo:
> > 
> > root@demo-xfs-reflink /var/lib/xfstests # ./check -s xfs_reflink -n -g soak --start-after generic/025
> > Start after test generic/025 not found in any group specified.
> > Be sure you specify a test present in one of your test run groups if using --start-after.
> > 
> > Your set of groups have these tests:
> > 
> > generic/476 generic/521 generic/522 generic/616 generic/617 generic/642 generic/650
> > 
> > root@demo-xfs-reflink /var/lib/xfstests # ./check -s xfs_reflink -n -g soak --start-after generic/522
> > SECTION       -- xfs_reflink
> > RECREATING    -- xfs on /dev/loop16
> > FSTYP         -- xfs (non-debug)
> > PLATFORM      -- Linux/x86_64 demo-xfs-reflink 6.5.0-5-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.5.13-1 (2023-11-29)
> > MKFS_OPTIONS  -- -f -f -m reflink=1,rmapbt=1, -i sparse=1, /dev/loop5
> > MOUNT_OPTIONS -- /dev/loop5 /media/scratch
> > 
> > generic/616
> > generic/617
> > generic/642
> > generic/650
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> > 
> > Changes since v1:
> > 
> > This all addresses Anand Jain's feedback.
> > 
> >  - Skip tests completely which are not going to be run
> >  - Sanity test to ensure the test is part of a group, if you listed
> >    groups, and if not provide a useful output giving the list of all
> >    tests in your group so you can know better which one is a valid test
> >    to skip
> >  - Sanity test to ensure the test you specified is valid
> >  - Moves the trim during file processing now using a routine
> >    trim_start_after()
> > 
> >  check | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> > 
> > diff --git a/check b/check
> > index 71b9fbd07522..1c76f33192ba 100755
> > --- a/check
> > +++ b/check
> > @@ -18,6 +18,8 @@ showme=false
> >  have_test_arg=false
> >  randomize=false
> >  exact_order=false
> > +start_after=false
> > +start_after_test=""
> >  export here=`pwd`
> >  xfile=""
> >  subdir_xfile=""
> > @@ -80,6 +82,7 @@ check options
> >      -b			brief test summary
> >      -R fmt[,fmt]	generate report in formats specified. Supported formats: xunit, xunit-quiet
> >      --large-fs		optimise scratch device for large filesystems
> > +    --start-after	only start testing after the test specified
> >      -s section		run only specified section from config file
> >      -S section		exclude the specified section from the config file
> >      -L <n>		loop tests <n> times following a failure, measuring aggregate pass/fail metrics
> > @@ -120,6 +123,8 @@ examples:
> >   check -x stress xfs/*
> >   check -X .exclude -g auto
> >   check -E ~/.xfstests.exclude
> > + check --start-after btrfs/010
> > + check -n -g soak --start-after generic/522
> >  '
> >  	    exit 1
> >  }
> > @@ -204,6 +209,24 @@ trim_test_list()
> >  	rm -f $tmp.grep
> >  }
> >  
> > +# takes the list of tests to run in $tmp.list and skips all tests until
> > +# the specified test is found. This will ensure the tests start after the
> > +# test specified, it skips the test specified.
> > +trim_start_after()
> > +{
> > +	local skip_test="$1"
> > +	local starts_regexp=$(echo $skip_test | sed -e 's|\/|\\/|')
> > +	local grep_start_after=" | awk 'f;/.*'$starts_regexp'/{f=1}'"
> 
> Looks like grep_start_after is not used
> Otherwise, LGTM:
> Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

Thanks I've made these changes, will send a v3:

diff --git a/check b/check
index 1c76f33192ba..d0bf7ea43870 100755
--- a/check
+++ b/check
@@ -18,7 +18,6 @@ showme=false
 have_test_arg=false
 randomize=false
 exact_order=false
-start_after=false
 start_after_test=""
 export here=`pwd`
 xfile=""
@@ -216,7 +215,6 @@ trim_start_after()
 {
 	local skip_test="$1"
 	local starts_regexp=$(echo $skip_test | sed -e 's|\/|\\/|')
-	local grep_start_after=" | awk 'f;/.*'$starts_regexp'/{f=1}'"
 
 	if grep -q $skip_test $tmp.list ; then
 		rm -f $tmp.grep
@@ -266,7 +264,7 @@ _prepare_test_list()
 				exit 1
 			fi
 
-			if [[ $start_after && $start_after_found -ne 1 ]]; then
+			if [[ "$start_after_test" != "" && $start_after_found -ne 1 ]]; then
 				echo $list | grep -q $start_after_test
 				if [[ $? -eq 0 ]]; then
 					start_after_found=1
@@ -278,7 +276,7 @@ _prepare_test_list()
 			done
 			group_all="$group_all $list"
 		done
-		if [[ $start_after && $start_after_found -ne 1 ]]; then
+		if [[ "$start_after_test" != "" && $start_after_found -ne 1 ]]; then
 			group_all=$(echo $group_all | sed -e 's|tests/||g')
 			echo "Start after test $start_after_test not found in any group specified."
 			echo "Be sure you specify a test present in one of your test run groups if using --start-after."
@@ -301,7 +299,7 @@ _prepare_test_list()
 		trim_test_list $list
 	done
 
-	if [[ $start_after ]]; then
+	if [[ "$start_after_test" != "" ]]; then
 		trim_start_after $start_after_test
 	fi
 
@@ -361,7 +359,10 @@ while [ $# -gt 0 ]; do
 		fi
 		;;
 	--start-after)
-		start_after=true
+		if $randomize; then
+			echo "Cannot specify -r and --start-after."
+			exit 1
+		fi
 		start_after_test="$2"
 		shift
 		;;

