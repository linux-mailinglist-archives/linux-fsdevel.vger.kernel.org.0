Return-Path: <linux-fsdevel+bounces-44045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C257A61D2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 21:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1B63B6DCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 20:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755FA198845;
	Fri, 14 Mar 2025 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIsIqUex"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1841547E2
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741985446; cv=none; b=CNh8pkBuBy1+5giAZdmqk87cdc8tYMa4q345r6goSovn9x4Gt9bopdqoEIw9io2A9NSAPUxBuUcj2/MCXvuU+BUwqYcdKlhwoM+L1/u+i8PVeqnD3b7q4NkiOnczKbiCazHzj32vrg6d4kz0vjXouqbiKOUDBnnUVg2nUGXR67E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741985446; c=relaxed/simple;
	bh=tm/B4py7EYuSsSLNqxDR+tDZn5+3TufOvVwpSw3aeEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nn6a4gTsgKvWOE2dO7tOrytrwg9Oct/+wprZzeWrSp0UzEt31kq80RDR9rOYPzqXVjL3zJGVPv1/n9ZEZh3E1n/Pct78pDxcuHLt2nAYWRV84mfgfbr43BmI55ImVENvX0+Wd4LqqGMlHHwzluF26HWaLeyAwsKJaIInkunli8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIsIqUex; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e46ebe19368so2116343276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 13:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741985444; x=1742590244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wmIjd2kV+SNyaXVQwp9mzDhUQaztt3De1d/l++eeKg0=;
        b=nIsIqUex45tnsurWgPKfIchroXAuqV2JHtgS7uWS/MykdWWjsmXCM3UUEfQnN5kiSm
         UGkRbYthZe2ZnuWW7HpHjvUVGOtH4Em5JvJMIOtyvU9Ta+kDKjzU65c0/kA4A66jXZpM
         I1WGP0QsTZzKJRSlfm6YYhXEp2Igxdvjlvowej9ADZ7PmFyCPKGykveplMNlZ6cKNgzq
         9i7NSZ6+5mSVvebbkitvPPVZqkaTeAHRwmGYYo3ptvjOihrsOTPOXxj7FTNC2qz3AUiq
         5ZX5hUNcR/ArWlX7sJ05g7Lyy6La5HtvhiAa0VJNNgli9u65KSOC2lOs9hc5HU7twA6p
         CiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741985444; x=1742590244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmIjd2kV+SNyaXVQwp9mzDhUQaztt3De1d/l++eeKg0=;
        b=g+NhlO/XtwK7oXqlIBXKSmSHZwl7wy3b6wfZHKaPN71qHBuI5ZNus6JIbpPfwg7hcV
         ZJlv7vw+IiZvvFdQkLornpg7k+pCsD3qS4JP9Jqysh3RVRu9eXc9kUwBmZnpvldk3lRV
         ZbvhQXZ/be5kDBHznVeKyWFydhqmyN2VsYVkPGahzR7rsSO4xxgcsv9KcLYM3vDMbKZ9
         aIUNzIeBXvpMLE34rm182g5oeolA5aBPNRC3RshwU1MroZRzhzRjyc4zt7j5+JNmF7WU
         I/DYAkiqDCEL7YihPrmv3VXrsnlI+ZUwnCP0vhyVXmq8AW0bhF2azRYZ1yEiV6Xq7u1c
         /xVw==
X-Forwarded-Encrypted: i=1; AJvYcCXsLB+fckI1Hnju4nq2tROiS9le8bCDPiLP/LLxcMwHm188yP1HZDqVubkw2HLzNXBRPyre+tTP1t/eTOF6@vger.kernel.org
X-Gm-Message-State: AOJu0YyaBPji2xZEOjJhyLnE9Ezu0NIO7FqEoQAIfNgDQtiA/4djmi0z
	GkIlCtzxawhBpiAJT9hEMbbEQzxzErInuSCpojeXyyfqPR6fYjhqOW/9GA==
X-Gm-Gg: ASbGncuZaYSPakiyUvKFOpwJi4hN1/K2nBXYy7QeGw1Rj0IPRWNhYZK++qsbEcjFXF8
	XUbPcaJhzbukOlbceMbKfeJd0Mos8D2USiJnEbe72EKyGiurBle5fF5CBk9wZ8UC4lPHBcywrbU
	TNCKcdXbVbQ01JHqzlhCxeMdZ+9bYzylqVnve38x/mnw5RbK6m7StLoTwK4WQRUDojEagmAP6FH
	Jl6H/duT5+Q94jVmuGfYaZT7N5vmd0vFHB7RP2hI5ls9CtCkcMevIRYIbJF03GsR/PuXih1vxEp
	jLO2sJpaY3axBSHu4Hj0xqFWsAeh9yDhPBGa9bYZVOE=
X-Google-Smtp-Source: AGHT+IHlRUu+XtV+vNIypkI6QeLYgZKhzymZJVfY4JZ6Gpd2MlwR77kVzcqH0E4F7ByRrNUa8+ieEQ==
X-Received: by 2002:a05:6902:2581:b0:e63:7119:bcb with SMTP id 3f1490d57ef6-e63f65274f7mr5355022276.18.1741985444113;
        Fri, 14 Mar 2025 13:50:44 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e54451d1sm1024911276.28.2025.03.14.13.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:50:43 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v2] fuse: fix uring race condition for null dereference of fc
Date: Fri, 14 Mar 2025 13:50:33 -0700
Message-ID: <20250314205033.762641-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a race condition leading to a kernel crash from a null
dereference when attemping to access fc->lock in
fuse_uring_create_queue(). fc may be NULL in the case where another
thread is creating the uring in fuse_uring_create() and has set
fc->ring but has not yet set ring->fc when fuse_uring_create_queue()
reads ring->fc.

This fix passes fc to fuse_uring_create_queue() instead of accessing it
through ring->fc.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")
---
 fs/fuse/dev_uring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index ab8c26042aa8..64f1ae308dc4 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -250,10 +250,10 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	return res;
 }
 
-static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
+static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_conn *fc,
+						       struct fuse_ring *ring,
 						       int qid)
 {
-	struct fuse_conn *fc = ring->fc;
 	struct fuse_ring_queue *queue;
 	struct list_head *pq;
 
@@ -1088,7 +1088,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 
 	queue = ring->queues[qid];
 	if (!queue) {
-		queue = fuse_uring_create_queue(ring, qid);
+		queue = fuse_uring_create_queue(fc, ring, qid);
 		if (!queue)
 			return err;
 	}
-- 
2.47.1


