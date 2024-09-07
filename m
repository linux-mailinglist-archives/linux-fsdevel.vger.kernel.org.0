Return-Path: <linux-fsdevel+bounces-28902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D923970354
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 19:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0FF3283810
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 17:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD0C1649BF;
	Sat,  7 Sep 2024 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE+QVblp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E1C40BE5;
	Sat,  7 Sep 2024 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725729702; cv=none; b=QKZ9CUX11R9YzAoQS3Z7lnm5TUiBAQxhh70r586RfTiKL1W4g0XBDMK4e1R51ShwpJcgxZzYrnSgD+r55hIDLk7CKDybA26BMdmFujBeUN3SwRh/9P4dUubK/H5O9fGVD0/AuChVYmqM2+NIYlsBfcToyt/hTJFXerJxQO06FHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725729702; c=relaxed/simple;
	bh=BH15G+LRkBf2raQI2Af5gfKoabGOmJToOKTHnDU9hu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C0OP+2t1ifsCsUp8LFHA5JdSoQSwNwD2OzGt5O4ad+41UbUjKSze/t2icBG4ka/yccseUNHzOVrHIzvDFr5w/mqpPgaAa8b/ZNnv//g6a1bY7CDo1rQ2eYFE9S11W0T5WRcdso+7a9fEVJgwzACAvyrIFquxNh01Ns8VoLGErPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fE+QVblp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2053f6b8201so28498225ad.2;
        Sat, 07 Sep 2024 10:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725729701; x=1726334501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tTWXzEyNPgr8Bi+ysv0iEfMTXJjCZNItKihJCs9lwDM=;
        b=fE+QVblpR3UxAA8hj5wHS5IBu/W7sAdA3gmhB9bYMSztaAh2YrADISufIQLyF4r/08
         jTdvjt6uLKIyHMbZlIY6XaqUsu1iv9eo3xcc8zuEDxIUYTu8qzTG5c25vjFuFWEzlJGG
         cdonZbqhmENntUevOintczGo0HNjWygOEN8DU4eM9kQwQcxbew3IuYZcmOb7/rjwxnxy
         iM/uKHNO8BQ9IoCFEy8t3gGu8C9s9iPFZt52q4Tu6hEnpAhB8NFYPolwozHBIqiU8dOA
         wXhO4CJSoqt7jLhH6j9hWUbrMmiWrVO/hrXDfODikXwEtqjKw+pTGoHAmD4SNB6a2B/C
         WMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725729701; x=1726334501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTWXzEyNPgr8Bi+ysv0iEfMTXJjCZNItKihJCs9lwDM=;
        b=tVWYCuBMDWEC6ce+TTc7RtnK95ec9/87sjAagJE2K218YQYJEXXKAgnfour6RpS7wd
         mkCHl+LjtsxawzaV37Y8Jcth7A58U+Y00pLY9jaYWNoKHGbF4FwVPR79h6AgNrH+fFhw
         TaB+IMEe+IvfTO3fRCNNYJhfcneubzz80GZf6Rf8o44tvVyvqFXF3C5sUq3xXd6pvP7j
         TFdTfvwucrbmtCz2SnfwLRT2yPVR4QkckMcFDLWVnALlPjnIIOv8u0/HvmkjT5KtyZJs
         amNf01goOPd1uPXhxgwhHIrJLZJVnvqc2BUFsi4KE2Yxt66R9F42qazF/8PTDYzCtMsr
         IRcw==
X-Forwarded-Encrypted: i=1; AJvYcCWJbQqNndvIJpQIVfftdCY6sNukr5gO2BkwxdMNL25y7x+YXSzt9uquoBa26FqOkn64O5C68bSFDjLinQxm@vger.kernel.org, AJvYcCWuHGnvsqv/AlTBWhdi9XkkGOAEMw5X0z2CimRd1plr4BjJ3SDBTLDgMkI4AK3W5q1mr9Tr+t29Zlya4cve@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj5xlk4pGPLDkjbeysJ5IvvcQoCsx3K4PYtxP9sCUWdtArre4P
	KftLtniO6zJQnAl0glKhSj0kDPFnXzIEo6aOtHmQvElzUSM8UZrb
X-Google-Smtp-Source: AGHT+IF9x8ky+ChW+xRQ8RXDYEvV+19bIfUhyrP0COKmFzZbVQhy6YP+xmncsAstlFBkkG2IVBk2qw==
X-Received: by 2002:a17:902:f642:b0:202:3dcf:8c38 with SMTP id d9443c01a7336-206f05f62femr78813005ad.44.1725729700450;
        Sat, 07 Sep 2024 10:21:40 -0700 (PDT)
Received: from dell-xps.. ([2401:4900:51e3:cc18:d1b8:b902:8a52:a5f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d825ab14c7sm1058616a12.80.2024.09.07.10.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 10:21:40 -0700 (PDT)
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+41b43444de86db4c5ed1@syzkaller.appspotmail.com
Subject: [PATCH] VFS: check i_nlink count before trying to unlink
Date: Sat,  7 Sep 2024 22:51:10 +0530
Message-Id: <20240907172111.127817-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported-by: syzbot+41b43444de86db4c5ed1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=41b43444de86db4c5ed1
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
 fs/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 5512cb10fa89..9e5214dfd05d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4419,7 +4419,8 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
 			error = try_break_deleg(target, delegated_inode);
 			if (error)
 				goto out;
-			error = dir->i_op->unlink(dir, dentry);
+			if (dentry->d_inode->i_nlink)
+				error = dir->i_op->unlink(dir, dentry);
 			if (!error) {
 				dont_mount(dentry);
 				detach_mounts(dentry);
-- 
2.34.1


