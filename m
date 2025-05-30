Return-Path: <linux-fsdevel+bounces-50134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB74AC870F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 05:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE621BC120D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 03:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1A71C8FBA;
	Fri, 30 May 2025 03:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lrjw8+vj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001C454652;
	Fri, 30 May 2025 03:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748577195; cv=none; b=At6xTqgVrqEqVE0FNvQQItaMPJaGQE657dht+Dy+JzVDHhEwWTsiFlNvCdmPuBGJ2m8yuLtUJJadVJq6WhfqwnuiPkE02omxX5a/jAairU+O5MX+8cKwrCzhSSVbY9l4HxG5Tb2m7eXcbcM6u3kRvMYPZmueuFcHm+Svx6ivJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748577195; c=relaxed/simple;
	bh=dQQUntt1ss5Ok8Y5E6ZNrvwcuMGQPmjWrkgxYZOEJts=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WW3MeHk9OOO6vq4HbIZjbsrsxQ+JWE5rLsCx64aBLOc4t8jPlEABPVwZI7LwzEvTONSOhmSVoTHxcy9KTqKVOcAOSEjewLGwlEsbmojsXJHLSEIXw9Gdr0Nx8nX5OdGF7bGXQo6IOaMYZFEk7SSz+nBZhIC7Qw9Pshol02Nwh78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lrjw8+vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E929EC4CEE9;
	Fri, 30 May 2025 03:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1748577194;
	bh=dQQUntt1ss5Ok8Y5E6ZNrvwcuMGQPmjWrkgxYZOEJts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lrjw8+vjHne+Cm4nbQaTnY/Yw0sQCNrd1cLA4RbmsUYgUlPBQTKvVDv0t1vHDCFDX
	 pqQAHc+ACogHUOQVS+w2L4TePGUdleQf2ZDMYi3Nsup9QWV94FZgEGc/6znc48+fZW
	 FRIQlR2e25SfNqJBkSJhHz/VZImmH9BV8GyeAczc=
Date: Thu, 29 May 2025 20:53:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: david@redhat.com, shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, donettom@linux.ibm.com,
 aboorvad@linux.ibm.com, sj@kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix the inaccurate memory statistics issue for
 users
Message-Id: <20250529205313.a1285b431bbec2c54d80266d@linux-foundation.org>
In-Reply-To: <4f0fd51eb4f48c1a34226456b7a8b4ebff11bf72.1748051851.git.baolin.wang@linux.alibaba.com>
References: <4f0fd51eb4f48c1a34226456b7a8b4ebff11bf72.1748051851.git.baolin.wang@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 May 2025 09:59:53 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> On some large machines with a high number of CPUs running a 64K pagesize
> kernel, we found that the 'RES' field is always 0 displayed by the top
> command for some processes, which will cause a lot of confusion for users.
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
> Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")

Three years ago.

> Tested-by Donet Tom <donettom@linux.ibm.com>
> Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Thanks, I added cc:stable to this.


