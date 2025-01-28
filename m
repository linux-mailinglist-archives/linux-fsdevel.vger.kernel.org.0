Return-Path: <linux-fsdevel+bounces-40187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F91A202A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 01:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FDC1658F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBBF2942A;
	Tue, 28 Jan 2025 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0/WiCq9v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD314286;
	Tue, 28 Jan 2025 00:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738024869; cv=none; b=EU29o6B+EyxL/HnDE83w5xwNmxKkXnamfVg0uKUxfVm1wU41Qb3t0GoGuqh/+ysAlvBSlfMhvrnAewLUvBZ/EWPBd2n+4A7VIt4kmcYLs0kbjpvGwELvKGaAUa4TaNtkhUbufVde3XtPhtkpceNaQzSiBw8d3RBuEAOrKKhYWFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738024869; c=relaxed/simple;
	bh=n9XTVKn6KHy7cORMWOZCzd4Ie6hNugIHiNZYNrvLsD4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lnalCkBiolw8xCc46XeT5tL6bFGW9rtaRNrb4Drus+ifuSeCVA/TFoBrUybTYNhQr7MkyrcHk0JvtkrL0otZ9xjSBhdHaqwwy8pIdSuvo8CnY9L6bfvQp+gROh/b4O/KCjnPRbKlrg+l7plkyhNqalqx1i1+uGVg6NUIuA0DGTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0/WiCq9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F3FC4CED2;
	Tue, 28 Jan 2025 00:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1738024868;
	bh=n9XTVKn6KHy7cORMWOZCzd4Ie6hNugIHiNZYNrvLsD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0/WiCq9vvlbeyOMCmkWvXr2wXtiaAyUu5RI+un3MWYf6/wGRcRDRTgH0K+aFp/PSx
	 Ajs5w4OT9TXmrgAvwljfQpSGGbyvGUA/dxmjg1XDxLkFrMiNgnqc1Xb6Ksy8Pg1Zn+
	 GCII9kuSHFUCjSdofzYBmSAOmwtKZbKsdwCC5agQ=
Date: Mon, 27 Jan 2025 16:41:06 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, brauner@kernel.org,
 viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@meta.com, rostedt@goodmis.org, peterz@infradead.org,
 mingo@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, shakeel.butt@linux.dev, rppt@kernel.org,
 liam.howlett@oracle.com, surenb@google.com, kees@kernel.org,
 jannh@google.com
Subject: Re: [PATCH v2] mm,procfs: allow read-only remote mm access under
 CAP_PERFMON
Message-Id: <20250127164106.5f40b62e0f1cf353538c46fd@linux-foundation.org>
In-Reply-To: <20250127222114.1132392-1-andrii@kernel.org>
References: <20250127222114.1132392-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 14:21:14 -0800 Andrii Nakryiko <andrii@kernel.org> wrote:

> It's very common for various tracing and profiling toolis to need to
> access /proc/PID/maps contents for stack symbolization needs to learn
> which shared libraries are mapped in memory, at which file offset, etc.
> Currently, access to /proc/PID/maps requires CAP_SYS_PTRACE (unless we
> are looking at data for our own process, which is a trivial case not too
> relevant for profilers use cases).
> 
> Unfortunately, CAP_SYS_PTRACE implies way more than just ability to
> discover memory layout of another process: it allows to fully control
> arbitrary other processes. This is problematic from security POV for
> applications that only need read-only /proc/PID/maps (and other similar
> read-only data) access, and in large production settings CAP_SYS_PTRACE
> is frowned upon even for the system-wide profilers.
> 
> On the other hand, it's already possible to access similar kind of
> information (and more) with just CAP_PERFMON capability. E.g., setting
> up PERF_RECORD_MMAP collection through perf_event_open() would give one
> similar information to what /proc/PID/maps provides.
> 
> CAP_PERFMON, together with CAP_BPF, is already a very common combination
> for system-wide profiling and observability application. As such, it's
> reasonable and convenient to be able to access /proc/PID/maps with
> CAP_PERFMON capabilities instead of CAP_SYS_PTRACE.
> 
> For procfs, these permissions are checked through common mm_access()
> helper, and so we augment that with cap_perfmon() check *only* if
> requested mode is PTRACE_MODE_READ. I.e., PTRACE_MODE_ATTACH wouldn't be
> permitted by CAP_PERFMON. So /proc/PID/mem, which uses
> PTRACE_MODE_ATTACH, won't be permitted by CAP_PERFMON, but
> /proc/PID/maps, /proc/PID/environ, and a bunch of other read-only
> contents will be allowable under CAP_PERFMON.
> 
> Besides procfs itself, mm_access() is used by process_madvise() and
> process_vm_{readv,writev}() syscalls. The former one uses
> PTRACE_MODE_READ to avoid leaking ASLR metadata, and as such CAP_PERFMON
> seems like a meaningful allowable capability as well.
> 
> process_vm_{readv,writev} currently assume PTRACE_MODE_ATTACH level of
> permissions (though for readv PTRACE_MODE_READ seems more reasonable,
> but that's outside the scope of this change), and as such won't be
> affected by this patch.
> 

This should be documented somewhere, so we can tell our users what we
did.  Documentation/filesystems/proc.rst seems to be the place.  .

