Return-Path: <linux-fsdevel+bounces-49775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1AFAC24C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 16:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A660543511
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4104F295517;
	Fri, 23 May 2025 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gEuVSLBC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F52DCBE3
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748009507; cv=none; b=lxV9KO0ltykokIiH8ZLjsXR5p99PaWcEe3bEJGM/5F5mDakIl2JJOD/iS1ubP0U5glH/FV5XK8uog1gPOdkz8k4JxloFzU+wdjv1tSpVas1BS5ZBqQzUwDCRLJmZ+4wnLjlxp7cfD71dgHWURyuiPm8i941IJQ94pTU8kXx/PbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748009507; c=relaxed/simple;
	bh=SSTtUNhFkPDZyNf4DwYT+gkdZj3odlnPp9bpfK7im0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CR2v/at6wFstHx/X+Ws2t5D0FxC4nCpHgyl43YxYJFMt8y/od9uHdI8SG9GUSZhr/f2V4ApncqgOfrN5WwMaXTQl82EUoTIXsc/cfzoCaHrSu1LyGlW/ta2f0RAjtFuOU/0fifGf4Z2kNRwB6tVn/QyrdXEy2/F4X/RZFDHrN54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gEuVSLBC; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 23 May 2025 07:11:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748009502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iyyet1GA+O6fAfZqBulBiVthKT8i/nPLXStWszD73KU=;
	b=gEuVSLBCr5UjNnMYC8OeQ3Sthe8ILLXGKsTiqBZPNnh4RyR8kxUPoWpHiZYLAfwebC2QyI
	BItrPCu4pTBo0vIFVnSanAmYCAnDvTGGe4eVyuO8V8zdnITDmnb+eS3sIJBPODSnrk/0gM
	jLMF+g84BE546fueju13H+8zJ2fs3GY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, david@redhat.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: fix the inaccurate memory statistics issue for
 users
Message-ID: <67n3snrowiyxjw6grddyer7np5rpnpg4x5f6bsyonmgcc5k5eq@s5v4ux27i4fw>
References: <3dd21f662925c108cfe706c8954e8c201a327550.1747969935.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dd21f662925c108cfe706c8954e8c201a327550.1747969935.git.baolin.wang@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT

CC Mathieu

On Fri, May 23, 2025 at 11:16:13AM +0800, Baolin Wang wrote:
> On some large machines with a high number of CPUs running a 64K kernel,
> we found that the 'RES' field is always 0 displayed by the top command
> for some processes, which will cause a lot of confusion for users.
> 
>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>  875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
>       1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd
> 
> The main reason is that the batch size of the percpu counter is quite large
> on these machines, caching a significant percpu value, since converting mm's
> rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's rss
> stats into percpu_counter"). Intuitively, the batch number should be optimized,
> but on some paths, performance may take precedence over statistical accuracy.
> Therefore, introducing a new interface to add the percpu statistical count
> and display it to users, which can remove the confusion. In addition, this
> change is not expected to be on a performance-critical path, so the modification
> should be acceptable.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Hi Baolin, this seems reasonale. For long term Mathieu is planning to
fix this with newer hierarchical percpu counter until then this looks
good.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

