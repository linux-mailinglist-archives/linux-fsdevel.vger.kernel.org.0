Return-Path: <linux-fsdevel+bounces-33027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0786C9B1FA7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 19:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EEE2815DC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 18:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26759183CBB;
	Sun, 27 Oct 2024 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVrV57y3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE2A17BB32;
	Sun, 27 Oct 2024 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730053075; cv=none; b=DQNWT3MA0s0lRi4XM+/gYDXt7IH3wMsENdYZ/CKaCkTsLk6LSugv0VQWACZ+912PPlpLqah+zoDdc4G2/iPj2aP/s+mMZwyBH0VxAAjdSH98hv2wo4VkRTSHDH8iinL6fAgz4ulM+gGayuN/WlPOt8JTm4AYFhV3MNoEl8PsRrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730053075; c=relaxed/simple;
	bh=lFlE2lzdud9Wm5BYL/80r7Eoxs5vlCkkI0BDXowyjxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLq77IwaoWaXqy/5K+fhbUJ/Nf7t5B7n8YFUB6x1MlNyWcop5yK4i5KHQejp8UMGL7OCAlN1oJv60FYrmtYd8IS//67ox/ofmI/XU65WUoUxV/lLXV0uo9hovf58KQR8U8nTUMI+uc2hqbK1gMNSd6tW42MccQEtrwiT8zcq2GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVrV57y3; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-656d8b346d2so2312371a12.2;
        Sun, 27 Oct 2024 11:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730053072; x=1730657872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIG/VePA94ngMhv++GpkFcjTMUbZokWtpy9DDHaG6pI=;
        b=EVrV57y3xP3kAno7p7o7JXpNDBlP0CUTm0+2GsWFWRNW/tNhaqKhH0EIuagKWzFcv0
         DLwrnCXrwYxZrRSh/ve8INgeixlgXbgSmDBPAZSNaMUMnTFL9e5sGSyX3rdbsyeqToMo
         y+RhtWJb9XaWrb0Hfm1UcE21fvIKdsMrCGqdFjatcL3I+HqeRjIktzYOeu9yBDqbbbUu
         kGWJq2zG2MG4NN+4o9aSfba216NKxJWiTc472/X4JyuLm4QhELMYOcB2IqUf7RP2b+Co
         0xvkU3HTB3gwqSNSBTMOwOIsIsvx/BROo8gLNZ78RSokOF0HnlhbZU04tlS1gOPQVq+L
         s30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730053072; x=1730657872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIG/VePA94ngMhv++GpkFcjTMUbZokWtpy9DDHaG6pI=;
        b=EmaNz9YYy7E5JVIcP1xw1yGpBdxjc3Y1wqlZT7nv6/9bdUizgwhrMk62cOsF59Qr0P
         P/jLY5oA3OJ5zjVgCjeIZOS8alR1cieYHauAYWVgma09AR8NxLecgbVa4uPQTiVwC4bl
         TENd6Cs6vvG9LzAXKf3m4s0/V2EWBt8Fm9A5ShNzmZyKgwYzYOTpjq4SqjHHV32L8052
         reZDgewtlGMSvwadPV0GRAAJLHl/7jdQ3SpucNgxeKqKXSfy9kIoyCRhxSwu6oVtmJbv
         LDr6v5ZexSRaeEX6WeUuOYiVcidzip62PTaVNF38unKG4FDZE0+XUKfsFewfv+4vpj+/
         kxDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjaRNBk84ZJEygLSZ/BJ6GKSyQrRplPmn429hdy+/P+2DZIgEp1duZ80YXspCpA1UOi9d/rW7Vd0z8J7GP@vger.kernel.org, AJvYcCWI5uxkc5x8tk0i1bL5F/3rdoIkv4kdcV1S31oMkk/fUtOiB7tWi+fnEK0X1RUQRUt9EsXc5GHEoe/k@vger.kernel.org, AJvYcCWR/EuxQNyKnmOGJp06B4PGCKQT8hg8MCIm3LmUALUw6WE5WDgMH7gz4yzMPofYkAui7WF74V9VoCWexB5z@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ5ZU2sNPXPgQTD3nWsOYdfciR2bDcxwTQ6YiVclIahypP+Zq3
	cc2id+x8yHZOnssGEzgHFHMrs81WW7EPuBsndpXqP5c7mdOw0svHaDAEzQ==
X-Google-Smtp-Source: AGHT+IG/BR3q47H84KcJI2JvB5THMdtv3sxmNpwtaQz8MQ9YIWXUarEAK1UqcT36wBQMt0varbGCEg==
X-Received: by 2002:a05:6a20:d98:b0:1d9:1858:2f75 with SMTP id adf61e73a8af0-1d9a84b8ca8mr7765626637.38.1730053072101;
        Sun, 27 Oct 2024 11:17:52 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.83.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc867d0c1sm4306492a12.33.2024.10.27.11.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 11:17:51 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2 2/4] ext4: Check for atomic writes support in write iter
Date: Sun, 27 Oct 2024 23:47:26 +0530
Message-ID: <78ce051e4a7e9a453a46720da76771c21691b162.1729944406.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1729944406.git.ritesh.list@gmail.com>
References: <cover.1729944406.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's validate the given constraints for atomic write request.
Otherwise it will fail with -EINVAL. Currently atomic write is only
supported on DIO, so for buffered-io it will return -EOPNOTSUPP.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/file.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index f14aed14b9cf..a7b9b9751a3f 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -692,6 +692,20 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (IS_DAX(inode))
 		return ext4_dax_write_iter(iocb, from);
 #endif
+
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		size_t len = iov_iter_count(from);
+		int ret;
+
+		if (len < EXT4_SB(inode->i_sb)->s_awu_min ||
+		    len > EXT4_SB(inode->i_sb)->s_awu_max)
+			return -EINVAL;
+
+		ret = generic_atomic_write_valid(iocb, from);
+		if (ret)
+			return ret;
+	}
+
 	if (iocb->ki_flags & IOCB_DIRECT)
 		return ext4_dio_write_iter(iocb, from);
 	else
-- 
2.46.0


