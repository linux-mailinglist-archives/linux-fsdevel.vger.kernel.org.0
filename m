Return-Path: <linux-fsdevel+bounces-44500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF7BA69D5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 01:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E3F18997F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 00:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2043D15C158;
	Thu, 20 Mar 2025 00:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhTKWHxU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82424690;
	Thu, 20 Mar 2025 00:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742431615; cv=none; b=haZEoRfQOVUWel5FU8VF3Al2Ysvlbt+d+mP1AD79IQ0bbe/J98VFfsLoMT34mnRNPaMrR+wTMzK3XYgCHi1h/w5aIt0PkscBip92HUyDxAZLo6I9Pu/oRcH3pJKnVC/FzJgqJWsxeshg/sGN0baMNuqJqBryCBbdomwOcvGSOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742431615; c=relaxed/simple;
	bh=kLftjTzXCqxPfjFVytwmzGj+w1ZvZzFghC5T1gJMirY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EsOfpTtt/OR7/Z0WqYGgIxD7JiAZC5Teh+PK3ZHIP4VqeBp4Ac2EBqx9NMZ1+u5HZtxEEsxQMN4s4OTBcuxCQvIRtPxlrfqaHRiI4hXaVjB+vLJoGq/nVXfbG+3f5hqayBOTUr1cR6TIt3WNCnAZla8q9dOdtkLQsCDriNDoEfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhTKWHxU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso1367915e9.1;
        Wed, 19 Mar 2025 17:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742431612; x=1743036412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JWT1HZcxgdD5H0gsV8JNG5vjgWpKUyKFyRlFbs8A5RY=;
        b=YhTKWHxUOC1od3OIL9LhO1pn0NrPeAmf+5+mhUg+6UU3ebOePyMrUUYOwnCD1w4WoA
         3QUGOXjr+NcgLFLF3uPX+71wxJS/6b9e6Z+x4uV5AmqjgGoQT7+y2asCrBx50eBXkfbB
         0OzasI7CAXTLXH/b49oxBaJkHFdvIDMUqGZcMjYA+Ccl2F7COaTVpUn6vDp6aO315cDG
         puRJH1e1LY3a13os/iG/PrmUvcxDARyNCJ72Dg6ADUpqtZgOx4c8woKh8G1Ed7KDB563
         /mAO9+Z4siVrcBQf8lOuQg1csT+BkKLqHEUicBPFJgPt+dtCHhWhik6nOyXrt7Uro/IC
         gOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742431612; x=1743036412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWT1HZcxgdD5H0gsV8JNG5vjgWpKUyKFyRlFbs8A5RY=;
        b=hwiNa+OkniPVWfqADCrVqbCaBXz2lsf+L3o6eIBQzL2/YBBYULTTPj6IBSOno/CaXc
         5mvO4x+xSnbC+CXmKYnCNeMiqP+sXyJkTSqUDcDWy0F4ZQWGUdJKlPbZE04CWVNp7DRu
         aRATVlcb5Lh8WLs4VAT/dfZ+lzXAPhD3dAo6QVH+qqd1Jvd/ua72svFTGSMQUgVjxAur
         DtOy4Hrk5OOVegtDnJQvtP/ud82c45vR+RaYGGZGbhLOPgY9bZyLckpX5FTVCIEGeZmE
         w6kBJpSOjUAVSksXY1pRJGFOy8xuIWjKAxEMPJO1Jk/58Gg1+ho7JFJxuZBg09d0E4mY
         cotw==
X-Forwarded-Encrypted: i=1; AJvYcCUC6D4/cgl7BciJMihokdbIbXtBb+q7I+cB+h2hg4aCL2TqJoBQTBlLfpONEHhxM54WEMiG9v+7uXNefzNf@vger.kernel.org, AJvYcCWVu90J7qUxe1yF4EfJhi0zt19YEYZaxH/Yyey9clELki0JQ36NEh93XJOiBwZl0PaVLFCEtiQyjz9ooVrL@vger.kernel.org
X-Gm-Message-State: AOJu0YwIibyEgxwydX8Uc9WOYUQH8RYcmxzbvvQ4nZFccl6vnhuAYesH
	qVRItqJoBS2jk20ReRl2j0b6vX8cUZnAxUNOvA157BGqngKXpCHEZlvj93cG
X-Gm-Gg: ASbGncs32pK1rk29asyn+STTbyMMYrIT4Daj4t5qr3acgP9WO5lRl2fU9SCcypv0lZ5
	Z7JyMURKg9SkPBna4MQKlPtcpMK52irofuRulg7pgw9COy7lNt1ABZu5AOud3DqQl1clUwMohyE
	M4HfLYJjwYbmGT7wrw9JGzYEIFXIDq3eqxeL+PRowRbKW3sMvOdIuSOTen4sllGp6zWjpuP+5BG
	cz/IKWKckvNjU2cinc4R1duh0JzoUw2yXvWn0RW5u3fwm9/TuVMIS+jNPHfPrRcZNuv6vsbPoLq
	2BPIRSobIilZLzZWKn3P5XiV2mnBVbMy9oHD5sgrneja+JIxjtDqvr7HC6TIms4=
X-Google-Smtp-Source: AGHT+IF3L6qgKT97lQDkx//5u3Bq4U1PG+Cf7sFNpCpv/3DA+AXv8ginLUIFU4byWR3N+GYWO44sTQ==
X-Received: by 2002:a7b:cbcf:0:b0:43d:10c:2f60 with SMTP id 5b1f17b1804b1-43d44bf3743mr25995915e9.24.1742431611686;
        Wed, 19 Mar 2025 17:46:51 -0700 (PDT)
Received: from f.. (cst-prg-67-174.cust.vodafone.cz. [46.135.67.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-397f2837e61sm16985837f8f.97.2025.03.19.17.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 17:46:51 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [RFC PATCH] fs: call inode_sb_list_add() outside of inode hash lock
Date: Thu, 20 Mar 2025 01:46:43 +0100
Message-ID: <20250320004643.1903287-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As both locks are highly contended during significant inode churn,
holding the inode hash lock while waiting for the sb list lock
exacerbates the problem.

Why moving it out is safe: the inode at hand still has I_NEW set and
anyone who finds it through legitimate means waits for the bit to clear,
by which time inode_sb_list_add() is guaranteed to have finished.

This significantly drops hash lock contention for me when stating 20
separate trees in parallel, each with 1000 directories * 1000 files.

However, no speed up was observed as contention increased on the other
locks, notably dentry LRU.

Even so, removal of the lock ordering will help making this faster
later.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

There were ideas about using bitlocks, which ran into trouble because of
spinlocks being taken *after* and RT kernel not liking that.

I'm thinking thanks to RCU this very much can be hacked around to
reverse the hash-specific lock -> inode lock: you find the inode you
are looking for, lock it and only then take the bitlock and validate it
remained in place.

The above patch removes an impediment -- the only other lock possibly
taken with the hash thing.

Even if the above idea does not pan out, the patch has some value in
decoupling these.

I am however not going to strongly argue for it given lack of results.

 fs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index e188bb1eb07a..8efd38c27321 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1307,8 +1307,8 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	}
 
 	if (set && unlikely(set(inode, data))) {
-		inode = NULL;
-		goto unlock;
+		spin_unlock(&inode_hash_lock);
+		return NULL;
 	}
 
 	/*
@@ -1320,14 +1320,14 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	hlist_add_head_rcu(&inode->i_hash, head);
 	spin_unlock(&inode->i_lock);
 
+	spin_unlock(&inode_hash_lock);
+
 	/*
 	 * Add inode to the sb list if it's not already. It has I_NEW at this
 	 * point, so it should be safe to test i_sb_list locklessly.
 	 */
 	if (list_empty(&inode->i_sb_list))
 		inode_sb_list_add(inode);
-unlock:
-	spin_unlock(&inode_hash_lock);
 
 	return inode;
 }
@@ -1456,8 +1456,8 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 			inode->i_state = I_NEW;
 			hlist_add_head_rcu(&inode->i_hash, head);
 			spin_unlock(&inode->i_lock);
-			inode_sb_list_add(inode);
 			spin_unlock(&inode_hash_lock);
+			inode_sb_list_add(inode);
 
 			/* Return the locked inode with I_NEW set, the
 			 * caller is responsible for filling in the contents
-- 
2.43.0


