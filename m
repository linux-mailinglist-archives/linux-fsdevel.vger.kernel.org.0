Return-Path: <linux-fsdevel+bounces-28011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABDD9660C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD791C2460B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 11:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB78199920;
	Fri, 30 Aug 2024 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuij65pU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9350E17ADEB;
	Fri, 30 Aug 2024 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017496; cv=none; b=S8avFLR3GXzP1ile3u2jajN+7DwW+4Vj2bjYAwDGA1g5WPc66iB6Qp1ASUTSzNSZTuKLvv0e470QXmaUa1P7LO1QBEE9h5/NCMr5vF8IyMVU59MpU2dhFGnhoPRGDUV7p+15WG9239JJn/aEZuURrWdg8e3N+OasWUVKCnx2G38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017496; c=relaxed/simple;
	bh=BEseMaH/R26oENGgZC1y8ZUAeWSWb0ov7ljLsQGQL5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jfPDjFSuxx4hBqayxEXF6vLQe3zFAuCwjLP0ygmwWGxr9m4LwKJAX05M5ILAwVBkz1Yu2L9Y+sVotxIZ5quLfQoTlwnyjmFKYsYE+ZkslaLiBYa3UKHQuFWNPiLvEztRXYGfIuxRwgoz1M7TNIJrdFsC6AphTSdoeiynMS9gW7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuij65pU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so1182099b3a.1;
        Fri, 30 Aug 2024 04:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725017494; x=1725622294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFHF8CkCSJECTVcPI7L3d3vdcCaiUuTgwTRGi6N0+KM=;
        b=fuij65pUOklz4SFHmCElfwuyE665HS3yR7kEopSIyZQeUMk9Tjz0NXjLyWM4Yod/Yi
         vufGwTV0nPTGcL0rSxlJ8XTe0gNrSs5LJMmpWZ2DwwJqL13wonzhe52iBgibHES4gy2v
         rTjqaZYuFTlUkQWa4AetPwWSleQ316SvwmO78bcYLJqQiEiums16xmX53lqRTSzkb8FU
         ZgdF3jG7x0dJKgfn7wY8QGEmj2GCv0gmbATjflH+RFEBUmOHJLOjujk2NLOzbcbmlea6
         Ql2QOf+rLo9ti8OajnPsk4WRvH/P68+8+8FkQiyi03GDT/qKFxOuEDWNJeQxdKlV3Zil
         js4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725017494; x=1725622294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFHF8CkCSJECTVcPI7L3d3vdcCaiUuTgwTRGi6N0+KM=;
        b=UXL/Vw0X8ouHvtQu+6PDQbCuc8XD4YadlEEo8HA47m+6o+RgW2DLkBae14LDwwbd6k
         z9x1rpSaUAHTarb5SFrIeSzBI0Z6alc0Wx/59tOCNPdQj7NaKmBmHobRx3LYWBsx8+fs
         UFWVBdJnYjSeTp7BJxbqeAW2DMg/9TSetDONlNpSa2D2mhnszNAbZxuakvSRgTl2Y4Fw
         T+ZhKyc2iJnPk3z28manp1ABbMcXNja9T3jv3WLFyuK7BOjZhe9JYaj3fOozjFgUbpFU
         FHE3LjC8AJDwft6N/RsH6jswxn1uDOPnBrOZ+5sB19+njqqVsfD5uyQPFTeZk/rTl0lg
         KE0A==
X-Forwarded-Encrypted: i=1; AJvYcCUdsr2IyHkb3mIbZNwO0N5SxoTG5eiCNWONA0AE1CALYmpqGMgCrn1WffDZE6qg5+odFsVI68+hfAtb@vger.kernel.org, AJvYcCUx59fLPtpsi432J8Gk18I3NJWgbxSrRXLKGsWvJFsaNRSGhQTzydxQaY2thJOTbQloxclnAuX1G2cqSrRu@vger.kernel.org, AJvYcCVCB9UJt36jJExtZQNGtyo5E/d26vbozvas+utZURlkJJoVUhOQe3wUJ/tKBkD10xZ6JxWUE/GXbfPckN1T@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3MHPknya1zg64a+LKE0RANSsQo8fAK6h1waSBtYPVtazWyZhd
	ZuAVdvcv27/JcJLYSWxhw+Mjxp3x/nSplCjp45Aa9F4Vfl1DwZXz
X-Google-Smtp-Source: AGHT+IH5Hvvt5LsiN3gjHVMOELcNkoiyya11sfbL9JT4CUB7pFtIBW7+HZ9dcHBmVWJOiOqr6somEw==
X-Received: by 2002:a05:6a00:1409:b0:714:1311:cd24 with SMTP id d2e1a72fcca58-715dfba79bcmr6392117b3a.5.1725017493588;
        Fri, 30 Aug 2024 04:31:33 -0700 (PDT)
Received: from localhost ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a6ad9sm2551051b3a.84.2024.08.30.04.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 04:31:33 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: sunjunchao2870@gmail.com
Cc: brauner@kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iomap?] [xfs?] WARNING in iomap_write_begin
Date: Fri, 30 Aug 2024 19:31:30 +0800
Message-Id: <20240830113130.165574-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <df7fc9c1863f353091cfcb84f04e365aa4609bab.camel@gmail.com>
References: <df7fc9c1863f353091cfcb84f04e365aa4609bab.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch passed test locally, and the patch in the link 
appears to be messed up. Please retest.

#syz test: upstream ee9a43b7cfe2

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 72c981e3dc92..6216c31aa3cc 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1162,6 +1162,9 @@ xfs_buffered_write_iomap_begin(
 	if (error)
 		goto out_unlock;
 
+	/* Get extent info that may updated by xfs_bmapi_reserve_delalloc() */
+	xfs_iext_lookup_extent(ip, &ip->i_df, offset_fsb, &icur, &imap);
+
 	/*
 	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
 	 * them out if the write happens to fail.

