Return-Path: <linux-fsdevel+bounces-56529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E40B1876C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 20:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E981C224C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 18:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E9428D850;
	Fri,  1 Aug 2025 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zab1KhEh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC061D5CE5;
	Fri,  1 Aug 2025 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754073518; cv=none; b=Pdgt8LciyqlXpzQeCXytZgjrxbfX2aOoqqk/LhBOmhKF93hdzvMs+bCr9zesUZdvtCPG3sLYYOSdN7RTJM1hPcIi1ITXHQcr1xvOeRUSX2HpiOkd9G1A14+W9b+E660ZRJOQHvYGorb24TAKo7f27bEkkbCvOlNFcN0yW5Qp/20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754073518; c=relaxed/simple;
	bh=imashWwUDsbC5s/UDXGZVZQqEjlTbXz8PwBJPtlckXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JN8tNCvyN1Ng44+x6YHokuXgszkTBHyIBb+VqUSOBLm+3RcvdPUt73xqGwlNEZehkTEfq+JhKf7vMpYx7TWAoin8DupBLijdtpKCuaJ8ijNJb3OARNEOEwcsP4IcAc4NIoMkq8ArAZdnmVUD7+diHYSbXIQ4fOi/wINZjsoYznA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zab1KhEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4899C4CEE7;
	Fri,  1 Aug 2025 18:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754073515;
	bh=imashWwUDsbC5s/UDXGZVZQqEjlTbXz8PwBJPtlckXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zab1KhEhm+kx/z8ToNRKWL/WYJyIj24HC/h9IsisLbcpBGzz6T2YUqvi2HSPH+dk3
	 u/zeY7M2it5nwB6B4ekp13T4vr2H8Ry7q1+FLogZVc9ilVJVnOtStcNV09TyRIyVXk
	 Zn47ynQlgxHlZiiZ5rrICIxstW9D1Bqd+LCOkTPNRPWm8ELhTe4aDqdu42TCGJtK3E
	 TGbf11Rn1Nlbf8AbDUBCq8TReEtoQjVXG1utigD/sWXA40D5Fci34yS74uHvyYsPSS
	 6LCf/VtDgrf3bUNFad6JV7mZ6CDZjEAnmhtilLBsKiTTQmsiD/HIlpgpG9ivPBnBIG
	 XDp2dN1BF6aSQ==
From: SeongJae Park <sj@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	david@redhat.com,
	vbabka@suse.cz,
	peterx@redhat.com,
	jannh@google.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	paulmck@kernel.org,
	shuah@kernel.org,
	adobriyan@gmail.com,
	brauner@kernel.org,
	josef@toxicpanda.com,
	yebin10@huawei.com,
	linux@weissschuh.net,
	willy@infradead.org,
	osalvador@suse.de,
	andrii@kernel.org,
	ryan.roberts@arm.com,
	christophe.leroy@csgroup.eu,
	tjmercier@google.com,
	kaleshsingh@google.com,
	aha310510@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/proc: test PROCMAP_QUERY ioctl while vma is concurrently modified
Date: Fri,  1 Aug 2025 11:38:33 -0700
Message-Id: <20250801183833.30370-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731220024.702621-2-surenb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 31 Jul 2025 15:00:22 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Extend /proc/pid/maps tearing tests to verify PROCMAP_QUERY ioctl operation
> correctness while the vma is being concurrently modified.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: SeongJae Park <sj@kernel.org>
Tested-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

