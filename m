Return-Path: <linux-fsdevel+bounces-19060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C4D8BFA55
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 12:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F001F240F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 10:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0106684D04;
	Wed,  8 May 2024 10:03:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8817E794;
	Wed,  8 May 2024 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162584; cv=none; b=ryyxGPiCIr3mkH72mIbuqI5UBHprYgEVTwV0jSgOdl6X7bWWQ5IHXjTx8cDpAqNfyxZh7LVxIJRVzQZeOc1O/atS7QPFUQLxM0ILalmsGaS0u3vcV+Xhx4TrkKsugb8IvAEdbDoAkhmHBJK7B0ZJ3QorsUdWw/bwo5HusvNBwuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162584; c=relaxed/simple;
	bh=cVjts9SZXZ4NmM7fBk0URrytFXU4oROO3YR0wv1o+Nc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Scj2Eq9yFOTMu+zM0x/q1NiQybbPmtcAsrC99J3WEZFDJhJQVEEp/7lB7ghk6QKnbRKg071cElc4/ri96rsYo3PEQlMPUezqcLDUV0OS8Clk7vwXJzjNNPfzbPTvfkL8nA39B2PW3RwgUaZoIp6+/749Ef3qobFMULbLeW7kzOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-a9-663b4a3b9061
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
	42.hyeyoo@gmail.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	hdanton@sina.com,
	her0gyugyu@gmail.com
Subject: [PATCH v14 25/28] cpu/hotplug: Use a weaker annotation in AP thread
Date: Wed,  8 May 2024 18:47:22 +0900
Message-Id: <20240508094726.35754-26-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508094726.35754-1-byungchul@sk.com>
References: <20240508094726.35754-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbVBMYRTHPc+9e+/dtWvurEy3fMBizHjXiEMGX+RhNON1zPCBHd20VMyW
	khmjN7VKiKklTWplrUrYXeOtzVpKiYRFmoQySG2Z2J2ykW3x5cxv/ud/fp8ORymvS4I5TVyC
	qI1Tx6gYGS1zyUtnha0Oi5r70rQY8o7OBfcPHQ1FVyoZaK6qQFBpTcXQVbsSXnt6EHifPKVA
	n9+MoPTDWwqsde0IbKY0Bl58HANOdx8DDfk5DKSfv8LAs+4hDG0FJzFUmCOg8YQBg33wMw36
	LgbO6tOxb3zBMGgsZ8GYMhU6TIUsDH2YBw3tryRga50BZ4rbGKi2NdBQd7MDw4vbRQy0Vw5L
	oLGunobmvFwJXO41MNDtMVJgdPex8NxeguFqhk+U+f23BB7m2jFkll3D4HxzB0GN7j0Gc+Ur
	Bu67ezBYzPkU/LxYi6DjmIuFw0cHWTibegxBzuECGjLaQsE7UMQsX0Tu9/RRJMOSRGyeEpo8
	MgjkVuFblmTUtLKkxLyPWEzTyfnqLkxK+90SYi4/whBz/0mWZLucmPQ2NbGk/rSXJh+derw2
	eItsSaQYo0kUtXOWbpdF92e1or3vpPtrsr1MChpms5GUE/j5Qn3LKeo/N146hUaY4acJLS2D
	/jyAnyhYcj9JRpjie2RCWVP4CI/l1wjv2nP8HpqfKngv3fV3FPwCoawz759/glBx1e73SH35
	m8+9fr+SDxXupBf6OjJfZ4ATfgwU4L8HQcI9Uwt9AilK0KhypNTEJcaqNTHzZ0cnx2n2z96x
	J9aMfM9kPDi09Sbqb97gQDyHVHKFPXBxlFKiToxPjnUggaNUAYrarIVRSkWkOvmAqN2zTbsv
	Rox3oPEcrQpUhHiSIpX8TnWCuFsU94ra/1vMSYNT0KbOtI0/6YigZSG24tDGzOGIx8/bdiyX
	V+mWrV8S2ek1GF0PP1kLNsPT0bppRn3qzO5zo29/zc3TVWfJJ4WseuzkHNvXSNOG17mORyGT
	Y8r1RRsm6wOO5BgsF60bEw5FVNmsqlhj+AUi/3ZuV4D9WfiKcb/GesKSxqzfeSMwiMx8oKLj
	o9XzplPaePUf16XCT0gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfX+P183Zbyf8ls3DbQ0ZahyfqWGz6TvP/irm6dIv3XSn3ZFi
	tnKXhx5MqCPVrgcndZE7DymllYs0OYpIRYmkuibu5tyRavzz2Wvvz+f9+usjIqUG2k+kVB8S
	NGpFjIwRU+LNwbpFweuDowILC/whIy0QnD9OU5Bz08yA/UYpAvPtJAL6baHQ5hpE4Hn2nARD
	ph1BfncnCbcbuhBUF59goKV3CrQ6hxlozExlQFd4k4EXA14COrLOE1Bq2QRN5woIqHX3UWDo
	Z+CKQUeMjS8EuE0lLJgS/aGnOJsFb3cQNHa9pqE+t5GG6vaFcDmvg4EH1Y0UNFT0ENBSmcNA
	l3mUhqaGJxTYM9JpKHMUMDDgMpFgcg6z8LLWSEC5fsx28vsfGh6n1xJwsugWAa1vqxDUnP5A
	gMX8moF65yABVksmCb+u2RD0nB1iITnNzcKVpLMIUpOzKNB3yMHzM4dZsxLXDw6TWG89gqtd
	Rgo/LeDx/exOFutr2llstBzG1uIAXPign8D5I04aW0rOMNgycp7FKUOtBHY0N7P4ySUPhXtb
	DcTWmTvEIZFCjDJO0CxZtVccPXKqHcW+94mvSfEwiWiUTUE+Ip5bxjddv4DGmeHm8W/euMlx
	9uXm8Nb0z/Q4k9ygmC9qXjfOU7mN/Puu1IkuxfnznusPJ24k3HK+6GPGP+dsvrS8dsLjM5a/
	7XNM+KWcnK/SZbPnkNiIJpUgX6U6TqVQxsgXaw9EJ6iV8Yv3HVRZ0Ni7mI57MyrQj5bQOsSJ
	kGyyxM4ER0lpRZw2QVWHeBEp85XYTq2IkkoiFQlHBc3BPZrDMYK2Ds0UUbIZkvVhwl4pt19x
	SDggCLGC5v+WEPn4JaLNtPrODoelpMN/+86HLvfa+S+Kpya1lc+aMVT6bbXqq6NnabL1ovnu
	usextmnJ21TxfRt0fZ2fbtizwjRTorfkelPyNzyafsxbl51XdiQifJJ0ztVl99ZWBNhGExdE
	yObqYp2B8ULQu4FXvyvDQR4S1l/W5qKLIhSRlN6+y7NbjmWUNloRFEBqtIq/MqLSeSoDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

cb92173d1f0 ("locking/lockdep, cpu/hotplug: Annotate AP thread") was
introduced to make lockdep_assert_cpus_held() work in AP thread.

However, the annotation is too strong for that purpose. We don't have to
use more than try lock annotation for that.

rwsem_acquire() implies:

   1. might be a waiter on contention of the lock.
   2. enter to the critical section of the lock.

All we need in here is to act 2, not 1. So trylock version of annotation
is sufficient for that purpose. Now that dept partially relies on
lockdep annotaions, dept interpets rwsem_acquire() as a potential wait
and might report a deadlock by the wait. So replaced it with trylock
version of annotation.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 63447eb85dab..da969f7269b5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -534,7 +534,7 @@ int lockdep_is_cpus_held(void)
 
 static void lockdep_acquire_cpus_lock(void)
 {
-	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 0, _THIS_IP_);
+	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 1, _THIS_IP_);
 }
 
 static void lockdep_release_cpus_lock(void)
-- 
2.17.1


