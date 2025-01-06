Return-Path: <linux-fsdevel+bounces-38429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE822A02523
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 13:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5623A628E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 12:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35271DE4CB;
	Mon,  6 Jan 2025 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caf2YQnR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47201DDC1E;
	Mon,  6 Jan 2025 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736165652; cv=none; b=FC7/VrvGXs2R72Wow9h17El32yDmP/9Lztk0i9jzD63WYcjq+kY5O0WWOKmgX45+Jb3d1hb7y1yX8qwYX2oD52UUlIHuvsMuni3kfJ5KxrylC5mjT32PuVn1QzEL3CjXkC2TY+htP3RZhg2wi1W5thZemqei0PsnLM4emfPlxAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736165652; c=relaxed/simple;
	bh=pz/4rE/ts3Ms1eBIRCBDyTzHSq2kFw61Al1W77b1+dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEBW+JmJPt0BEI1C61rkJ9MER84/qFLw2lamE3rH9p1wWy0WBEj9jGjQJFbXdgrSlreJAWXU0KbTz7asths+Q+GsdQcdoDTMg4fh88HxrUy7Hxxe9f2Du4VxdoHL0rskPg6dH7+3F6VRxoceMG6L+TBDtUS6oHfnOFqy6YxPnlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caf2YQnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6915C4CED2;
	Mon,  6 Jan 2025 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736165651;
	bh=pz/4rE/ts3Ms1eBIRCBDyTzHSq2kFw61Al1W77b1+dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=caf2YQnR17OTGlwFLLjBw9d2kz0nAliuNzLceABBepOxnUXs4Aoplgb7rrbHGpq05
	 FtnokncqBowzsrN664XaoLyqWXQueddDWrGUQxyN0BuIc1F9rBcc6F/mOdhg/ImuOs
	 pg5xJbkFsiPPlmof1Z6ESp3iZXyDNH9NSre+ShxekLPkfIRtFGM4holrpVO0NI4fJ2
	 9yewgWtusNUBnEVBkE1yK0fbuw7RGWnA3Id5rtlQJWGrLtVpth+paunYIeP7dCDU6e
	 pZrODwBP58ZPZ89zcxiZkQVW+vfnPCzLGH6tRNLKJpFw6Ehq9sF1Wm4ZZAHvRaZD3s
	 YusupTuuxzjtg==
Date: Mon, 6 Jan 2025 13:14:06 +0100
From: Joel Granados <joel.granados@kernel.org>
To: yukaixiong <yukaixiong@huawei.com>
Cc: Brian Gerst <brgerst@gmail.com>, akpm@linux-foundation.org, 
	mcgrof@kernel.org, ysato@users.sourceforge.jp, dalias@libc.org, 
	glaubitz@physik.fu-berlin.de, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, kees@kernel.org, 
	j.granados@samsung.com, willy@infradead.org, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, paul@paul-moore.com, jmorris@namei.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dhowells@redhat.com, haifeng.xu@shopee.com, baolin.wang@linux.alibaba.com, 
	shikemeng@huaweicloud.com, dchinner@redhat.com, bfoster@redhat.com, souravpanda@google.com, 
	hannes@cmpxchg.org, rientjes@google.com, pasha.tatashin@soleen.com, david@redhat.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, yang@os.amperecomputing.com, 
	zev@bewilderbeest.net, serge@hallyn.com, vegard.nossum@oracle.com, 
	wangkefeng.wang@huawei.com
Subject: Re: Re: [PATCH v4 -next 13/15] x86: vdso: move the sysctl to
 arch/x86/entry/vdso/vdso32-setup.c
Message-ID: <ka6zci6bvgvyvlxf5u5g7ecefpqlrlqxwzdviukonmvtzeed54@fkseedf6ilms>
References: <20241228145746.2783627-1-yukaixiong@huawei.com>
 <20241228145746.2783627-14-yukaixiong@huawei.com>
 <CAMzpN2hf-CFpO6x58aDK_FX_6C2MBKh1g7PdV4Y=ypaeUNVfRw@mail.gmail.com>
 <3ed73b8d-1080-941b-ce6a-2d742b078193@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ed73b8d-1080-941b-ce6a-2d742b078193@huawei.com>

On Mon, Dec 30, 2024 at 02:43:12PM +0800, yukaixiong wrote:
> 
> 
> On 2024/12/30 7:05, Brian Gerst wrote:
> > On Sat, Dec 28, 2024 at 10:17 AM Kaixiong Yu <yukaixiong@huawei.com> wrote:
...
> >>          return 0;
> >>   }
> >>   __initcall(ia32_binfmt_init);
> >>   #endif /* CONFIG_SYSCTL */
> >>
> >> -#endif /* CONFIG_X86_64 */
> >
> > Brian Gerst
> > .
> Hello all；
> 
> I want to confirm that I should send a new patch series, such as "PATCH 
> v5 -next"， or just modify this patch by
> "git send-email -in-reply-to xxxxx"，or the maintainer will fix this issue ?
There are still some outstanding comments (besides this one) to the
series that you must address. This is what I propose:

1. Address the outstanding feedback in the series
2. Wait a couple of more days to see if you get more feedback
3. For your next versions, please include the tags from previous
   reviews; I see that you have not added Lorenzo's reviewed by for
   "[PATCH v4 -next 06/15] mm: mmap: move sysctl to mm/mmap.c" and
   "[PATCH v4 -next 08/15] mm: nommu: move sysctl to mm/nommu.c"
4. Once you have addresses all the issues, Send a V5. If there are still
   issues with this version, then we can cherry-pick the patches that
   are already reviewed into upstream and continue working on the ones
   with issues.

Best

-- 

Joel Granados

