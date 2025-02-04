Return-Path: <linux-fsdevel+bounces-40783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45A1A27799
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 17:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26573A8015
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 16:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2587521577F;
	Tue,  4 Feb 2025 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wFlZUecE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D087A2153EA
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687891; cv=none; b=SOKvXYPlnczOzDjBA0sY8JiX49tI8Y9xnvuulSeIgVqYkPlg8cfMxxr0XsG7N/xm7EoF1WUrgdY9tU39Fg8pEgzThEgHL1/q9O/zIhDj8b2rxZWwvmTsAeb/1shngZ/qaD4o5kq9E9Pj77TR1EqDzXiZZ/OIATHa8HdwG/VpHTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687891; c=relaxed/simple;
	bh=qUs5qxq7TlNWEk5AqD2e8U8+LYK0ti0l2GCGHyetHIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPNWED+a2Wq+MpD5CBiEnoMl2CBiqWySuJwe7Hv9O1XQep89bYK0lGN4CJ57PejU6vqIV4xV4o6SW1WOhRLyYdAHvcA1cZ+mpF1f2xKaCmPXp96D4oTIh/4bCyCnQ0vsjB2w6FuIhd6eEVGpdc3q+9eVgjZ7RslBX4ZRSmlkUxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wFlZUecE; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 4 Feb 2025 08:51:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738687874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2anvafoIZ1StH+i5LxOCWHXeT3UJ7rs0jfPknzu/uUk=;
	b=wFlZUecEJuyWp+dj1/Tr87HsPFUjVNDdnOvx6vK1RQVn1kPNbzFUg+lcaygeVj0FijX2eY
	mbR2F22jyypEvrL3coOoVt6Q/2eetPY4BRvo/uCO35Bn3utGU3Pyrz3zUis79MO2kabeLv
	DrlVLkjIecr/EJb933L7HWX5qiCq8pM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Sang <oliver.sang@intel.com>, John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 1/6] pidfd: add PIDFD_SELF* sentinels to refer to own
 thread/process
Message-ID: <nw5xnaile4phgaqxf77jhqlguscgicfwsfspgtxeuronrvwqai@xykuanoemqay>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
 <24315a16a3d01a548dd45c7515f7d51c767e954e.1738268370.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24315a16a3d01a548dd45c7515f7d51c767e954e.1738268370.git.lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 30, 2025 at 08:40:26PM +0000, Lorenzo Stoakes wrote:
> It is useful to be able to utilise the pidfd mechanism to reference the
> current thread or process (from a userland point of view - thread group
> leader from the kernel's point of view).
> 
> Therefore introduce PIDFD_SELF_THREAD to refer to the current thread, and
> PIDFD_SELF_THREAD_GROUP to refer to the current thread group leader.
> 
> For convenience and to avoid confusion from userland's perspective we alias
> these:
> 
> * PIDFD_SELF is an alias for PIDFD_SELF_THREAD - This is nearly always what
>   the user will want to use, as they would find it surprising if for
>   instance fd's were unshared()'d and they wanted to invoke pidfd_getfd()
>   and that failed.
> 
> * PIDFD_SELF_PROCESS is an alias for PIDFD_SELF_THREAD_GROUP - Most users
>   have no concept of thread groups or what a thread group leader is, and
>   from userland's perspective and nomenclature this is what userland
>   considers to be a process.
> 
> We adjust pidfd_get_task() and the pidfd_send_signal() system call with
> specific handling for this, implementing this functionality for
> process_madvise(), process_mrelease() (albeit, using it here wouldn't
> really make sense) and pidfd_send_signal().
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

