Return-Path: <linux-fsdevel+bounces-42188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A09BA3E5A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 21:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8730F19C0E80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 20:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546CF1E9B28;
	Thu, 20 Feb 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaadaOcz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306D91DDC14
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082658; cv=none; b=a0lxQWf8R0Zw7/7Bih8bTSt1rFFulRggULHVXkjXoOY0S7Xsjv1PRQhSXE/4anhC9s501BJablIRZcyMVRMPrscOONUsfYGJKldQFMQfeW1Wy9z3XdXO5o66cvzxqV0P61gtjHIDXPzNQSu8OGZ75EDBN+YPgBkjDPhYsGULsb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082658; c=relaxed/simple;
	bh=DJ1Zix4wWDR9rcuuDJXUnKz7kHOFIj24qZ5uZH600Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ic2kshQj1b8wvcFBQonpTVcziTyg28+JMZ7EETPj2JgRRCg1f9CNossUQU3+DQ2Ux+pzNqfBChoVo6MUvJIOgPYbPZ7LxFKlfroyunkVkUtZLmiQUvCjI7LG+Z3UVS0j9ONGZZINz8GwHXmdpLbWsotpwoGtBmKzLqvKGGkaO+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaadaOcz; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fb7c373416so11076827b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 12:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740082656; x=1740687456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j45ANHJHmXEa+7wHmOwfFdiw5PsrLY1dKuP334EQGk=;
        b=HaadaOcz+BPPSzOK6LNYlEojP4x6lnNR4yds6QOvJj42wK3EhNmb0rl+8raA95Cqmy
         gsH+kI42csQLnO08CWrxmjKJXYmcxQB1wE4PXebmV30c1i79SAzjEsH8HodqC/f0fu9t
         SGDFi0vF7Q7D3df6eeP+6I6/Xs1QXmHOaMl1Xqn89HI3YD1OT85MN18d6bC+P578jOAL
         anrZr8bNFuHQjDN9c5c+Lrrm0Vwkuamp+P3GDL6kvXvgraZpxibS9UPumCypv/g2CYhE
         uqurZ+CERWnDTe4tFxZRtptmfbVMQkGsmeksRvcDRcZx9YkW8iDGU+1agyLFSq7hKJrc
         RwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740082656; x=1740687456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0j45ANHJHmXEa+7wHmOwfFdiw5PsrLY1dKuP334EQGk=;
        b=IP2r39pbEKmGjZRPaYcgrVv57v2whXRGBVpWLAsvEN/xotsfnpKzbHMK1AbniE+JFI
         9LfxvZEaNpxvYPyynXuM9h2Z2EezN3O5oxD4BEuoDEjWHUrROpM25bzzxTKCpKzT3732
         zEagaz7brRQzhT/wsVFDEWGTs7RJ9gvHrdX/1C/omDVicEKToXL9fjsjvxM0joqSJVUV
         NXNoTf5/eawPfD5ztefjrJuKDO5PqHfvjm4nqTB36TGB/GngpTV+lmfhjgwpLAjsg1s7
         t/8n5UqbgDOFTeMlknVTsjQbUVg/WIWN3SZa3JHsD2XHGp0ReThnLembEBTtng2bDUlR
         CgdA==
X-Gm-Message-State: AOJu0Yyz2OS3pNhqXbQ5/xA5bg+kywT01wCVDdS6eBW9YrLn5t9mtm/5
	T4Bzdqs0t2aFOwO4ZRzabIPbWHSH1vpTnjwqyjwkirUlYSFPFnLzIl8mWg==
X-Gm-Gg: ASbGnctXA2Ev8pe2E0RZ02HU2iUdJHTmWUthSaaK8sDKXV71z4YkrR2M28CAwQeR/qs
	EUnuOcO6jzau41FJm5elzK1bwi+TMGo3iAwTJmH3SOk5ODfiOzAwngs5nVdSJlaWpXmJ1z6NH8I
	t+cBxPBWLm5oXO+0q4DfysTYymdi2MeSx4zUQVm7KUbpjG2FZJ5lOdcdKm0B6WXmdARTmSLvS35
	nOj/MRQLmCIvUzk46tHgWqwF34yAQwyhlzbgeDh+HwnYxbd8LaAtwXVgpokiFgpricZF+CCzmCb
	a4zLbGZJ+MaBSA==
X-Google-Smtp-Source: AGHT+IF76r9UslHzxfwOQqIdJGqMjLGHzKMCABicql/g5vOUYEIrB5YiGPdolFKN4wuzfKeDCD7ywg==
X-Received: by 2002:a05:690c:498b:b0:6f9:753a:519a with SMTP id 00721157ae682-6fbcc25e721mr4058687b3.17.1740082655939;
        Thu, 20 Feb 2025 12:17:35 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb7e496f15sm21450167b3.7.2025.02.20.12.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 12:17:35 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 2/2] fuse: use boolean bit-fields in struct fuse_copy_state
Date: Thu, 20 Feb 2025 12:16:59 -0800
Message-ID: <20250220201659.4058460-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250220201659.4058460-1-joannelkoong@gmail.com>
References: <20250220201659.4058460-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor struct fuse_copy_state to use boolean bit-fields to improve
clarity/readability and be consistent with other fuse structs that use
bit-fields for boolean state (eg fuse_fs_context, fuse_args).

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c        | 16 ++++++++--------
 fs/fuse/dev_uring.c  |  8 ++++----
 fs/fuse/fuse_dev_i.h |  8 ++++----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 2b2d1b755544..af11283861ea 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -705,7 +705,7 @@ static int unlock_request(struct fuse_req *req)
 	return err;
 }
 
-void fuse_copy_init(struct fuse_copy_state *cs, int write,
+void fuse_copy_init(struct fuse_copy_state *cs, bool write,
 		    struct iov_iter *iter)
 {
 	memset(cs, 0, sizeof(*cs));
@@ -1427,7 +1427,7 @@ static ssize_t fuse_dev_read(struct kiocb *iocb, struct iov_iter *to)
 	if (!user_backed_iter(to))
 		return -EINVAL;
 
-	fuse_copy_init(&cs, 1, to);
+	fuse_copy_init(&cs, true, to);
 
 	return fuse_dev_do_read(fud, file, &cs, iov_iter_count(to));
 }
@@ -1450,7 +1450,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
 	if (!bufs)
 		return -ENOMEM;
 
-	fuse_copy_init(&cs, 1, NULL);
+	fuse_copy_init(&cs, true, NULL);
 	cs.pipebufs = bufs;
 	cs.pipe = pipe;
 	ret = fuse_dev_do_read(fud, in, &cs, len);
@@ -1912,7 +1912,7 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 		       unsigned int size, struct fuse_copy_state *cs)
 {
 	/* Don't try to move pages (yet) */
-	cs->move_pages = 0;
+	cs->move_pages = false;
 
 	switch (code) {
 	case FUSE_NOTIFY_POLL:
@@ -2060,7 +2060,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	spin_unlock(&fpq->lock);
 	cs->req = req;
 	if (!req->args->page_replace)
-		cs->move_pages = 0;
+		cs->move_pages = false;
 
 	if (oh.error)
 		err = nbytes != sizeof(oh) ? -EINVAL : 0;
@@ -2098,7 +2098,7 @@ static ssize_t fuse_dev_write(struct kiocb *iocb, struct iov_iter *from)
 	if (!user_backed_iter(from))
 		return -EINVAL;
 
-	fuse_copy_init(&cs, 0, from);
+	fuse_copy_init(&cs, false, from);
 
 	return fuse_dev_do_write(fud, &cs, iov_iter_count(from));
 }
@@ -2173,13 +2173,13 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	}
 	pipe_unlock(pipe);
 
-	fuse_copy_init(&cs, 0, NULL);
+	fuse_copy_init(&cs, false, NULL);
 	cs.pipebufs = bufs;
 	cs.nr_segs = nbuf;
 	cs.pipe = pipe;
 
 	if (flags & SPLICE_F_MOVE)
-		cs.move_pages = 1;
+		cs.move_pages = true;
 
 	ret = fuse_dev_do_write(fud, &cs, len);
 
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index ebd2931b4f2a..26366316e5b8 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -551,8 +551,8 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	if (err)
 		return err;
 
-	fuse_copy_init(&cs, 0, &iter);
-	cs.is_uring = 1;
+	fuse_copy_init(&cs, false, &iter);
+	cs.is_uring = true;
 	cs.req = req;
 
 	return fuse_copy_out_args(&cs, args, ring_in_out.payload_sz);
@@ -581,8 +581,8 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		return err;
 	}
 
-	fuse_copy_init(&cs, 1, &iter);
-	cs.is_uring = 1;
+	fuse_copy_init(&cs, true, &iter);
+	cs.is_uring = true;
 	cs.req = req;
 
 	if (num_args > 0) {
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 6005919f1020..be38986fa2ce 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -29,9 +29,9 @@ struct fuse_copy_state {
 	struct page *pg;
 	unsigned int len;
 	unsigned int offset;
-	unsigned int write:1;
-	unsigned int move_pages:1;
-	unsigned int is_uring:1;
+	bool write:1;
+	bool move_pages:1;
+	bool is_uring:1;
 	struct {
 		unsigned int copied_sz; /* copied size into the user buffer */
 	} ring;
@@ -51,7 +51,7 @@ struct fuse_req *fuse_request_find(struct fuse_pqueue *fpq, u64 unique);
 
 void fuse_dev_end_requests(struct list_head *head);
 
-void fuse_copy_init(struct fuse_copy_state *cs, int write,
+void fuse_copy_init(struct fuse_copy_state *cs, bool write,
 			   struct iov_iter *iter);
 int fuse_copy_args(struct fuse_copy_state *cs, unsigned int numargs,
 		   unsigned int argpages, struct fuse_arg *args,
-- 
2.43.5


