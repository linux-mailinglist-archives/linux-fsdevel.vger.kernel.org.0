Return-Path: <linux-fsdevel+bounces-24515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA24D93FFB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 22:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65397282DA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 20:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE42518D4D6;
	Mon, 29 Jul 2024 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qPsZShbg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC478139580;
	Mon, 29 Jul 2024 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285831; cv=none; b=Bt+hh8vY3oB0ynWsE4d7R3KXkTYsL6UGMb5W9qwSZXcvEIndv5OJcpRZcK9gOD4/BtmLJSxURDzmE3dmtyLrTJBbZx9GUV32bzxx0GeRq7q1LxxmEf1vkuhrvJoeX8vCSTqv11KZ9OV3K9YPU4M/iCAUp0+Uu+6yCnLgTxPIAp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285831; c=relaxed/simple;
	bh=+8EiNSQOMwemaFInZrcbrNKfkjk0rnP33xnFebeRFYY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tVxjikQBVIpus4cJTQ+L4BH0X+SjDCCcuDVvg3cN8nfu44dqYeGpCmm9Y3oOPub2B6qAvMBA7fViMACjde+l7jJqOwqJul2012Xs/Eo6vwxEYMxfmmkcGou1Abr4cC+wESqmSO97vzdIB5ULLluoV/bLfrXNlcUC53ew/A15Xmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qPsZShbg; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722285818;
	bh=+8EiNSQOMwemaFInZrcbrNKfkjk0rnP33xnFebeRFYY=;
	h=From:Subject:Date:To:Cc:From;
	b=qPsZShbgDoxmdeXTe9pAtlDgHrGD281zzf06pN0peLepy+xGWA7Etka4urpMTQ+dl
	 vlzHFyvOs29UDlgnqGPM1GzV7KnF20YbhlwWtxROkRicNqLlIGuxC8cFN3Bxc2kV/Q
	 +sol7Uz1dXk0vCQ/QkbcNiOmipB8FeUrA1QQyg2s=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/5] sysctl: prepare sysctl core for const struct ctl_table
Date: Mon, 29 Jul 2024 22:43:29 +0200
Message-Id: <20240729-sysctl-const-api-v1-0-ca628c7a942c@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPH+p2YC/x3MTQqAIBBA4avErBso+8OuEi1CpxoIDUeikO6et
 PwW7yUQCkwCY5Eg0MXC3mXUZQFmX9xGyDYbVKXaalAa5RETDzTeScTlZBwa3bVrY3tlasjZGWj
 l+19O8/t+7+eegWIAAAA=
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
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722285818; l=2619;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+8EiNSQOMwemaFInZrcbrNKfkjk0rnP33xnFebeRFYY=;
 b=2f0+X5UaPP52HuEePU+BDdUvotXwcftvmS2uOgwMe3JKxSuSdjzICB8xcWVn5MObGDat3MPmB
 pJnVmFRGAauDUBHGwn2uo0Guu1BzCEBEIbKXCMR/oenr0MfDfBvtnDW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Adapt the internal and external APIs of the sysctl core to handle
read-only instances of "struct ctl_table".

Patch 1: Trivial preparation commit for the sysctl BPF hook
Patch 2: Adapts the internal sysctl APIs
Patch 3: Adapts the external sysctl APIs
Patch 4: Constifies the sysctl internal tables as proof that it works
Patch 5: Updates scripts/const_structs.checkpatch for "struct ctl_table"

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
Thomas Weißschuh (5):
      bpf: Constify ctl_table argument of filter function
      sysctl: move internal interfaces to const struct ctl_table
      sysctl: allow registration of const struct ctl_table
      sysctl: make internal ctl_tables const
      const_structs.checkpatch: add ctl_table

 fs/proc/internal.h               |  2 +-
 fs/proc/proc_sysctl.c            | 91 ++++++++++++++++++++--------------------
 include/linux/bpf-cgroup.h       |  2 +-
 include/linux/sysctl.h           | 12 +++---
 kernel/bpf/cgroup.c              |  2 +-
 scripts/const_structs.checkpatch |  1 +
 6 files changed, 56 insertions(+), 54 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240729-sysctl-const-api-73954f3d62c1

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


