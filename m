Return-Path: <linux-fsdevel+bounces-41317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A99A2DEB3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 16:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0135C1882B5F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 15:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D72D1DF756;
	Sun,  9 Feb 2025 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaJhklru"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974CD1CAA99
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Feb 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739113732; cv=none; b=mw7r/agPgq2JQiDqe9pk92ZMpJLGU1nOyNQFMHnhyOp0yvcJeiO/kk+AX7T6VNaAe62GUeP6k/WWsYU1jMvOzXbEWTrYZ5lTzSgW5nHAYQ05WKyIJcyBjGQygam5qGqInVlbFEWdvJNMK1PpTqdJkRYO9w1rzuTLPYB8gQmoGUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739113732; c=relaxed/simple;
	bh=3j7x4qb9+aqqiVdSCyBdk1Z4LwjXjaLTVNPhwIFVi4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p76EwlhBlTmmIV/Gf8jOqOGAD1jKkFnnZnqtfEY9ALEzDJHmwl7soXzRMAi3Bf0mtah+aUoTQuAs66ToMmxtkm/RloehHOmjXWiK8rjlvRgmFjiCIFK7JOyyrSnj3QMPR0Zv1gitTdU3wMYi4rxiKTRu8Ete9KodHt938lP7qZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaJhklru; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739113729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WKq/GoVu8AJXvVETTB0hWEI/zu4QQM8xp88r2RP6yp8=;
	b=LaJhklruEaxDXxK+F9nUkQsbf9MbpyWsuTyYtE695oDFJlQ4WZKNruZVdvL61+wIpbJSUE
	Lwb0DRtsC4/pQ/GcpmusoNAqT1gh30cNUB9/7Rs4hMZddwhvhRzUvn7S/246cuHVbvZQ9f
	202uGf93s7Db6SmF+LDjnUompfwsgOI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-9UA9-7n1O1-zziPgJBs_uw-1; Sun,
 09 Feb 2025 10:08:46 -0500
X-MC-Unique: 9UA9-7n1O1-zziPgJBs_uw-1
X-Mimecast-MFC-AGG-ID: 9UA9-7n1O1-zziPgJBs_uw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF7A319560AA;
	Sun,  9 Feb 2025 15:08:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1A76B180087D;
	Sun,  9 Feb 2025 15:08:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  9 Feb 2025 16:08:16 +0100 (CET)
Date: Sun, 9 Feb 2025 16:08:11 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Oliver Sang <oliver.sang@intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] splice: add some pipe_buf_assert_len() checks
Message-ID: <20250209150811.GB16999@redhat.com>
References: <20250209150718.GA17013@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209150718.GA17013@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

After the previous patch the readers can't (hopefully) hit a zero-sized
buffer, add a few pipe_buf_assert_len() debugging checks.

pipe_buf_assert_len() can probably have more users, including the writers
which update pipe->head.

While at it, simplify eat_empty_buffer(), it can use pipe_buf(pipe->tail).

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/splice.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 28cfa63aa236..fb7841c07edd 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -453,7 +453,7 @@ static int splice_from_pipe_feed(struct pipe_inode_info *pipe, struct splice_des
 	while (!pipe_empty(head, tail)) {
 		struct pipe_buffer *buf = &pipe->bufs[tail & mask];
 
-		sd->len = buf->len;
+		sd->len = pipe_buf_assert_len(buf);
 		if (sd->len > sd->total_len)
 			sd->len = sd->total_len;
 
@@ -494,13 +494,11 @@ static int splice_from_pipe_feed(struct pipe_inode_info *pipe, struct splice_des
 /* We know we have a pipe buffer, but maybe it's empty? */
 static inline bool eat_empty_buffer(struct pipe_inode_info *pipe)
 {
-	unsigned int tail = pipe->tail;
-	unsigned int mask = pipe->ring_size - 1;
-	struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+	struct pipe_buffer *buf = pipe_buf(pipe, pipe->tail);
 
-	if (unlikely(!buf->len)) {
+	if (unlikely(!pipe_buf_assert_len(buf))) {
 		pipe_buf_release(pipe, buf);
-		pipe->tail = tail+1;
+		pipe->tail++;
 		return true;
 	}
 
@@ -717,7 +715,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		left = sd.total_len;
 		for (n = 0; !pipe_empty(head, tail) && left && n < nbufs; tail++) {
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
-			size_t this_len = buf->len;
+			size_t this_len = pipe_buf_assert_len(buf);
 
 			/* zero-length bvecs are not supported, skip them */
 			if (!this_len)
@@ -852,7 +850,7 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
 			size_t seg;
 
-			if (!buf->len) {
+			if (!pipe_buf_assert_len(buf)) {
 				tail++;
 				continue;
 			}
-- 
2.25.1.362.g51ebf55



