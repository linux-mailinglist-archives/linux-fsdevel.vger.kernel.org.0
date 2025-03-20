Return-Path: <linux-fsdevel+bounces-44526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EF4A6A27D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100C61899310
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 09:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2222222AD;
	Thu, 20 Mar 2025 09:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUlAEvdR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DB321B196;
	Thu, 20 Mar 2025 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462624; cv=none; b=dloqPreqdwlUkYsFt3kTVLEG1dbO5EeyXX63FO08JFeDmY9aqUa9bNTidxBZPJW6IYLGqfqCUQ7RRXLFyRQCwYU98SVHOnLWLlCx9y+9j4ojdVONMxyNr5ALo8ctx+rKiPC7fKBjJLRCEdbeoNrQXZ3S+TsogU2iBxnl/0KNj8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462624; c=relaxed/simple;
	bh=JnnHAfmsCUUWCwfWeq4NU1/uI0vcW8GoW3DDhrDBFaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CJFTZBlqFzgZEgTs9Lw1qW+kSvoVdWA57VtB5SD7nulo6PN2WnHrIbl+O9ka10S303LXWlDxQkW1Dn9QYusiEfT/Mz4djJhtBK+4ib+iUG0yfsNCauZH7BJPK9OJXa5RcRoE2RKPiUcGZQmti71lzICUq+u+hrtrtSHfKgAfGUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUlAEvdR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3913cf69784so418460f8f.1;
        Thu, 20 Mar 2025 02:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742462620; x=1743067420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XDkXv87ePtZ8dqvGjrUGbMHN/FXCcninEB+YGNwQu8Q=;
        b=GUlAEvdRkb5Ji+rDClOW8maTaHglumja8QeKVo3X/MswBqhLKakpR5atx0eKWIAcdH
         vb0UwUwjPjsPvXkFU2iyEByc3DOH+XWRUFwj0z2PT+Nr4FYT2M0I2ceQD7rHmnAkOPSS
         pCqf9luNlrzbXVlkFe7+QqVfvMtvlbHNg9KOULt1Kr+mDboJCr/bRzbTtamjj8qFIoqm
         BUaiILYHElwhXoXRC02zzCVuXv+i8haLkKYt/xuM5aUWqRoogjgtwsJu57bcepYVrf6W
         v55tR7IjDe2d72pvqsjTZxMOhFZkuFRmYpw5BKB0kUDJp2BwL/1+lZir3TD41DXyFsGg
         ObvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742462620; x=1743067420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDkXv87ePtZ8dqvGjrUGbMHN/FXCcninEB+YGNwQu8Q=;
        b=NzjIlXLj0dJVeYUqotH7b59J/GyFrHi3fH806cjpNDhhE2EuI3GsN8ath6D4TmQO6n
         jwjYW7AK/CPi39t1IHaZLOT288WU4pRCt2HP2LANnQ/gs3KNIlVFd3rwJe4X05AUEhTV
         Sj3v3Uf4dRDDF/gsuMFralJIFzE0hGzuyNIceS2xUZFdwxH5260FQXaZMBim+K3kOOG5
         oZogHH8kEQqYW1w2Z/0O9LHbcsfUODPjJt3XXlDG+bYTbxIlv/rlknoIflAb5+321PNe
         L9mUoZVzFiZH87EOU04NKYhiRbAl3tsNbVq8gTZpmzi5GhpP7n7FYj4thNm9c+qpC9wh
         /5pA==
X-Forwarded-Encrypted: i=1; AJvYcCUDpE2Gxul48rvKRRHu592WsKwlJ56V8HU9WVwwlWEbK8zLf0k1xR4+dl7y36NR0AmCk96Lq88/d7f9wVuF@vger.kernel.org, AJvYcCWWClqk3Nlfz5sg4uVBsf00fGhKXJV7CfMzZd/CNs8ORSuJCUSqZMAwuIC4tNTbiwKoHw6CX1OHVPR5S0yy@vger.kernel.org
X-Gm-Message-State: AOJu0YyHK6bm+30v7ccV0P+vS++aLIGRbC2FZl0fbXHhS+PtV/s/ycnJ
	uDeV7GEsGzQOTabUQW1kD8lD6flTIfeWuN3KEMC0xuv6ZZCEGV1k
X-Gm-Gg: ASbGncs6ASjwBMuAZCQjqOvnb+uZt1RbGmsCRrE6Yb4BcFDEPzRWqcEX4VfQKfR0w8H
	48hMJW/rBbykbIfEDjxbLM6mRLYJQUiPBG0EqJCWdmUoTOyER7UAjJs6QkUv+loA7lwFs59XAWL
	Ukge5nDdd5hNw47U3bJ+1tMSPaSUa/Gea8iSq1sSp9pg1qn4YSCUfRD1IIuZ5NCY8OyLjYa4eAv
	hV3irF99AGIplLE1cCx46Jo+fI7VnAXyjt8X2NytlB7x9kWyEMDhNZE4vpkCF7v5+sfblLxNPxp
	hfcRHAJHamZuxgoIFR4kuRvDKOfnn9f66cQ81M5IxbBlawF4w16EUlXxCJBvBQE=
X-Google-Smtp-Source: AGHT+IGGkbN6Wt5565TRSFegTWEecyqWTBi2I8zaMDwULNUAqPzMF7rmIdqpD5XoEUbGZITIBTn4oA==
X-Received: by 2002:a05:6000:402a:b0:399:6dd9:9f40 with SMTP id ffacd0b85a97d-399739b7ca9mr5150479f8f.9.1742462619523;
        Thu, 20 Mar 2025 02:23:39 -0700 (PDT)
Received: from f.. (cst-prg-67-174.cust.vodafone.cz. [46.135.67.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a5esm22871762f8f.27.2025.03.20.02.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 02:23:38 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: tidy up do_sys_openat2() with likely/unlikely
Date: Thu, 20 Mar 2025 10:23:31 +0100
Message-ID: <20250320092331.1921700-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise gcc 13 generates conditional forward jumps (aka branch
mispredict by default) for build_open_flags() being succesfull.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

maybe i'll get around to do it a full pass instead of sending byte-sized
patchen. someone(tm) should definitely do it.

 fs/open.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index bdbf03f799a1..a9063cca9911 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1413,18 +1413,19 @@ static int do_sys_openat2(int dfd, const char __user *filename,
 			  struct open_how *how)
 {
 	struct open_flags op;
-	int fd = build_open_flags(how, &op);
 	struct filename *tmp;
+	int err, fd;
 
-	if (fd)
-		return fd;
+	err = build_open_flags(how, &op);
+	if (unlikely(err))
+		return err;
 
 	tmp = getname(filename);
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
 	fd = get_unused_fd_flags(how->flags);
-	if (fd >= 0) {
+	if (likely(fd >= 0)) {
 		struct file *f = do_filp_open(dfd, tmp, &op);
 		if (IS_ERR(f)) {
 			put_unused_fd(fd);
-- 
2.43.0


