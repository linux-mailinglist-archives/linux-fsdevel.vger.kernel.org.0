Return-Path: <linux-fsdevel+bounces-40747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAAEA27327
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 14:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7192D161F6A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665752153DD;
	Tue,  4 Feb 2025 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YR+TI5J/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3481C212D6D
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675354; cv=none; b=A2D818M7ldeBgpXe/h0FAFbRO39eWX0dZz5kN6UFUHtIL8rB4To7WcakLwpd9y14nBLBSI3iqNVtguTQ3E17CA3//vdJ+WRqGqXqqOw7qVZHQEqSmNcZjVExmsDuYHl4tjUY3GshjmyLRFSqY7HyYUri4MFAgO5SYAkIzmIXE2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675354; c=relaxed/simple;
	bh=/RNQWEzfAvswoGmjk8nGWVqXmQV3CoAfw1ORFAPGdCA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AiKWzPvu5u2DQe12NRk9BIBjkf6gQTPtZLFCVL03JCLOQSVrV2sSb1X1NNFr6EBN/7lywRNsHgWKJ3C+t6fCEXGFLPRX3WXr9pD9HQ1wHx9/NTEQDMIdon3+iZyLfN/r+3+WXoy6wtXoK5WhBqJ9t3Yf+7XkSftSIDstEyYKCqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YR+TI5J/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738675352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=+003+UEJK+ptm6WSi1sJYGwRN/uUQPknFmu3AzEdpbw=;
	b=YR+TI5J/B6aRDBiUFp/ITb66xEOZdKyrxfEmInuxblgd80v/rAmRClYmTwWeVwGUV4flmu
	h9vEkQUL3yuO6WWZkSayvY4A8iwvsogmOrE3RODTj0TSNx7ncbbNPEqhxtQPGs7lTbQ70b
	4iAwrksSg+ZSwGOgylKUr0F1NUiublk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-wdKZ8D01M5m8qd40Bs_d2Q-1; Tue,
 04 Feb 2025 08:22:27 -0500
X-MC-Unique: wdKZ8D01M5m8qd40Bs_d2Q-1
X-Mimecast-MFC-AGG-ID: wdKZ8D01M5m8qd40Bs_d2Q
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AD7B19560B4;
	Tue,  4 Feb 2025 13:22:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.72])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AE7381800268;
	Tue,  4 Feb 2025 13:22:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  4 Feb 2025 14:21:59 +0100 (CET)
Date: Tue, 4 Feb 2025 14:21:53 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
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
Subject: [PATCH] pipe: don't update {a,c,m}time for anonymous pipes
Message-ID: <20250204132153.GA20921@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

These numbers are visible in fstat() but hopefully nobody uses this
information and file_accessed/file_update_time are not that cheap.
Stupid test-case:

	#include <stdio.h>
	#include <stdlib.h>
	#include <unistd.h>
	#include <assert.h>
	#include <sys/ioctl.h>
	#include <sys/time.h>

	static char buf[17 * 4096];
	static struct timeval TW, TR;

	int wr(int fd, int size)
	{
		int c, r;
		struct timeval t0, t1;

		gettimeofday(&t0, NULL);
		for (c = 0; (r = write(fd, buf, size)) > 0; c += r);
		gettimeofday(&t1, NULL);
		timeradd(&TW, &t1, &TW);
		timersub(&TW, &t0, &TW);

		return c;
	}

	int rd(int fd, int size)
	{
		int c, r;
		struct timeval t0, t1;

		gettimeofday(&t0, NULL);
		for (c = 0; (r = read(fd, buf, size)) > 0; c += r);
		gettimeofday(&t1, NULL);
		timeradd(&TR, &t1, &TR);
		timersub(&TR, &t0, &TR);

		return c;
	}

	int main(int argc, const char *argv[])
	{
		int fd[2], nb = 1, loop, size;

		assert(argc == 3);
		loop = atoi(argv[1]);
		size = atoi(argv[2]);

		assert(pipe(fd) == 0);
		assert(ioctl(fd[0], FIONBIO, &nb) == 0);
		assert(ioctl(fd[1], FIONBIO, &nb) == 0);

		assert(size <= sizeof(buf));
		while (loop--)
			assert(wr(fd[1], size) == rd(fd[0], size));

		struct timeval tt;
		timeradd(&TW, &TR, &tt);
		printf("TW = %lu.%03lu TR = %lu.%03lu TT = %lu.%03lu\n",
			TW.tv_sec, TW.tv_usec/1000,
			TR.tv_sec, TR.tv_usec/1000,
			tt.tv_sec, tt.tv_usec/1000);

		return 0;
	}

Before:
	# for i in 1 2 3; do /host/tmp/test 10000 100; done
	TW = 8.047 TR = 5.845 TT = 13.893
	TW = 8.091 TR = 5.872 TT = 13.963
	TW = 8.083 TR = 5.885 TT = 13.969
After:
	# for i in 1 2 3; do /host/tmp/test 10000 100; done
	TW = 4.752 TR = 4.664 TT = 9.416
	TW = 4.684 TR = 4.608 TT = 9.293
	TW = 4.736 TR = 4.652 TT = 9.388

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/pipe.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 94b59045ab44..baaa8c0817f1 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -247,6 +247,11 @@ static inline unsigned int pipe_update_tail(struct pipe_inode_info *pipe,
 	return tail;
 }
 
+static inline bool is_pipe_inode(struct inode *inode)
+{
+	return inode->i_sb->s_magic == PIPEFS_MAGIC;
+}
+
 static ssize_t
 pipe_read(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -404,7 +409,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	if (wake_next_reader)
 		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 	kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
-	if (ret > 0)
+	if (ret > 0 && !is_pipe_inode(file_inode(filp)))
 		file_accessed(filp);
 	return ret;
 }
@@ -604,11 +609,13 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 	if (wake_next_writer)
 		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
-	if (ret > 0 && sb_start_write_trylock(file_inode(filp)->i_sb)) {
-		int err = file_update_time(filp);
-		if (err)
-			ret = err;
-		sb_end_write(file_inode(filp)->i_sb);
+	if (ret > 0 && !is_pipe_inode(file_inode(filp))) {
+		if (sb_start_write_trylock(file_inode(filp)->i_sb)) {
+			int err = file_update_time(filp);
+			if (err)
+				ret = err;
+			sb_end_write(file_inode(filp)->i_sb);
+		}
 	}
 	return ret;
 }
@@ -1108,7 +1115,7 @@ static void wake_up_partner(struct pipe_inode_info *pipe)
 static int fifo_open(struct inode *inode, struct file *filp)
 {
 	struct pipe_inode_info *pipe;
-	bool is_pipe = inode->i_sb->s_magic == PIPEFS_MAGIC;
+	bool is_pipe = is_pipe_inode(inode);
 	int ret;
 
 	filp->f_pipe = 0;
-- 
2.25.1.362.g51ebf55



