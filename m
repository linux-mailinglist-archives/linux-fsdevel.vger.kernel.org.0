Return-Path: <linux-fsdevel+bounces-44101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1540A623A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 02:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A82E880BAD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 01:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8431EB48;
	Sat, 15 Mar 2025 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hiDkEE6J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1554C8E;
	Sat, 15 Mar 2025 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742000787; cv=none; b=Ynp/37rZORhljUWwb7XLxS07YtOKwfuS5dGCDTQsl8I6SwT4e+yFmO9acmOvJrVuzE89wiYfZKvcK9/xdUnwFxLJc4Wl7S4KV2CthMB4vAyVmUt7H0A2uqleASW71OO74fiQ+A2ybY7hvl82isQZntZFfZeIBqHMwmK4JBEPb60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742000787; c=relaxed/simple;
	bh=9oWnsRrteEppsIdl5wrmRTiQSvICywXOfyVLBTYkPCI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DCqrOskG+tEroBqGuvA5rPA64AoPn05gPWN6ORUUc8CrJ7miNFVVURZYiOmyEeWV8JOxLwPcwF7alhVFzAwNhl291qVT7hd2D2YzBnqT3jcfQ2wJovbXJDyJLpQJ8UBMGhyWGo/2B6+5G3TQObTd168QL3WickLinBYaDf3MAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hiDkEE6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50731C4CEE3;
	Sat, 15 Mar 2025 01:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1742000787;
	bh=9oWnsRrteEppsIdl5wrmRTiQSvICywXOfyVLBTYkPCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hiDkEE6J0GX+v0+CdESRoz6zAHZRHQZ72O5QKVYZ5LGWrjOEvbGY+IX/tGmhLRq9z
	 4EoNAziY4xo2uHV9ZoPku2B4MfYlNMovYNZdeyRXjA2Jx/wWHrU4V1izR9ldGxdxtk
	 4iph9jC++nXZzJojFvQ59UmAE6u4XbopROzZAjq0=
Date: Fri, 14 Mar 2025 18:06:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev,
 alexander.atanasov@virtuozzo.com, muchun.song@linux.dev,
 roman.gushchin@linux.dev, mhocko@kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 jgross@suse.com, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 mst@redhat.com, david@redhat.com, yosry.ahmed@linux.dev,
 hannes@cmpxchg.org, nphamcs@gmail.com, chengming.zhou@linux.dev,
 kanchana.p.sridhar@intel.com, llong@redhat.com, shakeel.butt@linux.dev
Subject: Re: [PATCH v2 1/4] meminfo: add a per node counter for balloon
 drivers
Message-Id: <20250314180625.8c3a2a5a990a132a7b0b9072@linux-foundation.org>
In-Reply-To: <20250314213757.244258-2-npache@redhat.com>
References: <20250314213757.244258-1-npache@redhat.com>
	<20250314213757.244258-2-npache@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 15:37:54 -0600 Nico Pache <npache@redhat.com> wrote:

> Add NR_BALLOON_PAGES counter to track memory used by balloon drivers and
> expose it through /proc/meminfo and other memory reporting interfaces.
> 
> ...
>
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -162,6 +162,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  	show_val_kb(m, "Unaccepted:     ",
>  		    global_zone_page_state(NR_UNACCEPTED));
>  #endif
> +	show_val_kb(m, "Balloon:        ",
> +		    global_node_page_state(NR_BALLOON_PAGES));

Please update Documentation/filesystems/proc.rst for this.

