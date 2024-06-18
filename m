Return-Path: <linux-fsdevel+bounces-21873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5691890CA75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 13:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691E21C234B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 11:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AEB152199;
	Tue, 18 Jun 2024 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiMS8ZRk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA421514D9;
	Tue, 18 Jun 2024 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710515; cv=none; b=G9hoPNNfPRC9PPVEq9kT1cevW2di3SwdhW/Tjc+oEvmMtmkEe3MQKcrfXooh72ac7AdllrvX6oql5hZ9sqtihFq91DnMSD58DJeQQ1tW5gwdjZgnnkmNu1r2idZqyjm0M1cZW1wn23lIo7rsTnjvVIr2KrBkqiVzXh+hvvmtMAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710515; c=relaxed/simple;
	bh=tvy1KDoX7BzvM+TQIszHfPGpCYbwly5oJv6QMttbfj0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k3YseY39V+cdBgaBuLdc/I3w8RsqLAV1JyENqqEAgJZ5/2gumDnJKT6OrgA1rp/I/57M6M6oIqe0ZTsf5XOq/17k4AJlVJU2B4gHg2dChUNXvECXz7q8A3sbUss0fU9li4Ksr3htQSt1zkxSoiGNCL+dGpoS4CeVUZvwyJ+qvwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiMS8ZRk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f6a837e9a3so33318605ad.1;
        Tue, 18 Jun 2024 04:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718710513; x=1719315313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7RlZFY/8hx3jftd1uqf6MluK/MUBXIl7epplrOLOsNo=;
        b=NiMS8ZRkSATS58JtgTDDj3gUxgqyLVNh02/BIweuDTqkigyxwBR1yrwyx710QV8ZDp
         X9BJ/fPDkwRRQ3DfKsQa35w/2AQy3iHk1LvRphmHsCHSQE7NIm/WVmLkqUKf2omPSQsA
         bCQ1aLNTyQArZ3df74nGpEAV8bYKfBA4YYD6NkTNcT0GQcVJQENV5JFNMyQSkbNeeO9s
         k3QE7jgTKMlZ30CDNWzcvJ39d2iZxyEIF1NmUR/KAv+WM6lb65BtAnjB+Xj/cK4QBvbG
         vCoohYXR+WdPDBS6qWnfGE/eEXimDKBTCAG9+IZv0dG82cwwPRo5AGlewGOwKsU4At6z
         2UmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718710513; x=1719315313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RlZFY/8hx3jftd1uqf6MluK/MUBXIl7epplrOLOsNo=;
        b=vjf44GPmBoJKP/SFQ5Y3pjP3YJUUWx/wK12A7DenuJJhRgItN2ISjY0sOAyb+OdOEt
         Vgt3ZBKthUo5ceNjK7g54OCoIuJEpyduIG45MwDnMZuPKkxlwlC7P4itdWUTS1Za4ePq
         n2aWEhMZicozRqpwhYo5eRK0SEsqoxvFNL/5JslkdlizIpcpW25v2lHM9W7RF17Drm+F
         61KEgN04/cWR2pG+F/sxN9KGgjL0jmmGsMTjKxh1wpGOvR40zoEccioaNuTxVEV84fmF
         lSfuCKQ5pvxgNAzAfGDvl685x1kv7k/DqMROWA/bu/9lpBh6SYk+mEz40jc2J0OjzVye
         n2bg==
X-Forwarded-Encrypted: i=1; AJvYcCUCkG9UPIUwZgprYFYBON8dTd6p0A5GDSVxejEzNnjXrbhNZEaD92UZVaLN92gwP+cH80+psIBywpF1WxmkgGF8xDRrNB1eWN09
X-Gm-Message-State: AOJu0YyuAjypgWiRnb6ScF7Jni0O9ebwYpWW6QVYFfjikbOSyNvbZj5G
	kJ3i4UG0nNNm7iKrtqX0z2O2zxdztVho0WPseg2semR6NZfhCZfxdrfBrg==
X-Google-Smtp-Source: AGHT+IHe+hQzEGMA8sgHFat6BOaxhmQhDamGc0QsNIjTLlGSG3Zyp6fxemBrkymeqY6weBD3stpueA==
X-Received: by 2002:a17:902:8505:b0:1f8:3c9e:3b8c with SMTP id d9443c01a7336-1f8625d37damr108884225ad.20.1718710513042;
        Tue, 18 Jun 2024 04:35:13 -0700 (PDT)
Received: from localhost ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f15a9csm95429875ad.222.2024.06.18.04.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 04:35:12 -0700 (PDT)
From: Junchao Sun <sunjunchao2870@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	Junchao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH 1/2] xfs: reorder xfs_inode structure elements to remove unneeded padding.
Date: Tue, 18 Jun 2024 19:35:04 +0800
Message-Id: <20240618113505.476072-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By reordering the elements in the xfs_inode structure, we can
reduce the padding needed on an x86_64 system by 8 bytes.

Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
---
 fs/xfs/xfs_inode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 292b90b5f2ac..3239ae4e33d2 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -40,8 +40,8 @@ typedef struct xfs_inode {
 	/* Transaction and locking information. */
 	struct xfs_inode_log_item *i_itemp;	/* logging information */
 	struct rw_semaphore	i_lock;		/* inode lock */
-	atomic_t		i_pincount;	/* inode pin count */
 	struct llist_node	i_gclist;	/* deferred inactivation list */
+	atomic_t		i_pincount;	/* inode pin count */
 
 	/*
 	 * Bitsets of inode metadata that have been checked and/or are sick.
-- 
2.39.2


