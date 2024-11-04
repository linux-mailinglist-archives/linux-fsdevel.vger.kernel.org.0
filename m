Return-Path: <linux-fsdevel+bounces-33594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5065A9BAE58
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 09:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CB51F23483
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 08:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A1B1AB6DD;
	Mon,  4 Nov 2024 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCOlt+NR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257521AAE2E;
	Mon,  4 Nov 2024 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709775; cv=none; b=Bg9yAc2+dpvD2fzTnU/pDVU1yzJqO1wznjwLgrTzTKjF8uAKU4euykWax+gMIsbdKhqOZwMNsr/Vf11vHFV26ZuPRBKHPCu9mWXpxMSvrXfIF6hjq2WPxQRvd4JL/BY0w/wXB2mH/XFYEUa4ax45wWj1UY79zlaNHn+zoErYywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709775; c=relaxed/simple;
	bh=5NJiUk8bCZ3kcgBohRRzUDb3uTOSFIvGx3ay92B7kOI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MIy1ymqiBtLXS9BXDyO6YgFOU3+nIo+flyGOk9Bgqfy5SCgEVBRbHfN7inNcZ0cUBClr6KjlOzlFbVcw353rbeOe6Yco5M8iqcgPwt8EidNH0/wqGLhDBeOzTqvoVrTn85+/Vo24WGXJRyV3ljkdlsLTqEppGV0zbm43DzUDy0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCOlt+NR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so3307097b3a.1;
        Mon, 04 Nov 2024 00:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730709773; x=1731314573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/8YHBY/s7hL7LBt+bml67qPtYFLfLzO7wsBOP4nNMQg=;
        b=XCOlt+NREWknlnJeg/zEmuFXXhTjObcRiMS+xlJQ4IgfMFMXffhZ5EsODgqO83+JXa
         FWbXK/dabcfewlv6+7lKrWkcaDxYGBkg/7Z/Gy1SAsCuSY10T3axleBPNaXDCAZwM2JB
         I9GQUz5cOMBh9kH16Jlqd3T7b1K/r+yhO0wPjwyO9hkVdDZkxGsP0VXgyjEsYJv7cbrU
         uM+oDNkKU1wkJ520IoBqp8OOHz8pbV3NgdeIHwlKC4cYFEaGtxa2DHXsH95T2AtLq/QH
         c4fj7O/S42laV0bwWjXq6XgHl2JnFYSLD/t2EQfgNWzNwseWXxvK8BAmzRMyeUUDRRu5
         k2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730709773; x=1731314573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8YHBY/s7hL7LBt+bml67qPtYFLfLzO7wsBOP4nNMQg=;
        b=gpuaUx6k4lAFkXGq+ewj+EPTAYAr0NkQPEjWgoT1yT9rUQrKsU1ra0y+sdIaw14RQI
         +s23wF6dzArMW0LnOvSQb0SxJQ3VPoudu7Ks8g1Txbesd8JRGwX7h17xump5nn8es6en
         OkmKD07WcmtcWdhiSngeIRU0V+c3ELuLajG+nyEk3Cw8f9LE3u0Jgr0aLAFfMRV9R7hX
         PLe0Mf1C1MBqCtEYlB1ZzopqvZqrib398sI4ZdytcObQhaaBwiUqz/z9+2jdHHk8FTfV
         3+E+VgbBm5MP3DwQitrLp4xzNs2hrdVn11cc+A3/zyJkcd6HBY85QQZ33JiBFu168mc9
         Yv+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUr8HIUPXZBOWO0HqPqb5bHjS2YmYvH7b5kqOe+NHVdu0gAkCIvQuXvPj3JfMZGw7WK51wQwc1gGLtp4JPg@vger.kernel.org, AJvYcCVCDbzJ/7/W/9p1VYSqzDUFCkzkAAJgtNmWw7dN+aOdoRBGXxvZXkKZskkwg8h56X2pzAw95DTvHWzVQqZo@vger.kernel.org
X-Gm-Message-State: AOJu0YzOUfPnC27xl46XiRb8miPdfz7iqHFvbEmOgN/p6vGGsu19J1T5
	XlY58rSuQAmGxsk/LSW9jptvneitLN11ndY69SZgjPDSI5CBf5FB639i4vgUqcs=
X-Google-Smtp-Source: AGHT+IHh5A/7/W9p56TSopcVQlWHydJS943ePx+Q9RUlvuynsTn6oLoVpFHHRABwmwLVdXzCkbcevQ==
X-Received: by 2002:a05:6a00:3cc8:b0:71e:780e:9c1 with SMTP id d2e1a72fcca58-7206306ecf4mr45209948b3a.18.1730709773244;
        Mon, 04 Nov 2024 00:42:53 -0800 (PST)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7ee490e08f4sm6244865a12.40.2024.11.04.00.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 00:42:52 -0800 (PST)
From: Daniel Yang <danielyangkang@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Cc: Daniel Yang <danielyangkang@gmail.com>,
	syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
Subject: [PATCH] fix: general protection fault in iter_file_splice_write
Date: Mon,  4 Nov 2024 00:42:39 -0800
Message-Id: <20241104084240.301877-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function iter_file_splice_write() calls pipe_buf_release() which has
a nullptr dereference in ops->release. Add check for buf->ops not null
before calling pipe_buf_release().

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
Reported-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
Fixes: 2df86547b23d ("netfs: Cut over to using new writeback code")
---
 fs/splice.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 06232d7e5..b8c503e47 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -756,7 +756,8 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 			if (ret >= buf->len) {
 				ret -= buf->len;
 				buf->len = 0;
-				pipe_buf_release(pipe, buf);
+				if (buf->ops)
+					pipe_buf_release(pipe, buf);
 				tail++;
 				pipe->tail = tail;
 				if (pipe->files)
-- 
2.39.2


