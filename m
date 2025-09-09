Return-Path: <linux-fsdevel+bounces-60636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ADDB4A74F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 11:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B86543053
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B80A2BE65E;
	Tue,  9 Sep 2025 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgJg8fvM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377D92BDC01;
	Tue,  9 Sep 2025 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409263; cv=none; b=Rxj3hvQFyw30TPHlsdDE12Isu5ppbwYtr3fnPylxsQYCWS6+famrltFNohCIWM/aoStroBmF8yCPhuepuE4gWoPdAeQMW7DSMsR1axgDAK5oiogbF+zCyfENUqGpqUAnUx23bNxutGjsrf1Zc8Z3vKsoB7mbAWF5tWXgFe6yI98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409263; c=relaxed/simple;
	bh=50R3pwXs1e/VX71Ayzy/05cPJ1lbpi+2qfPdQ6LJu4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnNR8mELzJjIa8ClmlqPQkz6OshGzoTvVJClZsoJBxLkbIwxRXK7JysJ6hKPgr/qva1zMOZQAmstRA42KrVMNe12/HSIA2tbFwZ3eFBdGPHbATpW9DrIX/1ekchH8/7nOO6m8Tq173bqnf6TqybiXyKFKFWxmBx31O5Z9Hb9wqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgJg8fvM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e46fac8421so2648910f8f.2;
        Tue, 09 Sep 2025 02:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409259; x=1758014059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5aEOGf5lzke7NfjFn8+kgwyzmdKicgx8i+x5xoYQng=;
        b=MgJg8fvMwvhLKvjZiKVxOFno93b/CgizwGcMHklNtWS2i+3O6uagAN9T+PnkrxmqzS
         zlq1D4nOR9Nz1xK+UO+hgAwIvxBalxONHAhes9OKAvoXyYTeNkUmYGf9f7DduAnGpq5C
         n9CGNcIakqp8rpbjFS7aRBAuC6uK3FJubvNFFjgmmQWsg4caeuHSL9rUMdWhfRFLEUjs
         zkibjF783AOS517eMp6OtSYTHz6UfpsyDIQpZ+8CjTN5rgYkGXPNaRSbBC/PlPJx0XCa
         4zSUUI7We63HjLDuplt0OM9+LuPZ4W6kDUYZHeVEoqNc7/btF4V8WuLaPUhxBHa3Nqnb
         8MiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409259; x=1758014059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5aEOGf5lzke7NfjFn8+kgwyzmdKicgx8i+x5xoYQng=;
        b=Pw25VpeN6in6PzoyY1fAzIaJLLzODaZ9DEjBr4SL37K5r3G1iWsYWX+P0dlJaXeejd
         RHT7/Fkzh0U8Goxj4M//KhgB6yk/nU5fS4YtBUB3FUvtx0wM7k9Fv3CZxhg3DMP3NT5s
         Tbb1Dfj7Gx8pPuT/bYz7OpbywoLCaqF8SNjTDZHZ9DnS3xs3mr04w5eXlSIaLcV4rPsX
         ZVgbCxbx9PgIPxigSllY51m81QItoYOGACUe62U2wACd7S9wFhoaDB4sSW8sC6sggmml
         84apIqd2fNrDDP6MTAZ3QhBcfRFpch7kUSccHSXsJ1aszvPP7h172U3hbSzNTUuuTPRf
         N42w==
X-Forwarded-Encrypted: i=1; AJvYcCV7JGO+06cBpfDQAQVU8tyV2qBESZubV4kc+YFjF7he4tYwkVPtJjuVVswOILx4aJ/yU3LSNu+6IIKigw==@vger.kernel.org, AJvYcCVTCWS+bJvVn4A4CddiVJL2mRHu11QcHTiY00iU8NRWDMrgDbaiLHtoXvPzzOyEwuGX+CwQ8ow0KbTosg==@vger.kernel.org, AJvYcCWPO6EgmecE5n6UCH6eqRL+OugXltl7WHzzBXRcaUwosRfh5vK3UUpyiJ/1xfpCm6ROb3VOuUUk1FX0qKIi0A==@vger.kernel.org, AJvYcCWgU8IOfDfIigtN/aAZr5UdOlq/hxyS3/dqkMyVGSchR6xEPnn2rie3SITKueigvtPd4EdAUWG+05BPQ5ua@vger.kernel.org, AJvYcCWwkuDa1DmearzRueLygkXObvb9DlX4dwgajXgmVlFi70bD8gmblNiFFrbG9ZwjSvOe0irgtAEPXvx0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2VjOD56SgdLu7ux5vyClwHXGXj3HeGg2NEeo5SHV6+TrLCZkz
	SPNSU1J4RlPBIxjdBbdrfmi0fTSBPamabsYsOicOhM62kbh5jSKewvk6
X-Gm-Gg: ASbGnctcztOwG18xtCMPz3VdD8hhAbuPYC06MO5QxbvRdJdTWpX13SmU1HcDbMBIsnB
	VpeZwmLCqR/NfykQt5VGcOjAAMGQGSad73pN1YDV6PpTDik2edpihATfzEsdib63bIgCJVb0FLF
	pXPZkGUH0uBvPVQfzmT5R0yMPCn6O4qMnoxpNgJmTE/zsutZopTDUA/6UH1jp35pR1XIeoDEZba
	SAylvCTNt13t2pYqSVBvGqgm3CPP160QXEvE856sqr4nE5s563ngpqNbanapn/AEDSnxWphq/r+
	nZyP+zkVitufl9QrEhHs+6/4QeNhA5l0HKKGUBVzvXNyhTGnOQfPR/9gkCzoSsCKpySJGNOn20d
	DD54HhXOJGIysV/3wxy5ICFqPPgeU8EXVl4F3gCqxSHJFGHjTONM=
X-Google-Smtp-Source: AGHT+IHqMwLiYolQ5me436vqKuF39mMXx3pO93Vub5Pv0KjfPnkmrMoeMa+RFTf/DfJaqpH93CaTXw==
X-Received: by 2002:a05:6000:18a4:b0:3e5:955d:a824 with SMTP id ffacd0b85a97d-3e64d22b2c2mr9348224f8f.63.1757409259384;
        Tue, 09 Sep 2025 02:14:19 -0700 (PDT)
Received: from f.. (cst-prg-84-152.cust.vodafone.cz. [46.135.84.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bff6esm1810784f8f.13.2025.09.09.02.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:14:18 -0700 (PDT)
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
	ocfs2-devel@lists.linux.dev,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 07/10] ocfs2: use the new ->i_state accessors
Date: Tue,  9 Sep 2025 11:13:41 +0200
Message-ID: <20250909091344.1299099-8-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909091344.1299099-1-mjguzik@gmail.com>
References: <20250909091344.1299099-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/ocfs2/dlmglue.c |  2 +-
 fs/ocfs2/inode.c   | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 92a6149da9c1..b3b7954926d6 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2487,7 +2487,7 @@ int ocfs2_inode_lock_full_nested(struct inode *inode,
 	 * which hasn't been populated yet, so clear the refresh flag
 	 * and let the caller handle it.
 	 */
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_unlocked(inode) & I_NEW) {
 		status = 0;
 		if (lockres)
 			ocfs2_complete_lock_res_refresh(lockres, 0);
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 14bf440ea4df..02312d4fbd7b 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -152,8 +152,8 @@ struct inode *ocfs2_iget(struct ocfs2_super *osb, u64 blkno, unsigned flags,
 		mlog_errno(PTR_ERR(inode));
 		goto bail;
 	}
-	trace_ocfs2_iget5_locked(inode->i_state);
-	if (inode->i_state & I_NEW) {
+	trace_ocfs2_iget5_locked(inode_state_read_unlocked(inode));
+	if (inode_state_read_unlocked(inode) & I_NEW) {
 		rc = ocfs2_read_locked_inode(inode, &args);
 		unlock_new_inode(inode);
 	}
@@ -1307,12 +1307,12 @@ int ocfs2_drop_inode(struct inode *inode)
 				inode->i_nlink, oi->ip_flags);
 
 	assert_spin_locked(&inode->i_lock);
-	inode->i_state |= I_WILL_FREE;
+	inode_state_add(inode, I_WILL_FREE);
 	spin_unlock(&inode->i_lock);
 	write_inode_now(inode, 1);
 	spin_lock(&inode->i_lock);
-	WARN_ON(inode->i_state & I_NEW);
-	inode->i_state &= ~I_WILL_FREE;
+	WARN_ON(inode_state_read(inode) & I_NEW);
+	inode_state_del(inode, I_WILL_FREE);
 
 	return 1;
 }
-- 
2.43.0


