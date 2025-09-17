Return-Path: <linux-fsdevel+bounces-61885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BA0B7D8EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4AA3BFDC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 07:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2F3303CB7;
	Wed, 17 Sep 2025 07:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbSauEvn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F50248F68;
	Wed, 17 Sep 2025 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095056; cv=none; b=jRGTW24+OEvvbIJxW9Zu9kQ0Wnz8jyb1rUKRi42lm9DzCBuBh/tE0yxoE3kleQ6tn2n+30MjP/AGFO68STJYqDb+z7iDekgB05+B7XlphGTDGIEnAQBqg2WnlJeJA4YQvb2emXbpaxs5IA5sHMJATUIv/oqtoDjPoxRfynwHGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095056; c=relaxed/simple;
	bh=O32d9nMpfCjkvZmQj+LHF+wrVeinQYtykhIahUtbw28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iSJtplyrVDTCqp4EoHbm5Xf1zECwq4gsCit9yZfw6SiScHAIFj9dvMVNXu5Gf2ezcqTyQ9B/scqsA5QgeFSX0zGxb5Pait72TtjDcLCg7BqzssbfgzNv8QmbHu3xugoQTHpQ9GfVo7KoU3O06TGYcRabTnHD62X4GbZgL/geado=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbSauEvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E97C4CEF0;
	Wed, 17 Sep 2025 07:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758095055;
	bh=O32d9nMpfCjkvZmQj+LHF+wrVeinQYtykhIahUtbw28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbSauEvn8Wn3EmtIF1IR8j8PX6fACuh6JMywy6s8FmmriFeqeH4xYjv3rsgkiiCHw
	 UyXW6ZCZNvyZE6RGZMkRkFVYho1qOiCrBlbKLbvA3DYc3eG5k5Z3b3t4Ah6Vut8N9F
	 mz9Od2K/Zjhb48M5Pz2QeuVL8vkMb1oj5uZE9k+U3z9YRyXC2W/V4Q1Rs0QQvxv6oI
	 TuhwBy01nl82bA0BWe24Tay45kPxpRH5HoKH4BQiwqA0cpTdkVZWobrGlHTzenVrMv
	 tcbISR9d3OsZQnCUcEViB7xZ1G39ye6jJ1F7RiGRvM7WXqTvJfZlKNBNHAG6K+b2bD
	 GaMy0M7pskqyA==
From: SeongJae Park <sj@kernel.org>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	minchan@kernel.org,
	lorenzo.stoakes@oracle.com,
	david@redhat.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	pfalcato@suse.de,
	kernel-team@android.com,
	android-mm@google.com,
	stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Jann Horn <jannh@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/7] mm: fix off-by-one error in VMA count limit checks
Date: Wed, 17 Sep 2025 00:44:13 -0700
Message-Id: <20250917074413.58886-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915163838.631445-2-kaleshsingh@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Sep 2025 09:36:32 -0700 Kalesh Singh <kaleshsingh@google.com> wrote:

> The VMA count limit check in do_mmap() and do_brk_flags() uses a
> strict inequality (>), which allows a process's VMA count to exceed
> the configured sysctl_max_map_count limit by one.
> 
> A process with mm->map_count == sysctl_max_map_count will incorrectly
> pass this check and then exceed the limit upon allocation of a new VMA
> when its map_count is incremented.
> 
> Other VMA allocation paths, such as split_vma(), already use the
> correct, inclusive (>=) comparison.
> 
> Fix this bug by changing the comparison to be inclusive in do_mmap()
> and do_brk_flags(), bringing them in line with the correct behavior
> of other allocation paths.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: <stable@vger.kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

