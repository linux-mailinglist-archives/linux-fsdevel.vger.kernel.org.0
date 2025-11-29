Return-Path: <linux-fsdevel+bounces-70213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F46C93B94
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 10:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09ED2348B85
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 09:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E39274B4A;
	Sat, 29 Nov 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WdQujMwn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65E336D4EF;
	Sat, 29 Nov 2025 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764409492; cv=none; b=Fo1e4EhkutbDHZqW2ZMzoQc1a9xDkCUxOllyl4MjwHLWScm71XaHyEKB0TF536u45SSHHxTg1jmNrMMimddPaUU8bcYWxtw6QhszQJ7Ag155eVgBK+S7fZcI0FpYEku6CxJJhakI1qUlcg6XvoDAA4n9hD5qJobSz9IT//Pcnlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764409492; c=relaxed/simple;
	bh=7x5WBJk+LvtOs+NucZTK1bQeYiT7V2jpesI3ynK4xh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqwHJ8l1y81YN5RqUlAvwNBR6jQ48GGlpsv4SucYvDDDQD2mKPpMRim+/NYqe+hfks6ijTyakAnNKwNhpOiAELGHVI0+n+wfKn07Vdn4gI06mF1uZyde5ajXrL639HzVqomGDqZrJcE6wTqqTWOxUae7W4hOtLqZaQhbMsKgYo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WdQujMwn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Uo8TBg8AtxzlOE4Yqx7kavPid3wS0PC/nG9PfSHZKxs=; b=WdQujMwngoaiotKE+sjfTEDix5
	/Quh6v3dAOZbKwpiPRmLYx/4yq+iMPUTybuIxveIGsrIk9ol/Pwww2I6MKFzY9/8bfk5KC9gvcxlJ
	+XI3SdRUCbwXwlTUuxNp4Nssse82eDUiCkIRhOxgRrdnjJJ1nLFoXEuKXjIQtr+/z152+d0nhkZbV
	NMeLLVqYZSe2YuFhUS0OEmOm50coh4aYAoV2OlrFIZlICaBRiN2AX66N1ci9LOUKXUn0WTkKBJpBx
	vWjAt7xOnJlyU4zU5+O3ctln5KTWQG8AXSGsbGXZvUeB7266YsqjJelIwqS4mTr5vMv5iHIN6lym+
	pwkRJgvw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vPHVY-00000008MI2-2f73;
	Sat, 29 Nov 2025 09:44:48 +0000
Date: Sat, 29 Nov 2025 09:44:48 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: will@kernel.org, linux@armlinux.org.uk, bigeasy@linutronix.de,
	rmk+kernel@armlinux.org.uk, akpm@linux-foundation.org,
	brauner@kernel.org, catalin.marinas@arm.com, hch@lst.de,
	jack@suse.com, linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, pangliyuan1@huawei.com,
	wangkefeng.wang@huawei.com, wozizhi@huaweicloud.com,
	yangerkun@huawei.com, lilinjie8@huawei.com, liaohua4@huawei.com
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
Message-ID: <20251129094448.GL3538@ZenIV>
References: <20251129090813.GK3538@ZenIV>
 <20251129092545.5181-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129092545.5181-1-xieyuanbin1@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 29, 2025 at 05:25:45PM +0800, Xie Yuanbin wrote:
> On Sat, 29 Nov 2025 09:08:13 +0000, Al Viro wrote:
> > On Sat, Nov 29, 2025 at 12:08:17PM +0800, Xie Yuanbin wrote:
> >
> >> I think the `user_mode(regs)` check is necessary because the label
> >> no_context actually jumps to __do_kernel_fault(), whereas page fault
> >> from user mode should jump to `__do_user_fault()`.
> >>
> >> Alternatively, we would need to change `goto no_context` to
> >> `goto bad_area`. Or perhaps I misunderstood something, please point it out.
> >
> > FWIW, goto bad_area has an obvious problem: uses of 'fault' value, which
> > contains garbage.
> 
> Yes, I know it, I just omitted it. Thank you for pointing that out.
> 
> > or
> > 	if (unlikely(addr >= TASK_SIZE)) {
> > 		fault = 0;
> > 		code = SEGV_MAPERR;
> > 		goto bad_area;
> > 	}
> 
> In fact, I have already submitted another patch, which is exactly the way
> as you described:
> Link: https://lore.kernel.org/20251127140109.191657-1-xieyuanbin1@huawei.com
> 
> The only difference is that I will move the judgment to before
> local_irq_enable(). The reason for doing this is to fix another bug,
> you can find more details about it here:
> Link: https://lore.kernel.org/20250925025744.6807-1-xieyuanbin1@huawei.com
> Link: https://lore.kernel.org/20251129021815.9679-1-xieyuanbin1@huawei.com

AFAICS, your patch does nothing to the case when we hit kernel address from
kernel mode, which is what triggers that "block in RCU mode for no good reason"
fun...

