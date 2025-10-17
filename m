Return-Path: <linux-fsdevel+bounces-64420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7D6BE7337
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895D45E4992
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 08:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A6D2BEC41;
	Fri, 17 Oct 2025 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIudQB0K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4227E29A31D;
	Fri, 17 Oct 2025 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689990; cv=none; b=CNIB3orZ87KspuMEQbaR3vevhlYY/NpLhiyhQ3o2NdfUypSAdFRQfw2Gkkwkiu+cLH2lE5zDHRcNUO+aAm0KbXLTijnBvvY8GB49YaJS77B4fQ3RMwTeectbqPwmT02fOIhaOJ4FNNqeFbwTuToIKgf/ESgP5udwnsczpZrOrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689990; c=relaxed/simple;
	bh=ALPubsE7iL0y6ckYIsK2z8DnJSwyHG1uWAH3bkMSxcA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IVZei5B64XYcHDsPx8sP3tS3zc+VWFa835Vg7UNGGSLIEtVOpmhTzUPx9eRT0tmZchyGmT9ycaLxRNxuVdMj0qYYiSv6RkSkqd4vxVbWYpfcb4lHNGsVmpyROFXCY5YMvyasIjMgNdl6y+lowYrVfNkuWV2ICnJnPdgRf/2eyS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIudQB0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99387C4CEE7;
	Fri, 17 Oct 2025 08:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760689989;
	bh=ALPubsE7iL0y6ckYIsK2z8DnJSwyHG1uWAH3bkMSxcA=;
	h=From:Subject:Date:To:Cc:From;
	b=WIudQB0K5PljL/kCwIvm9XF3aQMCt2I0xeG09dcX4x5ymat1gtvytAiuzXVkmGerB
	 f9r2ygpHUBY3Wje4znVH5THu6nz4Ak8M4flIaJWtPt4cPfSiNf3mHPaFjOAmjI/shR
	 MnzvvE74KJo4eoFnusTkgmK/qi961O6syPZpSp/QfqsSuCwOf/zzDEyiMAVMGOAyQR
	 P0SCNIGIFsm0YYbAFVv2mq31G85lcJot9KBgRoMwuqMI57xVVylbetjSbhq61Hn6dt
	 zMGdDTCUfd2hL6Ah8hWqY7atAJd9OHwAI70KtU5wdmmob11JrQAfLNGRwxj8gi0j5a
	 WykninJLFx8ww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB8ECCD19A;
	Fri, 17 Oct 2025 08:33:09 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Subject: [PATCH 0/7] sysctl: Move jiffies converters out of kernel/sysctl.c
Date: Fri, 17 Oct 2025 10:32:10 +0200
Message-Id: <20251017-jag-sysctl_jiffies-v1-0-175d81dfdf82@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAr/8WgC/x2M0QpAQBAAf0X77MrJEb8iibPLSuhWIvl3m8dpm
 nlAMDAKVNEDAU8W3lYFG0fgp24d0fCgDGmSOpvYzMzdaOQWfyztzETamoJUOKSydzlouAckvv5
 p3bzvB7mTV4xkAAAA
X-Change-ID: 20251014-jag-sysctl_jiffies-7f0145ef9b56
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2447;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=ALPubsE7iL0y6ckYIsK2z8DnJSwyHG1uWAH3bkMSxcA=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjx/zMz6r0/GrkigbyDYiU3B7C56XjyMs54l
 W5ZjFYJ9dlr5IkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo8f8zAAoJELqXzVK3
 lkFPYB0L/AitYQV44fDBP/FpA+Cme8q1tS7K8z482NOTlJAE0ZWj5gNCdtqcK4fVlZWe0+GrgKp
 4pYvnzaU7HuJ8i1kyHCwEEC4OO31OuCm6S78wLP5Cr33mfYSe/vbPIHEHZoGgf5fFDlTjHHQzHm
 tcvuuZGFb1J9W6jGizn6AvzR1dMKFc7p7qblDL1jcwzaUREvsbNsJ3SgN0yyiNWbvoqPH1Vp/c2
 VktCzVhqeUue0fSkNTeQyCBIVmKWuSQBFdAarbbqDmvX4t7LWQkGv7F2pBtGRlKQyYHtMCrTsRA
 cOFdVPZVQCnrXAnYP91OpOc4A0UlYIpG/64HKtbJcij0RuezfBRGLL/I/u7KQnDyGGOd9LBghWG
 zYoU+FmML952xC7pJ1AZbxrPXe4AiNf7zRHP++eC6JVtxQ9/CrlKYXVJzbwMGarWqby32x04jCr
 QHtxcitHVHoGTgfvD2jS99GFC2jsPOAdUt28i1Rfqp+YrYUTiC43iyEhbd5jRJTC68qybT6Fmn7
 UQ=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move the jiffies converters into kernel/time/jiffies.c and replace the
pipe-max-size proc_handler converter with a macro based version. This is
all part of the effort to relocate non-sysctl logic out of
kernel/sysctl.c into more relevant subsystems. And is based on the
preparation series in [1].

What was done?
==============

* Moved converter macros (SYSCTL_USER_TO_KERN{,_INT_CONV,UINT_CONV},
  SYSCTL_KERN_TO_USER{,INT_CONV} & SYSCTL_{,U}INT_CONV_CUSTOM) to
  sysctl.h so they can be used in jiffies.c and pipe.c.

* Moved jiffie converters (proc_dointvec_ms_jiffies{,_minmax},
  proc_dointvec{_,_userhz_}jiffies & proc_doulongvec_ms_jiffies_minmax)
  to kernel/time/jiffies.c.

* Replaced do_proc_dopipe_max_size_conv in fs/pipe.c with a macro
  version; no functional changes intended.

Why it is done?
===============

Motivation is to move non-sysctl logic out of kernel/sysctl.c which had
become a dumping ground for ctl_tables until this trend was changed by
the commits leading to (and including) 73184c8e4ff4 ("sysctl: rename
kern_table -> sysctl_subsys_table"). Same motivation as in [1].

Testing
=======

Tested by running sysctl kunit tests and selftests on x86_64 architecture
to ensure no functional regressions.

Comments are greatly appreciated

Best

[1] https://lore.kernel.org/20251016-jag-sysctl_conv-v2-0-a2f16529acc4@kernel.org

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
Joel Granados (7):
      sysctl: Allow custom converters from outside sysctl
      sysctl: Move INT converter macros to sysctl header
      sysctl: Move UINT converter macros to sysctl header
      sysctl: Move jiffies converters to kernel/time/jiffies.c
      sysctl: Move proc_doulongvec_ms_jiffies_minmax to kernel/time/jiffies.c
      sysctl: Create pipe-max-size converter using sysctl UINT macros
      sysctl: Wrap do_proc_douintvec with the public function proc_douintvec_conv

 fs/pipe.c               |  28 ++---
 include/linux/jiffies.h |  11 ++
 include/linux/sysctl.h  | 145 +++++++++++++++++++---
 kernel/sysctl.c         | 312 +++++++-----------------------------------------
 kernel/time/jiffies.c   | 125 +++++++++++++++++++
 5 files changed, 314 insertions(+), 307 deletions(-)
---
base-commit: 130e5390ba572bffa687f32ed212dac1105b654a
change-id: 20251014-jag-sysctl_jiffies-7f0145ef9b56

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



