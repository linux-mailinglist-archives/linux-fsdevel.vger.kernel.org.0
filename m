Return-Path: <linux-fsdevel+bounces-57557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D07AB234EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 20:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C6B6E2623
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9E32FFDF4;
	Tue, 12 Aug 2025 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkV3t6Gb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3A2FFDC3;
	Tue, 12 Aug 2025 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024030; cv=none; b=TMFsCJLh8TUiZfAd1sZROl96zQW79f4vo8AhIsiq5Rgu0eaCur4JZvNqEwValZDleRlnSr5gW5kYk4IOpWjf0B/a0MhyzUNhTKGWkQfRgWhuvLaNJHbxBRlSC6ERUjM72e9LYCrEO5dUjeWBkauqjYkKt2DT/hadmDiiEx+2yqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024030; c=relaxed/simple;
	bh=Ehdoi+tqwd7gasNT3+/xFAmwud9NS1gi6Msx+4xdnbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V5U9mY1jQWHpfBl/zjP6ovydzQjhIA5dUYLrcpolTXK/BAQXoz8COp7So1lDB+fH1CcS5vuvgUOrofSmkJbWJFnGKN/jw7tvRUghdqy++OFTUGLNPfEC7giSl7wMkXcgfnKkhN+kVSAHUccxGaTZib8egrOHjjmQX5JB0PHYDLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkV3t6Gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111ADC4CEFB;
	Tue, 12 Aug 2025 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755024030;
	bh=Ehdoi+tqwd7gasNT3+/xFAmwud9NS1gi6Msx+4xdnbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hkV3t6GbOvkBq8Xi/VN7/NdNc5WB6bvnmNTY8vUCY9U64j0HBZbTaQzTv6ns6SH3w
	 8RqTBt0gFksB6BAGLIQTCkDRufQjSK1RLDWenTQvYSeMWRQSntynNE5vgIP+RzgEUb
	 +lnsN94W/oUmwJINmjhbedw4r4L5P5oFA1aXPbnGSN0F2A22qfdT5N2RiM3twVGbdM
	 NOvoB+T2Yajr5M+OTEk+Tt3Z8YpumMvZn8f+enDaY16GDjxvn24GNFaTmM2QXfK4bE
	 sFvCBucs+eVuUAfZ+FOtA5HXAMeIrS2nfOe3Nv/pHxCAZrvzvhP2Xe0nkYSkNLw6cu
	 CJsowISZocw/w==
From: SeongJae Park <sj@kernel.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] mm: remove redundant __GFP_NOWARN
Date: Tue, 12 Aug 2025 11:40:27 -0700
Message-Id: <20250812184027.57846-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812135225.274316-1-rongqianfeng@vivo.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 12 Aug 2025 21:52:25 +0800 Qianfeng Rong <rongqianfeng@vivo.com> wrote:

> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> redundant flags across subsystems.
> 
> No functional changes.
> 
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

