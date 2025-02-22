Return-Path: <linux-fsdevel+bounces-42334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D278EA4082D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 13:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B245E19C6490
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 12:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E6F20AF71;
	Sat, 22 Feb 2025 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INii8xYY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0FD19D8AC;
	Sat, 22 Feb 2025 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740225927; cv=none; b=PuTAXXRMhI3dte9xGNsbvRU5ia8c3pBxl3FGNvof0a+mO50tmCABZy99BpCUjZuxS7cvUBFM4Ma91sirKr/2rMIreC1SXIWotJlHNePusQzQumHwCmpmhjCO/zRQXwQzq78BqImD0b8w/BWYmrac1JZTVeVvRWHxPa3Zh9zg86Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740225927; c=relaxed/simple;
	bh=AvbO5/5GTYZnYvRAUft9DyG/18ymXgC3kPeuTPaKuI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MizViB+9kRJ5w0ZocXsXe7FToOzW0OFCC7o3YrDiYlttjxv97a7bBrMjkwUxje3pLGwh6bOYzb+20QtMTYe5/4J5zmp2WjBfjkfVMAzt6yCoareTtmCksRUoj3LKa7Gw+QjqSp7oszxOToWI1WFLbksflIiNS2ZvnDsWYdclemM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INii8xYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEE9C4CED1;
	Sat, 22 Feb 2025 12:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740225926;
	bh=AvbO5/5GTYZnYvRAUft9DyG/18ymXgC3kPeuTPaKuI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INii8xYY+1RfV8oNF/8uhHfZOeG2G+2beEP208/OrWyKS6Vu9JRlM5R1f0jTyU8wF
	 FPB9LDo153HAZF0AOVY7/G1jpIlGe8237KK/wKxbTnAJskL03zN6pyp5HefBud4Wwm
	 CsThjQmHppffyFTLW9hzoMcLzDSas+gBh+wUK44azftJtitB4X1tlTmObHz1CWBF1d
	 Ms6zv6+jFon5I9xbeYIl81D2daPLr1+5GOLR37QuOSNvVAhZBaU6Yd19puPoeHY0oj
	 tcAY8lgtJqUz8/CS5EsrVVZgXtqRPXWUaIcRixha5OhH3YM86J+EBASUKNrvnQhOPc
	 krP+CEjNctZRA==
Date: Sat, 22 Feb 2025 13:05:15 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	peterz@infradead.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, shakeel.butt@linux.dev,
	rppt@kernel.org, liam.howlett@oracle.com, surenb@google.com,
	kees@kernel.org, jannh@google.com
Subject: Re: [PATCH v2] mm,procfs: allow read-only remote mm access under
 CAP_PERFMON
Message-ID: <Z7m9e-oR4rLIiDGm@gmail.com>
References: <20250127222114.1132392-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127222114.1132392-1-andrii@kernel.org>


* Andrii Nakryiko <andrii@kernel.org> wrote:

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
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

