Return-Path: <linux-fsdevel+bounces-74015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C79D28B51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 22:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96E1830AFCE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 21:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A433327C1D;
	Thu, 15 Jan 2026 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZpOIjM2X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743E326D4C7;
	Thu, 15 Jan 2026 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768512263; cv=none; b=AId1hOqxZ5W1Dpoao98os7Tg5ohK8XMoe58FP0QPSEhZyqwLZJgjmzMnH2SDRPk6Jk4dP+b8kEhvxOkiJpcM2aK3iXiY0FGW6V9vFx0OX8AWSStjgxEXaBdZrcg58DJ+c6eC8v/KnF+aszhgn46cdeLEl4E+0+/S8G7/U0RxLtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768512263; c=relaxed/simple;
	bh=H/v7bcXCOvYCoQimdy/IGbQwcO4m3VLUShKuBeAiPOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKFdvvzkB4E2s9wlcalvR7Nqr3T8XlVZHmG63woQ/uC4rF6vVC/TH8tx8XrwWaymrQStp8PTAhdsKRg4R/zxyaSqQU0isBmgzqj2cA2gg0LVkWHm/kXab0YP2iOjquNOzUsYiqDBggi0BUlMTzuGFaGAjBSUem+GdA7N3lymLvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZpOIjM2X; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5jH/9gyhAjsMzBCKTbZPwqOjpQsENntFgEonz8xqhAg=; b=ZpOIjM2XfL7Hq1DWM/vEu3N9hF
	Y04BmrCZXC2WKIIrfvOnut+FKfkjZ7AF5/XeQLNxNRlAIyIBs93iU3aH71D1ASbybFZmTcOKBtKW6
	2AcpE4Jq/Gc/Z0TGFxxpWq/xtmm5ZuuJ/zrJXEtaJ5cAGKvCUFxNcD7gaDaBaLLW5RzeNUyRsVG0+
	iveFQqOuTiTWkZUR4nAiI9zGZC0YXOUR28pU2jAdUQMc1cDy+P5nX4MlidX4Y/PxFmBlgEjKjf/Bf
	P5p2eGPC/Bz+JYBPB2ga76yETCiEk+rpMoXhEp/d47/buUzHrpvpi69YJNkV4XI/1F+cgOP3b6j8W
	6LQLwyiQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgUoE-00000007fIE-12ju;
	Thu, 15 Jan 2026 21:23:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BC9373003C4; Thu, 15 Jan 2026 22:23:13 +0100 (CET)
Date: Thu, 15 Jan 2026 22:23:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Aaron Tomlin <atomlin@atomlin.com>, oleg@redhat.com,
	akpm@linux-foundation.org, gregkh@linuxfoundation.org,
	brauner@kernel.org, mingo@kernel.org, neelx@suse.com, sean@ashe.io,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [v3 PATCH 1/1] fs/proc: Expose mm_cpumask in /proc/[pid]/status
Message-ID: <20260115212313.GF830755@noisy.programming.kicks-ass.net>
References: <20260115205407.3050262-1-atomlin@atomlin.com>
 <20260115205407.3050262-2-atomlin@atomlin.com>
 <4a1c24ae-29b0-4c3e-a055-789edfed32fc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a1c24ae-29b0-4c3e-a055-789edfed32fc@kernel.org>

On Thu, Jan 15, 2026 at 10:19:08PM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/15/26 21:54, Aaron Tomlin wrote:
> > This patch introduces two new fields to /proc/[pid]/status to display the
> > set of CPUs, representing the CPU affinity of the process's active
> > memory context, in both mask and list format: "Cpus_active_mm" and
> > "Cpus_active_mm_list". The mm_cpumask is primarily used for TLB and
> > cache synchronisation.
> > 
> > Exposing this information allows userspace to easily describe the
> > relationship between CPUs where a memory descriptor is "active" and the
> > CPUs where the thread is allowed to execute. The primary intent is to
> > provide visibility into the "memory footprint" across CPUs, which is
> > invaluable for debugging performance issues related to IPI storms and
> > TLB shootdowns in large-scale NUMA systems. The CPU-affinity sets the
> > boundary; the mm_cpumask records the arrival; they complement each
> > other.
> > 
> > Frequent mm_cpumask changes may indicate instability in placement
> > policies or excessive task migration overhead.
> > 
> > These fields are exposed only on architectures that explicitly opt-in
> > via CONFIG_ARCH_WANT_PROC_CPUS_ACTIVE_MM. This is necessary because
> > mm_cpumask semantics vary significantly across architectures; some
> > (e.g., x86) actively maintain the mask for coherency, while others may
> > never clear bits, rendering the data misleading for this specific use
> > case. x86 is updated to select this feature by default.
> > 
> > The implementation reads the mask directly without introducing additional
> > locks or snapshots. While this implies that the hex mask and list format
> > could theoretically observe slightly different states on a rapidly
> > changing system, this "best-effort" approach aligns with the standard
> > design philosophy of /proc and avoids imposing locking overhead on
> > critical memory management paths.
> 
> 
> Yes, restricting to architectures that have the expected semantics is
> better.
> 
> ... but we better get the blessing from x86 folks :)
> 
> (CCing the x86 MM folks)

Yeah, seems like a very bad idea this. mm_cpumask really is an arch
detail you cannot rely on very much. Exposing this to userspace is
terrible.


