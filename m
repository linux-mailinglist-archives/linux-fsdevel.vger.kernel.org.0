Return-Path: <linux-fsdevel+bounces-41970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57975A397D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 10:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D24188DFAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 09:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145A5236A6B;
	Tue, 18 Feb 2025 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMgR7bo0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFDA653;
	Tue, 18 Feb 2025 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872606; cv=none; b=edKSVzXpWOqNkMVHDidxxUKIJgWx+XK24kVlArWSABePdaAj5pMdNiqKSJUUavoNbQJwet4rqN/KbL51Xr6dR5skoDnoch1mSwctJEhmMDB9uSkkgEbLpOfWP1ykpOYUmS1neugIEWRyvuFbQ1cECbf5nspuMwlS5CSEZfIBc9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872606; c=relaxed/simple;
	bh=+Ro/oqfvGVYxj3TObN+RDoEaw0SsbEolN0PZuCXlz9k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uYHzTxCopfIqNlL9fZIsd9ZlkbjQlqqB0FSPAbU9raWkheXIwSPGzvzr6MI8lUaYF80gqWiJzyPq9FWk2NLovVsJs31n0itMeXkPd980MCTV06C8douf4oGBxzHw+g8x8yYHZv3XuC8qwTEtlz4g36N4JNOTPN+oY4zdSxbh29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMgR7bo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95764C4CEE6;
	Tue, 18 Feb 2025 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739872605;
	bh=+Ro/oqfvGVYxj3TObN+RDoEaw0SsbEolN0PZuCXlz9k=;
	h=From:Subject:Date:To:Cc:From;
	b=SMgR7bo0E+ouRwWv2YvMzhmzTV+dFvpmu7Lma8D7TUmyIH5hYiVeFzWzUlFZJoutb
	 f05KVq+MZlenDC5MWPIgPrTgrnV6Sc7eKiMqi5nmr6P9WWQBxjFKynSnA5C4aBNNjq
	 1JkCYGyaKn+TnGrQZFC+/Az9Nh2GMPHSRrBBPSboWsJl5iC9wOSC+B8PVl1G+tGiuI
	 0FbjrPB0bq+A0aX+GoUtRNNTfj5Pt1IyW//rcGk6Qf+Etsn06zaLxC+6JQ8/jQGgWC
	 yT0/o0fIMG9SAleyJunM3B9G5lj/+8c50gRHHCwjeL9maUtymw4TUE+tSzvSrC/wsP
	 S6q37d2NUHiEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82441C02198;
	Tue, 18 Feb 2025 09:56:45 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Subject: [PATCH 0/8] sysctl: Move sysctls from kern_table into their
 respective subsystems
Date: Tue, 18 Feb 2025 10:56:16 +0100
Message-Id: <20250218-jag-mv_ctltables-v1-0-cd3698ab8d29@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEBZtGcC/x3MTQqAIBBA4avErBNMEqOrRITZZBP2g4oE4d2Tl
 t/ivRcCesIAffWCx0SBrrOgqSswmz4tMlqKQXAhuWgU27VlR5pMdFHPDgMzq5LYKo68k1Cy2+N
 Kz78cxpw/2JeJ2mIAAAA=
X-Change-ID: 20250217-jag-mv_ctltables-cf75e470e085
To: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.15-dev-64da2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2573;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=+Ro/oqfvGVYxj3TObN+RDoEaw0SsbEolN0PZuCXlz9k=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGe0WVOoj6LvNDW0CL4P50y0ZMFe6cFQ86kia
 kfkpVTXzGuYgYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJntFlTAAoJELqXzVK3
 lkFPJpIL/2715yYj/GmvnxpGika5Ef5M6h06gykmNbmK/8jadbKLcQAe9tsLGnF3+Ojw7ChLrol
 HlTolz82WQ2I/xVSm4XoRxfixCkZfY0coFA9OeuPhHMNzQ+Ut1JWZewtKtxIVAG4H8bqDVQRs/G
 Aaoy15GXfo+rPVTu3r8Kd/VugKe9FQzDSRgXpTGLCBzWBv1sn/+QBdW9/9pbGXf6gfdq4Mn8aoO
 S9nuRmKjQ1q+k3kfif/7TakTbtjGwuTxksRI1SlBbrkubYjAK2StDNNwqOyblX+rvIZIAdue5hJ
 FbqZ17s9ye/NoC/0AxPYsf6C34UOU5GQIVEQzhHskYb8iVUc6nooUVtM1I/4/cpc8zJomftwpsf
 KaNmZx6F1CuttQ/3bCA+xAxEQB3SkjpJ8nbvFEki/OFbxXTUwu2lnxX8EFVwsj0AmT9G7CanU+H
 Fz2s1gjQFsVpWSQ9URUj1XmxuoZBETbem4y9lXwW0L5ar2wZN266UfFAX7nD2+01sHs6eY5WoB7
 D8=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

This series relocates sysctl tables from kern_table to their respective
subsystems. To keep the scope manageable, this patchset focuses on
architecture-specific and core kernel sysctl tables. Further relocations
will follow once this series progresses.

By decentralizing sysctl registrations, subsystem maintainers regain
control over their sysctl interfaces, improving maintainability and
reducing the likelihood of merge conflicts. All this is made possible by
the work done to reduce the ctl_table memory footprint in commit
d7a76ec87195 ("sysctl: Remove check for sentinel element in ctl_table
arrays").

* Birds eye view of what has changed:
    - Archs: sparc, s390 and x86
        arch/s390/{lib/spinlock.c,mm/fault.c}
        arch/sparc/kernel/{Makefile,setup.c}
        arch/x86/include/asm/{setup.h,traps.h}
    - Kernel core:
        kernel/{panic.c,signal.c,trace/trace.c}
        kernel/events/{core.c,callchain.c}

* Testing was done by running sysctl selftests on x86_64 and 0-day.

Comments are greatly appreciated

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
Joel Granados (7):
      panic: Move panic ctl tables into panic.c
      signal: Move signal ctl tables into signal.c
      ftrace: Move trace sysctls into trace.c
      stack_tracer: move sysctl registration to kernel/trace/trace.c
      events: Move perf_event sysctls into kernel/events
      sparc: mv sparc sysctls into their own file under arch/sparc/kernel
      x86: Move sysctls into arch/x86

joel granados (1):
      s390: mv s390 sysctls into their own file under arch/s390 dir

 arch/s390/lib/spinlock.c     |  23 ++++
 arch/s390/mm/fault.c         |  17 +++
 arch/sparc/kernel/Makefile   |   1 +
 arch/sparc/kernel/setup.c    |  46 ++++++++
 arch/x86/include/asm/setup.h |   1 +
 arch/x86/include/asm/traps.h |   2 -
 arch/x86/kernel/setup.c      |  66 ++++++++++++
 include/linux/acpi.h         |   1 -
 include/linux/ftrace.h       |   7 --
 include/linux/perf_event.h   |   9 --
 kernel/events/callchain.c    |  38 +++++--
 kernel/events/core.c         |  57 ++++++++--
 kernel/panic.c               |  30 ++++++
 kernel/signal.c              |  11 ++
 kernel/sysctl.c              | 250 -------------------------------------------
 kernel/trace/trace.c         |  45 +++++++-
 16 files changed, 322 insertions(+), 282 deletions(-)
---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250217-jag-mv_ctltables-cf75e470e085

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



