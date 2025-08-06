Return-Path: <linux-fsdevel+bounces-56854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E0BB1C9DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 18:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70C8A7A9386
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 16:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA2F296141;
	Wed,  6 Aug 2025 16:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/y054IB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928D0155322;
	Wed,  6 Aug 2025 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754498137; cv=none; b=ot1BxoTk/23d+NzGWuND6/uzxTArJlV1yM/qW1kjb8ChV5S0y9AUASkxERdRzAZrUTP/+TP2UwR7S4Tmf5E7MBAYUHlKGIOasHoSOFSMr/2/iWUHR8TTABtRqlNeN43EYvSgY6KJfD1Wq4GlnEUs+6JVw0jFZTMs373XZtYv/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754498137; c=relaxed/simple;
	bh=xGGpA95XAeb0WwdxHKDD91ns9hkx0Ye7AgEA8IpfDQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N4f+GRG7ScW3KLI1tpqD3gNmt3ramcVg47DPOyBUbjoOhZziP3JusvwTKzfUybsfWdIMuu77x0g4hQqI7T0vJKSYlS/TZr50gRbUQe9r7bF//z+WGtHvB3oHXRPekcKec+L+wKCGaS6cgCpGGP/wT4eMpHjpukkx9rGuJAwBmjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/y054IB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4AFC4CEE7;
	Wed,  6 Aug 2025 16:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754498135;
	bh=xGGpA95XAeb0WwdxHKDD91ns9hkx0Ye7AgEA8IpfDQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/y054IB3WTivroNoV2FuA+UveCHLltCgYNZqm23SCuo2K9wGbGR2ca6JyInOgSVe
	 LYLjRM5pnbKC0QeVcHViZHHqT64AmrA7+rN4vgnhFxrEqyFoh23I1CaVCHNR80/chv
	 +DuIUQynVIwoERpz8iCWEZg9uf1Nzr1Y2HH1TTNynQwuiRE2+hMbXXLE/j98m3NiCq
	 INKjI9cpu4MAYIcc0N2+F4aHVyHz4y4h7OQdop9sNR0xVL7gnaINkSav9ExiAYebtU
	 eivKoe6UotebTQfZDgo8QyQIrou2wX9HPTkpDlfL71wIAEzMUlsuOnJ0fwyvZXDGOq
	 +rTtZl13re3PA==
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
Subject: Re: [PATCH v3 3/3] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under per-vma locks
Date: Wed,  6 Aug 2025 09:35:32 -0700
Message-Id: <20250806163532.82466-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250806155905.824388-4-surenb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  6 Aug 2025 08:59:04 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Utilize per-vma locks to stabilize vma after lookup without taking
> mmap_lock during PROCMAP_QUERY ioctl execution. If vma lock is
> contended, we fall back to mmap_lock but take it only momentarily
> to lock the vma and release the mmap_lock. In a very unlikely case
> of vm_refcnt overflow, this fall back path will fail and ioctl is
> done under mmap_lock protection.
> 
> This change is designed to reduce mmap_lock contention and prevent
> PROCMAP_QUERY ioctl calls from blocking address space updates.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

