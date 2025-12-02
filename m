Return-Path: <linux-fsdevel+bounces-70468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF2FC9C283
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 17:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371693ADF6A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED34296BC9;
	Tue,  2 Dec 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y0RcuWOU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FF230DEDE
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691711; cv=none; b=t5ts66sPn36aDNv/SKvElGtryHZaBDVQTnnC6Pv6Z6S7WO/i9aVzrzrduuISTMB39xpOQChVF2KOByfZ557w9SmIuAGvnPTk1x2d1K2VKqZssZ8rjro56UNZE1UPR/l3U0hJWZ9j2ffT0f+gouU/0ufBnO7zCJXT9wDi+i98Wd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691711; c=relaxed/simple;
	bh=9/4WFakKa57+xP8PcJHm4JmGUkxo5sKZ7S+j3jhybKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT2H3/GGXa6JrsglxUmslNfqN+euq44IPxkfEB//C+kr0Gwde8nQgQVix8XdC9VjJMOtsySV8ajt/JHqA7TabEvsYfDPosOyo5awB5skigt9J34LUIrlQCji/QAi+L55Qd5fAUxRx8zFmiYO+fMVG2tHiofVTUqgST8qpNCFBX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y0RcuWOU; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 2 Dec 2025 08:08:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764691707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AxYnZ3DcAYZN6exEXvCVyOz/bBfugXcxeWApesjtppI=;
	b=Y0RcuWOU2Tiiv1djdr/LQ6eEENhEJga8bTu9p9hWPgTUYmQ/vOrK7vo4UtYotQYM2xjBv6
	uYRw5P3VSDZGKgz1+ETzvodZUGdK53XxzKOcOiU025/g1uEHf/ITL0caUJh15QUrBbLP0t
	0IUSq+EAbm3wHGt3guHwOnkFGRoOlIg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com, akpm@linux-foundation.org, 
	vbabka@suse.cz, surenb@google.com, jackmanb@google.com, ziy@nvidia.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH -next] cgroup: switch to css_is_online() helper
Message-ID: <ep2hqjcg4t5drnfms3cygtcuotqca5ftzw4zanepteyjlxexpx@6ad6mqxs7stb>
References: <20251202025747.1658159-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202025747.1658159-1-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 02, 2025 at 02:57:47AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Use the new css_is_online() helper that has been introduced to check css
> online state, instead of testing the CSS_ONLINE flag directly. This
> improves readability and centralizes the state check logic.
> 
> No functional changes intended.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

