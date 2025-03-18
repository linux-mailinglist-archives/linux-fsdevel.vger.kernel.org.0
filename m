Return-Path: <linux-fsdevel+bounces-44228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCDCA663E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 01:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC5F1674E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 00:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3013A1DB;
	Tue, 18 Mar 2025 00:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+VMmx67"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77162FB6
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 00:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257837; cv=none; b=oGI3JHw7R4+5j6Df1Znx8wjB3iiKQYve5dFc+pDZwb/MHdT0nHMRErv9Sf0qb9oomtqJ6O3kgjXdfQjFhmP/5iJ5WKmAo4ZcTvRjW9Obf0CuaIfxRMsn788cQdOdzo7vCiYbF5mFX3fH9F5zLbVVk11fx9omTw2IWzjqOUhCO/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257837; c=relaxed/simple;
	bh=9rJv310ZxyZbxkIe8h5X0f/kiS/WKYQH3RssVOS3Ve0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TsCmQPe5WEy+xN1xrttksIOE/Rh4/bk08/rQV0JghHF+FIBGhBcgSiQnaw+djDPyFjVIcT1YfDK3+3UbmEeDOTlEPgsivZpGDqpu6dreQuZvAr+lp7f4rvQ5y9pKW+k2DFScgxPEQXTABx9+uAnT6KUzu2eLwiA6Lwe9lsqvWfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+VMmx67; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6fedefb1c9cso41913497b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 17:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742257835; x=1742862635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gftZ7ugWuK3Ws8ciYhWGfFuIHG0PYc0T+5ipBuf5Ig4=;
        b=c+VMmx67DxUjGHDM9e7VugxPaj3K9kxYHF7u7rgk0BlKezcwG9aeWuACrRnAOv0Po2
         8pPeEB+CsVRRLQV/TkCGf0JA6Ep/BKPEsXv5VbKxo1lycbA71ymIzN8cZG4OqWiOZGLT
         wpd1a5tMY3Cqa/8Qd5fGPnYGcJQ90D3az0+Bcgo9/TbjsxRe5I8xrfbszewUKgrLe3IC
         f6a7iHvssbdwd6RzwGhWlobVaXkPH77uxnJa0Yzw8RUAI862ar42Jv7tGzKGe0BRNExe
         floSNq6ijhk38mZa5G/kl9dqNgVX0noBKemiUo2XYfFEyM9Dvxs+65g4uL3NZ26P/+UE
         odEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742257835; x=1742862635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gftZ7ugWuK3Ws8ciYhWGfFuIHG0PYc0T+5ipBuf5Ig4=;
        b=PatAnzfLhiAP23JI2H+IytrY9b+iYw+uJVaG19QbmdL0d4btrVgN2EbI+xynLnAyph
         3GRO5niaWWwJqtJnMZAV4z/8uU+1hzpw4j7lHxkVbj66Q4qAgN8uEXy7dJmQ/kCv5Vas
         oBv9M/0UQ0H8E/l4AIgq2a26owwOa0/onhTg2gihxF/XYXWviEsZ98k6HMKjnVyGxIYA
         wS5LezQacShM5XrtjWSD6aSuU//DtuZyx3xsdm3MtDWJHBewthQ7gIuBMlfgtgF2ovTb
         kLkWCSyg97F9mDUG4KxMhKMy/K4yesQvSh1MgXMACegpGryEQulUQPA9r3nApKWzKBmp
         s7Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXgjd7HsQFhIqR0wCSI3br7w4nBMHa+DAymGdZUZQk6n2lunbWm/OqoVwZ3N8khmtNYZN1OyRI2w+flHC1O@vger.kernel.org
X-Gm-Message-State: AOJu0YzNL/l9xQQN2P8fEePxF0LvljqoBwaQn2QXDn3UJnu2f3KwbiIK
	GSer4fbVAaaES4o1scZ8p+ZLZhM4plSvvWDaV/3mqXMnnloB4L/q
X-Gm-Gg: ASbGncsqEic+tvvSg4wj4Rkty3hT3syKTkHboifcrm1TyZEdbP4afH5kzUjr0MStZxH
	+X/8jOqnk32BLHEaB7vhyQSy0RpsuXWn8867MfZycgwc9YR94tmhuVUqoea9FvZ4YZnA8vf7KVK
	D9rF4j25szvkriDbQszsIEq8Mmsi5+D/23pLkNNjTYXwQq8eEmytcACwGRxxIWOM0jnC479iO2h
	Lvr8U0bxlzsebSnrddkoyr4KJRSz1acNqOapxYu/KdeLz2QH/sR7pOT2LF3oAXAkdUUixmYqN6+
	jLSZM/elIbpFacCyjharSfCW4uK25C7t+z3JACwpYw==
X-Google-Smtp-Source: AGHT+IE4v1qaRT3YtkCaQqYLS+zRcev1OOWjnO2oKxIW/bEeQqV9EAm4eoOKxBhAKgwtt8hom9emkw==
X-Received: by 2002:a05:690c:6404:b0:6f2:9704:405c with SMTP id 00721157ae682-6ff45f62f4cmr191035387b3.15.1742257834660;
        Mon, 17 Mar 2025 17:30:34 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff3283fb0bsm23902227b3.12.2025.03.17.17.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 17:30:34 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v3] fuse: fix uring race condition for null dereference of fc
Date: Mon, 17 Mar 2025 17:30:28 -0700
Message-ID: <20250318003028.3330599-1-joannelkoong@gmail.com>
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
reads ring->fc. There is another race condition as well where in
fuse_uring_register(), ring->nr_queues may still be 0 and not yet set
to the new value when we compare qid against it.

This fix sets fc->ring only after ring->fc and ring->nr_queues have been
set, which guarantees now that ring->fc is a proper pointer when any
queues are created and ring->nr_queues reflects the right number of
queues if ring is not NULL. We must use smp_store_release() and
smp_load_acquire() semantics to ensure the ordering will remain correct
where fc->ring is assigned only after ring->fc and ring->nr_queues have
been assigned.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")

---

Changes between v2 -> v3:
* v2 implementation still has race condition for ring->nr_queues
*link to v2: https://lore.kernel.org/linux-fsdevel/20250314205033.762641-1-joannelkoong@gmail.com/

Changes between v1 -> v2:
* v1 implementation may be reordered by compiler (Bernd)
* link to v1: https://lore.kernel.org/linux-fsdevel/20250314191334.215741-1-joannelkoong@gmail.com/

---
 fs/fuse/dev_uring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index ab8c26042aa8..97e6d31479e0 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -235,11 +235,11 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 
 	init_waitqueue_head(&ring->stop_waitq);
 
-	fc->ring = ring;
 	ring->nr_queues = nr_queues;
 	ring->fc = fc;
 	ring->max_payload_sz = max_payload_size;
 	atomic_set(&ring->queue_refs, 0);
+	smp_store_release(&fc->ring, ring);
 
 	spin_unlock(&fc->lock);
 	return ring;
@@ -1068,7 +1068,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags, struct fuse_conn *fc)
 {
 	const struct fuse_uring_cmd_req *cmd_req = io_uring_sqe_cmd(cmd->sqe);
-	struct fuse_ring *ring = fc->ring;
+	struct fuse_ring *ring = smp_load_acquire(&fc->ring);
 	struct fuse_ring_queue *queue;
 	struct fuse_ring_ent *ent;
 	int err;
-- 
2.47.1


