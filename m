Return-Path: <linux-fsdevel+bounces-14520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5260087D368
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 19:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B287DB22FAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4822A50A69;
	Fri, 15 Mar 2024 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="QmqHCebk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03C94CB3D;
	Fri, 15 Mar 2024 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526301; cv=none; b=uE2gOPkjxQslqXM+MA+U6XqtkUYnyMZXOAr4JmXgkwj7L+6RT8LZcxGnE53wiyNtgBxzSUrqNmwb/qi+vG/Z8yInjv/ldQvJdng3ZQB/aDoq1wNwRkXpqEETX8dgblg9N0v03RfylezOPr32/Kalkj+baICyeS+NPDXjbVXIH2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526301; c=relaxed/simple;
	bh=yGFDp6e2dOO1N4Y8mr47+8FXmhmHgoG2FhKm/aaPngU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K5t2YwMA2z8HWRCJbEK+Tm8JXRsK+dHz38M49jmQCuaWsnX29t2A5x9pi79ZFYsCsH24QmnAVGA58yUgVQlpfTLflkVs3ymYv4pH8U2Jc31hWjQkzjx+hh/72NI7d+mu8ZO1eBZhHZ2flfHXf2PVLT2KRgJL9fUW5KwsWYAJ0EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=QmqHCebk; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1710526295;
	bh=yGFDp6e2dOO1N4Y8mr47+8FXmhmHgoG2FhKm/aaPngU=;
	h=From:Subject:Date:To:Cc:From;
	b=QmqHCebkcJIp8hFAJ+35uz8sNQ1gebvIM8Ie2T7RirJ3Rmb4g12BL6Jld0dIDAam/
	 2dgp9O861WULp2YOB69BXiyiYxHUQKAGip0MtmOD9u/y7AhTvDAIanM/9sVSM1IN4/
	 wVNXw5OO19OGO3MhGy4e//QOyRBGkuFwaCmLYKEU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 0/2] sysctl: treewide: prepare ctl_table_root for
 ctl_table constification
Date: Fri, 15 Mar 2024 19:11:29 +0100
Message-Id: <20240315-sysctl-const-ownership-v3-0-b86680eae02e@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFGP9GUC/4XNQQ6CMBCF4auQrq2hQ6HiynsYF6VMbRNTSAdBQ
 ri7hcSVMS7/l8w3CyOMHomds4VFHD35LqQoDhkzToc7ct+mZpBDIQAqTjOZ4cFNF2jg3RQwkvM
 9t1aVWKlGImqWjvuI1r92+HpL7TwNXZz3P6PY1r/kKLjgrTrZtlVSNlpcJvREZNzTHQMObHNH+
 FgyByh+WpAsWydE1aXWFr6sdV3fOMp7VQ0BAAA=
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710526294; l=2217;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=yGFDp6e2dOO1N4Y8mr47+8FXmhmHgoG2FhKm/aaPngU=;
 b=DNfzcOV3La0DqS1e9f8mlyjqinvOmso4li0tSKMz6jzrXMrbzpx4XabqpBxzeeWmgOKGWoIxW
 0ciuoqIGa4BANa2FPeQeSZtd1DQQ9oNtDxrrm5i8MZO2a4Ep5rsOrek
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The two patches were previously submitted on their own.
In commit f9436a5d0497
("sysctl: allow to change limits for posix messages queues")
a code dependency was introduced between the two callbacks.
This code dependency results in a dependency between the two patches, so
now they are submitted as a series.

The series is meant to be merged via the sysctl tree.

There is an upcoming series that will introduce a new implementation of
.set_ownership and .permissions which would need to be adapted [0].

These changes ere originally part of the sysctl-const series [1].
To slim down that series and reduce the message load on other
maintainers to a minimum, the patches are split out.

[0] https://lore.kernel.org/lkml/20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com/
[1] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-2-7a5060b11447@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v3:
- Drop now spurious argument in fs/proc/proc_sysctl.c
- Rebase on next-20240315
- Incorporate permissions patch.
- Link to v2 (ownership): https://lore.kernel.org/r/20240223-sysctl-const-ownership-v2-1-f9ba1795aaf2@weissschuh.net
- Link to v1 (permissions): https://lore.kernel.org/r/20231226-sysctl-const-permissions-v1-1-5cd3c91f6299@weissschuh.net

Changes in v2:
- Rework commit message
- Mention potential conflict with upcoming per-namespace kernel.pid_max
  sysctl
- Delete unused parameter table
- Link to v1: https://lore.kernel.org/r/20231226-sysctl-const-ownership-v1-1-d78fdd744ba1@weissschuh.net

---
Thomas Weißschuh (2):
      sysctl: treewide: drop unused argument ctl_table_root::set_ownership(table)
      sysctl: treewide: constify argument ctl_table_root::permissions(table)

 fs/proc/proc_sysctl.c  | 2 +-
 include/linux/sysctl.h | 3 +--
 ipc/ipc_sysctl.c       | 5 ++---
 ipc/mq_sysctl.c        | 5 ++---
 kernel/ucount.c        | 2 +-
 net/sysctl_net.c       | 3 +--
 6 files changed, 8 insertions(+), 12 deletions(-)
---
base-commit: a1e7655b77e3391b58ac28256789ea45b1685abb
change-id: 20231226-sysctl-const-ownership-ff75e67b4eea

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


