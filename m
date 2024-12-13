Return-Path: <linux-fsdevel+bounces-37298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C5F9F0DE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA9C1886A5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916611E47C5;
	Fri, 13 Dec 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3sIVsAu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538391E3DE3
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097874; cv=none; b=RJ5JK9ZBLKN0gu0zhDVohAycfFL8E2LliIYIy4UX2HjZStQbviKpfQUiMSllAzQGcXDeUZQ5aEtIJGDm1/mSN+fQ41vnSQmvN4ycVv0EOaLvvf7NziemkDnTbNYsxlzGmy+wDWg+Yp57/1QhxsvttwL3CIs7D8s9zziWrQRJsxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097874; c=relaxed/simple;
	bh=uaeI9J7rEoRhi5ZksmwE/88jFR1W/T6sdc10RyCTsN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlYQoKvbrTm8T7qOrSzCmeEau+kYHWNAw4opmHFGq3MxCb6sTt2enaxX6qynu4GeeXg4DPyI7eVldaUwLPxT52AeZbPe2ssExFwDwejIplvIPTt8cB5gGPfShnZ1h9eq/NOY++Hzyjj6xd8zJZdqsaxTImkdVVVpr5j3GiR3XGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3sIVsAu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dahqI5gLkGfD05TuY+PqQn3pxJDwXGZGfLY3MOFYgVE=;
	b=R3sIVsAugDExB77D/kRmr7Bn6ZLuwbpIOP+iHDMl0apxDCVIeS3cAcxplaZXouyIjh5CRz
	tWlr4/kJ7Zymn/9zxOTlWyLiuPR3v99EeexhSc8Go+LulBLGDYjfwHYomBjzaH1wTrt7vp
	r/9L1ElMIjRwebB6/FSh/E3UwfrOQKQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-NQm--YxLM0SK64NOpZx29g-1; Fri,
 13 Dec 2024 08:51:06 -0500
X-MC-Unique: NQm--YxLM0SK64NOpZx29g-1
X-Mimecast-MFC-AGG-ID: NQm--YxLM0SK64NOpZx29g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E4CD19560B5;
	Fri, 13 Dec 2024 13:51:02 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 058071955F40;
	Fri, 13 Dec 2024 13:50:56 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 06/10] netfs: Remove redundant use of smp_rmb()
Date: Fri, 13 Dec 2024 13:50:06 +0000
Message-ID: <20241213135013.2964079-7-dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-1-dhowells@redhat.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Zilin Guan <zilin@seu.edu.cn>

The function netfs_unbuffered_write_iter_locked() in
fs/netfs/direct_write.c contains an unnecessary smp_rmb() call after
wait_on_bit(). Since wait_on_bit() already incorporates a memory barrier
that ensures the flag update is visible before the function returns, the
smp_rmb() provides no additional benefit and incurs unnecessary overhead.

This patch removes the redundant barrier to simplify and optimize the code.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Akira Yokosawa <akiyks@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20241207021952.2978530-1-zilin@seu.edu.cn/
---
 fs/netfs/direct_write.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 88f2adfab75e..173e8b5e6a93 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -104,7 +104,6 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 		trace_netfs_rreq(wreq, netfs_rreq_trace_wait_ip);
 		wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
 			    TASK_UNINTERRUPTIBLE);
-		smp_rmb(); /* Read error/transferred after RIP flag */
 		ret = wreq->error;
 		if (ret == 0) {
 			ret = wreq->transferred;


