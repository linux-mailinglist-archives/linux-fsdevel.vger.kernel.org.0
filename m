Return-Path: <linux-fsdevel+bounces-43008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D5EA4CEA3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 23:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548FC18897F0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 22:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D595223907E;
	Mon,  3 Mar 2025 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sCxrpcyQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132D51F03C7;
	Mon,  3 Mar 2025 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041814; cv=none; b=RXr1vd/U1dpWr7u1WmLQ/Khdbx/GgK8owh4iqHw/X3zZIOAa5q3D/1H5x4FjvbRVxbVLMuuNfppO97FhLTzfkFcGVfYEtjKCt109V0gjQY/DC3d5MJKw0jji6js6FG/XZ7l1T7nvSAOygQVvj67y9wZrlndi0y2/zp7SDdnosto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041814; c=relaxed/simple;
	bh=Ye4xOllgSwhjXuDnyBuAKIEjHgB7tBT2sx0Mlr/Fn7g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AKk5Hnm3NKwRqF27fGpH3tW4rQkl6m2QpYd4ZvXsGuhZiWsevcGH+93apDMkJarFkQr8s+UhHjgW49Esxo6YVQvuiA/OTugyXxQtZRFBwXWobOsdLp5COpzLFXtdkPEFivbcXMI7uz/5mD/KN5ChrUU2A3uOV0sO+kv3n2dXedQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sCxrpcyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2066C4CED6;
	Mon,  3 Mar 2025 22:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741041813;
	bh=Ye4xOllgSwhjXuDnyBuAKIEjHgB7tBT2sx0Mlr/Fn7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sCxrpcyQEg5yYBT2gW7pbCgt0yG3N/wlf3mWDI4OGJqicQA+KFPrU8gmIwdRlmZrE
	 Vhrdglv/yHorwkHx/4JsNBgWrl1E0iQkC9p/QSt42U6PomymhGBg6FCQ8eRXM/ovjp
	 aWQwvj44KHZCQUuPyIcdXIrEvPMbBDKjvUujtAhM=
Date: Mon, 3 Mar 2025 14:43:32 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Michal =?ISO-8859-1?Q?Koutn=FD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski
 <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn
 <jannh@google.com>
Subject: Re: [PATCH v3 00/20] mm: MM owner tracking for large folios
 (!hugetlb) + CONFIG_NO_PAGE_MAPCOUNT
Message-Id: <20250303144332.4cb51677966b515ee0c89a44@linux-foundation.org>
In-Reply-To: <20250303163014.1128035-1-david@redhat.com>
References: <20250303163014.1128035-1-david@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Mar 2025 17:29:53 +0100 David Hildenbrand <david@redhat.com> wrote:

> Some smaller change based on Zi Yan's feedback (thanks!).
> 
> 
> Let's add an "easy" way to decide -- without false positives, without
> page-mapcounts and without page table/rmap scanning -- whether a large
> folio is "certainly mapped exclusively" into a single MM, or whether it
> "maybe mapped shared" into multiple MMs.
> 
> Use that information to implement Copy-on-Write reuse, to convert
> folio_likely_mapped_shared() to folio_maybe_mapped_share(), and to
> introduce a kernel config option that let's us not use+maintain
> per-page mapcounts in large folios anymore.
> 
> ...
>
> The goal is to make CONFIG_NO_PAGE_MAPCOUNT the default at some point,
> to then slowly make it the only option, as we learn about real-life
> impacts and possible ways to mitigate them.

I expect that we'll get very little runtime testing this way, and we
won't hear about that testing unless there's a failure.

Part of me wants to make it default on right now, but that's perhaps a
bit mean to linux-next testers.

Or perhaps default-off for now and switch to default-y for 6.15-rcX?

I suggest this just to push things along more aggressively - we may
choose to return to default-off after a few weeks of -rcX.


