Return-Path: <linux-fsdevel+bounces-11796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127058572EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 01:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143F4281092
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 00:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A31D267;
	Fri, 16 Feb 2024 00:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KYXR1+er"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5B89445;
	Fri, 16 Feb 2024 00:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044882; cv=none; b=TbGu90giDw3o4acrkNtvDyuvhPPjc3RNJ5fDV58/4LhztENJbWhqvaRadEvJatkABgGLaOjZDX8UtO9JSlG51S1zwRkzJL9zEmqfqJ30PUn8j+qRO2WUpIGaYMZO2sbPrVrgN9v3EaeTvhgjqO3FZUZCsoHJGlXEkNRDlB2yKiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044882; c=relaxed/simple;
	bh=ZIEOMXwsk6UMZSFSW/RNZRCFWY8oX4WOTkp26Ser0Og=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GA8lakSEqejppXhcUxfAg4xo+67t84NGGfXJUHW42AvOr8fzSrEqyNuwLniJ8p7TZrrB3tFQOJab4bQdyP0xUPs1voLJYGZlsHJq/Yp6A1PGLXzL9JDbBgkkQ8D5k4c36l8cY2+rDbt/lXVFip0n+OFCqJ3sieDDJWBVALPZFac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KYXR1+er; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA5BC433F1;
	Fri, 16 Feb 2024 00:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708044881;
	bh=ZIEOMXwsk6UMZSFSW/RNZRCFWY8oX4WOTkp26Ser0Og=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KYXR1+er6CkT6dVj5BHoTm5sdpzXInSUFDjwd/A/Yjb7LGJBkBRSRWj5hWf4h9LKS
	 C+G7d4aLzLoAak5aMT/1pDhdwp5e2TSMBrg/VJtTWmvU2Yy7hQLmAYDDo5TkqKMuWM
	 2DEbMt/kOf0QnfRdomb4IRyy3uv3wiqCnc9MsNuo=
Date: Thu, 15 Feb 2024 16:54:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
 dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
 corbet@lwn.net, void@manifault.com, peterz@infradead.org,
 juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
 arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
 rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
 yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
 hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
 ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org,
 ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
Subject: Re: [PATCH v3 13/35] lib: add allocation tagging support for memory
 allocation profiling
Message-Id: <20240215165438.cd4f849b291c9689a19ba505@linux-foundation.org>
In-Reply-To: <20240212213922.783301-14-surenb@google.com>
References: <20240212213922.783301-1-surenb@google.com>
	<20240212213922.783301-14-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 13:38:59 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> +Example output.
> +
> +::
> +
> +    > cat /proc/allocinfo
> +
> +      153MiB     mm/slub.c:1826 module:slub func:alloc_slab_page
> +     6.08MiB     mm/slab_common.c:950 module:slab_common func:_kmalloc_order
> +     5.09MiB     mm/memcontrol.c:2814 module:memcontrol func:alloc_slab_obj_exts
> +     4.54MiB     mm/page_alloc.c:5777 module:page_alloc func:alloc_pages_exact
> +     1.32MiB     include/asm-generic/pgalloc.h:63 module:pgtable func:__pte_alloc_one

I don't really like the fancy MiB stuff.  Wouldn't it be better to just
present the amount of memory in plain old bytes, so people can use sort
-n on it?  And it's easier to tell big-from-small at a glance because
big has more digits.

Also, the first thing any sort of downstream processing of this data is
going to have to do is to convert the fancified output back into
plain-old-bytes.  So why not just emit plain-old-bytes?

If someone wants the fancy output (and nobody does) then that can be
done in userspace.

