Return-Path: <linux-fsdevel+bounces-73255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D4AD136D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B653530ABCCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10762DA771;
	Mon, 12 Jan 2026 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ez/mkTvR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Udqzx1ld"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29EA2BEC43
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229497; cv=none; b=VLn+qsDoREf/inoNoxDqf2L4iz43p7pPSqBSoEVAydWY+BFV3BDq5TIuSNHH704E336HGqqtUA1Z2HPfMnC9+effGEwLScGwcZuJ1yyGaSBTkEmfEx/S8slZd3+9I3HpncM7RGVEwaONQ02YKtT4ce+auM3n1ic+FytGQr/laQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229497; c=relaxed/simple;
	bh=JPjcCt7QWTf38nAptPhawsXuiMG7Azz0b4ENiSKcovw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZnQyfNkgzF2nYA0YfiMETTnzzy40FoKn50hJk3KpSAZMal60nox8KRSQBfftAmMACIFN0yHjWtDAEiA4o7VKjmdVw5uIDgRaFnVJe6tT3VhwLkro0wRbOgDuA1fYM4XrkAScjLTBUzmkePNvJX/hA3u9I71sWFN4BUXpIF/IkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ez/mkTvR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Udqzx1ld; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQFyKAmxkxq8BXZgaDmWovpGdqDXxz9LIVm+AcEZ+2Q=;
	b=ez/mkTvR11qr9RMN7hh6gmj/MmEwhEgZDo81zR9/Fy/OyxDFMCtZw62dqvRvVj3HaXQMiv
	bFXqMK0FwzNpO5dluLDx8L5trFcrFFYOKYpC8wwjaZNqHCQgy5IvMA/zdt1C3IJQAJ4Y71
	2d1aRMAXJb3JH/coWS+0jyeXyaZ65Ww=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-Ai80ISwmPh2d8qSYUCrIoA-1; Mon, 12 Jan 2026 09:51:33 -0500
X-MC-Unique: Ai80ISwmPh2d8qSYUCrIoA-1
X-Mimecast-MFC-AGG-ID: Ai80ISwmPh2d8qSYUCrIoA_1768229493
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b871d7ad66cso127992966b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229492; x=1768834292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MQFyKAmxkxq8BXZgaDmWovpGdqDXxz9LIVm+AcEZ+2Q=;
        b=Udqzx1ldzvoyffyHrlSukFwn2qt4e/J6xJhGLZtH7UnToyZ7YsZ+H8kwCpT4pbO/b3
         3XE1GbInKcDAb4cjXmO7Rp746fcdbAsIyxeRUqDhe494Syi0jnhg21sqq7HASl0ixkhR
         AGkTKmtLh9jVVtwlZJf09F/yCxX0e6St0CNHWxZjc9Eu+2w5qpljLw1FMZyt9/xbdUGx
         UT5K/+T8kX60IdF9EfbMghvA+SU2QnNJZJS8qnUab6BhDs4Ogzu0XN+alqbgs3m+T92O
         KlxfMoCLiEaHlwG1Raylp1MlKQ6LncyD9rsccTCWA4y99h98j6GO2iavF3EOEGsI3Z++
         MdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229492; x=1768834292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQFyKAmxkxq8BXZgaDmWovpGdqDXxz9LIVm+AcEZ+2Q=;
        b=oLNHavLEraroxX7qL18E1sclX/feHyUHkfQfKJdwPmGISTDFNqdrIDHqv8qDdWgrtu
         qhpTCFqf+ab6NIj6ZdEyP74q49uDqJmHQzTgBpP36Aq7CAY7FNc+AKqJWV8ADwGBZRpL
         W7KpTstn6u4ZYERnhjKV8hsIKNHtQZWPVqJMe+HcKT5cxS74tC33f+JUCezpnD8ELR3f
         9GThF0KUuWgOcg7Ff3Qael1QJDbs043sUR5Bd/ULR+gWmRXvFqOT6wo0P0++434oAHnx
         LhEzy+CobeCr+1XaFtO5TMd6yl+LYU2BiKBY6FSXEla6Jh0QHCZit1AqBnzhC8HjWhab
         BKWg==
X-Forwarded-Encrypted: i=1; AJvYcCU5K4yf4HvuduUTlgWw/JOym5t9lW8J7hAnwEckZMcZpsRfNbILEpA/4EUmm4/OnVhs50UjTQJiu+JrwCGz@vger.kernel.org
X-Gm-Message-State: AOJu0YxQxFKEF8RoM6E+fehJ3aXAXBOdYTWdpEX/bQzbA4qv5koI9Afd
	0bJjJS4t1nONVbEDCG9bI5jaZnwb0irl4lWZ2USI7lfOjzLZZvG0kHnPQ9TsPrusx95q3ukBE1h
	HbZZRH93PmLyJqXm6+7xNJ76Gct/4UUERRY/besglTYNHqdqF5ABM/OEm5a+aeu5Xxg==
X-Gm-Gg: AY/fxX6c05smFdUpX/BQi3/TnVNlfm1/ABt/ndETsTbWa1SIgp0utiOOnWIVSAH+Oeu
	KoTCtBhdZmRBCy24ZUQvYyseklEdJgBxkQyQL1fxJ/tkLJZqzt5ahgP6p4ZRycHXyqS9n6J7qqZ
	yZUFaNBzZjCPLCoEwzdmWVdsjtz3ETdefRBekZ0yCSFGTPNlIVHOrraAdJQN1ClrSRAhP5UkWa8
	CdwVgu27RrJsvtBQtW4l+gzyxj1wsYgzROzT0Zrz5pNKWwdqgcLgFlW+4yqmiheZYRlyzD2AtBT
	63kFkfz6eMbakiSleY5Ek1mDtvjoNNpbgZ06PUW0ED7XpfXs2T1K00KS6TPG4ojYLwzKKh7tpXI
	=
X-Received: by 2002:a17:906:8a65:b0:b87:8c1:1ea5 with SMTP id a640c23a62f3a-b8708c120femr408105066b.5.1768229492479;
        Mon, 12 Jan 2026 06:51:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT+lJr2mupsGTVPSmnIPthPNsIkn3bEkceKZ9KStsHmzA6ycghaOXhi8PQ2VxPhst05XGo9w==
X-Received: by 2002:a17:906:8a65:b0:b87:8c1:1ea5 with SMTP id a640c23a62f3a-b8708c120femr408102466b.5.1768229491989;
        Mon, 12 Jan 2026 06:51:31 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b871b5e610csm306104766b.65.2026.01.12.06.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:51:31 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 Jan 2026 15:51:30 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 14/22] xfs: disable preallocations for fsverity Merkle
 tree writes
Message-ID: <h5rtbef7rnkc7kooimncgxjefge7bybzujkxy3yrwbfkaiqiya@4n64b7spvy46>
References: <cover.1768229271.patch-series@thinky>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768229271.patch-series@thinky>

While writing Merkle tree, file is read-only and there's no further
writes except Merkle tree building. The file is truncated beforehand to
remove any preallocated extents.

The Merkle tree is the only data XFS will write. As we don't want XFS to
truncate file after we done writing, let's also skip truncation on
fsverity files. Therefore, we also need to disable preallocations while
writing merkle tree as we don't want any unused extents past the tree.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_iomap.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 04f39ea158..61aab5617f 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1938,7 +1938,9 @@
 		 * Determine the initial size of the preallocation.
 		 * We clean up any extra preallocation when the file is closed.
 		 */
-		if (xfs_has_allocsize(mp))
+		if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
+			prealloc_blocks = 0;
+		else if (xfs_has_allocsize(mp))
 			prealloc_blocks = mp->m_allocsize_blocks;
 		else if (allocfork == XFS_DATA_FORK)
 			prealloc_blocks = xfs_iomap_prealloc_size(ip, allocfork,
@@ -2065,6 +2067,13 @@
 	if (flags & IOMAP_FAULT)
 		return 0;
 
+	/*
+	 * While writing Merkle tree to disk we would not have any other
+	 * delayed allocations
+	 */
+	if (xfs_iflags_test(XFS_I(inode), XFS_VERITY_CONSTRUCTION))
+		return 0;
+
 	/* Nothing to do if we've written the entire delalloc extent */
 	start_byte = iomap_last_written_block(inode, offset, written);
 	end_byte = round_up(offset + length, i_blocksize(inode));
@@ -2109,6 +2118,7 @@
 	bool			shared = false;
 	unsigned int		lockmode = XFS_ILOCK_SHARED;
 	u64			seq;
+	int			iomap_flags;
 
 	ASSERT(!(flags & (IOMAP_WRITE | IOMAP_ZERO)));
 
@@ -2128,8 +2138,20 @@
 	if (error)
 		return error;
 	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
-				 shared ? IOMAP_F_SHARED : 0, seq);
+	iomap_flags = shared ? IOMAP_F_SHARED : 0;
+
+	/*
+	 * We can not use fsverity_active() here. fsverity_active() checks for
+	 * verity info attached to inode. This info is based on data from a
+	 * verity descriptor. But to read verity descriptor we need to go
+	 * through read iomap path (this function). So, when descriptor is read
+	 * we will not set IOMAP_F_BEYOND_EOF and descriptor page will be empty
+	 * (post EOF hole).
+	 */
+	if ((offset >= XFS_FSVERITY_REGION_START) && IS_VERITY(inode))
+		iomap_flags |= IOMAP_F_BEYOND_EOF;
+
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags, seq);
 }
 
 const struct iomap_ops xfs_read_iomap_ops = {

-- 
- Andrey


