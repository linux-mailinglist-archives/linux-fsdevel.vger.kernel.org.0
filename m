Return-Path: <linux-fsdevel+bounces-30370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0800098A5B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 15:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3929E1C225ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3701EA91;
	Mon, 30 Sep 2024 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="14fdPih7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C3918E046
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703948; cv=none; b=t+M1vfg5CSTZBCHLT2k6FRKShLdPir1zFNK5JTzko+UMy9AXvqWCB0LJQl0ufT+Xa82gmmmPqeJXd/JpHFs7/vVoVVqKwpXHPaGG/OBXOVrmoVY3JQPVbmqg+1rDs9WgxBy24qlI/s7FOwhrpYcJ+3U7Ah8cihnpEKu4XXl1V0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703948; c=relaxed/simple;
	bh=QjhWXX99YcYZggtkS3ASVI5vIztmbk1Bj4ji8EO1PCo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdoYYsliBxI0QyI4Wt+JB7tudRrSXAe7fTpNyJIs1xwig3nj9rB47GnW8fTlqG+Mcqti17uLk29qNxYUJdeEgURB0t5AqpMPRWdfqYxDGdqiU/Xz8je+r0z0xV2GHJamCWR+viFlaaqjl7/yGDiQArkcQTSCVcuZuoJ/xK9Hei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=14fdPih7; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-45815723c87so34834431cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727703945; x=1728308745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5zjhaIoS4x1gFV18KSzw13Nd3fOQvJvqPRXABTSAZU=;
        b=14fdPih78nUGLN0ChiSrZj7rd9OiW0iVjne/th6U/wIjlK7iLHEFLaVMNqAIH9Chab
         bVtMB/C/FYkYrtQbO51cAV1VhmS3F32JHYp8vzkd8nvBCcDY+F4s5EBkc/5JK7XywkGO
         OGQT5Q9fYZODQNIA/fqZlR7Lh9OK0jnUdc6rffNS88p1oF2htgpXhu4pXJEQs07qbMke
         IwSirBav48fmGB6QifFnfrwLVbcnf53W7GzZXfR1YCR0/1ECRqZrRAUgMnFLSO2BgV1r
         wprvRFAeROgi9koSBVKzXTGCWdiF31RI/cnbEvuYsOUF9iLajPaIC09IeUwJITgwdbSX
         XO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703945; x=1728308745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5zjhaIoS4x1gFV18KSzw13Nd3fOQvJvqPRXABTSAZU=;
        b=DeZah3yXHkii30l/VK6Cy8/3Q4qRQZgOuzWXhpvVT66AnCkbgHsKXeM0CZObxTrjvh
         NJgYRSs4gY+ZOjk2rG6nsOMxAet5+e0aROntEMe+JksDMcTirRc2no69WXKTGCdo2DXN
         35ia775xY/xlbrubdhn0v3Tij3SRH67Tapj7ipMt/IWVClftSAu2tJAUCSvuSH0w1Qpo
         yG8gppzyaodXxv75f9nKz3hy7PHjVM0Ta8hrsvc4HHtI8wFGHMUKSd5v+ulDrWb77D3x
         n0CAZNXECjomEzEfbMsk/ABjkz6BmFPNrO5deo/03mHKDbvosiHo07MbIl9YB2Nn1Eze
         1LWw==
X-Gm-Message-State: AOJu0YzGd/IKWzNQt+DmTjIcV7CtUm4oBGe9U+nBI0Xvdgd69Vwg8+j8
	XHzxs5KSjIygk4uu+a9VZqqOTTumEZHO0LtZqwsi75fsYugsKKEC2S8uCbU3CtgwhU3hCoWpf8Z
	k
X-Google-Smtp-Source: AGHT+IETnyyAlyvSZsPlIYriCQmIDl20xXWgkUs+n5Yuixbij1QuKGa0KLNouV6gd99ggq7XsKeJUg==
X-Received: by 2002:a05:622a:144a:b0:447:d963:ebbf with SMTP id d75a77b69052e-45c9ed2afbfmr244081421cf.21.1727703945112;
        Mon, 30 Sep 2024 06:45:45 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f2f2264sm36508421cf.56.2024.09.30.06.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:45:44 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Subject: [PATCH v4 05/10] fuse: use kiocb_modified in buffered write path
Date: Mon, 30 Sep 2024 09:45:13 -0400
Message-ID: <5b7dc1e745c0747e4141520b037cb9e592422dd1.1727703714.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727703714.git.josef@toxicpanda.com>
References: <cover.1727703714.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This combines the file_remove_privs() and file_update_time() call into
one call.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c8a5fa579615..2af9ec67a8e7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1455,11 +1455,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	task_io_account_write(count);
 
-	err = file_remove_privs(file);
-	if (err)
-		goto out;
-
-	err = file_update_time(file);
+	err = kiocb_modified(iocb);
 	if (err)
 		goto out;
 
-- 
2.43.0


