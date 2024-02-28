Return-Path: <linux-fsdevel+bounces-13103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6405586B409
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 17:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1990D1F29A75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB0515DBC8;
	Wed, 28 Feb 2024 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVLaK22m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C115DBC5
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136146; cv=none; b=lp1n5b2R2ZgkXgzULxN36P4HRvdoflOT3caOfXyJrhxZmRPabXXa3+Vfohf0tS6kE0omK2Bb3CuZPZjbt/tnMtCvUxm3HnS8bqMq5fDYemHn+A6TdWr3/jruSeLQBV9izNVWx4ejf7mLDIhUu/EsIyDLp6CGJ122Xb6Bm8BE1iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136146; c=relaxed/simple;
	bh=PxbAKHYgLI1OcHRl8vHYQg+01tE05xhYOI0BJIVrw2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwYRMN1ubHU0xvTs23c9Qt2yubODpefaDjH+DcGs+tTHsSbzvHG4hLC/ry0+hFzNo9QaMPMv7kHMz/68v7EnDgCnhwULZ40ES3L67dePn8nJGlAyiRZ0OZo3rd6ZLk7cp+ZDvlVP+TiHJcDYGtElkQe1vSgKjz80fNSDPFesTQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVLaK22m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709136143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wlZidGHDUsm6YjuGgrJ/SWDsF8BQWxQfJqXAP4zn/+4=;
	b=gVLaK22mMwnodiNBR5kRTbvxjCUSCDvTnK81RXudYyc49KQ/Wf3hY2oZCS+UVql1taWUGf
	EbQiaYtmasUsaMJn3oAAmgB0Z7sMdZVhvjyC/ymT+aAdFjIjDzhbBJUlG6ArCrv7PTvkkD
	czGLnDkgblhc1ix7O0B7ZrG5wzReUGI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-XFaujB6dM8qHjJAwy0l5yQ-1; Wed, 28 Feb 2024 11:02:21 -0500
X-MC-Unique: XFaujB6dM8qHjJAwy0l5yQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-558aafe9bf2so5412275a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 08:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709136139; x=1709740939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlZidGHDUsm6YjuGgrJ/SWDsF8BQWxQfJqXAP4zn/+4=;
        b=rCVH+UPtz1d4OSZ8bad5MnCKme5WrjPbdyusr3fQ5X+/A9nRFtcjKVTH9Li5FhveCD
         QL+o+Hi+rNEHzT4yChputpni5m2vZ0QDOyDmmc77rZg+MbtL0u6MncnFSPmMVVv5WLZw
         K9rp5gmJEpz0dYD3iW2wmpcexBtBmh7zTN+oopKT9lDSVrVV6pZ8CwF79A79l2s9hrRk
         2omZ4GgdqdsmOri3oqEj3p5HWFG3pjW7rhNvkpbGO0O8JbmgXsrCHfsS9TQBrQY4YFHu
         iJHd+0agz5dUfXiyXrs+tOSGv9dXSn09A33FZ5irsClRLD9Iw49aQJjf+MT0xx1BajG6
         /tCw==
X-Gm-Message-State: AOJu0YxFLiMx52Q3+6AvVolLiaXIwusc355ZyXkoRt9UJxw5bV0yKU/E
	AMJnBYZ7ESjcKDVOfcyLHP1IFFoDRNN0F8ZakG/EeShq4rM4yJho/0x0mu/avXyJfHkyJ5cbC7E
	2+kO0t8wrel0NQB8Siy3wERXb8FchoQmGDtYLnh9INLo2Fnyqs6wegYtGVnkroJggWKa6CEuoaU
	Px+37z7OtZEK9bDencafb828j1NFddkqzosmEReFYx1FNIlJc=
X-Received: by 2002:a05:6402:1845:b0:565:6f27:9dcf with SMTP id v5-20020a056402184500b005656f279dcfmr10306938edy.34.1709136139013;
        Wed, 28 Feb 2024 08:02:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXTHVHUP8BhrulS8Tz1mtVfwNA/F60tarZKITiYxPPCqHwt9qQ6ly5ZfgrEFnwrY4kyejMCg==
X-Received: by 2002:a05:6402:1845:b0:565:6f27:9dcf with SMTP id v5-20020a056402184500b005656f279dcfmr10306917edy.34.1709136138648;
        Wed, 28 Feb 2024 08:02:18 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (fibhost-66-166-97.fibernet.hu. [85.66.166.97])
        by smtp.gmail.com with ESMTPSA id ij13-20020a056402158d00b00565ba75a739sm1867752edb.95.2024.02.28.08.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:02:18 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: 
Cc: linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	Amir Goldstein <amir73il@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] fuse: don't unhash root
Date: Wed, 28 Feb 2024 17:02:08 +0100
Message-ID: <20240228160213.1988854-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228160213.1988854-1-mszeredi@redhat.com>
References: <20240228160213.1988854-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The root inode is assumed to be always hashed.  Do not unhash the root
inode even if it is marked BAD.

Fixes: 5d069dbe8aaf ("fuse: fix bad inode")
Cc: <stable@vger.kernel.org> # v5.11
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/fuse_i.h | 1 -
 fs/fuse/inode.c  | 7 +++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7bd3552b1e80..4ef6087f0e5c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -994,7 +994,6 @@ static inline bool fuse_stale_inode(const struct inode *inode, int generation,
 
 static inline void fuse_make_bad(struct inode *inode)
 {
-	remove_inode_hash(inode);
 	set_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state);
 }
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c26a84439934..aa0614e8791c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -475,8 +475,11 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	} else if (fuse_stale_inode(inode, generation, attr)) {
 		/* nodeid was reused, any I/O on the old inode should fail */
 		fuse_make_bad(inode);
-		iput(inode);
-		goto retry;
+		if (inode != d_inode(sb->s_root)) {
+			remove_inode_hash(inode);
+			iput(inode);
+			goto retry;
+		}
 	}
 	fi = get_fuse_inode(inode);
 	spin_lock(&fi->lock);
-- 
2.43.2


