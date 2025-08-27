Return-Path: <linux-fsdevel+bounces-59407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D10B387BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 18:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA0C97A8487
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B752701C5;
	Wed, 27 Aug 2025 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+CzF/Kz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC847225795;
	Wed, 27 Aug 2025 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311868; cv=none; b=FiotETmbpQD9aVyH4QxIGR7nB4Ca+M3X6hlwXU6pLGyiBphiauOO0JLeFs8l6fpq3eG+AMRNAf9cOijBMPR8iZNn9aUNsTB8BUjVsJVMH4VFP4zxjP83we4n1kVyclY8K436nwCS6AYQbZsiQtq3C/kpmutxDDVPWLHMik8PC6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311868; c=relaxed/simple;
	bh=q11WpxUFhvO/esftWBjREbWcgHoEc2c9tkJDBH8/zR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuDC9EenPdzfuTwJtOgWJIgzczq04b9O8SI6UImFXQd96v1qOeKzZ5joBbwcVL5RS0BxcbkAyOaj6vpXuX5tTigfbV+hhfF3/g1wM+s1aiEPItmcPsfKWBJfD/gmh+fS713U/GXXUK/UE0zS6RyWnWDeGUkBzljibnAKBfA7Pn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+CzF/Kz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1ac7c066so272635e9.1;
        Wed, 27 Aug 2025 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756311865; x=1756916665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtqLPxSOjNA92P/67aisgS/1EtyVsOb1fQUkLLE6hBg=;
        b=h+CzF/KznTaAhJh1K00NKb93FUuELQiXJgZxyvtQhHIKauSINLkQcACLdpM9tZN04V
         sia6UQetSFUJ3kakbZHxJNyGRn3lcipb5NcfKKJZAcqLva2KLl9cnRQ6qp2k6UkYuShC
         bpMaV5jVqYteUKSHzkeystmdPnuWOpDrj1Ppt8n5RJGDMts9WRB3loLz/lzF0nbI10YP
         r2VZPKPqoUlPfhv7DhqlryqWSY0oMFsQP3uBJWqOwvFPJ+s/jnutnWMIFJsHhinupqen
         mxOfaWL76P1rkyvJckx8HjFwUPjbRY+jNA2+oQXkKlG/ldPGhGESsbfFdyGTXEo7s4gp
         CbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756311865; x=1756916665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtqLPxSOjNA92P/67aisgS/1EtyVsOb1fQUkLLE6hBg=;
        b=TwHoAizEVQ7UxgaWtcy8sxXF3vdgMoqTUpMELcfD5Ing7/fU/nb7xzjh4wXjEjYLMh
         4nHvcXPtrxEsYMFhwDJwefQmvcXAOC5X/ch/pBeLM3bcHm/VkwJvjkjlNmsmnDseu2+7
         KzYyn1BUmBH4ZBXyE84IVcCXK/8MTiWEBUNIz7fzYdQ2boG7p9//wWXthsyklhUd3FwP
         1BgV7LqnNaxVlOWYa13gbGCeH+HgSpROw1jhRQ5EkW2vdymWP2KAmBDc45g3cRqbMNUd
         3D93sFflOFT+esTe56BecVB1Af0HOHdZx3kxlOz95xm9XWV/o3VmvpCgvafN2kBZwDRK
         jisg==
X-Forwarded-Encrypted: i=1; AJvYcCU3yAR41IljPMva1O9Vc9+EWvFE1dHLsLJYu7VjthGgU986q3vQ/5bNGb4aUR/WyjHqYOJcBJSQD18ZoA==@vger.kernel.org, AJvYcCUhZbUNI0RQUvi5WoZsTp/sd7BlNneHSeKM5phD7mJbq6N7Uf8LZphNBz2qvoJ4wjNp1/U3UjGUOBYBlH7T@vger.kernel.org, AJvYcCV1auSobla00bfJzj4w4mW6oxPRcMB9iqK6rIhELDOxSgbRtJEeEKt93nZKgQhtYWU5RbBNZqFRnutiDQ==@vger.kernel.org, AJvYcCWgju3K2MpfHd9N6+l/XknIfoArmtPhANKGrhvNnSpF9Mwj83M03hQvYHc7pPn33L1EyxVX35Bw98Ci@vger.kernel.org, AJvYcCXwiMCrKpeST+SKu66bJNod5e4D8ORUM3aAEgFCrBEAs4byoAUzTjIsnNsbTQbjBWHS72KYkCt97ptoOBHtJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwHXiaPo4nMYuQFHjblflS2SPONKjbshkekCna8l74q4B5QNx
	a1+CSIRFhUkA1Z5Wub9h8uJTm4Bst6BRCDuO5FfHc0yyL9st3TgFqE3A
X-Gm-Gg: ASbGnctqn1aduZFKdMSOA96oFRX948oQFr1ot66TTkSsPkiAmMdsCr3+EzK3MpaOg0x
	zvSWpd5v3+p7sUreLEyj19GVQ8rgpCJvh/ulTCd2xAPymRVKRjZw1IG+hUM2fJbtz9LOwMOBOG4
	P30S44L7bWUM0ok9X4dBNkNjZdQIxmLMCmR5zaT2RzcADCFWiN1DeHsJA5Zn+6Gm0EgRm6lEJJT
	K1QE6pWQS3f/ksQnXQ9d9qyZe+BxXj3voHOVO4yjLQ5IaIAf2bvgZ6Mf7QVH0FQYODDYYedYFcu
	OpTL4vs3EIUsl97hYEK5ck4BqO8vC0jrgTbE4XetDo1aE4EqCiGVPUI/b52OsHObEjqPPA4gxMh
	/NPGWs+2nAN6p7X/HFI6mqyGxKUM+jcuj1oIM+Rfo9uBZkEGs
X-Google-Smtp-Source: AGHT+IEb47YJOUw2T2IjYN+oZreDcC2dDxETmr3b+2Z7K0zidaTMTBRhE+jy8CSfkhHRAmxsQjuE8A==
X-Received: by 2002:a05:600c:1554:b0:455:f7d5:1224 with SMTP id 5b1f17b1804b1-45b6870ddcamr51991355e9.9.1756311864769;
        Wed, 27 Aug 2025 09:24:24 -0700 (PDT)
Received: from f.. (cst-prg-2-200.cust.vodafone.cz. [46.135.2.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba44fsm21078170f8f.5.2025.08.27.09.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:24:24 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: revamp iput()
Date: Wed, 27 Aug 2025 18:24:09 +0200
Message-ID: <20250827162410.4110657-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827-kraut-anekdote-35789fddbb0b@brauner>
References: <20250827-kraut-anekdote-35789fddbb0b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The material change is I_DIRTY_TIME handling without a spurious ref
acquire/release cycle.

While here a bunch of smaller changes:
1. predict there is an inode -- bpftrace suggests one is passed vast
   majority of the time
2. convert BUG_ON into VFS_BUG_ON_INODE
3. assert on ->i_count
4. assert ->i_lock is not held
5. flip the order of I_DIRTY_TIME and nlink count checks as the former
   is less likely to be true

I verified atomic_read(&inode->i_count) does not show up in asm if
debug is disabled.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

The routine kept annoying me, so here is a further revised variant.

I verified this compiles, but I still cannot runtime test. I'm sorry for
that.  My signed-off is conditional on a good samaritan making sure it
works :)

diff compared to the thing I sent "informally":
- if (unlikely(!inode))
- asserts
- slightly reworded iput_final commentary
- unlikely() on the second I_DIRTY_TIME check

Given the revamp I think it makes sense to attribute the change to me,
hence a "proper" mail.

The thing surviving from the submission by Josef is:
+       if (atomic_add_unless(&inode->i_count, -1, 1))
+               return;

And of course he is the one who brought up the spurious refcount trip in
the first place.

I'm happy with Reported-by, Co-developed-by or whatever other credit
as you guys see fit.

That aside I think it would be nice if NULL inodes passed to iput
became illegal, but that's a different story for another day.

 fs/inode.c | 46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 01ebdc40021e..01a554e11279 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1908,20 +1908,44 @@ static void iput_final(struct inode *inode)
  */
 void iput(struct inode *inode)
 {
-	if (!inode)
+	if (unlikely(!inode))
 		return;
-	BUG_ON(inode->i_state & I_CLEAR);
+
 retry:
-	if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
-		if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
-			atomic_inc(&inode->i_count);
-			spin_unlock(&inode->i_lock);
-			trace_writeback_lazytime_iput(inode);
-			mark_inode_dirty_sync(inode);
-			goto retry;
-		}
-		iput_final(inode);
+	lockdep_assert_not_held(&inode->i_lock);
+	VFS_BUG_ON_INODE(inode->i_state & I_CLEAR, inode);
+	/*
+	 * Note this assert is technically racy as if the count is bogusly
+	 * equal to one, then two CPUs racing to further drop it can both
+	 * conclude it's fine.
+	 */
+	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) < 1, inode);
+
+	if (atomic_add_unless(&inode->i_count, -1, 1))
+		return;
+
+	if ((inode->i_state & I_DIRTY_TIME) && inode->i_nlink) {
+		trace_writeback_lazytime_iput(inode);
+		mark_inode_dirty_sync(inode);
+		goto retry;
 	}
+
+	spin_lock(&inode->i_lock);
+	if (unlikely((inode->i_state & I_DIRTY_TIME) && inode->i_nlink)) {
+		spin_unlock(&inode->i_lock);
+		goto retry;
+	}
+
+	if (!atomic_dec_and_test(&inode->i_count)) {
+		spin_unlock(&inode->i_lock);
+		return;
+	}
+
+	/*
+	 * iput_final() drops ->i_lock, we can't assert on it as the inode may
+	 * be deallocated by the time the call returns.
+	 */
+	iput_final(inode);
 }
 EXPORT_SYMBOL(iput);
 
-- 
2.43.0


