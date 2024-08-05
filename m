Return-Path: <linux-fsdevel+bounces-24991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE9E94789D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C62281362
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B55C15574F;
	Mon,  5 Aug 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hGl362aO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D91E152E02;
	Mon,  5 Aug 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850831; cv=none; b=D+HCodnf0sNJBhehVM7da64Kfh/BvRiOWTqbD3G+Y8fahsgFDN38OJtkrHFTZqYoFY3bInDVHhda+DhvXl0cmPQzPeOgPmMhuUjM4llOLU4kIE12EBMJacyLNJ0PtDxptEJU3HnaI3G1GhWcHGywQU3yyIsoh5Ab+pXVoE5KkKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850831; c=relaxed/simple;
	bh=coe0y78UwhKWJW7PsD0qo2yJRLRh9q2BOig3oj68HQo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nK4s9y5n72zcnRMEMv3QPN4EqQk39Lf1Z4TI0yLqI9PfErCALYoZd7QQDXFrr3wkKMSFAnCjvBGUIF7WGWoZWTZN8H542urzus8sKNu+qwP3tSDmFri9bXLZWWxjTsSz52M29jPLlUWHYB5GqgPD8hu9sUMra/1O6zN1pfbejkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hGl362aO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722850825;
	bh=coe0y78UwhKWJW7PsD0qo2yJRLRh9q2BOig3oj68HQo=;
	h=From:Subject:Date:To:Cc:From;
	b=hGl362aOY8oo8UMA43uXHtXmYbv4HU8OmSbokDLS3HQ7llP6Yey7a7FwS0SSZy99L
	 TnqoJzzmqUtp2IVCs02TSVpeRRgXVR07Es6lvfRDCRUmHsMbw15InnCR0Dpp83Klp8
	 oIOg47K0ZPryu0/SmtoaGzyZiUU4KS9IWyLlAFhs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/6] sysctl: prepare sysctl core for const struct
 ctl_table
Date: Mon, 05 Aug 2024 11:39:34 +0200
Message-Id: <20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANadsGYC/32NQQ6CMBBFr0JmbQ0MCMLKexgWzTDYSUwhnYoSw
 t2tHMDle8l/fwPlIKzQZRsEXkRl8gnwlAE56x9sZEgMmGOVN9gaXZXi09DkNRo7i2nK9lKN5VA
 jFZBmc+BRPkfy3id2onEK6/GwFD/7J7YUJjdka7xSY9sK6fZmUVVyL3f2HKHf9/0LdLV+urUAA
 AA=
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Kees Cook <kees@kernel.org>, Joel Granados <j.granados@samsung.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722850824; l=2956;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=coe0y78UwhKWJW7PsD0qo2yJRLRh9q2BOig3oj68HQo=;
 b=mcs2aApIig8exj75ncJO707C1zdo7AeYfoUdUpv7tiyQAW0CPOSCzcf1TZXAp+AdX9aQQa/Cj
 ODvKICIDz1OAPwVHuzRVIk68A9Q3RMBW0HIi+4aTCK4WTExdaEKuAr9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Adapt the internal and external APIs of the sysctl core to handle
read-only instances of "struct ctl_table".

Patch 1: Bugfix for the sysctl core, the bug can be reliably triggered
         with the series applied
Patch 2: Trivial preparation commit for the sysctl BPF hook
Patch 3: Adapts the internal sysctl APIs
Patch 4: Adapts the external sysctl APIs
Patch 5: Constifies the sysctl internal tables as proof that it works
Patch 6: Updates scripts/const_structs.checkpatch for "struct ctl_table"

Motivation
==========

Moving structures containing function pointers into unmodifiable .rodata
prevents attackers or bugs from corrupting and diverting those pointers.

Also the "struct ctl_table" exposed by the sysctl core were never meant
to be mutated by users.

For this goal changes to both the sysctl core and "const" qualifiers for
various sysctl APIs are necessary.

Full Process
============

* Drop ctl_table modifications from the sysctl core ([0], in mainline)
* Constify arguments to ctl_table_root::{set_ownership,permissions}
  ([1], in mainline)
* Migrate users of "ctl_table_header::ctl_table_arg" to "const".
  (in mainline)
* Afterwards convert "ctl_table_header::ctl_table_arg" itself to const.
  (in mainline)
* Prepare helpers used to implement proc_handlers throughout the tree to
  use "const struct ctl_table *". ([2], in mainline)
* Afterwards switch over all proc_handlers callbacks to use
  "const struct ctl_table *" in one commit. (in mainline)
* Switch over the internals of the sysctl core to "const struct ctl_table *" (this series)
* Switch include/linux/sysctl.h to "const struct ctl_table *" (this series)
* Transition instances of "struct ctl_table" through the tree to const (to be done)

This series is meant to be applied through the sysctl tree.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Avoid spurious permanent empty tables (patch 1)
- Link to v1: https://lore.kernel.org/r/20240729-sysctl-const-api-v1-0-ca628c7a942c@weissschuh.net

---
Thomas Weißschuh (6):
      sysctl: avoid spurious permanent empty tables
      bpf: Constify ctl_table argument of filter function
      sysctl: move internal interfaces to const struct ctl_table
      sysctl: allow registration of const struct ctl_table
      sysctl: make internal ctl_tables const
      const_structs.checkpatch: add ctl_table

 fs/proc/internal.h               |   2 +-
 fs/proc/proc_sysctl.c            | 100 +++++++++++++++++++++------------------
 include/linux/bpf-cgroup.h       |   2 +-
 include/linux/sysctl.h           |  12 ++---
 kernel/bpf/cgroup.c              |   2 +-
 scripts/const_structs.checkpatch |   1 +
 6 files changed, 63 insertions(+), 56 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240729-sysctl-const-api-73954f3d62c1

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


