Return-Path: <linux-fsdevel+bounces-8745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA5E83A92D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D621F237E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B316DCF9;
	Wed, 24 Jan 2024 12:00:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD7067E71;
	Wed, 24 Jan 2024 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097618; cv=none; b=WSjvNfCGXjnO3DiTFYyRHTSzNtfW0g0xPpt54CH40FuE9wSGjfbLfd2d7Le3H4WgkBy0YF5kFgQPPvYEcr6y8VaDvTK7bRkL9wyN4cInJHkwGPr9C8Bm/Y1dw/iPCaZFnPLKhRFZNkNwF9GL//HNc4fkiebTUErv23JClAMxAMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097618; c=relaxed/simple;
	bh=VZqpdCT23a4FLYa7casjJexKzDefLDFZjLgIXAUOM2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dn04dRZ9CNFxEIUTdPo6bkr0IGQ/FSIHmLDS70KN9DYlnFzT4DaWH/3csme5qzQeDs1vvj3o8SRvLNyiZgDixESWzrUUoz+R9sbCpCgbe6gGFp5nzsYgpDWw2RfraHnzscmb4aF6O34b3WZ9H7u0CUmS3KoNP2B2ZIAAW2puYnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-d3-65b0fbb8fd1e
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
Subject: [PATCH v11 26/26] locking/lockdep, fs/jbd2: Use a weaker annotation in journal handling
Date: Wed, 24 Jan 2024 20:59:37 +0900
Message-Id: <20240124115938.80132-27-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUyTZxiF9zzvZzu6vOsIvIrJli5mDhQURe8ZZ1hitmfLjDNmf1wiNvYN
	NBYkLZ9LNICoyJdKhPqBs6CptRSLBQ0KJQwjgsSCQqAiNEAIA6RA0DbryqaUbX/uXDnn5OT+
	cXhK+ZBZy2vTMiR9mlqnYuW03BtWs6k52CBtrvdEwIXSzeB7W0RDtd3GQt+dOgS2pnwMM4+/
	gyH/HILgs14KjJV9CGrGRylo6vQgcFoKWOif/AgGfAssdFeWsHDyhp2F56+XMYxUVWCoc+yF
	nvO1GNoDf9BgnGHhqvEkXjnTGAJmKwfmvPUwYbnCwfL4Fuj2DDLgHI6By7+NsNDq7Kahs3kC
	Q//DahY8tncM9HR20dB3oYyB+vlaFl77zRSYfQscvGg3YWgoXCk6/eYfBp6UtWM4ffMuhoGX
	LQjaisYwOGyDLDzyzWFodFRS8Netxwgmyr0cnCoNcHA1vxxByakqGnr/fsJA4UgCBP+sZhN3
	kkdzCxQpbMwmTr+JJk9rRfLgyihHCtuGOWJyZJJGSzS50TqDSc2SjyEO61mWOJYqOFLsHcBk
	3uXiSNelIE0mB4z4p6iD8l0aSafNkvRxuw/LUxY902z6XVlOgfkBk4eCXDGS8aKwTSy4OUkX
	I36VrV5NSGaFL0S3O0CFOFz4TGwsm2KKkZynhDMfipbFZ2zI+EQ4LHa+WVgN0cJ60V10G4dY
	IWwXL5Y/Z/7t/1Ssa2hfzchW9PrLw3SIlUKCOGY9x4VKRaFEJp6ZafrvoTXi7xY3fR4pTOgD
	K1Jq07JS1VrdttiU3DRtTuyRY6kOtLIo8/HlX5rRUt+BDiTwSBWmSLTaJSWjzjLkpnYgkadU
	4Qr3mjuSUqFR5/4q6Y8l6TN1kqEDRfG0KlIR78/WKIVkdYZ0VJLSJf3/LuZla/NQTOnUgQBq
	8R/cYZg12dsyut++WjxxfVPuZHxYzvzHO69H5Rza802+K+t74muuvkfG9zdEbK1K32Bftjm4
	+8lDvovGlri4a4mxR/r3HL205CuPKLrlCki28J7MrumMH0brX83mxciTvv6yav+6jb37fvw8
	Mvlbj9NQsU7X+pWm5+dsl4o2pKi3RFN6g/o93sw5bE0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRzF+/3u09XitsRu2UMWURS9SONb9vorL0FR/2hFD1deckxnbGrZ
	g6YzM01T0ZnOQq2WTVObPazUlqJpkY80M7OV2kNRW2gTbfZwQv8cPpxzOH8dlpDlUPNYpTpc
	1KgVIXJaQkp2+epXPnSWimu6JjZC6qU14PgZT0JOSRENzcWFCIruRWPor/WDt6ODCJyvmgjI
	zGhGkNf9gYB7dTYElQUxNLR+ngltDjsNDRmJNOivl9DQMjCBocuQhqHQshNepuRjsI5/IyGz
	nwZjph5PSh+GcZOZAZNuCfQUZDMw0b0WGmztFNRcbaCgsnMFZF3roqGisoGEuvIeDK2Pc2iw
	Ff2l4GVdPQnNqUkU3PmeT8PAqIkAk8POwGtrLobS2Mm1uJE/FDxPsmKIu3EXQ9u7Jwiq4j9h
	sBS101DjGMRQZskg4NetWgQ9yUMMnL80zoAxOhlB4nkDCU2/n1MQ2+UDzrEcepuvUDNoJ4TY
	shNC5WguKbzI54VH2R8YIbaqkxFyLRFCWcFy4XpFPxbyhh2UYDFfpAXLcBojJAy1YeF7YyMj
	1F9xksLntky8e/5+yaYgMUQZKWpWbwmUBP+w9dHH77qdjDE9onTIySQgluU5b948FJSA3Fia
	W8p3dIwTLnbnvPiypK9UApKwBHdhOl/w4xXtCmZzgXzdiH2qRHJL+I7429jFUm49n57cQrmY
	5xbxhaXWqY7bpH8nq5N0sYzz4T+ZLzMpSJKLppmRu1IdGapQhvis0qqCo9TKk6uOhoVa0ORn
	TGcnUsvRz1a/asSxSD5Dus1cIsooRaQ2KrQa8Swhd5d2zC0WZdIgRdQpURN2WBMRImqrkSdL
	yudIdwSIgTLumCJcVInicVHzP8Ws2zwdWl/V5GkI9M+b9WDgo7rl97oFuw3LSus773v5djc9
	8JHNaXltVJ027NFlmw8Vp2+3Ru+znzD4Z5T3Rg3n92/9ZrRdO6f3YFQHjBEevX2bA/QjGxYe
	OfzeviHduj15bHXS2N4YXYD/DG+vo/V4MfO0N/Qg7KutULU/DvsSf7P1zLM3TjmpDVasXU5o
	tIp/akcm2y8DAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

jbd2 journal handling code doesn't want any jbd2_might_wait_for_commit()
to be between start_this_handle() and stop_this_handle(). So it marks
the region with rwsem_acquire_read() and rwsem_release().

However, the annotation is too strong for that purpose. We don't have to
use more than try lock annotation for that.

Furthermore, now that Dept was introduced, false positive alarms was
reported by that. Replaced it with try lock annotation.

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


