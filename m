Return-Path: <linux-fsdevel+bounces-35184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ADE9D22B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 10:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66640282DB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42EB1C3036;
	Tue, 19 Nov 2024 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caqHBTuF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7321C2DB2;
	Tue, 19 Nov 2024 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009583; cv=none; b=UgTElrb3cMHAvkWB2tRZY9+ZDfMl1bBlKZUnE9q8XjLK2/qiWOcUrKE+6U0cIJjuACEzH9Qc5c8Pz7bCkVFETGibcNxDS4Jr6dBaGR4Yj0SFjHKJof8O/zSL32Jpy9kSh5suOOSnhUOP8KebWdWA7oA8g7TGOADAXwVtaSqkrKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009583; c=relaxed/simple;
	bh=xtTZUjsWZVXj5yW5dnZUqVQ8rBguXuqM28VC+lUH3wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bk0oixhe8D3PmzOEcOZyuQI9wnMVZK74+dY4KyMyiwZV2NF6Yjtek7lKuJJBUXetDh7pha7E7BTzWmX4KvFzpzTXZ4FRJ0eQT50hlWmohkvxPrXKMQm7c3U6JCEaboM7RP2TOmiQf3muZ9u789YvsMLQEUZLEHtLK1J3Kmdmyhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caqHBTuF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so1144674a12.2;
        Tue, 19 Nov 2024 01:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732009580; x=1732614380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMDpr51HGMdjTn/zZt2QmbhLNhc4xxoRwRH832sAaPM=;
        b=caqHBTuFm3Km3wQ2HHCiTYjzZOb5wOIAVDsUA7ZC54PdI0PP89o8jGRu18JdpKtl8w
         BRlX1u6XazDllJuy09C9vJi51gP+r+pLmYjc2jvftfEXsxlAOwJnMACg2DZuzMUZzIFm
         1xLCNcX3rNfEwxQmzP+DziwBjiLd7Gln+n4YXeQ2qcQNIF0Umm+00/LAeFJQE6QJE0zY
         aY7MC05M5lPGH7hFziCvmK6HTAonyb8ol8Njr/D8yxpeT4jbOcd/53MMo4/Gb8gf3QR/
         QH0rJ+0FPyZ4xccq60aDO5RB78SqrMml4HntBVC3gZcARfiW0MenjjL1Rkm0HRc1x85o
         7B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732009580; x=1732614380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMDpr51HGMdjTn/zZt2QmbhLNhc4xxoRwRH832sAaPM=;
        b=k1XrpnN8ypGz1feVsYWeuJHQIRl0Ckuy1j6t+InWabCsC4rZr5+oPj7VjY3Rs2P72H
         0Uo8HK+qoHVrBpbpT64UT7pe5NBmttuaSuV/3tBA6jlhmRFV6PXYgSnx5KmBAZAZlGxZ
         ZqBQCG5fSUMRrFooaQpvDLqkPShw0Ea1lRjDLDoYw4+RMfTbYMi59CN4ISZuZTvDWOmH
         QhHd9oIS/z/bYjNkwE7xIYKatTmOuaiTAl6nH7fVh4Yy3waD7gOCC1JDZ3Zt+5tk7dBS
         8AFfg0rnw6yTNoMhZLuqeYCKfyhh+g7Ug0mAjzMtVOzLFFJEaua/U/jX6ukpsrQrRiVZ
         UCOw==
X-Forwarded-Encrypted: i=1; AJvYcCVObN560uwCZQ/tUxL3eE/J9EBI4WPujWgwqtsaWoHciD/x8pYGZQ9pbyPHFq75dztlyyLNnZFnQaf9GLzZOw==@vger.kernel.org, AJvYcCVtRcVpKwqonGF42uhO0pIkIy0J9sWl9IEdNSmNhT8PpcIelzWCJ4Yy/+v/yncvwPbMka6V5bg6Qy3m@vger.kernel.org, AJvYcCXDJv85+UblSVQ9PZ9GiysnuoiD2GfsmsADek75nFvY9UdzWhSqgaHOed/WyHEly1D25u/8p2LkJQT8UfI/@vger.kernel.org
X-Gm-Message-State: AOJu0YybH9stYl2z99oc2V1j214cbOw/Nf7QKLcrAtiHBmcBLA7fN1Od
	HaOHViGjOtKchITzNunq0IV5IfbeSmZ5OGaolkzb/LAL884N0OhD
X-Google-Smtp-Source: AGHT+IFp88Ev/g5mJ8o8R3VYOBPpM+QA5xyPCCcIu8wbpjjrR5KO7r2Uhp+NQwM/bCB9W1Ce+c9J4A==
X-Received: by 2002:a05:6402:34c5:b0:5cf:bcc8:f490 with SMTP id 4fb4d7f45d1cf-5cfbcc8f8d1mr7093276a12.11.1732009579773;
        Tue, 19 Nov 2024 01:46:19 -0800 (PST)
Received: from f.. (cst-prg-93-87.cust.vodafone.cz. [46.135.93.87])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfcb3edce9sm1821154a12.35.2024.11.19.01.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 01:46:18 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	hughd@google.com,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 2/3] ext4: use inode_set_cached_link()
Date: Tue, 19 Nov 2024 10:45:54 +0100
Message-ID: <20241119094555.660666-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241119094555.660666-1-mjguzik@gmail.com>
References: <20241119094555.660666-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/ext4/inode.c | 3 ++-
 fs/ext4/namei.c | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 89aade6f45f6..7c54ae5fcbd4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5006,10 +5006,11 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		if (IS_ENCRYPTED(inode)) {
 			inode->i_op = &ext4_encrypted_symlink_inode_operations;
 		} else if (ext4_inode_is_fast_symlink(inode)) {
-			inode->i_link = (char *)ei->i_data;
 			inode->i_op = &ext4_fast_symlink_inode_operations;
 			nd_terminate_link(ei->i_data, inode->i_size,
 				sizeof(ei->i_data) - 1);
+			inode_set_cached_link(inode, (char *)ei->i_data,
+					      inode->i_size);
 		} else {
 			inode->i_op = &ext4_symlink_inode_operations;
 		}
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index bcf2737078b8..536d56d15072 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3418,7 +3418,6 @@ static int ext4_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			inode->i_op = &ext4_symlink_inode_operations;
 		} else {
 			inode->i_op = &ext4_fast_symlink_inode_operations;
-			inode->i_link = (char *)&EXT4_I(inode)->i_data;
 		}
 	}
 
@@ -3434,6 +3433,9 @@ static int ext4_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		       disk_link.len);
 		inode->i_size = disk_link.len - 1;
 		EXT4_I(inode)->i_disksize = inode->i_size;
+		if (!IS_ENCRYPTED(inode))
+			inode_set_cached_link(inode, (char *)&EXT4_I(inode)->i_data,
+					      inode->i_size);
 	}
 	err = ext4_add_nondir(handle, dentry, &inode);
 	if (handle)
-- 
2.43.0


