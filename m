Return-Path: <linux-fsdevel+bounces-74744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAwtLVgPcGlyUwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:27:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3C04DC8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC9A0B28FB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83B83ED110;
	Tue, 20 Jan 2026 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LpKW17+B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DCF379983
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947648; cv=none; b=EMby1El0je8sgYGe0wRuZc1IdOhT8bdNJywdOVLpYYbaByQm0sCUGzqXOY/we8wOLKJJF1v3U1++3wa0MuKJduDvb/pxCuzBLmoTIhfZDRsfcmHPibF3x+9tVuQwBJqfi1+Pmzp4NmtAAZPvF8AyOkk0RJJjw+mdCh2fay/uUPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947648; c=relaxed/simple;
	bh=6JP/sznWvRn24zjf74RGNA75JpcAmyT1APU4W1nKD3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZlOi+dZ1sZ2RMq5jQfUuOSLNCfcsJ26fSzEvVO0TkP3MAASurFBGA7g/F4EQf2QU9mElUtZCpMtXce+e8ixPobs+jo2tOyOKRIA9Pecjy/grhovHYB0LrJ3mPTsOtZVwE7v7jOTjel6VMB7WSDjGWO9DMBE6Gt6UVoC3c7ikH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LpKW17+B; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Jan 2026 14:20:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768947629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=27qEqXjIKzAxOtj3W7bsDUaYZJOkqZmMfwcX7lLHET0=;
	b=LpKW17+BMp7pRqcLmA8Y1uunY6pichpMlyLZ5W08ReCkxrj9rzUBpwbDbWA7fJNi0bw6dI
	VjRYxh4oHO7XBKtyqfBWCtF3poqFnJHzn0ObnZJnHOJ9cbZpy3+VvBkPKGqZiMWp8iS3LN
	NKt3kV6fV90h5vcgOmY93G6Ac+EEqbY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: akpm@linux-foundation.org, david@kernel.org, 
	lorenzo.stoakes@oracle.com, riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	harry.yoo@oracle.com, jannh@google.com, willy@infradead.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	zhengqi.arch@bytedance.com, kuba@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: add skipexec mode not to reclaim pages with
 VM_EXEC vma flag
Message-ID: <aW__D24ZrpeSPKZN@linux.dev>
References: <20260116042817.3790405-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116042817.3790405-1-jackzxcui1989@163.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74744-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 3E3C04DC8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Jan 16, 2026 at 12:28:17PM +0800, Xin Zhao wrote:
> For some embedded systems, .text segments are often fixed. In situations
> of high memory pressure, these fixed segments may be reclaimed by the
> system, leading to iowait when these segments will be used again.
> The iowait problem becomes even more severe due to the following reasons:
> 
> 1. The reclaimed code segments are often those that handle exceptional
> scenarios, which are not frequently executed. When memory pressure
> increases, the entire system can become sluggish, leading to execution of
> these seldom-used exception-handling code segments. Since these segments
> are more likely to be reclaimed from memory, this exacerbates system
> sluggishness.
> 
> 2. The reclaimed code segments used for exception handling are often
> shared by multiple tasks, causing these tasks to wait on the folio's
> PG_locked bit, further increasing I/O wait.
> 
> 3. Under memory pressure, the reclamation of code segments is often
> scattered and randomly distributed, slowing down the efficiency of block
> device reads and further exacerbating I/O wait.
> 
> While this issue could be addressed by preloading a library mlock all
> executable segments, it would lead to many code segments that are never
> used being locked, resulting in memory waste.
> 
> In systems where code execution is relatively fixed, preventing currently
> in-use code segments from being reclaimed makes sense. This acts as a
> self-adaptive way for the system to lock the necessary portions, which
> saves memory compared to locking all code segments with mlock.

Have you tried mlock2(MLOCK_ONFAULT) for your application? It will not
bring in unaccessed segments into memory and only mlocks which is
already in memory or accessed in future?


