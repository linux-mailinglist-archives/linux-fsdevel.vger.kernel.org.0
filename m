Return-Path: <linux-fsdevel+bounces-35655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B42B9D6B45
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 20:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3858728251D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 19:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51A1188583;
	Sat, 23 Nov 2024 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgBJq+9/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61B134545;
	Sat, 23 Nov 2024 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732391404; cv=none; b=pFB1a9jy1hgz3a+Xk2MmQgfoBClLo8VSTNSSlqHPa8xCZZa97RRFM1QOUWZw6jIOO6tcF4TbBxHGVA3WgAvWGKOqxNBpQ/WD1kodKi31QxeX+Z3d/SMIis06LRiNsIYmaumS/AGAQ8Lxrcmt7oFJPeHajUgWkI8X2SNcTzPxhkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732391404; c=relaxed/simple;
	bh=0lJjK/Wj3Hu8vBZP4NKVokNyrxkIqZj5FLU4Os+ancI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xhf8GQxE4+OWJcunMnPJQiJprn9AiLFZtuayZElO8uUjUtqh+0sC53YbVTtoaXPlbeV4fTqF9Ddwhkl22uyi7QaARnMoE0WrFewW4R8KC4OwCw/LX2W7NQsxTOgFsD3IkKP2YV8Gun/fq+SENkUmEZE/0/KXsuhr33vRo9O3Jqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgBJq+9/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7246c8b89b4so3146851b3a.1;
        Sat, 23 Nov 2024 11:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732391402; x=1732996202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtpJ5UMR5MaspyfBoKBZMhSAyxFrrP/3aDqY9HRg/tw=;
        b=QgBJq+9/kIbGqrS9KV2K0UWpMvL1+qegKyVCgyS2ZEWUfzBP91yxsNNO0QfO+/h2zO
         E2Zbuw4Ag+OTvfo0pAsOJ19ZPi8XThXlxN5kBubYq/kz158WWJcXYFx0ZKczK/h/1B+a
         pKfTRLXBI+1B/Tk3AvRnupgxVbugrAuru+i2rqtipHfhO0zCN9ZCorKuhvvnQy0rZzPR
         Bd1YJmOcg9ImZiVhdBrtI5GClFg6Cmza6rYw2aRVbWGoiUcnaO9DIGjhJOz7dh+2lRaY
         K1O9k2FfA8w/epGM3pumRN4CI5ZhzxZ/w2oyklI7lLL3JNORCF8tMipwl6OgdK9/qsuL
         XjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732391402; x=1732996202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtpJ5UMR5MaspyfBoKBZMhSAyxFrrP/3aDqY9HRg/tw=;
        b=WKZPm6G7+AJnWYBc6BrjshOqrf7C71hns+8/bBk8Fa5oDivXg8ZwypysaloRQA+F/B
         X51GpVfhYJ3Zr2T3c1ef5nv5EoBmXGUqmZ9USsevbYjfc1jJxGw5qBgMrhns4RWObrTf
         xMHbGr/XtdS298JSRrGXo1ze5GingNEgIRwMgiebeE4GkLOp+jIfvngsm4qIT1C3I3cc
         I8vnyTS4GfDcNtn0dHvxwgk7KsnvNWSBtJ1fkZENKdBxZeccsuzcDHOxDYnciBd4DL1v
         jFYND3ssmZ3rRlEv7wlL9Ipev0Nkfn0cKzNQi0N4qTftsF700EhEi01S1HVjpc7ODzD4
         /O3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfd33gn5O1691TF/PwW6nf+9/3KoNGWa0qYGMTLBNnA3oUxuixqueEMX7vl/i7gsxBs68stoifLwUDnEOn@vger.kernel.org, AJvYcCWAk5su8ZaWEccICHE7VfTpqxJKTlgMYsKkavCrCN5mR2FxhkMK0Nj1VRb4fbW3ug7rvatkd/6XwB6r7nuU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3fns4tyW60q2V9+DFmKShxS/tNK4PoP247tw0Rn6MkrOer9H8
	Vey2NVEjYm6BIY62+nCpEaXsk3u8yXrBsvR1ah2hh4Fb6ijv5J60
X-Gm-Gg: ASbGncvdGyEdmfJMnYhB+/hwt5QQJ2BVw8qBDAq/rki+SjMuf0ukQYgh6c4Xt9E/g1c
	fa1HzG2I1KPCFpA+1VYwUKsApUktR+jptLYBVDZ2K7eygOOLZyqPi0Bgpc4+pvPFcd+q68DSbOP
	iiBeNHKzcbFDXC0X1wXZiRAO5orrznSLvcOiGSCmf2/U+0BlZReRcT9UP4FDKjnGqWg/C7f3WFk
	DtqPUWa5//kxH0Koy5QzSSIe8HHy1J7Yz2eITI05/RY1ljGCzNgsW8YSE4/Dqz+jg==
X-Google-Smtp-Source: AGHT+IEonW02YsXMiQhDOe5tluD1XYyX9QKCECbVHY7UXTIZwuR2Rb7BIbNCftr/q27vK/JUE+i3IQ==
X-Received: by 2002:a05:6a00:23cc:b0:71e:44f6:690f with SMTP id d2e1a72fcca58-724de95a306mr13402766b3a.8.1732391401983;
        Sat, 23 Nov 2024 11:50:01 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:86c6:5b62:b5b7:ec1a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de48f108sm3627957b3a.87.2024.11.23.11.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 11:50:01 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com,
	brauner@kernel.org,
	quic_jjohnson@quicinc.com,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	sandeen@redhat.com
Cc: Leo Stone <leocstone@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	shuah@kernel.org,
	anupnewsmail@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] hfs: Sanity check the root record
Date: Sat, 23 Nov 2024 11:49:47 -0800
Message-ID: <20241123194949.9243-1-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67400d16.050a0220.363a1b.0132.GAE@google.com>
References: <67400d16.050a0220.363a1b.0132.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the syzbot reproducer, the hfs_cat_rec for the root dir has type
HFS_CDR_FIL after being read with hfs_bnode_read() in hfs_super_fill().
This indicates it should be used as an hfs_cat_file, which is 102 bytes.
Only the first 70 bytes of that struct are initialized, however,
because the entrylength passed into hfs_bnode_read() is still the length of
a directory record. This causes uninitialized values to be used later on,
when the hfs_cat_rec union is treated as the larger hfs_cat_file struct.

Add a check to make sure the retrieved record has the correct type
for the root directory (HFS_CDR_DIR).

Reported-by: syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2db3c7526ba68f4ea776
Tested-by: syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
 fs/hfs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 3bee9b5dba5e..02d78992eefd 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -354,6 +354,8 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 			goto bail_hfs_find;
 		}
 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
+		if (rec.type != HFS_CDR_DIR)
+			res = -EIO;
 	}
 	if (res)
 		goto bail_hfs_find;
-- 
2.43.0


