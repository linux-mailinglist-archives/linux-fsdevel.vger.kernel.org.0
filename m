Return-Path: <linux-fsdevel+bounces-63961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3E2BD3303
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 15:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3CDF434AE1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 13:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0700F306B1C;
	Mon, 13 Oct 2025 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mteMyMk8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577A52FF642;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361946; cv=none; b=SiGmt4nBN83i76h1F/OBmqH3mKcIzDzc/cXW5iZs10wtz/L7cK4ES/Z2OIyW8aCX7DVWmyXz/cQa/rG9I1YemYAxFsUpLKUNxg2KJPfkcxPFFlHXIbfUD5ea9nez2AZCW08SEG64Opxfdst5HXtzuXwR+mcZn6kdA685ZEPnJTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361946; c=relaxed/simple;
	bh=EQftlmgTvzftJHVOqEL+YlrIiJf4J+wLDyJnZMuRg8I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TT1TM4R/+bSDS1OC8SIdNdTHEap7J6GwgoR2lteO1/maDAyscizkQdgSz8MWwdeP5WYDaQJrfSZD7BpOm4ZOAsVSrQvQop0VCImR18iR8ilJvZbRiEAw1MdDPn3LAKm0+USPPEA2hxiSQ1oukZKTO1fL/4aPfACn+yvvKXnH8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mteMyMk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7EE1C4CEE7;
	Mon, 13 Oct 2025 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760361945;
	bh=EQftlmgTvzftJHVOqEL+YlrIiJf4J+wLDyJnZMuRg8I=;
	h=From:Subject:Date:To:Cc:From;
	b=mteMyMk8qWT5OiterxVW2HPlzi45EIazwm0+YwQgglBxgsr7vkaBS33k0Y2brfRm0
	 8bS8XPE+Q/VEeefmEf0l+o4q3C+FdJ5NbY71Y2FKwK9pQVd+6c0qccyLh8D2PPKEaJ
	 Qof+6bXiSFIsx93Zi3pvURSeSIuTwmr2VTuZFpmZmIMzKnWm1/BA5ZPKCvfdSPT4Ih
	 NMYMgDM5ppzaSsPzW6sQmjxJn/NUsHd2OpFLEVjjzb3DWV39bOZckydJOYupRXMmGX
	 5RYEi3UyTgKnj7Ewsa8328dzeTdaIKv2vzmMqJ+nVSZ3V+yWtJyCR9RsVp3RGA940B
	 UkdkPxRP5yGjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D407BCCD18E;
	Mon, 13 Oct 2025 13:25:45 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Subject: [PATCH 0/8] sysctl: Generalize proc handler converter creation
Date: Mon, 13 Oct 2025 15:24:50 +0200
Message-Id: <20251013-jag-sysctl_conv-v1-0-4dc35ceae733@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKL97GgC/x3MQQqAIBBA0avErBNUkqKrRITYWBOh4UQU0t2Tl
 m/xfwbGRMjQVxkSXsQUQ4GqK3CrDQsKmotBS22UVFpsdhH8sDv3ycVwCdPKrmm88bP1UKojoaf
 7Pw7j+36lopEFYQAAAA==
X-Change-ID: 20251012-jag-sysctl_conv-570844f5fdaf
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3177;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=EQftlmgTvzftJHVOqEL+YlrIiJf4J+wLDyJnZMuRg8I=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjs/bfHX8L8LqWeSVVbJjkR/ozj7Zgcsrvnr
 r/D2BQO5rfcsYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo7P23AAoJELqXzVK3
 lkFPM+AL/3wbIXJF4mMOzfCjRJdeSYvamDvfRCzOMIYRKj10o/QVWNQYxkhpZJqqjrFFSOsf8On
 tDKgr5mkDsfJm5h1tXXa9Jsey+5NWBdOKVofjLX3huiYpKFdFPaJqO26MycOryEE9SVNE4dX2jq
 S4iZZF76eJbX7Odhc/c/rOyLHuNryc/1YAtaQCYoa01D0vO/OB+roomOkWhzoJ0kShNXJ6p5/Ml
 kKds3eIbPF5pd1+wySmlyjV6g+MTCKPGp7fBwAZW5Ulx1LMp8jBCHYAy8UhenQRWoDWj0IIhK4J
 djFPf4mL42o2yW7MgsarrX4ZMmdiW4rOk2P3c8VolFgmCPfuGpd6SNtePVlVIL26ZQKd1GtrWkA
 C2Nnn8ctQdte0LAhJfxieKjZSBcDIoGkSkzTjgY81OuM+mAJObo8XfeC7/aq6wmnCkl68nrAMo9
 oOMjkrPdoyMdlfKKLpOPxMVAfHGFUN2gkqOInxYzyBCclqitff2llmS4hxzrnu6emCO/+EVKDa7
 Wc=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Implement new converter generation macros this removes repeated logic
and preps the proc handler converter infrastructure for exposure to the
greater kernel. Macros will be exposed in a later series in such a way
that they can be used in the jiffie proc handlers (you can see an
example of how this might look here [1]) and in the proc_dopipe_max_size.

What is done?
=============

Three macros (SYSCTL_{KERN_TO_USER,USER_TO_KERN,INT_CONV_CUSTOM}) are
created. SYSCTL_INT_CONV_CUSTOM creates a bi-directional (meaning that
it handles both user to kernel and kernel to user writes) converter that
optionally implements a range checker for when kernel memory is written.
SYSCTL_KERN_TO_USER is a uni-directional converter that writes to a user
buffer avoiding tears with READ_ONCE and setting the negp variable
appropriately; it generates functions that do not fail.
SYSCTL_USER_TO_KERN is a uni-directional converter that writes to a
kernel buffer, checks for integer overflow and avoids tears by using
with WRITE_ONCE; it returns -EINVAL when an overflow is detected.

For now these macros produce static functions that are used from within
kernel/sysctl.c but the idea is to move them to include/kernel/sysctl.h
so they can be used to create custom converters.

Why it is done?
===============

This is a prep series to get jiffies out of kernel/sysctl.c which had
become a dumping ground for a considerable number ctl_tables.

kernel/sysctl.c had become a dumping ground for a considerable amount of
ctl_tables. Though this trend was corrected in the commits leading to
73184c8e4ff4 ("sysctl: rename kern_table -> sysctl_subsys_table"), some
non-sysctl logic still remained in the form of the jiffies converters.
This series does not move the jiffie logic out, but it sets things up so
it can eventually be evicted from kernel/sysctl.c.

Testing
=======

* I ran this through the sysctl selftests and sysctl kunit tests on an
  x86_64 arch
* This also goes through the sysctl-testing 0-day CI infra.

Any comments are greatly appreciated

[1] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git/log/?h=jag/sysctl_jiffies

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
Joel Granados (8):
      sysctl: Replace void pointer with const pointer to ctl_table
      sysctl: Remove superfluous tbl_data param from "dovec" functions
      sysctl: Remove superfluous __do_proc_* indirection
      sysctl: Indicate the direction of operation with macro names
      sysctl: Discriminate between kernel and user converter params
      sysctl: Create converter functions with two new macros
      sysctl: Create integer converters with one macro
      sysctl: Add optional range checking to SYSCTL_INT_CONV_CUSTOM

 fs/pipe.c              |   6 +-
 include/linux/sysctl.h |   5 +-
 kernel/sysctl.c        | 648 ++++++++++++++++++++-----------------------------
 3 files changed, 269 insertions(+), 390 deletions(-)
---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20251012-jag-sysctl_conv-570844f5fdaf

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



