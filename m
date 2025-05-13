Return-Path: <linux-fsdevel+bounces-48865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD4FAB5201
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78441883B94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209B928981D;
	Tue, 13 May 2025 10:08:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E9027E7C6;
	Tue, 13 May 2025 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130891; cv=none; b=BfALdea4hoEeiS+xJi4JhheWiO/WiDpOspVs+mnHBNmABlnc2EW/juVz+WPOqBhngYY/4GsquE4HnpLvs8LR9F7bltfCGLi/JbIyXCzVT1IwTt84y0DZgHRD/PjL1KKQVYpYjPoIOeuWXNxM4+U2qq6smYMj+M3NyEArF2iKCwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130891; c=relaxed/simple;
	bh=WLFy2XrzC3m864Tg26cLbN8q8gwXnUddJfJFmRKv6UE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mqjRAJfybN2Av/zNX/a8uCbUwaEsZA0dg0lsKpaWQCx7gykR/Nr7Rm9O+FByIt1e9ilkbUVdebVFqK7sEuAypi13wZgbdmiAxoc0JuvPFWA4ZoRpthsXbHapSEDkz+QNuz3+RDgPpvLjqU0Ne+aO9/ZqLClwPks8FfNTfFQbhqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-af-682319f15cda
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yskelg@gmail.com,
	yunseong.kim@ericsson.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com
Subject: [PATCH v15 31/43] fs/jbd2: use a weaker annotation in journal handling
Date: Tue, 13 May 2025 19:07:18 +0900
Message-Id: <20250513100730.12664-32-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfe57qzXXQvSCJtOqcWERhKA5iTL9YOLzxczEt0RdtkbubGNB
	0wqKbpEKIhZhlQUIKtKCVkLbyS4uOAeGoaCVWFGQUuVFsXFrKJJU28mrthC/nPzzO7/8z5fD
	kcp2Op7TZh4T9ZlqnYqRU/LRBda1wbiVmnX+IQShD4UUXLnpYKDrdzsCxy0jAf72beAJBxBM
	Pn5CQkVZFwLr6wESbnUMImipO8NAt28h9ITGGHCVFTGQV3uTgacjUwT0l5cSYJe2w5DtLQWd
	5hoCKvwMXK7IIyLjPwLGbfUs2HJXw3DdJRamXieDa7CXhpYX30Dl1X4GmltcFHTcHiag+84V
	BgYdn2jo7HhIQbhkKXRdLKbB+a6GgZGwjQRbaIyFZ60WAjosi6EhP1JY8H6GhgfFrQQUXPuD
	gB7v3wjuFr4iQHL0MnAvFCCgUSojYeJGO4LhklEWzl4YZ+GysQRB0dlyCvL718Pkx8jlqg/J
	YKxuoMA53Yu2pGHHVQfC9wJjJM5vPI4nQs8Z3BK2UPhRjYD/ujTA4vy7L1hskbJwY10Crm32
	E9gaDNFYqj/PYClYymLTaA+B37nd7I5l++Sb0kWdNlvUJ337o1xT1FNJHP04/0TVr26Ui/6X
	mZCME/hUwTM1SZoQN5tLzYlRzPBrhL6+cTKaY/nlQmPxW9qE5BzJ984XPFVeFPVj+O+EzmZN
	1KH41cKM882sr+A3CEPOCXau/ivB3tA6y2URPn3DTUWzkl8vmC12as6plgnN19LmcpzwT10f
	ZUYKC5pXj5TazOwMtVaXmqjJydSeSDx4JENCkeey/TK1/zYKdu1sQzyHVAsUD/0rNEpanW3I
	yWhDAkeqYhXGpghSpKtzTor6Iz/os3SioQ0t5SjVEkVK+Hi6kj+kPiYeFsWjov7LluBk8bmI
	K/d6Zr5PUFTcsfum98Y+s07udkk8XfjT4p+vdyuCiVzgwGbPef0uedP++6v6U7bq1j1etPGw
	FP/1c/PBc9UuTUxSk+O0yhQ36D1pdtWeyirzahN87Y50HLP530O+gFvjHahMLRhRpzmZJkOR
	L2Xrb9fziq3b9qQu2/Qy6U9jnIoyaNTJCaTeoP4Mv/yOjFgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTZxTHfZ732mrNO2D6ghq1xjk1MklET7xh/OLjbTPxw7KpkaqvtrFU
	bBVBo6FSCBZBJEHwgtZqSkeLskIypoAEYrUSOya13gAVlUhEG5GWq2hr4peTf37nl3O+/Hkq
	ys7E8RrdAUmvU2mVrJyW/7osa8HH2FnqhXmenyHYn0vDhetOFlqvORA4a4wYem6vgUehXgQj
	9/+joKS4FcHllx0U1Lg7EdTbj7PQ9noi+IIBFjzFeSxkXbnOwv/vRjG0nynC4HBthOe2bhpa
	Cq0YSnpYOF+ShcPjLYYhWwUHtszZ0GU/x8HoywTwdPoZaC7zMFD/dD6cvdjOQl29hwZ3bReG
	thsXWOh0fmGgxX2XhlDBFGg9nc9A5QcrC+9CNgpswQAHDxotGNyWSVBlCl/N+TTGwJ38Rgw5
	V//G4HtyE0FD7gsMLqefheZgL4ZqVzEFw+W3EXQVvOcg++QQB+eNBQjyss/QYGpPhJHB8Oey
	/gQwXqqiofKzH61aSZwXnYg09wYoYqo+RIaDD1lSH7LQ5J5VJP+e6+CIqeEpRyyug6TaPo9c
	qevB5HJfkCGuihMscfUVccT83ofJB6+X2zTtT/nyXZJWkybpf1mZLFfn+c7i1MHx6WWnvCgT
	DcjMiOdFYZFYVBhvRjKeFeaIjx8PUZEcI8wQq/O7GTOS85TgHy8+KnuCIn608JvYUqeOOLQw
	WxyrfPXNVwiLxeeVw1wki8J00VHV+I3LwvxzuZeO5CghUSy0OOhCJLegcRUoRqNLS1FptInx
	hr3qDJ0mPX7nvhQXCvfHdnT0dC3qb1vThAQeKSco7vbMVEcxqjRDRkoTEnlKGaMw/hNGil2q
	jMOSft92/UGtZGhCU3haOVmx7ncpOUrYozog7ZWkVEn/fYt5WVwmMjqK12qPm9wNc/0VpWnW
	e7EjfNIPOW9Wn0p/yK7ocH2MvuW70ZAkLasLJA9uGdhQM9n+046+pHg/mVrg/mtbYIyg6CWa
	Uln3/DmbpulTpcbyWX/Udr3BP4a2bbTqYreqJe/Aseydm7fHPDuyZXBo9+61J5OV9P64gdzE
	peuzlh8yK2mDWpUwj9IbVF8BbO0khDsDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

jbd2 journal handling code doesn't want jbd2_might_wait_for_commit()
to be placed between start_this_handle() and stop_this_handle().  So it
marks the region with rwsem_acquire_read() and rwsem_release().

However, the annotation is too strong for that purpose.  We don't have
to use more than try lock annotation for that.

rwsem_acquire_read() implies:

   1. might be a waiter on contention of the lock.
   2. enter to the critical section of the lock.

All we need in here is to act 2, not 1.  So trylock version of
annotation is sufficient for that purpose.  Now that dept partially
relies on lockdep annotaions, dept interpets rwsem_acquire_read() as a
potential wait and might report a deadlock by the wait.

Replace it with trylock version of annotation.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 fs/jbd2/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index cbc4785462f5..7de227a2a6f8 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -441,7 +441,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 	read_unlock(&journal->j_state_lock);
 	current->journal_info = handle;
 
-	rwsem_acquire_read(&journal->j_trans_commit_map, 0, 0, _THIS_IP_);
+	rwsem_acquire_read(&journal->j_trans_commit_map, 0, 1, _THIS_IP_);
 	jbd2_journal_free_transaction(new_transaction);
 	/*
 	 * Ensure that no allocations done while the transaction is open are
-- 
2.17.1


