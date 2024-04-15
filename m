Return-Path: <linux-fsdevel+bounces-16965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFD08A59A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 20:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935EC1F2304C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D9D13AA31;
	Mon, 15 Apr 2024 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDdEU2cp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18B284D24;
	Mon, 15 Apr 2024 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205219; cv=none; b=bW3RWevGncJimNXHhFdvUhwfhMjyUaAL1ILKIyd+776Q7gzDG9j+HRaieHobudYl0Tc8wpI71o7c47M/cdb2WFzj94B7EhqU3SPZ//QCiI9ET2CpBcYPgX25O4m+tF9UQ+Ckr+wNK1JCiXntkJIgsUph+0Zs5pQmp0Uh31ANdVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205219; c=relaxed/simple;
	bh=IxmxOLjq+t/EfrnlWvmdomJwg/g/pev1YIKJkP7Vx6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qbbg+9xhN7NopET8NBul1IlpEbnSwD7YPR9Mbj0DWnXCZY6Jg39+xVyO3d1SrUSKzIC1NRbrP37ETCNChlYKf3BmjXmalmaBd0ZU3QOTaMPDnaLHy9OvdlhRCWvFNjDkPXZJ+CjOiFNKIPmiYBjj5Z988Lp02kR8KNfr2kYUsFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDdEU2cp; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so2752993a12.3;
        Mon, 15 Apr 2024 11:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713205217; x=1713810017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FI1TOwX6IbVOSxRjrbyHiEmOox04GkI62QwnqlP7Bk=;
        b=CDdEU2cpIemPZGunL9YDwTEKGJVXprf0abSMvW9dLrHKu99MlpXLZkZuBNefebTqKb
         06C2FBPCrWb6s2i95GFQ6i6Kt0zPRY5MXHXE7Jy/QZxiSpZlj4oMDsg0wg4kvYxgh3r1
         ZHfqMzWn0PK04e6CQImMAr5ExgYZspZCZLad/e7MpxK/d3zsYPwcwIya3WRQk3sgYC2p
         2G+oaj6pJ0pisc9fOw7URsgkd6LG5QvTM2K2BD7qXXoVtbrhXbjkTy32lacSzPsTrYhM
         lIi1cA60aRPF9I4opEGiyr9EH9seHxlSZ13QcHDAWCLeI0q8bHyRI0bUEuoFACKgHytB
         EdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205217; x=1713810017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FI1TOwX6IbVOSxRjrbyHiEmOox04GkI62QwnqlP7Bk=;
        b=EtpbjxBagv6KzTqyyX8EMykDOm8lOlOXq6VCfGjqMm+7tKfAJrHTH5Pi3G0qtHHNEr
         u/cjG4Hi6/TOTtAsA4b/p/KXJoUd8UzODL68VtPKZYx/06kHElJDV6vFg2TUUdn8BycU
         11u/VXOJglbgSmKHgO4URwOPHdZiN8M/pJDm4TpbTOT0ibO68MkyU7NXch7E/YSXL4Vz
         hQvwib6zU1t/Qv8F/yXdW7x+jv4o55SvBQauZHDnzc3Ph2d4FpgRkV3l42Q3Ke4Ty4lo
         YZhVeuTNzn+iGE8/NSfJ81tQ7DGrWVe9iReAxNrpOhd54k7H5A36li/vnvk/TZdjPt6i
         OKIw==
X-Forwarded-Encrypted: i=1; AJvYcCUV8jDubPe0hyN0EvNAb8L6gbM+5bm5w0GDU2E7OTZJRJK1XTeyI/0Jil3licstN+87cItBJkk6F/SI5UywCCaMAyn4mlprhnUG8IpGzZIU5vcM+BoO6i+95FB7tiFH697TnpzUS5pKOyTXgQ==
X-Gm-Message-State: AOJu0YyRy/UbaiacuhYWCnTa3ANk7PsTKhQFWKwdBQajcX6hyD5HpxUL
	JTWmdAg4NX/o+xbZjKAJ+XjPP2q2bdDPdvbCnwIQe/ZgwlD7kaaX
X-Google-Smtp-Source: AGHT+IEGlEfn9JapJQf9Gkq2Odljvsi/yTxrSbQobAzjOevgF84o8rieFhXnvHE/rMYQUFKc2UrnuQ==
X-Received: by 2002:a05:6a20:6a04:b0:1a7:5d1a:45f1 with SMTP id p4-20020a056a206a0400b001a75d1a45f1mr9561991pzk.16.1713205216855;
        Mon, 15 Apr 2024 11:20:16 -0700 (PDT)
Received: from carrot.. (i223-218-110-112.s42.a014.ap.plala.or.jp. [223.218.110.112])
        by smtp.gmail.com with ESMTPSA id ld16-20020a056a004f9000b006ecf72e481esm7578524pfb.26.2024.04.15.11.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 11:20:16 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	syzbot <syzbot+2e22057de05b9f3b30d8@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] nilfs2: Fix OOB in nilfs_set_de_type
Date: Tue, 16 Apr 2024 03:20:48 +0900
Message-Id: <20240415182048.7144-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000209c9506161fd1d4@google.com>
References: <000000000000209c9506161fd1d4@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeongjun Park <aha310510@gmail.com>

The size of the nilfs_type_by_mode array in the fs/nilfs2/dir.c file is
defined as "S_IFMT >> S_SHIFT", but the nilfs_set_de_type() function,
which uses this array, specifies the index to read from the array in the
same way as "(mode & S_IFMT) >> S_SHIFT".

static void nilfs_set_de_type(struct nilfs_dir_entry *de, struct inode
 *inode)
{
	umode_t mode = inode->i_mode;

	de->file_type = nilfs_type_by_mode[(mode & S_IFMT)>>S_SHIFT]; // oob
}

However, when the index is determined this way, an out-of-bounds (OOB)
error occurs by referring to an index that is 1 larger than the array
size when the condition "mode & S_IFMT == S_IFMT" is satisfied.
Therefore, a patch to resize the nilfs_type_by_mode array should be
applied to prevent OOB errors.

Reported-by: syzbot+2e22057de05b9f3b30d8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2e22057de05b9f3b30d8
Fixes: 2ba466d74ed7 ("nilfs2: directory entry operations")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
Hi Andrew, please apply this as a bugfix.

This patch from Jeongjun fixes an array out-of-bounds access reported
by syzbot that can occur for filesystem images containing corrupted
directory inodes.

Thanks,
Ryusuke Konishi

 fs/nilfs2/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index bc846b904b68..aee40db7a036 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -240,7 +240,7 @@ nilfs_filetype_table[NILFS_FT_MAX] = {
 
 #define S_SHIFT 12
 static unsigned char
-nilfs_type_by_mode[S_IFMT >> S_SHIFT] = {
+nilfs_type_by_mode[(S_IFMT >> S_SHIFT) + 1] = {
 	[S_IFREG >> S_SHIFT]	= NILFS_FT_REG_FILE,
 	[S_IFDIR >> S_SHIFT]	= NILFS_FT_DIR,
 	[S_IFCHR >> S_SHIFT]	= NILFS_FT_CHRDEV,
-- 
2.34.1


