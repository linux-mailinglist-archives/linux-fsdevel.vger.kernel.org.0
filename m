Return-Path: <linux-fsdevel+bounces-28197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB48967EA8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 07:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9381F2170B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 05:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ADE152196;
	Mon,  2 Sep 2024 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+4dcZHj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7987B376E0;
	Mon,  2 Sep 2024 05:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725253500; cv=none; b=nbNvLt8lF3FovuJjoa1IZKAXDGKWoNCpSDSrhveRWTIKDwEu/AtleM9UI5AeyErixQyflTNg1rcRzNzMerObZ6kwjqRJBA9kn5UI9kw8sq4TjlRmafpUEp+yEaKGoUxRxRWB3mfSxRTdCwQcNmOAOw9vq/9fsf5fyMEgpaTZpm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725253500; c=relaxed/simple;
	bh=KcjdDDJjrjgyP/exNug2pJgMTJLuvhmtIhMjw5Wsvvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SGrV6eQqBVWsp8NAe/YhNC15qyk27wDYiTGXULqhuipr0vdW/ddNUILC37mwvrz/KAPlzx3vyXYBqXQm/+RTZBJhGDQZIaWxnKmFwQ62QWpQmtPj78ggngQ2rBtzsIIYojcn6mHGQOuA23HwmVpiSB87HYglVwRt3q1mqdpXkWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+4dcZHj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d86f713557so1688118a91.2;
        Sun, 01 Sep 2024 22:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725253499; x=1725858299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHGqQxx7ikWTbtglo2cLX/JP+S/8emXrRQELM8lSwgo=;
        b=g+4dcZHji61Y3EnhaRGsh/JgllPVb/+XBS/9f4rABQpFAso6S3n9skuvyxq5hgTlB5
         zqBMGsuGw84+Fk9/CAoBXBRyb1NmBnim1mtB2clCZRmHVj1qbqRrvZNbZf8Yx63xcjnj
         YkKkEzSqgLAXR+771uRRWSv/K7aSCVWruUb42XUd1gcgDgzMF/Rzbv29aw9W9BsHdmjx
         2fbGgxn4bhTDsxAhf0cBSRtByYoMM+oKvEI3jMaK0Si0MRWSAlmbuMZow5wkf4p9M40Y
         TP8AgEaTkKNdop54Okwrm9eSY7UXPpl50emfKEboGZheaKPWBiD22sY8PcerRm7OW23h
         6l0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725253499; x=1725858299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHGqQxx7ikWTbtglo2cLX/JP+S/8emXrRQELM8lSwgo=;
        b=jOBqKEgW3XvNmhEHD5l3WpL9SzXaMxPOglLndbnRTWruMX36xtPkKufVjvdYak3icq
         DI12J7B1SffTNCqz88V45nHwLIG38EFM5udJZs0vAQQGXASAX0xSJwms3IDfmuzcphKW
         1RaKIm6oN/a06cpMsYvStRNllhJSsDs/ysNNLYthfOyEkP3/ouxQHN9yu0E+fefVzaiq
         1vfGmN4CzKOPj9OCzJqMHBn1F9Epc91aLz12/CIlv1o/Diva8nEH2z+RF83NDLgaMjMu
         poCA+JldYS1OqO5vFd9/Vr9N0gglDru2p7FvPLiI3sPvFLNGaB3I07ZzUblu/utG1FZw
         LVWg==
X-Forwarded-Encrypted: i=1; AJvYcCU/obILnzdxNnsuyRKSB1Brfhc6JqyfrQghm2ehsPOapHFLvc063n2BqO7TsFm5X5OWra9Mtnq8nLQK8kzq@vger.kernel.org, AJvYcCU2dZTAEKEzHZ2IAHrn5D1wtIMuj+ik9BZ0NOUb6ocle86mmzBJA/s2s2+Aj81E9S01rcP/q3z6p3QD@vger.kernel.org, AJvYcCVpEXkUnQYP99ZRtd11DCLxBHLASU5+aiazJs1mwsK3x1NQyd/IYRe/W3L3uuaveXTWQqIdxOgQXy9fymIK@vger.kernel.org
X-Gm-Message-State: AOJu0YzzBDFYYcgFVbVpwIBA41nkDDILaiy7U0BwLSuHr/IwtjVARAGE
	IEtC/FovjQ51nlsFGSvX5oa3526jwx8pNkrM/QAkZvOG09Ka73e2
X-Google-Smtp-Source: AGHT+IGNou438MaV4PAfToK6bA1lpSXsINAc7F6lcuaibNFJ3EfVXplkuwr0P+F0J2p+FFP49SuK7g==
X-Received: by 2002:a17:90b:8c6:b0:2cd:4100:ef17 with SMTP id 98e67ed59e1d1-2d8905ed64bmr5155151a91.31.1725253498541;
        Sun, 01 Sep 2024 22:04:58 -0700 (PDT)
Received: from localhost ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8c7f91919sm1764607a91.53.2024.09.01.22.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 22:04:58 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	sunjunchao2870@gmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iomap?] [xfs?] WARNING in iomap_write_begin
Date: Mon,  2 Sep 2024 13:04:55 +0800
Message-Id: <20240902050455.474396-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <0000000000002f63ae0620e563e2@google.com>
References: <0000000000002f63ae0620e563e2@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the following patch.

#syz test: upstream ee9a43b7cfe2

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 79a0614eaab7..6e3f6109cac5 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -76,7 +76,8 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 	int ret;
 
 	if (iter->iomap.length && ops->iomap_end) {
-		ret = ops->iomap_end(iter->inode, iter->pos, iomap_length(iter),
+		ret = ops->iomap_end(iter->inode, iter->pos,
+				iter->processed > 0 ? iomap_length(iter) : iter->iomap.length,
 				iter->processed > 0 ? iter->processed : 0,
 				iter->flags, &iter->iomap);
 		if (ret < 0 && !iter->processed)

