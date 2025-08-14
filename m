Return-Path: <linux-fsdevel+bounces-57903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7F2B269D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 16:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51489A268A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C00A1DF248;
	Thu, 14 Aug 2025 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SyUENzi3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C7B321428;
	Thu, 14 Aug 2025 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182273; cv=none; b=WQvxLaMzg0MNpyYenvhKpQ4cabB+jTIpYm5LA5VYeTrq1WTCSmplslGR6xkb03mCYj7r1kAigKEm3h8MMAzxc7YSn+8SXHSrDb6vqaGDL36j5qyYJus/4G/Y+bonDqVHNHX+g8JCxket/H/T62trK0oUxmFI6uO8zcM10EWQOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182273; c=relaxed/simple;
	bh=V9N00Nz47F+r23uiQqjpLoPEPkgzHhQb2JmjTGvHkOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6K8RWSzaVTiWNwHaVa0Yxqx2TxxfrU9GRwa7BmFLJbyo92SnyiZRoRRo1VP6jHZw+0I6MZBPr5CyKPMhPPj9NL3rfeHJh3j9FGoUFldli4/n5mfBlTQZLLBNpWepjEWV3eStKNFKnBLwTn3WvUy2LeXK51QUyZNl2jGNE29gso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SyUENzi3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=eDgRnsuLo8vubpJ2VjlcjumR5pIerCmW/K+TXJ575Pg=; b=SyUENzi3LjRgnMVxZh9rxyPzEb
	pvjQGv+BzBjZNJOoDdH1M5wIrmhjf8BYuSm0iS4vljrHEukpEaSYTVBLTtdm7Cu6vwB8npzhj2AWW
	pVxFXgxAZ8I5z3fWWo0KGJSvZ69RB5OrUqwhnfWUWdirkyxkhnSNV30tLX2DIPVkFi3PQ7mmyXg8+
	sBV6ANNZjFCzy0gjxtBAMoB5CVQ9ZZYGtE/c7snxaNtYteGpWDA9AuL4hA93TA4MpDfacuYwY+EQX
	K7o3nvZPdYInwTfBUSKDNTySR0FsnxrOOTDy7Gsu7pWFuERAFxKnYHtMvtZbJwMfjqAuaRAWB2E+y
	nbFygHyg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umZ4w-0000000GS8T-0A08;
	Thu, 14 Aug 2025 14:37:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 550C7302DA9; Thu, 14 Aug 2025 16:37:17 +0200 (CEST)
Date: Thu, 14 Aug 2025 16:37:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	len brown <len.brown@intel.com>, pavel machek <pavel@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nico Pache <npache@redhat.com>, xu xin <xu.xin16@zte.com.cn>,
	wangfushuai <wangfushuai@baidu.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Adrian Ratiu <adrian.ratiu@collabora.com>, linux-pm@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/9] freezer: Introduce freeze priority model to
 address process dependency issues
Message-ID: <20250814143717.GY4067720@noisy.programming.kicks-ass.net>
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250807121418.139765-1-zhangzihuan@kylinos.cn>

On Thu, Aug 07, 2025 at 08:14:09PM +0800, Zihuan Zhang wrote:

> Freeze Window Begins
> 
>     [process A] - epoll_wait()
>         │
>         ▼
>     [process B] - event source (already frozen)
> 

Can we make epoll_wait() TASK_FREEZABLE? AFAICT it doesn't hold any
resources, it just sits there waiting for stuff.

