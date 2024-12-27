Return-Path: <linux-fsdevel+bounces-38158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00DD9FD1C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 09:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522041883260
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B4214AD3D;
	Fri, 27 Dec 2024 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Iv9G5BRM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE95E2BAF7
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2024 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286553; cv=none; b=dD1PBst3MbP5ZjmC9U69jdBJF6LTEwgV0Hho6qMspJgA1lV87Y1LB4deq7MJv2ycSmi1UNb2DmYwdb/LptML5wSX0a/JKTEimnD55DJ3DkSOeX/NIICRky6G3XGfwZgOUjxlNn3a6m5ZJklJgSE72iID+RXcg7yM0byG6wOodC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286553; c=relaxed/simple;
	bh=lFksopVyuOEj81hezDSj1I5jxeXhwwC6b5ERCTyL6qo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=g5tV+SAiLQIkP5FJaoaATJXzhabmz8uY2LKUHDQRaDbc4zZz8TnaLgFrvNYN9DhL09SDthGbIovScM0ss3eZEo2/zjuqsMMTXSuuMFjmeY40anhuJp/DT2pr8VgBv0KVW4fSoR09lghhUgsP9Deg0m+9SG//OvxMmEFOzhEyFeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Iv9G5BRM; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1735286553; x=1766822553;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lFksopVyuOEj81hezDSj1I5jxeXhwwC6b5ERCTyL6qo=;
  b=Iv9G5BRMPhcqtGJGQP/4tsYfcRJOyYYdvOLtAJrPhzDD8QFwHxTnqh/o
   p8or3IIEHsziFJp8zgWicb2pmaiZBcsuZpCeb2QddtOr4f8kBCMEuPN/x
   xO5lo9+jb95APAOGD6SJTi4hzo2w8NVBgocPeUDhm+2NjHgt3j54FIGHV
   /0sfv2O1G76/87oKVUxUFBVZDGqmGpHGnmc73AjTvdD/Jr+4P3myHEu1G
   QZ3SY+fOwNcFSoP05yRWtR4sATOrxJE1xwR6NiykbTxO40HWfMTerq1bk
   /vlXoDwkqKdXkvnZ4SsOVtsc6LjRbJC+GBw0aOvQW3OO3t7uvXny8axzh
   w==;
X-CSE-ConnectionGUID: TrAhGx6pTyKAg2ejS3fZ8w==
X-CSE-MsgGUID: isvo2etUQC+V+ROhfXX7Mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="185088847"
X-IronPort-AV: E=Sophos;i="6.12,268,1728918000"; 
   d="scan'208";a="185088847"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 17:01:22 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id BD69D9E539
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2024 17:01:18 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 94F0DD5603
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2024 17:01:18 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 23FA66AB4F
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2024 17:01:18 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 926131A0003;
	Fri, 27 Dec 2024 16:01:17 +0800 (CST)
From: Ma Xinjian <maxj.fnst@fujitsu.com>
To: ltp@lists.linux.it,
	linux-fsdevel@vger.kernel.org
Subject: [issue] cgroup: fail to mount, if mount immediately after umount
Date: Fri, 27 Dec 2024 16:01:21 +0800
Message-ID: <20241227080121.69847-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28884.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28884.006
X-TMASE-Result: 10--4.072800-10.000000
X-TMASE-MatchedRID: K/VPzqYiD+aoXGwWsKbNNDzHAJTgtKqwBMdp5178zSNgPgeggVwCFlKC
	SV79Dbqw5/gG8CUYditvedD3CYSjHUjEB+CXKX8YsrikU3BgPV2vMPxisLn2/JUKAwcqU3TdBjE
	nKR+6jgDiPg9GiifbJvLsqSqP9dnTEciEU/z3/PVv+ggm5QAi4RhBgVDb4fBgHOUhijZNQhs86a
	y9NNiI8eLzNWBegCW2wgn7iDBesS3fd+P6wwCt85Rncg/kBNofgP7Hdkpmcdepmf67L86KHvuZW
	WEPhjzeuTzpLePz2FKXXb5S+odR3Cpk6eZexLeVMUD4u+EDKx7sN0QAMaCd6QjQSq2FeR7HqSnN
	hjPe4IOzRfzYWxYz6KVFNWIr45mF6dk8zgnUZCyT76aKysvrqA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Hi guys,

I ran the LTP case "cgroup cgroup_regression_test.sh" on Cento10,
and found that if mounting cgroup immediately after umount, it will report 
error "cgroup already mounted or mount point busy."

But this does not occur on old kernel(such as Centos9).
Could someone help take a look?

Reproduce Step:
```
# mkdir cgroup
# mount -t cgroup -o none,name=foo cgroup cgroup
# umount cgroup && mount -t cgroup -o none,name=foo cgroup cgroup
mount: /opt/ltp/tmpdir/cgroup: cgroup already mounted or mount point busy.
       dmesg(1) may have more information after failed mount system call.
```

LTP failed case:
```
Running tests.......                                                                                                                                                                                                                                                                                                          
<<<test_start>>>
tag=cgroup stime=1735584666
cmdline="cgroup_regression_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
cgroup_regression_test 1 TINFO: Running: cgroup_regression_test.sh 
cgroup_regression_test 1 TINFO: Tested kernel: Linux  6.11.0-0.rc5.23.el10.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Sep 23 04:19:12 EDT 2024 x86_64 GNU/Linux
cgroup_regression_test 1 TINFO: Using /tmp/ltp-q3TtUTWV42/LTP_cgroup_regression_test.68LuGosjOZ as tmpdir (xfs filesystem)
cgroup_regression_test 1 TINFO: timeout per run is 0h 5m 0s
cgroup_regression_test 1 TPASS: no kernel bug was found
mount: /tmp/ltp-q3TtUTWV42/LTP_cgroup_regression_test.68LuGosjOZ/cgroup: cgroup already mounted or mount point busy.
       dmesg(1) may have more information after failed mount system call.
cgroup_regression_test 2 TFAIL: Failed to mount cgroup filesystem
cgroup_regression_test 3 TCONF: CONFIG_SCHED_DEBUG is not enabled
cgroup_regression_test 4 TCONF: CONFIG_LOCKDEP is not enabled
cgroup_regression_test 5 TINFO: The '/tmp/ltp-q3TtUTWV42/LTP_cgroup_regression_test.68LuGosjOZ/cgroup' is not mounted, skipping umount
cgroup_regression_test 5 TPASS: no kernel bug was found
cgroup_regression_test 6 TPASS: no kernel bug was found
cgroup_regression_test 7 TPASS: no kernel bug was found for test 1
cgroup_regression_test 7 TCONF: skip rest of testing due possible oops triggered by reading /proc/sched_debug
cgroup_regression_test 7 TPASS: no kernel bug was found for test 2
cgroup_regression_test 8 TPASS: no kernel bug was found

Summary:
passed   6
failed   1
broken   0
skipped  3
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=62 termination_type=exited termination_id=1 corefile=no
cutime=4420 cstime=7914
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20240524-400-gec81cf213
```

Best regards
Ma

