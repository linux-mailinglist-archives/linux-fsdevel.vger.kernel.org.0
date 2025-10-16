Return-Path: <linux-fsdevel+bounces-64395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52973BE57A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 22:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0489581B0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 20:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15C72E1F02;
	Thu, 16 Oct 2025 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2GG/tL4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6122E1742;
	Thu, 16 Oct 2025 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648366; cv=none; b=kBG/5dwsN2OuYUnId92xGkWU6WGBP8tgt+J6rhuiFRCfqZRc9SZ52W/FY2onuzzfPnj13s9XF0ciZbdjq3jl9mZvoy3rBCs5up4ivBn+7HG9EUazAD85fXpdaBw+mNE68X6pEkjR04jUSt4rRAW2TNJW5RAC8udgekZs84hzpHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648366; c=relaxed/simple;
	bh=On0cJn7W8Gh4erOEbo4yZw/MYHtBNjnFLohMdduX5Tk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gV2fN32jYsWDh6nEQgxepGI/Jvayvjy8uCReNqU4NKfbtK1q/K5yydWtSHIGhfiBP9RobVGpMezxvojCZaBYvJuhgyjmYuuNjFYJGh1xhmXza001+6ioakbVvOavItw+K3cEZ2sxX/3jIUxSfwbJp8PWfcczpmWdfXggr7n/kpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2GG/tL4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEECFC4CEF1;
	Thu, 16 Oct 2025 20:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760648365;
	bh=On0cJn7W8Gh4erOEbo4yZw/MYHtBNjnFLohMdduX5Tk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2GG/tL4K3Ivbf3xyWHn/Vtu/7WWXC55vU//3w11E7n1pREIksTdNSGEroj52SzDBM
	 4P2ldDBbTRfKAJFhz2Rn7lYgMJSYjzRJfAK5cl0MLrO10kUjs7RW35FkdRHU8sGejk
	 zt8FDRRwj38Hp9385EIAHhFvQFjlT5IKTW4Ggu0o=
Date: Thu, 16 Oct 2025 13:59:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, linmiaohe@huawei.com,
 david@redhat.com, jane.chu@oracle.com, kernel@pankajraghav.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, mcgrof@kernel.org,
 nao.horiguchi@gmail.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 1/3] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Message-Id: <20251016135924.6390f12b04ead41d977102ec@linux-foundation.org>
In-Reply-To: <49BBF89F-C185-4991-B0BB-7CE7AC8130EA@nvidia.com>
References: <20251016033452.125479-1-ziy@nvidia.com>
	<20251016033452.125479-2-ziy@nvidia.com>
	<20251016073154.6vfydmo6lnvgyuzz@master>
	<49BBF89F-C185-4991-B0BB-7CE7AC8130EA@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 10:32:17 -0400 Zi Yan <ziy@nvidia.com> wrote:

> > Do we want to cc stable?
> 
> This only triggers a warning, so I am inclined not to.
> But some config decides to crash on kernel warnings. If anyone thinks
> it is worth ccing stable, please let me know.

Yes please.  Kernel warnings are pretty serious and I do like to fix
them in -stable when possible.

That means this patch will have a different routing and priority than
the other two so please split the warning fix out from the series.

