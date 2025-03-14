Return-Path: <linux-fsdevel+bounces-43998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA372A60848
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 06:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E649E19C1D52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 05:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F0D145B3E;
	Fri, 14 Mar 2025 05:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RwvylZvw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B05C84A35;
	Fri, 14 Mar 2025 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741930064; cv=none; b=P5R7fMYi2XSRIq6k7cprrN/TEFJN7IDjjPwT2/1vShD/sVqTKV0DcA1UpJt2kEs7k1I3S+NEs1q5P6UxkeMmEuLZTtazMWVmGqtSyJZD03TupaFEgf26cMkdtC2Z4wtcncofa12EvjHKry7ZpkGbdHX+dJDdhpz6yGC0ng9yheI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741930064; c=relaxed/simple;
	bh=9H+50duVwBYTkpJlWh1d37TQqOH12/nsxscTKEHf88E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SiawEN66nVoUUx37WEaC8hbyg2ioTtFqHCMxLrC8qnoeAM5TgIU9Prjwfnrk73gYfrST/IRouWoAx9xJ1LHM6QJJymRhJrbN7bdPoMn3hH0VFtsOXB14hJ7grc5RPS/Kald6oi9dcnqpKgG4S4c3h8Bp54f84S+1MNIH9wRi5mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RwvylZvw; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ub0rLInAZOn0cTAgGmjvriynN2G3FgC62TIsmUrmL5s=; b=RwvylZvwIAqSKG+GQgAT35f45Q
	dJn7abVxmrizfLE8/P/YMJjAEsxB2b0dP9cXGMWXcFg0j3Y7uwGngzJeQE9JRbwRsd2cGONz22Jsx
	xuIURhy/Iw3QjK3tuRlaNKHYi7Hg5U0UBQluOwCztsQZaQ4MQ+rqyarjN3dMPAtcqzX4HsVY2atHu
	VXA4ADwSLQOdln0hfPrhpYC/5S4w/yOz0/YWCQS2yQP2xEmK9JGqZEkmzmH4DFUsxHAerJhfKVeui
	o8RsnOZraeeLuLcHgLI6JVbnNHXUsJ5hBvq1ST2YzVpTJ3ZtnikagvbQmntq7pwmUJ3P5aKlRxXAe
	0zFJxywg==;
Received: from [223.233.77.29] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tsxZr-008TWs-PU; Fri, 14 Mar 2025 06:27:29 +0100
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
Subject: [PATCH RFC 0/2] Dynamically allocate memory to store task's full name
Date: Fri, 14 Mar 2025 10:57:13 +0530
Message-Id: <20250314052715.610377-1-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working with user-space debugging tools which work especially
on linux gaming platforms, I found that the task name is truncated due
to the limitation of TASK_COMM_LEN.

For example, currently running 'ps', the task->comm value of a long
task name is truncated due to the limitation of TASK_COMM_LEN.
    create_very_lon

This leads to the names passed from userland via pthread_setname_np()
being truncated.

Now, during debug tracing, seeing truncated names is not very useful,
especially on gaming platforms where the number of tasks running can
be very hight.

For example for debug applications invoking 'pthread_getname_np()'
to debug task names.

This RFC aims to start a conversation and improve the initial RFC
patchset to avoid such buffer overflows by introducing a new
dynamically allocated pointer to store task's full name, which
shouldn't introduce too much overhead as it is in the non-critical
path.

After this change, the full name of these (otherwise truncated) tasks
will be shown in 'ps'. For example:
    create_very_long_name_user_space_script.sh

Bhupesh (2):
  exec: Dynamically allocate memory to store task's full name
  fs/proc: Pass 'task->full_name' via 'proc_task_name()'

 fs/exec.c             | 21 ++++++++++++++++++---
 fs/proc/array.c       |  2 +-
 include/linux/sched.h |  9 +++++++++
 3 files changed, 28 insertions(+), 4 deletions(-)

-- 
2.38.1


