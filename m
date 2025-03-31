Return-Path: <linux-fsdevel+bounces-45338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9597A765A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939373A9969
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 12:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2821E5209;
	Mon, 31 Mar 2025 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GGdN2Nda"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5954D1C5D7D;
	Mon, 31 Mar 2025 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423531; cv=none; b=s9/bmrKoR6Nd/kqYYKIx4JQzwT6Lbt7fwGimlDiLv04+KU6h+GKBC4mx2wC8Skk9WTs8Rt9NpXSOM0cCDJcviJw3oTz0sjK7nj35Dt9XX5XZv2MoCdU/MVcZa+pMWfixoGvfMusowI2GmDNMB8pquuCWp2w33suBg7lu6l8nn+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423531; c=relaxed/simple;
	bh=5YG77Ajfhyd6WQ2BkLEgeYJTHDqsxX4qxnsyIMDg1Og=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GY12MakjmRnirv70hcO+zvEyFN+qqTL1s4XT6j1R+0kHQ4HBes5aa3nZ4uDCWwNqwv2cLvSBvcyX+2Q7S7D/3W8cjbvrOE+Pl49rkGYeF4NwaD7KQMhW7/G6fBm9bcIIYiTKYXfW/JA+Of36cH1aR9DGPijbJ0Pz2NoVqx0Lwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GGdN2Nda; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=aYtcRKckV4dYri6hjuncAWA3kwTSWA5xveNInpzPVYo=; b=GGdN2NdaYkI1rFjSVVrEb7O7gx
	+8uhPYYFVsNEEXfcfaIN+czBiAme2Zn/Rdk1FIATN4r8SHccGKTG5/0nHdcBToT0V1l+oFdPOgxUv
	I5VPIPRviLgzcEXae7kJk3AKoUsMXT0axXAHfTZkwru1VeG9ZLOwMj6SbRJyxfp8XBARwjVil6PZw
	qEdQIk9F8wVM3G0L31F4+WBvnzP5rZfmNNElRfos62OULNvf3rI/Baqr9n5K7VE3/TqSb0CWaRYEZ
	RqjTXR0+CdULxZpFPuBpBcHIgQLYCliGRKjkVXvtriS+bnQdaXo5fE56AneavjgJspMaDmaQ4+X5Y
	okpQr0eg==;
Received: from [223.233.69.2] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tzE69-009Btr-Ma; Mon, 31 Mar 2025 14:18:38 +0200
From: Bhupesh <bhupesh@igalia.com>
To: akpm@linux-foundation.org
Cc: bhupesh@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	oliver.sang@intel.com,
	lkp@intel.com,
	laoar.shao@gmail.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com,
	andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl,
	peterz@infradead.org,
	willy@infradead.org,
	david@redhat.com,
	viro@zeniv.linux.org.uk,
	keescook@chromium.org,
	ebiederm@xmission.com,
	brauner@kernel.org,
	jack@suse.cz,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Subject: [PATCH v2 0/3] Dynamically allocate memory to store task's full name
Date: Mon, 31 Mar 2025 17:48:17 +0530
Message-Id: <20250331121820.455916-1-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
================
- v1 can be seen here: https://lore.kernel.org/lkml/20250314052715.610377-1-bhupesh@igalia.com/
- As suggested by Kees, added [PATCH 3/3] to have a consistent
  'full_name' entry inside 'task_struct' which both tasks and
  kthreads can use.
- Fixed the commit message to indicate that the existing ABI
  '/proc/$pid/task/$tid/comm' remains untouched and a parallel
  '/proc/$pid/task/$tid/full_name' ABI for new (interested) users.

While working with user-space debugging tools which work especially
on linux gaming platforms, I found that the task name is truncated due
to the limitation of TASK_COMM_LEN.

Now, during debug tracing, seeing truncated names is not very useful,
especially on gaming platforms where the number of tasks running can
be very high.

This patch does not touch 'TASK_COMM_LEN' at all, i.e.
'TASK_COMM_LEN' and the 16-byte design remains untouched. Which means
that all the legacy / existing ABI, continue to work as before using
'/proc/$pid/task/$tid/comm'.

This patch only adds a parallel, dynamically-allocated
'task->full_name' which can be used by interested users
via '/proc/$pid/task/$tid/full_name'.

After this change, gdb is able to show full name of the task, using a
simple app which generates threads with long names [see 1]:
  # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" > log
  # cat log

  NameThatIsTooLongForComm[4662]

[1]. https://github.com/lostgoat/tasknames

Bhupesh (3):
  exec: Dynamically allocate memory to store task's full name
  fs/proc: Pass 'task->full_name' via 'proc_task_name()'
  kthread: Use 'task_struct->full_name' to store kthread's full name

 fs/exec.c             | 21 ++++++++++++++++++---
 fs/proc/array.c       |  2 +-
 include/linux/sched.h |  9 +++++++++
 kernel/kthread.c      |  9 +++------
 4 files changed, 31 insertions(+), 10 deletions(-)

-- 
2.38.1


