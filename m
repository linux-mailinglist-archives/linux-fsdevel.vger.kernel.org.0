Return-Path: <linux-fsdevel+bounces-23932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852D0934FC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 17:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06CDE1F21705
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 15:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EFD1442F0;
	Thu, 18 Jul 2024 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA2h+VwU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B430D143C72;
	Thu, 18 Jul 2024 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315937; cv=none; b=R2sKukXSTuqsjXfcqMYNH3pxfwbCrq/58B3i1qBJSG8VyYUl1SKNeW5uE407ES/mZvJF7GagbrbLOkjAWv55PWk8omO5rFBT9QMt7GPq5TL07Tvm5fvPqGAUozDl2f+S8IHurkleDLW8dK0Iq82yh16QrDU2EymAwy6hm242VC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315937; c=relaxed/simple;
	bh=TfJwI1DxA0iQKpb1qdrSRO0yvas7Lmr0kvx/NkBIRtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X4bJaeLwzsmN9rSfjlsgziIN0L4MVYSrGTkG2YKKCdZQPRw5F1WnCaE34xciPpIweLcoRgh1Mjvt5LL4z/W37HlGh8l5TuPrIFq9BPL/99EDmidaMR8alTsvTz3opeoyY6jKgrqk/qQIXt3isnFcqNCl2o/bVJoRK2T9WgvhU3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dA2h+VwU; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so1564052a12.1;
        Thu, 18 Jul 2024 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721315934; x=1721920734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=66tOt3U7e+mliJJ0zIhh+HtH8ytlVxjCTIQsAfp/IiY=;
        b=dA2h+VwUbjugxOpnxDcLveuKRHa7MtzAs+j+WJi/dj+ohdi0PN+bEVm6YPRvo4+q7Q
         qeKazMnTB4TS611F9fyrUENNHhungIDXdJiDPRXpGh2yIllxE2uoCorKWrlFkSstjXMR
         ekwZn+tDBUVW64sgDBI9vnUrOd5zXR3oTSyCZnxeL4ChgI0PCE9oiSwMpB2AxggJMHWA
         TgvTYyLSWjqdCeLq636Eq+/lCW8piQj632fdNNVaW0pIJVRaeV1C6wbytvj11tZCRXwQ
         5aMa8hJV5EYfXkYA0kQoCOmVqyFNOHlrtdC18kXXqTsSx0/djX8TADoQVfwHY/j08MIz
         38Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721315934; x=1721920734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66tOt3U7e+mliJJ0zIhh+HtH8ytlVxjCTIQsAfp/IiY=;
        b=vBx29fK4VQCLygSwsiy78ca2f+mPyFulEmipnz6u3gFOOS3+UZq8EEhwwaa0GlcWeT
         g7oWrH9Mn2GdEVLtso1WL7LVVW59uaYCKW6flBdrSG/jjAvvxDnH0eSu2hvdLycw5YCf
         Z0L2aHixjDKJLRLK7APSHNZGD6oQusqq2E8e0/p0KnI5eQUnJSiSRsxWjjQQf4xIck51
         khxy1W2c1DtUMFo3tSeiVkbhgSXjoKpqvmYAFR86VMfxIVOyENZFSZh/5GvOaKu0vVH7
         oOlXHPz+wWxI8uwxpsYiDXP93wM7uUfB2J1Ck16sp5eHNwdSdI9JjWhCQkOcWqtPb4hg
         Tlng==
X-Forwarded-Encrypted: i=1; AJvYcCUbKFroH+fz2GcpBkqqe7tAh6jJTSAw2pKljlQUwqUAUh83fHnbYskFwBQQfpq5lgV43B6Xf1V/0DjeNIc7rkAYPBL1PN6xrJ6lSQjN9w+DfOL7NWsjYQVGCRUF3rro6Ml1njIotE5CfkL3ZA==
X-Gm-Message-State: AOJu0Yzq4JsN/L4t9J0RqifgDmVOcNiMhJz8R/tYh62AGEqqtVfp49hG
	SkxuRSrHvg4qnqT+TDWBcpcn4WEb4TVu83FLL1IBiWN4veRalxpf0jpqtVl0
X-Google-Smtp-Source: AGHT+IE5uwWjaNe+xWyJsYA3Q9W9tES3ir/K/R4AB7aMUxALfpcM+4hBfX86Yv6StyXC7bfdgiipqw==
X-Received: by 2002:a05:6402:2110:b0:57d:3e48:165d with SMTP id 4fb4d7f45d1cf-5a1557cd01fmr4004540a12.4.1721315933804;
        Thu, 18 Jul 2024 08:18:53 -0700 (PDT)
Received: from f.. (cst-prg-77-238.cust.vodafone.cz. [46.135.77.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59f7464d40asm4218581a12.68.2024.07.18.08.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 08:18:53 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jakub Kicinski <kuba@kernel.org>,
	v9fs@lists.linux.dev,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: handle __wait_on_freeing_inode() and evict() race
Date: Thu, 18 Jul 2024 17:18:37 +0200
Message-ID: <20240718151838.611807-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockless hash lookup can find and lock the inode after it gets the
I_FREEING flag set, at which point it blocks waiting for teardown in
evict() to finish.

However, the flag is still set even after evict() wakes up all waiters.

This results in a race where if the inode lock is taken late enough, it
can happen after both hash removal and wakeups, meaning there is nobody
to wake the racing thread up.

This worked prior to RCU-based lookup because the entire ordeal was
synchronized with the inode hash lock.

Since unhashing requires the inode lock, we can safely check whether it
happened after acquiring it.

Link: https://lore.kernel.org/v9fs/20240717102458.649b60be@kernel.org/
Reported-by: Dominique Martinet <asmadeus@codewreck.org>
Fixes: 7180f8d91fcb ("vfs: add rcu-based find_inode variants for iget ops")
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

The 'fixes' tag is contingent on testing by someone else. :>

I have 0 experience with 9pfs and the docs failed me vs getting it
running on libvirt+qemu, so I gave up on trying to test it myself.

Dominique, you offered to narrow things down here, assuming the offer
stands I would appreciate if you got this sorted out :)

Even if the patch in the current form does not go in, it should be
sufficient to confirm the problem diagnosis is correct.

A debug printk can be added to validate the problematic condition was
encountered, for example:

> diff --git a/fs/inode.c b/fs/inode.c
> index 54e0be80be14..8f61fad0bc69 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2308,6 +2308,7 @@ static void __wait_on_freeing_inode(struct inode *inode, bool locked)
>         if (unlikely(inode_unhashed(inode))) {
>                 BUG_ON(locked);
>                 spin_unlock(&inode->i_lock);
> +               printk(KERN_EMERG "%s: got unhashed inode %p\n", __func__, inode);
>                 return;
>         }


 fs/inode.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index f356fe2ec2b6..54e0be80be14 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -676,6 +676,16 @@ static void evict(struct inode *inode)
 
 	remove_inode_hash(inode);
 
+	/*
+	 * Wake up waiters in __wait_on_freeing_inode().
+	 *
+	 * Lockless hash lookup may end up finding the inode before we removed
+	 * it above, but only lock it *after* we are done with the wakeup below.
+	 * In this case the potential waiter cannot safely block.
+	 *
+	 * The inode being unhashed after the call to remove_inode_hash() is
+	 * used as an indicator whether blocking on it is safe.
+	 */
 	spin_lock(&inode->i_lock);
 	wake_up_bit(&inode->i_state, __I_NEW);
 	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
@@ -2291,6 +2301,16 @@ static void __wait_on_freeing_inode(struct inode *inode, bool locked)
 {
 	wait_queue_head_t *wq;
 	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
+
+	/*
+	 * Handle racing against evict(), see that routine for more details.
+	 */
+	if (unlikely(inode_unhashed(inode))) {
+		BUG_ON(locked);
+		spin_unlock(&inode->i_lock);
+		return;
+	}
+
 	wq = bit_waitqueue(&inode->i_state, __I_NEW);
 	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
 	spin_unlock(&inode->i_lock);
-- 
2.43.0


