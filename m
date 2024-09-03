Return-Path: <linux-fsdevel+bounces-28455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E58F296AC52
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 00:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F30CB216AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 22:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99BA1D58AC;
	Tue,  3 Sep 2024 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhAAp5yj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B82168D0;
	Tue,  3 Sep 2024 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403152; cv=none; b=USB+bXbFavLdxwA0oWOY1JntAMxcBoP5b+RWMIJ3nRzjLYTIXTWDSL7WtqnIE0Kf3Q+jMyMBPPcN18leDjfpeypyE2WMEaMsDv/o9Yf5CQ/iz23C31aPPkUs/hMEq97eT1ceoGznJDT/ezJfNR4DDlrRmdUZSzr3QAUVH8FLgic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403152; c=relaxed/simple;
	bh=Lpdiqv7U5WH0lEr8Eh3/GAkbxcCXk70iOpTe0x22h38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7iFDu1z5fkTItIghOWZe55/KzmjaKq/XSS+RBDTUQTIYaKMDngwJb3RZ3CPTDy+o5JLVqeJ1tEtzk5EbDDP4dML7ZUwzKVohIvw25f+2Dxw3I0g/GbCAOmPKApcE8CccNEfQ7PpSA9EP6MvhZSQzBJs75TtketrTVWI2R11Clo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhAAp5yj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d86f713557so3196006a91.2;
        Tue, 03 Sep 2024 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725403149; x=1726007949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2PtT26YRiaBYasNug4rMtQJAR6q3w0Bv3mtkz5A7vg=;
        b=KhAAp5yjpS8GwpurkUNJFsOVpx2PJP8ZvIer7qhOyAo71o7wgXrmB1qhPCW41sKK3y
         yRmB4seXMfkR2yML9hajm1ONoGgZN26wR049LEMALnGB/PjrJ+X9gItYb7Z8OzInAbMj
         7a2cgfkyuDR+a3H7COCIu6Up5i5egvpM0NiUw6suVorA895aTMdJoLKQptYW3r2nAGXR
         XluZfY1nT5JWoHkc3woWw3ypSB8N4W+fqp8jtc6g4+3nHZYdolwvN5xlX2NLA98aQxzy
         EXxvZAGABdw9k+WJFjGusI32t7mtYQ4HBrHSuQyAZsNfRhslmvMXmGlL4KIVC5oBIWvL
         T2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725403149; x=1726007949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2PtT26YRiaBYasNug4rMtQJAR6q3w0Bv3mtkz5A7vg=;
        b=wfokXaFGVeBLb3iAg50nKaJj5ang0DUP+I0CkEVGWwYCnkBIvC8ZmurITLavGfbRDy
         OpkUen5jP6r2/QK/HEpt2zPRK/nsVArhPIg4gh21TDddlr05AcY4mCYQb2C09PQOmTS+
         7K4+rtXQvNF8cXh+YyDKqhN9mW/ft6auIkMPg4qXK3pUBG8SPeHfq+iSLuGeS9Ppr8Qh
         4Nho1D+T9YJZ4BtsghZRVHqzmUBlh3+uhVBMljj4spxS1uD5jvswmqGCw1oQv4D5PwZx
         zPHxMlr4sfP9tu+WLPUtC1yPbuX2L1c21SHCExUWOR5zD6Caj4PPfFPxRytkqFzf+pAA
         4/OA==
X-Forwarded-Encrypted: i=1; AJvYcCUo1IIACMyWbjyHl2AY+/9kpCMvHEXD0HVGtnnVX1AmDBP22hlRrLyxtA6Di819bi7jSVXqfthcZ9p7yST8@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx3m+Ju1Ll/HHXUwc6Jol6q4onqaHp9IXdhsrFBTllZP+vOtMs
	wwtvqlwbRZJfibaRqY82DyLp3m/3CpiWxEJBIFS068xVT5ispzTOicHzrJ3Tj0XPjGAoFi+XZPH
	JfYN8W5C+XDyIJH2MifkgkYtGw6U=
X-Google-Smtp-Source: AGHT+IHqfBfyIi1sY/xSA1xbdpPbbWvmy5eqvGxffWVsRA5cwcYDa75eASwd10hegsqh0goLCXgFxIVazxTlOxZ30R8=
X-Received: by 2002:a17:90a:bd91:b0:2cc:ef14:89e3 with SMTP id
 98e67ed59e1d1-2d8904ee82emr11225806a91.15.1725403149223; Tue, 03 Sep 2024
 15:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829174232.3133883-1-andrii@kernel.org>
In-Reply-To: <20240829174232.3133883-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Sep 2024 15:38:57 -0700
Message-ID: <CAEf4BzYdP_6L1bT5bEwp5GAwM-rKOA36C-Cwv4i8h-3pKp-nkQ@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 00/10] Harden and extend ELF build ID parsing logic
To: willy@infradead.org, linux-mm@kvack.org, akpm@linux-foundation.org
Cc: bpf@vger.kernel.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	jannh@google.com, linux-fsdevel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 10:42=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> The goal of this patch set is to extend existing ELF build ID parsing log=
ic,
> currently mostly used by BPF subsystem, with support for working in sleep=
able
> mode in which memory faults are allowed and can be relied upon to fetch
> relevant parts of ELF file to find and fetch .note.gnu.build-id informati=
on.
>
> This is useful and important for BPF subsystem itself, but also for
> PROCMAP_QUERY ioctl(), built atop of /proc/<pid>/maps functionality (see =
[0]),
> which makes use of the same build_id_parse() functionality. PROCMAP_QUERY=
 is
> always called from sleepable user process context, so it doesn't have to
> suffer from current restrictions of build_id_parse() which are due to the=
 NMI
> context assumption.
>
> Along the way, we harden the logic to avoid TOCTOU, overflow, out-of-boun=
ds
> access problems.  This is the very first patch, which can be backported t=
o
> older releases, if necessary.
>
> We also lift existing limitations of only working as long as ELF program
> headers and build ID note section is contained strictly within the very f=
irst
> page of ELF file.
>
> We achieve all of the above without duplication of logic between sleepabl=
e and
> non-sleepable modes through freader abstraction that manages underlying f=
olio
> from page cache (on demand) and gives a simple to use direct memory acces=
s
> interface. With that, single page restrictions and adding sleepable mode
> support is rather straightforward.
>
> We also extend existing set of BPF selftests with a few tests targeting b=
uild
> ID logic across sleepable and non-sleepabe contexts (we utilize sleepable=
 and
> non-sleepable uprobes for that).
>
>    [0] https://lore.kernel.org/linux-mm/20240627170900.1672542-4-andrii@k=
ernel.org/
>
> v6->v7:
>   - added filemap_invalidate_{lock,unlock}_shared() around read_cache_fol=
io
>     and kept Eduard's Reviewed-by (Eduard);
> v5->v6:
>   - use local phnum variable in get_build_id_32() (Jann);
>   - switch memcmp() instead of strcmp() in parse_build_id() (Jann);
> v4->v5:
>   - pass proper file reference to read_cache_folio() (Shakeel);
>   - fix another potential overflow due to two u32 additions (Andi);
>   - add PageUptodate() check to patch #1 (Jann);
> v3->v4:
>   - fix few more potential overflow and out-of-bounds access issues (Andi=
);
>   - use purely folio-based implementation for freader (Matthew);

Ok, so I'm not sure what one needs to do to get Matthew's attention
nowadays, but hopefully yet another ping might do the trick.

Matthew,

Can you please take another look and provide your ack or nack? I did
the conversion to folio as you requested. It would be nice if you can
give me a courtesy of acking my patch set, if there is nothing wrong
with it, so it can finally go in.

Thank you.

> v2->v3:
>   - remove unneeded READ_ONCE()s and force phoff to u64 for 32-bit mode (=
Andi);
>   - moved hardening fixes to the front for easier backporting (Jann);
>   - call freader_cleanup() from build_id_parse_buf() for consistency (Jir=
i);
> v1->v2:
>   - ensure MADV_PAGEOUT works reliably by paging data in first (Shakeel);
>   - to fix BPF CI build optionally define MADV_POPULATE_READ in selftest.
>
> Andrii Nakryiko (10):
>   lib/buildid: harden build ID parsing logic
>   lib/buildid: add single folio-based file reader abstraction
>   lib/buildid: take into account e_phoff when fetching program headers
>   lib/buildid: remove single-page limit for PHDR search
>   lib/buildid: rename build_id_parse() into build_id_parse_nofault()
>   lib/buildid: implement sleepable build_id_parse() API
>   lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
>   bpf: decouple stack_map_get_build_id_offset() from
>     perf_callchain_entry
>   bpf: wire up sleepable bpf_get_stack() and bpf_get_task_stack()
>     helpers
>   selftests/bpf: add build ID tests
>
>  include/linux/bpf.h                           |   2 +
>  include/linux/buildid.h                       |   4 +-
>  kernel/bpf/stackmap.c                         | 131 ++++--
>  kernel/events/core.c                          |   2 +-
>  kernel/trace/bpf_trace.c                      |   5 +-
>  lib/buildid.c                                 | 397 +++++++++++++-----
>  tools/testing/selftests/bpf/Makefile          |   5 +-
>  .../selftests/bpf/prog_tests/build_id.c       | 118 ++++++
>  .../selftests/bpf/progs/test_build_id.c       |  31 ++
>  tools/testing/selftests/bpf/uprobe_multi.c    |  41 ++
>  tools/testing/selftests/bpf/uprobe_multi.ld   |  11 +
>  11 files changed, 605 insertions(+), 142 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/build_id.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_build_id.c
>  create mode 100644 tools/testing/selftests/bpf/uprobe_multi.ld
>
> --
> 2.43.5
>

