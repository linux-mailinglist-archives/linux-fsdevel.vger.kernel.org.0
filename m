Return-Path: <linux-fsdevel+bounces-68543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF83C5F35C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 21:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15A1235A424
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 20:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC8F3431F2;
	Fri, 14 Nov 2025 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggiVU6Pv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A702D47FE
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151490; cv=none; b=Yb0oLFHvbOfM0aZi1YR1UVzQdFVxOeuZX2swP3sJle83UboQU5qdF/mkc/WAknaDwLwIz22FLUZhV4FnEe7J8XsAOrA5zbkCTTf7/uNytDyXOqNBIZo4UMqnymiL8lBgoDvoGM6kq5k42YxBqCHNNNadvNcIFCCFzlidCXBlSUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151490; c=relaxed/simple;
	bh=kKvy37QW1/3BR8fdYquPuqP9EYS4mty39BS6D4AcBpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dJa0y7wivCqTze6uKDbHTs2X45ZXDaaMn6F93txXHcc42jHRVrinLUe2XJPI9w0uEsPVXeevGIbi2UCE2JehyVbjjmFFji6rPkVVCBKEOIqmMuJp2EM18KLKiqlIoHX1ucQdSNAPABvwqGgdyz3op1grqE4NynyTAOAAnIejDYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggiVU6Pv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b566859ecso1642106f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 12:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763151487; x=1763756287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RH2DEqpNSuBdy+arsRdO9BnWsTVg860XrhzdhL1pOfA=;
        b=ggiVU6PvBcXszn/H13V2VpmhvGHUbeQX616doKn13MxiQgw7ADA09wcDBVl/m3kWgb
         SKcpiN4Abyyhn2n5AbgM1qlyGthi9TJXwRGhM7Q1QyoBXbDZMSI30ZJma85AqDFzIx9X
         tINJJotmWXeg0KQ9zbqEkT15JJr2OjbLlGeNBlMH+5494Ygn8anHqp8lY1GxFzddrjjz
         v8uYe2FTPBMQKVOLi6ACQo1wbh89o5becKU2D1NnQiTsbOcYj6ypWElBrRQrH+uHAIY5
         +NjjbdkU8hGJSt95ma4OlLLa7FZKHo4wX20U99ASHsWHkcF+mzYhL0bZQNx8dNaJ2/kh
         mU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763151487; x=1763756287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RH2DEqpNSuBdy+arsRdO9BnWsTVg860XrhzdhL1pOfA=;
        b=jmgIg5d1et/f117OOa5qAOF9Mhd7def/bAaU/rlKMmEMpSbu/x+K8fHvP8mGxOyJqn
         9bxbUJay0g6WtKwSjemFvrmC4Bn7JWSoO+iMZO93f7ITsj9PElMkYBEdeGqSmB5Gi3DZ
         Uux3aghg+ejbSdtNI0nvf0IPWhqbggBfyloMUINOatUhONibzh1MadMU6Jrl7HbKU4Mr
         8jHoMEnVMnz0vD/OcUyVmYrR7PEPu8ggEttBYaPGK5AgHDDL44KKmfj0F8mLQC8WVyn7
         D1woCFwd62AhA2uIH9ZzhgvNTrTwZzqCqCJ7yaUTYKkbIYm+DRHqxtN8k+MwrBGRUUDY
         4cBA==
X-Forwarded-Encrypted: i=1; AJvYcCXoD1cAUsfaRVIjR3ZbA4IzWa+RWirTz4wIFtNBsx+X4vlkM9Vj6Mx4Ph3SBenaxEQHfFVJq4KZWdLiFLuZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyvPz7Zu+5+yAalX1EgEvw5SMOPg1KUCZSQm1qL7Yhcr3/TFUGA
	pR9zGSr7e1X/xOwl7o1RuUY89W18kqYRCfBNQo4wul9+0noXENiQ5wBc
X-Gm-Gg: ASbGncsrIczaSLhgqAFl5hn8WWzutqPmaJejtpXFy0ixvzW6XMSj+/XaJGQ5voWBH5x
	wrYkNeRFNJpU8WiL/TMlr+YnqReSBPsyb5jSVHUs+/njTvMljklddix/KnpCIKdWgCyfzA6pWb3
	Q1zOBmTqK9smXCRJHg7eGkFhKmY4rq0EE1j6M2cH0UxRRTQQ3C4lSOx1dXROQ8BMT0hEsknsP4h
	SSoFZCRgWFRBBuSsZMbcTo+uVk8F8IXarL+p2eqDT35qdt0hN3f2SUan2B2lq1rxp+daTXyEEuV
	/zTUB1J9YSjPkWzUq6//NJ5zGa4CcLVbEHdbmMNg52yHaOj5wX0IhyN9YginyeZDEkoH1mkKpf3
	GjwXhgz5TYelJKDTR3g2bUkT1lKxHNscaB/lzgP0TXNMQRMfe8Xt9CoQhQBRqqAvJh7GYnD+69F
	e0FJyqJ6kQxqKJq48OMd7cWiYyhNNnuQf1hhnViWn1PZ4ySHE7/t1z3g0KA5g=
X-Google-Smtp-Source: AGHT+IEi/ByZwNTkmJ4EcrnRiPDFN+AfIVbFmG1jNcMXN07oSP3veXjXBSY+4y2d2Bmdx4mTbv6+1w==
X-Received: by 2002:a05:6000:1842:b0:42b:3dfb:645f with SMTP id ffacd0b85a97d-42b59394e14mr4014548f8f.47.1763151486271;
        Fri, 14 Nov 2025 12:18:06 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e84a4fsm11436112f8f.11.2025.11.14.12.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 12:18:05 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: move mntput_no_expire() slowpath into a dedicated routine
Date: Fri, 14 Nov 2025 21:18:03 +0100
Message-ID: <20251114201803.2183505-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the stock variant the compiler spills several registers on the stack
and employs stack smashing protection, adding even more code + a branch
on exit..

The actual fast path is small enough that the compiler inlines it for
all callers -- the symbol is no longer emitted.

Forcing noinline on it just for code-measurement purposes shows the fast
path dropping from 111 to 39 bytes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

fast path prior:
    call   ffffffff81374630 <__fentry__>
    push   %r15
    push   %r14
    push   %r13
    push   %r12
    push   %rbp
    push   %rbx
    sub    $0x18,%rsp
    mov    %gs:0x2deef5d(%rip),%rbx        # ffffffff8454f008 <__stack_chk_guard>

    mov    %rbx,0x10(%rsp)
    mov    %rdi,%rbx
    mov    %rsp,(%rsp)
    mov    %rsp,0x8(%rsp)
    call   ffffffff814615f0 <__rcu_read_lock>
    mov    0xe8(%rbx),%rax
    test   %rax,%rax
    je     ffffffff817600ff <mntput_no_expire+0x6f>
    mov    0x58(%rbx),%rax
    decl   %gs:(%rax)
    call   ffffffff81466810 <__rcu_read_unlock>
    mov    0x10(%rsp),%rax
    sub    %gs:0x2deef22(%rip),%rax        # ffffffff8454f008 <__stack_chk_guard>

    jne    ffffffff8176030b <mntput_no_expire+0x27b>
    add    $0x18,%rsp
    pop    %rbx
    pop    %rbp
    pop    %r12
    pop    %r13
    pop    %r14
    pop    %r15
    jmp    ffffffff823091f0 <__pi___x86_return_thunk>

after (when forced to be out-of-line):
    call   ffffffff81374630 <__fentry__>
    push   %rbx
    mov    %rdi,%rbx
    call   ffffffff814615f0 <__rcu_read_lock>
    mov    0xe8(%rbx),%rax
    test   %rax,%rax
    je     ffffffff81760347 <mntput_no_expire+0x27>
    mov    0x58(%rbx),%rax
    decl   %gs:(%rax)
    pop    %rbx
    jmp    ffffffff81466810 <__rcu_read_unlock>

 fs/namespace.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index e8f1fe4bca06..6af6b082043c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1346,26 +1346,12 @@ static void delayed_mntput(struct work_struct *unused)
 }
 static DECLARE_DELAYED_WORK(delayed_mntput_work, delayed_mntput);
 
-static void mntput_no_expire(struct mount *mnt)
+static void noinline mntput_no_expire_slowpath(struct mount *mnt)
 {
 	LIST_HEAD(list);
 	int count;
 
-	rcu_read_lock();
-	if (likely(READ_ONCE(mnt->mnt_ns))) {
-		/*
-		 * Since we don't do lock_mount_hash() here,
-		 * ->mnt_ns can change under us.  However, if it's
-		 * non-NULL, then there's a reference that won't
-		 * be dropped until after an RCU delay done after
-		 * turning ->mnt_ns NULL.  So if we observe it
-		 * non-NULL under rcu_read_lock(), the reference
-		 * we are dropping is not the final one.
-		 */
-		mnt_add_count(mnt, -1);
-		rcu_read_unlock();
-		return;
-	}
+	VFS_BUG_ON(mnt->mnt_ns);
 	lock_mount_hash();
 	/*
 	 * make sure that if __legitimize_mnt() has not seen us grab
@@ -1416,6 +1402,26 @@ static void mntput_no_expire(struct mount *mnt)
 	cleanup_mnt(mnt);
 }
 
+static void mntput_no_expire(struct mount *mnt)
+{
+	rcu_read_lock();
+	if (likely(READ_ONCE(mnt->mnt_ns))) {
+		/*
+		 * Since we don't do lock_mount_hash() here,
+		 * ->mnt_ns can change under us.  However, if it's
+		 * non-NULL, then there's a reference that won't
+		 * be dropped until after an RCU delay done after
+		 * turning ->mnt_ns NULL.  So if we observe it
+		 * non-NULL under rcu_read_lock(), the reference
+		 * we are dropping is not the final one.
+		 */
+		mnt_add_count(mnt, -1);
+		rcu_read_unlock();
+		return;
+	}
+	mntput_no_expire_slowpath(mnt);
+}
+
 void mntput(struct vfsmount *mnt)
 {
 	if (mnt) {
-- 
2.48.1


