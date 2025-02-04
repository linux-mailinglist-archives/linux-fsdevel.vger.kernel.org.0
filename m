Return-Path: <linux-fsdevel+bounces-40706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E1FA26EC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 10:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF8A1669A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 09:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749722080C5;
	Tue,  4 Feb 2025 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBzOkKB0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2BD2066F3;
	Tue,  4 Feb 2025 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738662638; cv=none; b=Abx+A2FUjZIUaGH6QpwJ2LcjrNp2HnNXJcqrKIsbJpt/NQS0sCCqS/fMMjie0tpxmCrUNcKRBHvH12XnN4v8AClFuLP5ZHQzxP6wI9srfuQJpPbHHX3IHwj+NDuwR2z9IraVvVAfI0r4t94wekdP+NWyqupmxVITsLrU3QjSW+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738662638; c=relaxed/simple;
	bh=jb8kMwJ98DjWaCHgudb7JkXH1w0Cj8Tj6R51vZ/JS1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=satM3R7HWBj73ozU/xebIA8ypIR+EfFajtKefMY0Qd5DUnKbm6WtWwi96lo4XjziieiLpM6N8Umtfj605e8jWxNOrFIm1zswDPMj5FIoxhJxVW63gP1F3mKp8qu6GW/cZQs5EK5uUD8WMOttI+fQTjPJ6t+/Rc6LyCK4I2JbWTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBzOkKB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9D6C4CEDF;
	Tue,  4 Feb 2025 09:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738662638;
	bh=jb8kMwJ98DjWaCHgudb7JkXH1w0Cj8Tj6R51vZ/JS1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qBzOkKB0y4E6DYirbxs7d1/+MSesxUN6asKQjPs20sDGgtF0br7786l4TGnUdvHLz
	 W0judOCyijvE5jTIstIMrDDw5jKpbY8S75tpdHZM8B8D9pyRIxhuVSfLAhzNfHYzEv
	 YI0nPuGD/n/JBu6W89vQSc1Wd1KOVnzx+p9mwSu1U1hYJxIOryalfxgee0iywH31G8
	 jgbwTRnbFlMPcsRvSSe9Th4Gz8TwWMDzKCHde9ZPqpKYZaHSp6Fm1UcKb095nLe3cU
	 crO80UOzeuKKGbpHLEpM0NGskUUz6G54Y8y1zHm5DFk/nfjsJ+2pygbbORAST4Vz8s
	 vMWnZ5HtqPxDw==
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	pedro.falcato@gmail.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oliver Sang <oliver.sang@intel.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v7 0/6] introduce PIDFD_SELF* sentinels
Date: Tue,  4 Feb 2025 10:46:35 +0100
Message-ID: <20250204-joggen-buddeln-29e5ca75abb7@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=brauner@kernel.org; h=from:subject:message-id; bh=jb8kMwJ98DjWaCHgudb7JkXH1w0Cj8Tj6R51vZ/JS1M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQvfPTgTD7L0pub5DJF0/Jkm1bfN599J+JSe+g99xMrf HIyLtUv7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIVgYjw4fPN5iqNJV9OgsW svEXbPTITfBe7sAUZj2X8f5jmdCifwz/o9w3l/I+kFzBJnLz6KVvxzkSSuumWL9meHP5ZfeNjvN nuAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 30 Jan 2025 20:40:25 +0000, Lorenzo Stoakes wrote:
> If you wish to utilise a pidfd interface to refer to the current process or
> thread it is rather cumbersome, requiring something like:
> 
> 	int pidfd = pidfd_open(getpid(), 0 or PIDFD_THREAD);
> 
> 	...
> 
> [...]

Updated merge message. I've slightly rearranged pidfd_send_signal() so
we don't have to call CLASS(fd, f)(pidfd) unconditionally anymore.

---

Applied to the vfs-6.15.pidfs branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.pidfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.pidfs

[1/6] pidfd: add PIDFD_SELF* sentinels to refer to own thread/process
      https://git.kernel.org/vfs/vfs/c/e6e4ed42f8d8
[2/6] selftests/pidfd: add missing system header imcludes to pidfd tests
      https://git.kernel.org/vfs/vfs/c/c9f04f4a251d
[3/6] tools: testing: separate out wait_for_pid() into helper header
      https://git.kernel.org/vfs/vfs/c/fb67fe44116e
[4/6] selftests: pidfd: add pidfd.h UAPI wrapper
      https://git.kernel.org/vfs/vfs/c/ac331e56724d
[5/6] selftests: pidfd: add tests for PIDFD_SELF_*
      https://git.kernel.org/vfs/vfs/c/881a3515c191
[6/6] selftests/mm: use PIDFD_SELF in guard pages test
      https://git.kernel.org/vfs/vfs/c/b4703f056f42

