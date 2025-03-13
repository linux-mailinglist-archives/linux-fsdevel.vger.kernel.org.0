Return-Path: <linux-fsdevel+bounces-43912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05EEA5FB6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933DF1681AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 16:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823FB26A086;
	Thu, 13 Mar 2025 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cowdBlzD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B6267F77;
	Thu, 13 Mar 2025 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882957; cv=none; b=UVaKTr61HhBRdps1TNX1/Ir+k/+IA0rSgkJZXBcgp7dAkub2b3Z/mTYcqQ5ACj0LaA3oqjA4VyS5isNVXyvYrX4Vu3ZGamYopI1XVXJO+7cbUyQbI2tFcyyh2TY+Xy1wjounz/NTV/hETCa1SQt7eys0IBZRrO8yxgwz4LeXhUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882957; c=relaxed/simple;
	bh=9BJrspz9yE1EjgzFvirmz3UiLOLMBPHH+mtqER++Sv4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M8alPbHB3KIOU/p14kUQD2EuUy7IeKbA1WkjWVMlUrEj9eQAjzbpdhwpr++P3xGo0brB0/gCHzkbYB1IYDSsGIs5PO2XJkasEltrZOY2Az7YpuBULgNg0doDc8fFaRdWXNAA9OVy1PVXCpeTbXTz3Hl1ctJjFjm8o/yVTptNbwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cowdBlzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23D30C4CEDD;
	Thu, 13 Mar 2025 16:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741882957;
	bh=9BJrspz9yE1EjgzFvirmz3UiLOLMBPHH+mtqER++Sv4=;
	h=From:Subject:Date:To:Cc:From;
	b=cowdBlzDy6FflC/ZLWngg82GGSp87Lv+258sp3afuZWEodpoUgpmcY+ykT2FKbOWq
	 M97H1mze30wQ+MSTSmLcdxhgDGjxizkuz55nPhgQG3AEPzV47LljyTkIbpLgDPXUv+
	 JIls9M3M4lekWtald2eM9Mj8ACAq+GRSWvsahnhm9llpuJTQSlFMCdWRvdSucUSPIi
	 qL3KaviRXN7H8hTaqi90/QrYAg5o6OXqetmdEsMCX8ghNKoOBQB+/D21mBk4fTWpNn
	 2G2FWdnswjoP8nzkXOLTAis5sMoEs+/2ZEK2rKoZeTRhjWvM+lWLxDLJN4+weIdOUP
	 hX6JXfA68z+cg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE67C282EC;
	Thu, 13 Mar 2025 16:22:37 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Subject: [PATCH v3 0/5] sysctl: Move sysctls from kern_table into their
 respective subsystems
Date: Thu, 13 Mar 2025 17:22:22 +0100
Message-Id: <20250313-jag-mv_ctltables-v3-0-91f3bb434d27@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD4G02cC/23N3wqCMBTH8VeJc91if9TNrnqPiJjbUVemsckox
 HdvChFRl98fnM+ZIKB3GGC/mcBjdMENfQqx3YBpdd8gcTY1cMpzypkkF92QWzybsRt11WEgppY
 5ZpIiVTmks7vH2j1W8nhK3bowDv65fohsWd+Y+sUiI5QYK4pS6UpZXh6u6HvsdoNvYNEi/wiCF
 n8EngTJKp4Jo6yo1Zcwz/MLvJ2Q0PMAAAA=
X-Change-ID: 20250217-jag-mv_ctltables-cf75e470e085
To: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, sparclinux@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2666;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=9BJrspz9yE1EjgzFvirmz3UiLOLMBPHH+mtqER++Sv4=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGfTBkiMKwNqoKHHDpFPfiyeQ2Fe0oUt/OEGr
 v94WKqL/HG7rIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJn0wZIAAoJELqXzVK3
 lkFPvoAL/3V02KJiyAmy9V2bEiQYwDMb29ke6mz1PS2I1Hyq6bTTE+UOFqXEJK3263QufMxE1ym
 1ngbr1fQ9ayJAjPqDVxalEbAM4tm9tUipTiJBCAKrjWIXbn9c8SuonY7lcTWLzuIf9KJDOOO8MP
 ta6m3pLU+J2mbCgPqyJg0CrbyOltjxkWWK0YnyzlTA0EMNYfkTBOOKK+bHpeQdqhV/yM+444WM/
 pBDKXOb3Xtvid9OKx62BqIPJ6d0DlFf+TdmorQWitW0YtjhFJ4p8qyh5Ju5ToW/uoCYKsc8EJqU
 MC74luzxZNer3UwjAwWz0kYQimT8QvW6bGQhBLcDUL70aLr/srJ1KquVbYbGW+L8CfS0buGn9VD
 MDw79Hh9mX8QiUB/B1D5/KIVdaDEFe9IgO6TabiX3NYvJI+gUQB1iSZt2Bo8W8Sy7i1zuPRisYg
 tJDqSuvoCNPD/N/ffv96zxA7FdMtJ5SBRIpvxGyWi4cIxc8Fv2fL2LGkdUgQKwK5ER+I1ouBmr7
 uo=
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
    - Archs: sparc
        arch/sparc/kernel/{Makefile,setup.c}
    - Kernel core:
        kernel/{panic.c,signal.c,trace/trace.c}
        kernel/events/{core.c,callchain.c}

* Testing was done by running sysctl selftests on x86_64 and 0-day.

Comments are greatly appreciated

Changes in v3:
- Removed s390 from the series as it is being upstreamed through s390
  tree. Adjusted the Cc and To to reflect this.
- made stack_tracer_enabled static
- Link to v2: https://lore.kernel.org/r/20250306-jag-mv_ctltables-v2-0-71b243c8d3f8@kernel.org

Changes in v2:
- Dropped the perf and x86 patches as they are making their way
  upstream. Removed relevant ppl from To: and Cc: mail header.
- "ftrace:..." -> "tracing:..." for patch 3
- Moved stac_tracer_enabled to trace_stack.c instead of trace.c
- s390: fixed typo and removed the CONFIG_SMP ifdefs
- Updated trailers
- Link to v1: https://lore.kernel.org/r/20250218-jag-mv_ctltables-v1-0-cd3698ab8d29@kernel.org

---
Signed-off-by: Joel Granados <joel.granados@kernel.org>

---
Joel Granados (5):
      panic: Move panic ctl tables into panic.c
      signal: Move signal ctl tables into signal.c
      tracing: Move trace sysctls into trace.c
      stack_tracer: move sysctl registration to kernel/trace/trace_stack.c
      sparc: mv sparc sysctls into their own file under arch/sparc/kernel

 arch/sparc/kernel/Makefile |   1 +
 arch/sparc/kernel/setup.c  |  46 +++++++++++++++++++
 include/linux/ftrace.h     |   9 ----
 kernel/panic.c             |  30 +++++++++++++
 kernel/signal.c            |  11 +++++
 kernel/sysctl.c            | 108 ---------------------------------------------
 kernel/trace/trace.c       |  36 ++++++++++++++-
 kernel/trace/trace_stack.c |  22 ++++++++-
 8 files changed, 144 insertions(+), 119 deletions(-)
---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250217-jag-mv_ctltables-cf75e470e085

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



