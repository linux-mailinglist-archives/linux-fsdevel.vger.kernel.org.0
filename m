Return-Path: <linux-fsdevel+bounces-57538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B6DB22E98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53371679E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9933F2FAC1B;
	Tue, 12 Aug 2025 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oL4Sw+hk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E873C242D74;
	Tue, 12 Aug 2025 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018580; cv=none; b=h+nI8Tpqa4qtMBqcx6f55VlmHZOnTqQAVk0ugz2Nwq3L7kqAwjKtOsSJRja5asllqqgnci/gGBvkEIEUcDf+oiyhMmhKW7zAp0FmA7g2Feu7ZY5DDDhtyXqYd0By7BOGgc4tR7kOh4Dw/4xKBV0YhYavMiLIjlfGHwIUxs/4q8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018580; c=relaxed/simple;
	bh=WllhlpeuM1QYj3ynp+yRWpiZPyuig56MrMJq6geJbq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y1R0TIYcsGbnY+GuDvxx5A9Di8gJr2BcPjiW0HZHoiOEEnGiJJH/b8JLRwPJs8SAAJpWKeRmM8sM8sL0a8WcenKIuxYYmxFSu4C/Ci1MpyaGSWqAcmJHE762y1b71llMk5D/l/MxfCA68dVSKsvmCTSlPy1QgsApAXzjTBYJyA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oL4Sw+hk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315F7C4CEF6;
	Tue, 12 Aug 2025 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755018576;
	bh=WllhlpeuM1QYj3ynp+yRWpiZPyuig56MrMJq6geJbq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oL4Sw+hk8pHYaYySOCd+3ByAPToVrqxHD3EhBtFQtquiy/gNpJhiIPi7WbacIdYq+
	 JvtT9wxou7H8//kEP7MDOPvjQd4VmV1IYtx+Q/IG6W7pR23Rde8bNJVBEpyN3Q48go
	 wA4XGXVUYZrDwV7DQ3VDcHGRJ/iMWWdqSMG9yafwpj49LkbHWRh15PW0xw9d6pqlkd
	 IAdLzvxQ137cGLL35VCrUz47GH7iJNQYbtJ4KNK0AUoP52esjXltISKF3O/YNUU8ob
	 WX9UxN5jHoZUnM/0UgRfb0OvEIWIn4+byx88nT14VS4T5qmwmL20Aq0dkjIy4XLHU6
	 RrdPlWcKcaEZA==
From: SeongJae Park <sj@kernel.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Uladzislau Rezki <urezki@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH] mm: remove redundant __GFP_NOWARN
Date: Tue, 12 Aug 2025 10:09:33 -0700
Message-Id: <20250812170933.56674-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <aJs9dPMdY_W5uZdc@hyeyoo>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 12 Aug 2025 22:11:16 +0900 Harry Yoo <harry.yoo@oracle.com> wrote:

> On Tue, Aug 12, 2025 at 05:57:46PM +0800, Qianfeng Rong wrote:
> > Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> > GFP_NOWAIT implicitly include __GFP_NOWARN.
> > 
> > Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> > `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> > redundant flags across subsystems.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> > ---
> 
> Maybe
> 
> .gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
>                         __GFP_NOWARN | __GFP_NOMEMALLOC | GFP_NOWAIT,
> 
> in mm/damon/paddr.c also can be cleaned up to
> 
> .gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
>                         | __GFP_NOMEMALLOC | GFP_NOWAIT, 
> 
> ?

Thank you for catching this, Harry!

FYI, the code has moved into mm/damon/ops-common.c by commit 13dde31db71f
("mm/damon: move migration helpers from paddr to ops-common").  Please feel
free to make the cleanup if anyone willing to.


Thanks,
SJ

[...]

