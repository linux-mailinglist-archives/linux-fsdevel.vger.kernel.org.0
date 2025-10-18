Return-Path: <linux-fsdevel+bounces-64559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5906BEC12D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 02:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A3D4225A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 00:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6873523A;
	Sat, 18 Oct 2025 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tvRVTBeM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3501F3C17;
	Sat, 18 Oct 2025 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745926; cv=none; b=Z0bz+7dE9zkcIkjAk0M9i/3Sc0s6UaAiDQvvLw761bvukipVGbblL7cJeISjYZKiixdehpvkBNtacPtZdL4t5J50oGHNWcAM7uGn/wGVzf4NWvpQM1Sw3A0nB/sRmjHChQC6nJiAy958LlKsgHW/5vRdtlG2gWZfkgOYL7Fneok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745926; c=relaxed/simple;
	bh=WOIXD2aj1erNpVG0tSFDsLzoqQwtXekv2ZjXklHIzZI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Wzl64rA2NX3xwscxGbjrm00ESRJBTG/Ju893XeEl1GyKM08RdASzQUlIRnNi6zkoqtWtWKufKH/OyWzXTs+qJ3NsPJpMkvDsOVOcI7bRnY63Lay00XXrrd37yIWuTln21w592ahAwtr/LH2Zqqfk2QOKksYe/Mv4p58s3x5VhoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tvRVTBeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0EBC4CEE7;
	Sat, 18 Oct 2025 00:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760745925;
	bh=WOIXD2aj1erNpVG0tSFDsLzoqQwtXekv2ZjXklHIzZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tvRVTBeMogOKBZQEioCVJqqQwNHuhkgvhmb+ufpuFWlzMbv59merChNVUQK3M73fV
	 JAuZ65tYuEfU1ZZ4M33bDFyg9kZzEyry/10c10cCVADBBfjlpT7zRvCW9due+1xxL8
	 uFVHVnzws9L9aFv1gkuCgeBSBWhQ4DtC0oPMX10A=
Date: Fri, 17 Oct 2025 17:05:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, Wei Yang <richard.weiyang@gmail.com>,
 linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
 kernel@pankajraghav.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, mcgrof@kernel.org,
 nao.horiguchi@gmail.com, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
 <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
 <lance.yang@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 1/3] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Message-Id: <20251017170524.34cccc084f58d3996ff70c8a@linux-foundation.org>
In-Reply-To: <557fd56d-1a4c-4c65-8db6-34546c9ce8be@lucifer.local>
References: <20251016033452.125479-1-ziy@nvidia.com>
	<20251016033452.125479-2-ziy@nvidia.com>
	<20251016073154.6vfydmo6lnvgyuzz@master>
	<49BBF89F-C185-4991-B0BB-7CE7AC8130EA@nvidia.com>
	<20251016135924.6390f12b04ead41d977102ec@linux-foundation.org>
	<E88B5579-DE01-4F33-B666-CC29F32EEF70@nvidia.com>
	<16b10383-1d3a-428c-918a-3bbf1f9f495d@lucifer.local>
	<9567b456-5656-4a48-a826-332417d76585@lucifer.local>
	<FEFDFFAF-63BD-463A-B8B2-D2B2744DEE2F@nvidia.com>
	<557fd56d-1a4c-4c65-8db6-34546c9ce8be@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 15:32:13 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> > it. I will hold on sending new version of this patchset until either you or
> > Andrew give me a clear guidance on how to send this patchset.
> 
> I mean if you want to delay resending this until the hotfix is sorted out then
> just reply to 0/3 saying 'please drop this until that patch is merged'.
> 
> Otherwise it looks live.

Yeah, hotfixes come first and separately please.  A hotfix will hit
mainline in a week or so.  Whether or not they are cc:stable.  The
not-hotfix material won't hit mainline for as long as two months!

So mixing hotfixes with next-merge-window patches is to be avoided.

Note that a "hotfix" may or may not be cc:stable - it depends on
whether the Fixes: commit was present in earlier kernel releases.


Actually, if a developer has a hotfix as well as a bunch of
next-merge-window material then it's really best to send the hotfix
only.  Hold off on the next-merge-window material so the hotfix gets
standalone testing.  Because it's possible that the next-merge-window
material accidentally fixes an issue in the hotfix.

(otoh the hotfixes *will* get that standalone testing from people who
test Linus-latest, but it's bad of us to depend on that!)

I regularly get patchsets which mix hotfixes (sometimes cc:stable) with
next-merge-window material.  Pretty often the hotfix isn't very urgent
so I'll say screwit and merge it all as-is, after adding a cc:stable. 
The hotfix will get merged and backported eventually.

I hope that nobody really needs to worry much about all this stuff.
Juggling patch priority and timing is what akpms are for.


