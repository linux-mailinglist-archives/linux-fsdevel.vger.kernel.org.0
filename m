Return-Path: <linux-fsdevel+bounces-45007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BCCA701EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B6D3BB208
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451E5257AD7;
	Tue, 25 Mar 2025 12:59:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49AA257455
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907550; cv=none; b=peU3WrZjc5xHP/aBc2y2wjwTNK1QqJPdUxrFuq97cklVKVuLyX+p2rlpvZnYBWn4s2dB+v6tkjYWpI29kMpivECvtiwFIue1KNkmBTkXFTy3QJjYkRUFYe0P4ifHN6YHka3ctPwrkk0nmXdDfUnq7QW8jcgYAYAhWEHVYASKQaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907550; c=relaxed/simple;
	bh=/18HFftOLwQrGyFb3oNTkE9/ks2x+n9TTh+JNKcZMNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDZNXnRJEKDcz9nSOnSbWWENyDEpUY5jkQC/WpnlAGtsV+vc8jGssLYNag4oghBmISSN8J8tqW/dTLf7SenLUrXs9yjmD1hkmOyZ5dp/holutuQwEngLODwym0t0voB7KE2egl5trTNZwcBaowRpLX+LfPqb5WO8f2dPo1zh1ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c3bf231660so658559985a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 05:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742907547; x=1743512347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gK08EjceD7oAoWgY2C5J6cFp6HN4HP7GKFOgnyXyuQ=;
        b=R4tizfCxj/ZgFnq4cLNUne7EhKQzt3s5QE2EzkW75nDQfC0Z/mHoH52pMyGn17waR5
         NjS/MRChy0KNP1Z96jLULSxW9rBkV9QCzbQTMP2mVN6QyCKNEDDjiN52uTPrVFsmx2lp
         uwLotqFHGj/T+EewH8uCiw7rYR+ZicCSiPZB+72uI17Sci8JWL3TisXWIJCVsJewhbz8
         ENAc8o36zfdu17T/DUwpkvIcW6itYa2UMkrayGnJhxosT7u8mWFmDHxS8WiubDbacTk2
         9yng2kot+8tojGOtLpptFi5GEIPpyENIUuOtRBEoC8MZq0gOFsc2sAjWi0/5seNUE81p
         b9Bg==
X-Gm-Message-State: AOJu0YzkyCs6UBoN4HKs4dRLwhPCLq5i9yrnvTjYVZJO/i2tlLd6zyfA
	1rZp0IcqiQ0SPfaR5NWTSZxmqYKIG6u9Y5kjLnA8v43Mn3hWP0zvg3cbDS19
X-Gm-Gg: ASbGncuE5yhegWLbtA/1UbIaryBpvM9a8BUS2K5gTR8zuM+b8BH4jGb33SYB0pavjRa
	kBGBWB/CdsbmtNLV6KbLMxBB3jgxHcP4Y/UM+jU8Jh+qxp+GRFb+A/W/legil12XrZahguK8V8U
	oiZXbKMB7U91/61WNLaPoCtVESN5m8fC6Lda6aJ/f2h3p5WITXKGz77p1CIv3kGTZqiFiXKLwaY
	RStqvsPTQFJKS37MziX673rUnXRCyxeyJR41V2HbKno8r+vhb4+o7BmpZfy2keCf6MC8H9Wr4me
	mmQUU/Efbm/vzuc4GkCZcilSxDbJ79SJgIoPce3756+ancaGG4h8PfONdXAqcncQB9hW4EJVV2t
	MbzDMiHFhx6pkuX47eC5bSrVQwGDhOrGB6oztb/A9Fj454DYPT+LhthMyHW1aRQhBwZs=
X-Google-Smtp-Source: AGHT+IEc0G/1BKZQGl9iwoOgvjv5YcerHC5f++TxSA6f/6D0rL1vg40qxRFD+8GBxiCdj3WF6RDHRA==
X-Received: by 2002:a05:620a:560c:b0:7c5:4788:a14e with SMTP id af79cd13be357-7c5c80d4a5cmr1135160385a.39.1742907546954;
        Tue, 25 Mar 2025 05:59:06 -0700 (PDT)
Received: from hemlock.fiveisland.rocks (hlfxns014qw-47-54-140-188.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.54.140.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b935f1c1sm637360385a.117.2025.03.25.05.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 05:59:06 -0700 (PDT)
From: Marc Dionne <marc.dionne@auristor.com>
To: linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	NeilBrown <neilb@suse.de>
Cc: netfs@lists.linux.dev
Subject: [PATCH] cachefiles: Fix oops in vfs_mkdir from cachefiles_get_directory
Date: Tue, 25 Mar 2025 09:59:05 -0300
Message-ID: <20250325125905.395372-1-marc.dionne@auristor.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c54b386969a5 ("VFS: Change vfs_mkdir() to return the dentry.")
changed cachefiles_get_directory, replacing "subdir" with a ERR_PTR
from the result of cachefiles_inject_write_error, which is either 0
or some error code.  This causes an oops when the resulting pointer
is passed to vfs_mkdir.

Use a similar pattern to what is used earlier in the function; replace
subdir with either the return value from vfs_mkdir, or the ERR_PTR
of the cachefiles_inject_write_error() return value, but only if it
is non zero.

Fixes: c54b386969a5 ("VFS: Change vfs_mkdir() to return the dentry.")
cc: netfs@lists.linux.dev
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
---
 fs/cachefiles/namei.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 83a60126de0f..14d0cc894000 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -128,10 +128,11 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		ret = security_path_mkdir(&path, subdir, 0700);
 		if (ret < 0)
 			goto mkdir_error;
-		subdir = ERR_PTR(cachefiles_inject_write_error());
-		if (!IS_ERR(subdir))
+		ret = cachefiles_inject_write_error();
+		if (ret == 0)
 			subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
-		ret = PTR_ERR(subdir);
+		else
+			subdir = ERR_PTR(ret);
 		if (IS_ERR(subdir)) {
 			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
 						   cachefiles_trace_mkdir_error);
-- 
2.48.1


