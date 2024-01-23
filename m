Return-Path: <linux-fsdevel+bounces-8628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2629E839CF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 00:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C5A1F252FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 23:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3C954F80;
	Tue, 23 Jan 2024 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XuV9T5RA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0D53E2B
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051422; cv=none; b=S4gWXrz2k6zPcers0+0+t0GaiBGbL0xFyozeHtSWP05P2UgADzpiTt9Z9Zwl6IHDk6UFFB0kmLTZNzjgeKo08hR/SWqbVEtPSGBl3Dakxem4GKqilZFW2eCKCw5+PGIpzquwMpCAftvZC8Ct0+v15Tvz6xwkGxDqOWA11p4Np/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051422; c=relaxed/simple;
	bh=VSmKcMfyN3MYuxa3M+8VItvp5qj4UNGBOJKK9wA9Qlk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W1s1fQnoZAHKziRlBFvS9ptvnwt3k7kXr8ZVAlHoG5M9j0kY7hgqs5j+ovWQbMYSg6xHBH2O/NpP1Km9I0PlCT4QryWuWq2iSI/9fm48slmLFeUn0m4ZFAjqJE6AXPV0o4rtV7SYAMcyTApysLubam0cubElAHHGckVcdzgH46c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XuV9T5RA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ff7cf2fd21so51161117b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 15:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706051419; x=1706656219; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OLp6U6EsMSw583KQsA7U2jc3UsvPAv4xgtxefIxudO0=;
        b=XuV9T5RAXMXEf4hcRZSSpo96qObe0afVE4WoZ3Na/Td2ZSGF6RVXD9I3catbFL61Fx
         7EcKFg92EehqiNaSHycU78dw6JEa1uITxBKB0TuymA/Ckr9psHv6w8IL2Eajcizhicwa
         vY0zblX3cdStLP6OEJbVlHPVztheMt+4Q4NI6BhoNfGBEtF8+TDbCBSc7c1Fes5OT2D6
         RJgT9LKZETNfBXLqIhVZ8zNuArmkQetb4nq6naANciE3ke51eToTIjkqecGYBRMQFJzM
         0DM+2n0FHchVeKP7ElAtbgNGHyv85yZkJKkuZHYlLjDhndZsITipsOjHlgjT5tMacSZU
         l/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706051419; x=1706656219;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLp6U6EsMSw583KQsA7U2jc3UsvPAv4xgtxefIxudO0=;
        b=cap15qQHpX7uWoSNDLIGQ1ipr/87rrO7vKpp1D5YwVhwFgRZdOCUJgpDKq67Z045Kz
         PnS88pHzwq9C1y9ecFWDGQYnqyaMD4tzDjJWSMi9dodZ+HfeVHdShl/FDow5NKGEpm9Z
         1QyBHkfN6HXtxyOKDHK3lSYlfHKXlgPLKMIv30pASK9FLNhsWi3pKsipLspAwvb9gX7Z
         +Kefcn0T5cy1pppw+SCU+n9rqt92q+dV4vOtyOZBMG1mv/+vBtdKRLiB0QV45nXf0Jtw
         rW5wzqIso4T+ns52eKPWXq1yHQjgHzUIynTUiO0A9JH7dTD3JY69BzRob/Ljrhq8pKDw
         Mvaw==
X-Gm-Message-State: AOJu0YwhASPEcdhLBqo3JE8WqCB+AelqlbLU8+XB/aVPZcprI8NlxC5/
	eDjKLJDuVoUwoaNcTMVJqWIYdAzpCkuaFl0CFUS3D5tjo4jstnnmzRjZw9O8WJxeaUsVorgBEp2
	Hjg==
X-Google-Smtp-Source: AGHT+IFX5qIebM/ZQiKUEXGTW3oxR6pBTWd2HR+W3VQ1MxVAngHzessR/YRxQzpsjGe8I1sOL4WmImG7jew=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:8fc3:c34f:d407:388])
 (user=surenb job=sendgmr) by 2002:a81:9896:0:b0:5fc:7f94:da64 with SMTP id
 p144-20020a819896000000b005fc7f94da64mr134477ywg.5.1706051419411; Tue, 23 Jan
 2024 15:10:19 -0800 (PST)
Date: Tue, 23 Jan 2024 15:10:13 -0800
In-Reply-To: <20240123231014.3801041-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123231014.3801041-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123231014.3801041-2-surenb@google.com>
Subject: [PATCH v2 2/3] mm: add mm_struct sequence number to detect write locks
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	dchinner@redhat.com, casey@schaufler-ca.com, ben.wolsieffer@hefring.com, 
	paulmck@kernel.org, david@redhat.com, avagin@google.com, 
	usama.anjum@collabora.com, peterx@redhat.com, hughd@google.com, 
	ryan.roberts@arm.com, wangkefeng.wang@huawei.com, Liam.Howlett@Oracle.com, 
	yuzhao@google.com, axelrasmussen@google.com, lstoakes@gmail.com, 
	talumbau@google.com, willy@infradead.org, vbabka@suse.cz, 
	mgorman@techsingularity.net, jhubbard@nvidia.com, vishal.moola@gmail.com, 
	mathieu.desnoyers@efficios.com, dhowells@redhat.com, jgg@ziepe.ca, 
	sidhartha.kumar@oracle.com, andriy.shevchenko@linux.intel.com, 
	yangxingui@huawei.com, keescook@chromium.org, sj@kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Provide a way for lockless mm_struct users to detect whether mm might have
been changed since some specific point in time. The API provided allows
the user to record a counter when it starts using the mm and later use
that counter to check if anyone write-locked mmap_lock since the counter
was recorded. Recording the counter value should be done while holding
mmap_lock at least for reading to prevent the counter from concurrent
changes. Every time mmap_lock is write-locked mm_struct updates its
mm_wr_seq counter so that checks against counters recorded before that
would fail, indicating a possibility of mm being modified.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm_types.h  |  2 ++
 include/linux/mmap_lock.h | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index bbe1223cd992..e749f7f09314 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -846,6 +846,8 @@ struct mm_struct {
 		 */
 		int mm_lock_seq;
 #endif
+		/* Counter incremented each time mm gets write-locked */
+		unsigned long mm_wr_seq;
 
 
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 8d38dcb6d044..0197079cb6fe 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -106,6 +106,8 @@ static inline void mmap_write_lock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write(&mm->mmap_lock);
+	/* Pairs with ACQUIRE semantics in mmap_write_seq_read */
+	smp_store_release(&mm->mm_wr_seq, mm->mm_wr_seq + 1);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
@@ -113,6 +115,8 @@ static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 {
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write_nested(&mm->mmap_lock, subclass);
+	/* Pairs with ACQUIRE semantics in mmap_write_seq_read */
+	smp_store_release(&mm->mm_wr_seq, mm->mm_wr_seq + 1);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
@@ -122,6 +126,10 @@ static inline int mmap_write_lock_killable(struct mm_struct *mm)
 
 	__mmap_lock_trace_start_locking(mm, true);
 	ret = down_write_killable(&mm->mmap_lock);
+	if (!ret) {
+		/* Pairs with ACQUIRE semantics in mmap_write_seq_read */
+		smp_store_release(&mm->mm_wr_seq, mm->mm_wr_seq + 1);
+	}
 	__mmap_lock_trace_acquire_returned(mm, true, ret == 0);
 	return ret;
 }
@@ -140,6 +148,20 @@ static inline void mmap_write_downgrade(struct mm_struct *mm)
 	downgrade_write(&mm->mmap_lock);
 }
 
+static inline unsigned long mmap_write_seq_read(struct mm_struct *mm)
+{
+	/* Pairs with RELEASE semantics in mmap_write_lock */
+	return smp_load_acquire(&mm->mm_wr_seq);
+}
+
+static inline void mmap_write_seq_record(struct mm_struct *mm,
+					 unsigned long *mm_wr_seq)
+{
+	mmap_assert_locked(mm);
+	/* Nobody can concurrently modify since we hold the mmap_lock */
+	*mm_wr_seq = mm->mm_wr_seq;
+}
+
 static inline void mmap_read_lock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_start_locking(mm, false);
-- 
2.43.0.429.g432eaa2c6b-goog


