Return-Path: <linux-fsdevel+bounces-48598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 184CFAB141C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4255236D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709DC293721;
	Fri,  9 May 2025 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2gnI2ZJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABB92918F0;
	Fri,  9 May 2025 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795307; cv=none; b=ZQ59KqPOrkSt/NErBdW0z/5pAq47pSy0k/MxLZ/ESrQHvIAyraCfxrM03dAVALSIqIyLUmu6qp+Tw1ufQeWQSkWaxxQT0PoIAgxgbGc8XFwY8e8kcSMgvdV2KY3OJ69gw1W7HXOzHEsnHDX1BZF3jtEEsSVreV5U6MDbf40AJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795307; c=relaxed/simple;
	bh=9rUI733v52tyD4qD/w5fv4MFvpEqPz2boNwanOapOa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ED19uSIKHLhn3uZ4kdxo+EB6J49yqrfQRJfdTmx7ZBpqJJJH1uNi3TaZK9f9An2cKwokWIkJeWJHr183ViyI7mk4WBbyFTVfyeWwdO6BxjrLxvppSZyLeiZLxaNyOK3+bAJ7vcmTLcoJpvvvRfMxhL8+yz6dHZ6p3cP5bw6HHjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2gnI2ZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69714C4CEF3;
	Fri,  9 May 2025 12:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746795306;
	bh=9rUI733v52tyD4qD/w5fv4MFvpEqPz2boNwanOapOa0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a2gnI2ZJQZbb9jNAm2UICyM4UeiBulsb1SLjv9+QiXAsZAhPIIOaClx3sCZEs6vyK
	 7GmfUMqUbqfp9FEbJ1P8skw1q3Kz5V25wbQM4wdMOFkNWXexqzrDjH0ryjP/wjcvfz
	 T1aROfRgK1I/NkbhdhxN9PKUdrEpjCb9t8NAr+DH/C3lKFz5twJsYZso5K2wO6j+w4
	 DE651QxGkwT8ilBPqmfELA9nJOBGNZbJ7G8HAa5PBIISXDrFExmVT+p5z9EFNhBexA
	 aGnjoRfsTo1fxoRkJAXN01w2ERMQ83cZRDdy3DriWWb580GRTVxYiZW5tPfND/dXRn
	 hBPaHXPG11wGA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C66CC3ABCE;
	Fri,  9 May 2025 12:55:06 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 09 May 2025 14:54:16 +0200
Subject: [PATCH 12/12] sysctl: Remove superfluous includes from
 kernel/sysctl.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-jag-mv_ctltables_iter2-v1-12-d0ad83f5f4c3@kernel.org>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2583;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=9rUI733v52tyD4qD/w5fv4MFvpEqPz2boNwanOapOa0=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGgd+ydY223rqSHwB4C1mckkQQi7bRKrIQfLI
 rtDBZEL1cuGSIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJoHfsnAAoJELqXzVK3
 lkFPmBsL/2553g/JX/UeMa5y5SOfFJmDPzhUtapo/71UW/5OdLFx2JZskrl0SbCOFUfjTwu4mJp
 c5jTGK5aw/Hb2/PyQveQBCyfhdq5TjMC2c/rpw3Ryp3BEvjdyPp+PvWY0YuLlMjnTkir8oNYX3C
 Pym1ifCJS+k178tPjpVMvnew9QomUmd8TgWhBcYOsiSyCUY/x93rKSyWwFlrnOCaiXRn6YsDkCk
 97/85cO2uaUxkz3Ayi+CHOmlQYwuPT0jl3MgjN98SBFJ4mdks2b3s7bAMGuIU3I75iKBwVLdScp
 UbjEiSSeFUvKyiro5Bx8RJadVmBgGivzJApqMmJc41WKE9paV61DlIYT/41oniS6v/z+R82BSQH
 4AGsd1bvzVsIHiBLKIMfcs+rMhnhCCqzpn8ATz82I+SRZaUGTho21sMU4jBU/wSwW41PjOP4tMB
 UzYzCRVa4WwLsWhHJiReLrqNzM+hUw93Y1QlQ3MwcIFI78jxVYsb2Va5Hghv4fzkbhaabqEClB7
 Us=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Remove the following headers from the include list in sysctl.c.

* These are removed as the related variables are no longer there.
  ===================   ====================
  Include               Related Var
  ===================   ====================
  linux/kmod.h          usermodehelper
  asm/nmi.h             nmi_watchdoc_enabled
  asm/io.h              io_delay_type
  linux/pid.h           pid_max_{,min,max}
  linux/sched/sysctl.h  sysctl_{sched_*,numa_*,timer_*}
  linux/mount.h         sysctl_mount_max
  linux/reboot.h        poweroff_cmd
  linux/ratelimit.h     {,printk_}ratelimit_state
  linux/printk.h        kptr_restrict
  linux/security.h      CONFIG_SECURITY_CAPABILITIES
  linux/net.h           net_table
  linux/key.h           key_sysctls
  linux/nvs_fs.h        acpi_video_flags
  linux/acpi.h          acpi_video_flags
  linux/fs.h            proc_nr_files

* These are no longer needed as intermediate includes
  ==============
  Include
  ==============
  linux/filter.h
  linux/binfmts.h

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index dee9a818a9bbc8b1ecd17b8ac1ae533ce15c2029..0716c7df7243dc38f0a49c7cae78651c3f75f5a3 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -5,44 +5,24 @@
 
 #include <linux/sysctl.h>
 #include <linux/bitmap.h>
-#include <linux/printk.h>
 #include <linux/proc_fs.h>
-#include <linux/security.h>
 #include <linux/ctype.h>
-#include <linux/filter.h>
-#include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/kobject.h>
-#include <linux/net.h>
 #include <linux/highuid.h>
 #include <linux/writeback.h>
-#include <linux/ratelimit.h>
 #include <linux/initrd.h>
-#include <linux/key.h>
 #include <linux/times.h>
 #include <linux/limits.h>
 #include <linux/syscalls.h>
-#include <linux/nfs_fs.h>
-#include <linux/acpi.h>
-#include <linux/reboot.h>
-#include <linux/kmod.h>
 #include <linux/capability.h>
-#include <linux/binfmts.h>
-#include <linux/sched/sysctl.h>
-#include <linux/mount.h>
-#include <linux/pid.h>
 
 #include "../lib/kstrtox.h"
 
 #include <linux/uaccess.h>
 #include <asm/processor.h>
 
-#ifdef CONFIG_X86
-#include <asm/nmi.h>
-#include <asm/io.h>
-#endif
-
 /* shared constants to be used in various sysctls */
 const int sysctl_vals[] = { 0, 1, 2, 3, 4, 100, 200, 1000, 3000, INT_MAX, 65535, -1 };
 EXPORT_SYMBOL(sysctl_vals);

-- 
2.47.2



