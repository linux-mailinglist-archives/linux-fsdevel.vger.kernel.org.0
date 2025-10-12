Return-Path: <linux-fsdevel+bounces-63855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8AFBD007E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 10:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA2F94E2E7A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 08:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC9E258ED2;
	Sun, 12 Oct 2025 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="dy0RQGhT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE22A23B62C;
	Sun, 12 Oct 2025 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760257476; cv=none; b=kqTx61Zb1MNO+HdxawxLDxPTDgkTqItRXtiytTruHOriYiNtBwHe+b2Euvv0beJPJer74R0Z0kFjAq8KLfhoCtvYU2PqnxyC0BovkMjYhUVmr8NIt9cd9hzra0JmPDV4bgyHqQurO34oq4AdKBxmZfYCbvN1PnEd7Asnx+Kdu94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760257476; c=relaxed/simple;
	bh=FBbIun+3fHA8LljlIqTp4GIrvNglfpYAuuvY4cbNA7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=It4LB9mLJe8l7+fttZSmYMB9mva0GzPzVVMHf/MxFBOAQPGuTLGNsSTzgT3/rpV0QHnpVn9tC2g4Mvu1OzoZ5VwhhG90ma/RniXE+QJu7DvkjWV0xGZDraQ7cbUDNC71/Eee6bVNMUqyVbcG9sDljI+AcwFKtxT6PVy0xJxQFJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=dy0RQGhT; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cktnB1zFXz9t3C;
	Sun, 12 Oct 2025 10:24:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1760257470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lZhwgTQSJZh4wRAyKM1kTP6Jj9b7XQ1HM2VBmL39PJQ=;
	b=dy0RQGhT6nKswPw1srr82MB1hCkNXTtUaCs4Mmjo1DKImT1Jf4xVR81H9dpu2YEYbYnJ+b
	DS+hmMBDDJiGaiyaTax9ykxk4nVliFl8jyVkINFBrBn6Rw5aHUuHe8rwkzn8EA9yD+37eh
	cBu5QoS4Bh1RXILDr5+ryJIomHRfmG+f6Qhnt/9uc+bk1tibuRdYt3XUhfhPq4tN+WoWWw
	9R9KCLhy0ew+GRkUEoGn2Qvd3yngfiEOLWUpKplkiJV8P3DRs9whceFiY74yyCbYLOY3mK
	Ruwln2Ag5PA1Xu8CHECQwqNfVVOLAnTYg+e3qZ7oQ3ASY1EcNrGjNj8J8XPoCg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Sun, 12 Oct 2025 10:24:19 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com, 
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org, 
	mcgrof@kernel.org, nao.horiguchi@gmail.com, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Message-ID: <e64diq7jjemybcwr2kgmfrp7xxj6osfdnjmpozilhyjjrt4g6m@brocsk7dnbgp>
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
X-Rspamd-Queue-Id: 4cktnB1zFXz9t3C

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
> ---
LGTM with the suggested changes to the !CONFIG_THP try_folio_split().

Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

