Return-Path: <linux-fsdevel+bounces-43335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 030A2A54973
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 12:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AC917447D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 11:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2124F211A04;
	Thu,  6 Mar 2025 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzWvNgsx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CEC20FABA;
	Thu,  6 Mar 2025 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260651; cv=none; b=TKueu+U3oSZA5pGv5jqxnYxIP3zyukp6tjUBHggDhquQLA6TzD2U7yadvGgBwEr4hyW5+sUY8pMMCgd717QTYAs7RxKOBr/oLOtkbz3BH88Wg4kYCHbzKem43IBwhznwbEi7E8kkbWfNfIBVGElhVt1fhCN6vz86un8soY6tpTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260651; c=relaxed/simple;
	bh=BmDtc+FyqXKq5Ekj07+RwoaOM9j4PHP6W+rOCluL/1o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E6Dc6bjXA14xbZ+wxwQm5uXvo9ABhYBsbSmCCdGo5a2zwzui391lPWeA8ztBkU31LpDChQ0yqH4wT0lYWVLi1I2+Qekbyi1kA3bs7snuBgMV84gNwLX4akwhby2LUOY8CMxwkIDfVPwXGhJWzeQuP2MfE1tI8vco80ytCPjd6HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzWvNgsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54646C113CF;
	Thu,  6 Mar 2025 11:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741260650;
	bh=BmDtc+FyqXKq5Ekj07+RwoaOM9j4PHP6W+rOCluL/1o=;
	h=From:Subject:Date:To:Cc:From;
	b=BzWvNgsxSnhAXfFfPnOLbO5BVSKh2r2JZHaf9vxvhneiM8Xvs0f3eq4kQyHWZumH9
	 v8MJ7Q1zhzIGZHHOcyv0QC7q5oiXv8h8Ar4VrPGA1+sK/gbM849Ut00p5DNq4lrjsY
	 t6Jv1CwpFSd4kNT364cPAKwNeRy2OQSF8c1CfkopGEZsseMz2pu58eSGuFYvS+0Rf2
	 duXfyQSaZGdp8RgRwnESzxfNn4I2NTE9QpV7QfwHZjpp19znku7RS0Wsqz4JtuAmFJ
	 ylaPw0rkD/5x9MTYiFcpfMZjGNKxB8o4gLkCktHtk8r6IUpiYWpzks96Z2DFVDsZoa
	 bMAozsERu9vQQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF57C282D1;
	Thu,  6 Mar 2025 11:30:50 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Subject: [PATCH v2 0/6] sysctl: Move sysctls from kern_table into their
 respective subsystems
Date: Thu, 06 Mar 2025 12:29:40 +0100
Message-Id: <20250306-jag-mv_ctltables-v2-0-71b243c8d3f8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACSHyWcC/2WNQQ7CIBQFr9L8tRhAsdSV9zCNofDborQYaIim4
 e5iE1cuZ5I3b4WIwWKEc7VCwGSj9XMBvqtAj2oekFhTGDjlgnJWk7sayJRuenGL6hxGovta4LG
 mSKWAMnsG7O1rS17bwqONiw/v7SGxr/3F5H8sMUKJNodTI1UnDW8uDwwzur0PA7Q55w/EtyoXs
 QAAAA==
X-Change-ID: 20250217-jag-mv_ctltables-cf75e470e085
To: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-s390@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2670;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=BmDtc+FyqXKq5Ekj07+RwoaOM9j4PHP6W+rOCluL/1o=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGfJhz0pXhCw8tJC7aq0JL8ffmfIACv+dko10
 KYUtpwbFikijokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJnyYc9AAoJELqXzVK3
 lkFPtk4MAIpWsMgmVxyhJ6wKBpjaEYZOheqIKr6SQhHOLorhW96JeBB9DUG+0WdzSPAfH+NMxac
 AhYpnsugPC1HCuh1B71jLYrAakkFaL6ICRAatsS6Pt2Rm6rlmMZkcp/A8IkTiZ0jYbesFJ3fQh0
 AUdGpWYyQ18QIqQ+GR7RgT/IKnGdlMmIWNuuAKEbnNF/VoR8gPFfoCF8sJWvrpl2pV+earsiqr9
 4JpCEmwNlZbyzDuFqQNQXGsl7Men+LmxIWzynDbdaAobW8w8F8h4aHF2+RBKF2N+i1cl1p/UaLt
 CeUJ9/MzGhKA43O9yK74TmDjzqindrTkHgPh5f1DLcFGltgu1JGmZQjVAG7DtW5WZdKfiPkpS/f
 EaWJRoXEZQW1hvPsQDoe1RWGEBnn3ikZVugt998Vwozrmw/CD16lkIkl022Ds/K3IKkrDXEhaU3
 X2MIUPmf0WDi5AkBkgVNkFR6C2UcmG4I5hj7xpjAyQpd/QIwV+wijsGaG6otJ25mwxa+FwaQw35
 hw=
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

Changes in v2:
- Dropped the perf and x86 patches as they are making their way
  upstream. Removed relevant ppl from To: and Cc: mail header.
- "ftrace:..." -> "tracing:..." for patch 3
- Moved stac_tracer_enabled to trace_stack.c instead of trace.c
- s390: fixed typo and removed the CONFIG_SMP ifdefs
- Updated trailers
- Link to v1: https://lore.kernel.org/r/20250218-jag-mv_ctltables-v1-0-cd3698ab8d29@kernel.org

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
---
Joel Granados (5):
      panic: Move panic ctl tables into panic.c
      signal: Move signal ctl tables into signal.c
      tracing: Move trace sysctls into trace.c
      stack_tracer: move sysctl registration to kernel/trace/trace_stack.c
      sparc: mv sparc sysctls into their own file under arch/sparc/kernel

joel granados (1):
      s390: mv s390 sysctls into their own file under arch/s390 dir

 arch/s390/lib/spinlock.c   |  18 +++++++
 arch/s390/mm/fault.c       |  17 ++++++
 arch/sparc/kernel/Makefile |   1 +
 arch/sparc/kernel/setup.c  |  46 +++++++++++++++++
 include/linux/ftrace.h     |   7 ---
 kernel/panic.c             |  30 +++++++++++
 kernel/signal.c            |  11 ++++
 kernel/sysctl.c            | 126 ---------------------------------------------
 kernel/trace/trace.c       |  36 ++++++++++++-
 kernel/trace/trace_stack.c |  20 +++++++
 10 files changed, 178 insertions(+), 134 deletions(-)
---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250217-jag-mv_ctltables-cf75e470e085

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



