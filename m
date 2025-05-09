Return-Path: <linux-fsdevel+bounces-48589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8691DAB1403
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4631BC49F0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333AB29209F;
	Fri,  9 May 2025 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DimXxpcf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE3C290DA1;
	Fri,  9 May 2025 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795306; cv=none; b=myKgREclvvnouwGRfb81SdOKk7oOkIn2qS/K3Us8VVkCffu/475c8CoKr/65viw7PHRI0nZ+634TawXqLIi4QBNltKiE0lA01C+p99xahoq1Qlo7Djg/TmhkOvoJcF+6mY4rHDyNhGmkdqy7CBL1JT531CLVCQ+iAIiP41k1Q6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795306; c=relaxed/simple;
	bh=c3c94OjA1q5qb8EGSYnHVBVy8iOw9HUdPL9oEFYfxLk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jWRrFYex4iLboGjQKE+BTxDHzX8A1LYIMDmQ+NpYLYv9Xi9+iRKZqpIozh69p7nWL/ZVK8qfv/U4ms2z94pHA7grrM5p5cXhTFpJQYVUr0bEClayoDsdFsALZ+Y8Ed/EGj5CkNgoUlxEU7opaVzVv188Ix25r0Fo/s4ONKUQ/FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DimXxpcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC6E0C4CEEB;
	Fri,  9 May 2025 12:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746795305;
	bh=c3c94OjA1q5qb8EGSYnHVBVy8iOw9HUdPL9oEFYfxLk=;
	h=From:Subject:Date:To:Cc:From;
	b=DimXxpcfw4ebKQKH7DiK6f8PW/85zKA5OAFMbEXfxOrhT0N20cI4VMF5gYPrckgiU
	 F7rXr8UXkQwhA81+Aj1F6DhsPHy3xi0bQoho7o4uFaBrof6zFimYIV+Pvg/9KSFriQ
	 Vln4fCLIj70oiahJ7qOxo9+5Me4NpybqeRxX9Yz9bhzRhjOtGiKPsuXO5kygpU0RuW
	 9VXrlGN/WOzNTqjoSB7/h8d3vsVOWF1NMa7BAr+7G4U03ZkNyEFZcF+k7wtLdW2uVu
	 dBf5mLXoYU41w2aADbw5csR/3VdK6kbIvay2kxYMvuY14x9NQyrGCFbb5qt8Z/Pvga
	 +7Do9GVd7Wj5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C9DC3ABBC;
	Fri,  9 May 2025 12:55:05 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Subject: [PATCH 00/12] sysctl: Move sysctls to their respective subsystems
 (second batch)
Date: Fri, 09 May 2025 14:54:04 +0200
Message-Id: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO36HWgC/x3M3QpAQBBA4VfRXNtaI7ReRdJYg5G/djcpeXeby
 +/inAc8O2EPdfKA40u8HHtEliZgZ9onVjJEA2osdKGNWmhS29XZsAbqV/adBHaoDGVVSTmiNQP
 E+HQ8yv2Pm/Z9Pxv//uxoAAAA
X-Change-ID: 20250509-jag-mv_ctltables_iter2-9a176a322c9d
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Waiman Long <longman@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joel@joelfernandes.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 linux-parisc@vger.kernel.org, linux-serial@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4502;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=c3c94OjA1q5qb8EGSYnHVBVy8iOw9HUdPL9oEFYfxLk=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGgd+xMW7Hzi52CWL9iWR+Z70SJ7b24h1VVTE
 9+RcZ6N+tkWRYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJoHfsTAAoJELqXzVK3
 lkFP/6IL/jqzfrkpLBdybK4gjSc6ouWp4ieAHXYsQp1S7DOTMfmtKoA3WGZiaS/e09VycqVxmV7
 QL7bIphe5aOAGsKRfnzXH/Hw7gCvdsJ7wIDxjbXyoEZUvdZyAOe8ZXj/dvFWk1mTifku+SVY/tF
 0nAq1rIlLyFh8p7/3PU7knC9Chtj+lelUov03LWHsB7O1+aFpCDy2GRqkhDAeuYFPdE/iQes9mw
 2NJXuX6auIitRw64qZDDYLrbz2ZhcXKmYkc1m5h4tcIdJPhMOcI5jBaz+xT709w9P0ojGopy/I4
 iRU6Cpv3crKjS07AYXf0mSucoF//u0OalGFPsTMJkN5usP8JcRovnwFrPa+cLE8uC09Z+WXtXIV
 InsEjNTX8XjAZFZ07Z3Im0b4DJaT8bb0HUN1qHPR/smJbhD5qy6XjyWAZ6v1GgsYF1No+2YtLVm
 74Y6dZPLQqguGo8y7ok+l1LnUwN3yTYUlKz8oHZs4bVH3wIwcgGgmSjJ/E8AWrV+umAJ97WKW55
 TI=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

This series relocates sysctl tables from kern_table to their respective
subsystems. It is mostly moves to core kernel subsystems but also
includes mm/memory.c and 2 drivers (parisc and tty). With this series we
are left with 8 ctl_tables out of the original 50 that existed within
the kern_table array. With all this activity in kernel/sysctl.c, I took
the liberty of removing unneeded include headers as well as outdated
changelog comments.

By decentralizing sysctl registrations, subsystem maintainers regain
control over their sysctl interfaces, improving maintainability and
reducing the likelihood of merge conflicts. All this is made possible by
the work done to reduce the ctl_table memory footprint in commit
d7a76ec87195 ("sysctl: Remove check for sentinel element in ctl_table
arrays").

A few comments on the process:
1. If you see that the change is good and want to push it through a tree
   different than sysctl, please tell me so I can remove it from this
   series and try to avoid conflicts in linux-next.
2. Apologies if you have received this in error. Please tell me if you
   want to be removed from recipient list and note that it is difficult
   to actually know who is interested in these "treewide" changes.

Testing done by running sysctl selftests on x86_64 and 0-day.

You can find the first batch here [1], if you are curious.

Comments are greatly appreciated

[1] https://lore.kernel.org/20250313-jag-mv_ctltables-v3-0-91f3bb434d27@kernel.org

To: Luis Chamberlain <mcgrof@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
To: Sami Tolvanen <samitolvanen@google.com>
To: Daniel Gomez <da.gomez@samsung.com>
To: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Will Deacon <will@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <longman@redhat.com>
To: Paul E. McKenney <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
To: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
To: Josh Triplett <josh@joshtriplett.org>
To: Uladzislau Rezki <urezki@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
To: Zqiang <qiang.zhang1211@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
To: Helge Deller <deller@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: rcu@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-serial@vger.kernel.org

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
Joel Granados (12):
      module: Move modprobe_path and modules_disabled ctl_tables into the module subsys
      locking/rtmutex: Move max_lock_depth into rtmutex.c
      rcu: Move rcu_stall related sysctls into rcu/tree_stall.h
      mm: move randomize_va_space into memory.c
      parisc/power: Move soft-power into power.c
      fork: mv threads-max into kernel/fork.c
      Input: sysrq: mv sysrq into drivers/tty/sysrq.c
      sysctl: Move tainted ctl_table into kernel/panic.c
      sysctl: move cad_pid into kernel/pid.c
      sysctl: Move sysctl_panic_on_stackoverflow to kernel/panic.c
      sysctl: Remove (very) old file changelog
      sysctl: Remove superfluous includes from kernel/sysctl.c

 drivers/parisc/power.c       |  20 +++-
 drivers/tty/sysrq.c          |  38 +++++++
 include/linux/kmod.h         |   1 -
 include/linux/panic.h        |   2 -
 include/linux/rtmutex.h      |   2 -
 include/linux/sysctl.h       |   4 -
 kernel/fork.c                |  20 +++-
 kernel/locking/rtmutex.c     |  23 +++++
 kernel/locking/rtmutex_api.c |   5 -
 kernel/module/kmod.c         |  32 +++++-
 kernel/panic.c               |  60 +++++++++++
 kernel/pid.c                 |  32 ++++++
 kernel/rcu/tree_stall.h      |  33 +++++-
 kernel/sysctl.c              | 233 -------------------------------------------
 mm/memory.c                  |  18 ++++
 15 files changed, 271 insertions(+), 252 deletions(-)
---
base-commit: 7a94ff386a4a0d9322c56c0e998dd20468d869b1
change-id: 20250509-jag-mv_ctltables_iter2-9a176a322c9d

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



