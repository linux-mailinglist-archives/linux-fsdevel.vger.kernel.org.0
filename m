Return-Path: <linux-fsdevel+bounces-26909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF26A95CD2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 15:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8560A281CCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 13:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAB61865EF;
	Fri, 23 Aug 2024 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOzNLhaP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D17D185934;
	Fri, 23 Aug 2024 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418458; cv=none; b=JrC3V5LfCJWdLMa3DZCndt4jVWYxFFMZC8TxpChD5qIlOX4QPfzCV53x+l5+8JgtRnaN52nSYqkKp4K3sBl7FN8MoTrfa6GB0gCjALeD/7EE88fgbZ453CalpVTZ6CbR4qzOMiNrkNyYg36JpwYtTBPf7opifUqKPbx6/wtCdLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418458; c=relaxed/simple;
	bh=md6wvIYInqDvwCnlq2oN/hcs0ZrJ5aQ4hMYF/cjf1nw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rpC8IgX511x/cS5OCdJE5FgHGJ6HHf9QWYfVcGgw5Xqx5D9IcwmDkszl+pviGCN/iW5FGnGa/8aMyFxAoeO2tH9f9BuLDheiomvCYgILqkhDWbXIBrxxfMU1ZU1pLU9ph3qnlGBNvXx4I6ySEG0SoTWHGnAIVqgb7552ho8z0k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOzNLhaP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-202376301e6so15608265ad.0;
        Fri, 23 Aug 2024 06:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724418456; x=1725023256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rlYuM/xStZRZGHv2D7dEfaRA47te2oJ7fzvapL8KZI4=;
        b=UOzNLhaP95kOZk3gOBmn66KZo1Wqr5NvrAj2vyYGCVjhXkXeS4i5egejOZeD/2CYNk
         /d5TJN5fKIXC0zSDHgHgO41TwTK+L8KoeN0bsOIyTj0DRw35dxqZLmQeHcBeKzMrLAuJ
         jwk2e40uEj07yvqQww0Sf1yHmhN4DxJ2Dj0NCoUbS+rbLV9vNutc+f2vV6nO6kL0KlpL
         Nkn6jWHX2+9gFwj0yTYwSdLCFuCPuxgnK/Hg3pn3/E8Hru5ojBzNhKw4aXiUSqmoNZM5
         XuCBZH22wupu7xB1XnFOjq09uYGcdWsPwxIpkkHuP1kmhHwyje+7G+Ccsk1PYc6igpMg
         nCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724418456; x=1725023256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlYuM/xStZRZGHv2D7dEfaRA47te2oJ7fzvapL8KZI4=;
        b=iJSAjlllzDeW/cXLLx1Sn1SEFQqkKBKLUCAVCAXvQdEyarRyjldJuDFUujAjFvFuAS
         5u82E0DDBBl22spoQhey41reY9O/eRShQ3VH9A3S3fqEHevxpEJZdRFetoxoevS2JT2G
         2I8dPa1lxbC505rPeVG39yn/XRosHZz005J71BcwRVYrv6RViUaGRDnnm1znJNCEVhOX
         FGshGYEsFQGK96xngFAx75vAQBwPWi9OTsXdDJ+ZLJXwp3FampI9li7yfyIfTa4qx3TU
         TSriELg+/bJXFLalVhMvWfCllhiaCknZpu9GjGk5jTVF7NKy9N2DuUdforgF8s+jfvDw
         hD8A==
X-Forwarded-Encrypted: i=1; AJvYcCUnXWtZDh9OrRL0db6k5nMY8CPJ0xoYShehQtZ0UMflH64UvSXv6J+QRjkPghQGvPo1vIOwejzb@vger.kernel.org, AJvYcCWMEuqfU4AT3Vf9jmjOlVo5A2f3XkPeUzd4vNcDMa2OobU5n6hwp1L8wDyBQNjr27+tnWShKKCSjLMxyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpGx/ID7NP9/4sq1RqdJbvmEqz5IZkoCupkXjVdZmad5XneF/G
	1NJgS06razleSCPWkpmukw8DSPJE5wZ5PybUJ7UXJx/OK8vMmLWa19f9SKQJXmg=
X-Google-Smtp-Source: AGHT+IG+z90BpU4n3/D5JvXJxPKNimH1Y2FygEdZ5a8zEddj3cN280eNkrOJRuCTc//DWkYOie1WEg==
X-Received: by 2002:a17:902:c94f:b0:203:a12e:f8ca with SMTP id d9443c01a7336-203a12efa78mr19458605ad.20.1724418455563;
        Fri, 23 Aug 2024 06:07:35 -0700 (PDT)
Received: from localhost ([123.113.110.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385580986sm27958085ad.79.2024.08.23.06.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 06:07:35 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	david@fromorbit.com,
	zhuyifei1999@gmail.com,
	Julian Sun <sunjunchao2870@gmail.com>,
	syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] vfs: fix race between evice_inodes() and find_inode()&iput()
Date: Fri, 23 Aug 2024 21:07:30 +0800
Message-Id: <20240823130730.658881-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all

Recently I noticed a bug[1] in btrfs, after digged it into
and I believe it'a race in vfs.

Let's assume there's a inode (ie ino 261) with i_count 1 is
called by iput(), and there's a concurrent thread calling
generic_shutdown_super().

cpu0:                              cpu1:
iput() // i_count is 1
  ->spin_lock(inode)
  ->dec i_count to 0
  ->iput_final()                    generic_shutdown_super()
    ->__inode_add_lru()               ->evict_inodes()
      // cause some reason[2]           ->if (atomic_read(inode->i_count)) continue;
      // return before                  // inode 261 passed the above check
      // list_lru_add_obj()             // and then schedule out
   ->spin_unlock()
// note here: the inode 261
// was still at sb list and hash list,
// and I_FREEING|I_WILL_FREE was not been set

btrfs_iget()
  // after some function calls
  ->find_inode()
    // found the above inode 261
    ->spin_lock(inode)
   // check I_FREEING|I_WILL_FREE
   // and passed
      ->__iget()
    ->spin_unlock(inode)                // schedule back
                                        ->spin_lock(inode)
                                        // check (I_NEW|I_FREEING|I_WILL_FREE) flags,
                                        // passed and set I_FREEING
iput()                                  ->spin_unlock(inode)
  ->spin_lock(inode)			  ->evict()
  // dec i_count to 0
  ->iput_final()
    ->spin_unlock()
    ->evict()

Now, we have two threads simultaneously evicting
the same inode, which may trigger the BUG(inode->i_state & I_CLEAR)
statement both within clear_inode() and iput().

To fix the bug, recheck the inode->i_count after holding i_lock.
Because in the most scenarios, the first check is valid, and
the overhead of spin_lock() can be reduced.

If there is any misunderstanding, please let me know, thanks.

[1]: https://lore.kernel.org/linux-btrfs/000000000000eabe1d0619c48986@google.com/
[2]: The reason might be 1. SB_ACTIVE was removed or 2. mapping_shrinkable()
return false when I reproduced the bug.

Reported-by: syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=67ba3c42bcbb4665d3ad
CC: stable@vger.kernel.org
Fixes: 63997e98a3be ("split invalidate_inodes()")
Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 3a41f83a4ba5..011f630777d0 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -723,6 +723,10 @@ void evict_inodes(struct super_block *sb)
 			continue;
 
 		spin_lock(&inode->i_lock);
+		if (atomic_read(&inode->i_count)) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
 		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
 			spin_unlock(&inode->i_lock);
 			continue;
-- 
2.39.2


