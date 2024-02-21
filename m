Return-Path: <linux-fsdevel+bounces-12250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6A885D4E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2469028CA0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B649163120;
	Wed, 21 Feb 2024 09:50:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB11958ACA;
	Wed, 21 Feb 2024 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509012; cv=none; b=r5HYY2+3duY9oSKibGEW5rG74GMumuHCaq+kwr/jpL2vcZe7ILm/U0ovLBE1cpyn9CYxauxDUaHFAoasBgAZ3oYn8UGRb8oRzALhc+AX+bYIhY+IxlH8AY/Q7+HLcMYLXJ2hPwxjhMyNVmppiRHkoBI7FtjQ5lMcPiHh05+UUK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509012; c=relaxed/simple;
	bh=5yRKL/D4WKMUyz5KF4LYQmab3vQapC/hAllcpi+yp24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jlICJBlAq/vClzL5JKYSRePEwWReElQkTCJLXaXr42WLPRlrWlMKePOOgfXnhg3whwPhx4b5dI0ABZVNIcYWKGeCthRU+fGM3ENf2sMKbSz47Z6+FGJsvwc24Ivc3LQuVMQ/gJl1JAizFyGAS5zrk9Sm8S2D36BnDYJsym/Be7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-28-65d5c73b30c9
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
	viro@zeniv.linux.org.uk,
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
Subject: [PATCH v12 26/27] fs/jbd2: Use a weaker annotation in journal handling
Date: Wed, 21 Feb 2024 18:49:32 +0900
Message-Id: <20240221094933.36348-27-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240221094933.36348-1-byungchul@sk.com>
References: <20240221094933.36348-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTZxjHfd9zzntOC5WTzoSDxmhqdEYD6qLkiSGbX+aOS+ZM/MaySzdO
	pFmprJWbCYRLtYhAuASqQlxBUzvoQAsGBMq4hEtVoGhlWAEFUSTcNlg7uexSJH558sv/+T3/
	Tw9HKZuYrZxGd07S69RaFZHT8rngivConifSwUu9QVCYexB8f2XTUF5rJ+CuqUZgr8/AMN31
	Gfzun0Ww2jdAgbnEjaBifJSC+u4xBE5bJoHHk5vB41sg4Cq5TCDrRi2BwZk1DCOlRRiqHV/A
	g4JKDG3LUzSYpwmUmbNwYLzBsGytYsGavhsmbNdYWBs/BK6xIQac3v1w9foIgRani4buxgkM
	j5vKCYzZ/2PgQXcvDe7CPAZ+na8kMOO3UmD1LbDwqM2C4bYxUHRx6V8GevLaMFy8eQeD52kz
	gtbsFxgc9iECnb5ZDHWOEgpWbnUhmMifY+FC7jILZRn5CC5fKKVh4J8eBowjR2D1bTk5dlTs
	nF2gRGNdkuj0W2jxfqUg3rs2yorGVi8rWhwJYp1tn3ijZRqLFYs+RnRUXSKiY7GIFXPmPFic
	7+9nxd4rq7Q46THjU9ui5VExklaTKOkPfPydPLbm1SMq3h+UfL/rN5SOVmQ5SMYJ/GGhtKSd
	vOf0wSJ2nQn/oTA8vEyt8xZ+p1CX95rJQXKO4k1Bgu2PvncHH/BfCvWuDYnmdwvN3mm8zgo+
	Uhhv+JndKN0hVN9ue+fIAvkvZbPMOiv5I8KTwbvUhpMlEx5mh29wmNBuG6YLkMKCNlUhpUaX
	GKfWaA9HxKboNMkRP5yNc6DAR1lT175qRIvu0x2I55AqWBHb4JGUjDrRkBLXgQSOUm1R0EmB
	SBGjTjkv6c9+q0/QSoYOtI2jVaGKj/xJMUr+jPqc9KMkxUv691vMybamI+4n4+cnJ7Yzx72k
	2GIq3OUMyQxVFWqrTJ+0762fmcv//u/iowlNhrcRac3PoyPnw/pS/5wcGtcMtLzMcoVGrCQd
	O3Cr+ps7e55ZQvbklge1nF7aaTaNfpqme505ZE/VTeECU/TUQ3138QjjjTlRbLkSHK6oOfX1
	plr33pClHhJ+XUUbYtWH9lF6g/p/OE3gK00DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRzF+/3uvb87Z4ubSV0qykYWGb4g4wtGVBRdgp5/VESUo245fLbp
	yqLQXFaWQw1bpZVarKXLbBr20obiY9pj6iwTs7Tn0LSsjebM2or+OXw453D+OhIq4DIzU6JM
	TBFViYp4OZHS0g3RmaHRzV1ixCuHHPLORoDzxykaim6bCNgqyhGYqjMwOBrXwkvXEALP0+cU
	6AtsCEr6X1NQ3dSHoNZ4nEDn+ylgd44QsBacIZB57TaB9sFxDL3n8zGUm9dDW24pBov7Ew16
	B4FCfSb2ymcMbkMZC4b0YBgwXmJhvD8SrH0vGGi4bGWgtmcxXLzSS+BRrZWGpnsDGDofFBHo
	M/1moK2phQZbXg4Dt4ZLCQy6DBQYnCMsdFiKMVRqvWtZ3ycYaM6xYMi6fgeD/dVDBHWn3mIw
	m14QaHAOYagyF1AwdqMRwYDuCwsnzrpZKMzQIThz4jwNz381M6DtjQLPzyKyIlpoGBqhBG3V
	QaHWVUwLraW8cP/Sa1bQ1vWwQrE5VagyhgjXHjmwUDLqZARz2WkimEfzWSH7ix0Lw8+esULL
	BQ8tvLfr8abZO6TL9orxSo2oCl8eI42t+NBBJbv8D7U2PkbpaMwvG/lJeG4Jn96ez/qYcAv5
	7m435eNALoivyvnIZCOphOJO+vPGr0+JL5jGbeSrrf9KNBfMP+xxYB/LuKV8f81V9t/oXL68
	0vK34+f1bxYOMT4O4KL4rva7VC6SFqNJZShQmahJUCjjo8LUcbFpicpDYXuSEszIexrD0fG8
	e+hH59p6xEmQfLIstsYuBjAKjTotoR7xEkoeKKMPei3ZXkXaYVGVtFuVGi+q69EsCS2fIVu3
	TYwJ4PYrUsQ4UUwWVf9TLPGbmY6SybEDMR9HXStX9OvwytSk+efcs/T3k1Z7NAnaeUFvDovB
	Gvg0HD6Y8i2iaF/JV83W3DVbbLYHllWVdaYP05a3VXcuzjqS98aQrJk3RTeYkb3AX7Vol95T
	gza3TYRO/ZxvDMLKA98ypxrHpm9/NzF7Z0cJ6/9kTpruWEi3hlSkNMlpdawiMoRSqRV/AAj7
	mKAwAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

jbd2 journal handling code doesn't want jbd2_might_wait_for_commit()
to be placed between start_this_handle() and stop_this_handle(). So it
marks the region with rwsem_acquire_read() and rwsem_release().

However, the annotation is too strong for that purpose. We don't have to
use more than try lock annotation for that.

rwsem_acquire_read() implies:

   1. might be a waiter on contention of the lock.
   2. enter to the critical section of the lock.

All we need in here is to act 2, not 1. So trylock version of annotation
is sufficient for that purpose. Now that dept partially relies on
lockdep annotaions, dept interpets rwsem_acquire_read() as a potential
wait and might report a deadlock by the wait. So replaced it with
trylock version of annotation.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 fs/jbd2/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 5f08b5fd105a..2c159a547e15 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -460,7 +460,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 	read_unlock(&journal->j_state_lock);
 	current->journal_info = handle;
 
-	rwsem_acquire_read(&journal->j_trans_commit_map, 0, 0, _THIS_IP_);
+	rwsem_acquire_read(&journal->j_trans_commit_map, 0, 1, _THIS_IP_);
 	jbd2_journal_free_transaction(new_transaction);
 	/*
 	 * Ensure that no allocations done while the transaction is open are
-- 
2.17.1


