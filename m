Return-Path: <linux-fsdevel+bounces-25729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49B494FAA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 02:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B851C21A43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 00:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69FC17FF;
	Tue, 13 Aug 2024 00:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp0/J1GR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD9B80B;
	Tue, 13 Aug 2024 00:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723508975; cv=none; b=MrvXyquwZ0amLAlB9Sxx+VlZyuSMjzF3DoGifgI0jn1kf9kxZesvsemrB6K5VVbT9jRHokFK611KtzCV/pnf108mOyPixAYVmz83DrDBlc6DKMz3TIxWtOdMCIpiwkyTot1EXDJrMnsGHXKtjE16GFFO/F9praUI8pTlsqHXB4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723508975; c=relaxed/simple;
	bh=Fzk/HK9bIRfF20c/h6DzElGIXTaohG+iN7OWOlC5voc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Byj7gP9JjqiezKk2Ur2NxSCEk6RAc64UZ/FG7SxtjSMTrJNjOGI9tv+HFVHSc8wiOShAoFsl2mcJ0RkZRlwk6kNongOA9jb25jsVeG0b+ASMNuWK1vQYc4bUpSrCHjDrJd8aXANyhOMuVxSNwD2mnOObzCCyX2PK46KWQVbLVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp0/J1GR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C707C4AF0E;
	Tue, 13 Aug 2024 00:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723508974;
	bh=Fzk/HK9bIRfF20c/h6DzElGIXTaohG+iN7OWOlC5voc=;
	h=From:To:Cc:Subject:Date:From;
	b=Xp0/J1GRdRc6G9QaLBJszLu4DzgYdx/qupcibeHj2PRxLOXIY9QSS4yuJzxl7aDDa
	 axA66jygf6h0jy7ez7Uweaomog6otM66WN2f/tZ72/oAaN6ZNkLhL0t7jpP/o5Zl7Y
	 wjtiK+atzKJOdzydHIOe/ooK4fFLHjAhsXUpf54bROSZbrDHt4bnTP0yjtr5wGX6oY
	 XdPITVCOgoKhUUizX/HFXv1uXRZDVTVUqJwGo68nBauo14WYcef5XY/l91v0rmjrgU
	 fZkZEPEXuO6GTPHfVRMgFf2BcaJeu6saqYJpGggsu9hcl3GK1xJtnSVB9BtTLxRkoD
	 lo5HaIlV5Ccxw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	adobriyan@gmail.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	ak@linux.intel.com,
	osandov@osandov.com,
	song@kernel.org,
	jannh@google.com,
	linux-fsdevel@vger.kernel.org,
	willy@infradead.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v5 bpf-next 00/10] Harden and extend ELF build ID parsing logic
Date: Mon, 12 Aug 2024 17:29:22 -0700
Message-ID: <20240813002932.3373935-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal of this patch set is to extend existing ELF build ID parsing logic,
currently mostly used by BPF subsystem, with support for working in sleepable
mode in which memory faults are allowed and can be relied upon to fetch
relevant parts of ELF file to find and fetch .note.gnu.build-id information.

This is useful and important for BPF subsystem itself, but also for
PROCMAP_QUERY ioctl(), built atop of /proc/<pid>/maps functionality (see [0]),
which makes use of the same build_id_parse() functionality. PROCMAP_QUERY is
always called from sleepable user process context, so it doesn't have to
suffer from current restrictions of build_id_parse() which are due to the NMI
context assumption.

Along the way, we harden the logic to avoid TOCTOU, overflow, out-of-bounds
access problems.  This is the very first patch, which can be backported to
older releases, if necessary.

We also lift existing limitations of only working as long as ELF program
headers and build ID note section is contained strictly within the very first
page of ELF file.

We achieve all of the above without duplication of logic between sleepable and
non-sleepable modes through freader abstraction that manages underlying folio
from page cache (on demand) and gives a simple to use direct memory access
interface. With that, single page restrictions and adding sleepable mode
support is rather straightforward.

We also extend existing set of BPF selftests with a few tests targeting build
ID logic across sleepable and non-sleepabe contexts (we utilize sleepable and
non-sleepable uprobes for that).

   [0] https://lore.kernel.org/linux-mm/20240627170900.1672542-4-andrii@kernel.org/

v4->v5:
  - pass proper file reference to read_cache_folio() (Shakeel);
  - fix another potential overflow due to two u32 additions (Andi);
  - add PageUptodate() check to patch #1 (Jann);
v3->v4:
  - fix few more potential overflow and out-of-bounds access issues (Andi);
  - use purely folio-based implementation for freader (Matthew);
v2->v3:
  - remove unneeded READ_ONCE()s and force phoff to u64 for 32-bit mode (Andi);
  - moved hardening fixes to the front for easier backporting (Jann);
  - call freader_cleanup() from build_id_parse_buf() for consistency (Jiri);
v1->v2:
  - ensure MADV_PAGEOUT works reliably by paging data in first (Shakeel);
  - to fix BPF CI build optionally define MADV_POPULATE_READ in selftest.


Andrii Nakryiko (10):
  lib/buildid: harden build ID parsing logic
  lib/buildid: add single folio-based file reader abstraction
  lib/buildid: take into account e_phoff when fetching program headers
  lib/buildid: remove single-page limit for PHDR search
  lib/buildid: rename build_id_parse() into build_id_parse_nofault()
  lib/buildid: implement sleepable build_id_parse() API
  lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
  bpf: decouple stack_map_get_build_id_offset() from
    perf_callchain_entry
  bpf: wire up sleepable bpf_get_stack() and bpf_get_task_stack()
    helpers
  selftests/bpf: add build ID tests

 include/linux/bpf.h                           |   2 +
 include/linux/buildid.h                       |   4 +-
 kernel/bpf/stackmap.c                         | 131 ++++--
 kernel/events/core.c                          |   2 +-
 kernel/trace/bpf_trace.c                      |   5 +-
 lib/buildid.c                                 | 395 +++++++++++++-----
 tools/testing/selftests/bpf/Makefile          |   5 +-
 .../selftests/bpf/prog_tests/build_id.c       | 118 ++++++
 .../selftests/bpf/progs/test_build_id.c       |  31 ++
 tools/testing/selftests/bpf/uprobe_multi.c    |  41 ++
 tools/testing/selftests/bpf/uprobe_multi.ld   |  11 +
 11 files changed, 603 insertions(+), 142 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/build_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_build_id.c
 create mode 100644 tools/testing/selftests/bpf/uprobe_multi.ld

-- 
2.43.5


