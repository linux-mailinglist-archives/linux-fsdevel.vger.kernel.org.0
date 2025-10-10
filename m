Return-Path: <linux-fsdevel+bounces-63801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1D8BCE2EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 20:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D7B545BBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 18:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A3B2F1FC4;
	Fri, 10 Oct 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ711jaz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915D8C2EA;
	Fri, 10 Oct 2025 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760119341; cv=none; b=ofggAlsQCYytn3xH8pB1FRJzOOOj9n0IA6SMNJ08WkqVYvFChvV0g+8va6jKevRCLMmnhNrH66WzlOMGz7uZMeB/7wnQdKdrTmotFYsu4WHsP0RlhfCO5FgpCKZEpgQs2Y0ec2wxfPQxLIVJr2eCCLkVmZlCbErx1veyWwltKgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760119341; c=relaxed/simple;
	bh=q+KisPcXt+RcWDp+7x7C81lpwJKvshUPJCuK/IXgIR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R79IEJsI2f6o4kX3NKeSVk/O/j5M+7+SSsoQFJQQ/AUMlt6lzrMkt2fiDFO8zzBG4q2TKuahp19D6p+9FREiszbdHHjeXRm6Bg9eAcTqvpzN87dQ0g9/B1IceYS7AVZvkpVzGDolvQlnjp/KToav5kKfKupUrZBAubHexFag/YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ711jaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C0AC4CEF1;
	Fri, 10 Oct 2025 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760119341;
	bh=q+KisPcXt+RcWDp+7x7C81lpwJKvshUPJCuK/IXgIR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJ711jazmAFdHPqo8K3QuD9YSdSl4hkqsXZ6RP/lk4iOJmL9b06crvxk3hqsWwogu
	 cSzMOqdowJo1vLmtpIxn1DicZVfpHI5JmqVIcAF0zbXOvVvPoyICoXtbQpCZTO6Dku
	 kpDOEAQZ3lsHzn0duVhQsc2oC5WVL4dnGVfQI0vysv5yXbslxVEplhSIxdWFqVL9gW
	 cGyFymr3OQEXTUFKthpEzuxFgYi33Lgnog1dikBD5q/x+RuiHMxQoybV6zG8o+tEfx
	 Oh3wtxjEq0m32EuTT3f5gKFaVoIk1oq1hfBPNr20hWPs8oxiRFMxJ/zZSTsH/IJj4j
	 ycQ1f3S3fIymw==
Date: Fri, 10 Oct 2025 11:02:19 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
	kernel@pankajraghav.com,
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
	nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Message-ID: <aOlKK0b2Ht8FrDXS@bombadil.infradead.org>
References: <20251010173906.3128789-1-ziy@nvidia.com>
 <20251010173906.3128789-2-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010173906.3128789-2-ziy@nvidia.com>

On Fri, Oct 10, 2025 at 01:39:05PM -0400, Zi Yan wrote:
> Page cache folios from a file system that support large block size (LBS)
> can have minimal folio order greater than 0, thus a high order folio might
> not be able to be split down to order-0. Commit e220917fa507 ("mm: split a
> folio in minimum folio order chunks") bumps the target order of
> split_huge_page*() to the minimum allowed order when splitting a LBS folio.
> This causes confusion for some split_huge_page*() callers like memory
> failure handling code, since they expect after-split folios all have
> order-0 when split succeeds but in really get min_order_for_split() order
> folios.
> 
> Fix it by failing a split if the folio cannot be split to the target order.
> 
> Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks")
> [The test poisons LBS folios, which cannot be split to order-0 folios, and
> also tries to poison all memory. The non split LBS folios take more memory
> than the test anticipated, leading to OOM. The patch fixed the kernel
> warning and the test needs some change to avoid OOM.]
> Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@google.com/
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

