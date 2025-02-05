Return-Path: <linux-fsdevel+bounces-40954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ED3A29898
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09753166226
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 18:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034F01FC7EA;
	Wed,  5 Feb 2025 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/LHoV1t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA91779AE
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779533; cv=none; b=X6faxzWnXJH4YME7yMTw+5Q2IhlMXsLpFfbrsld2sxd1u3fP8xrcKhcZOSV6Qoad57mhF66/wGTO1RxpVVsSVDNRHCGr7vwpC/3PaHCwvIIE/n9Y9yeSaTvZRA3AkkydZDnWq7p+8fVVvdXLQUu19is1TWlyNYpZpKtXspXpuhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779533; c=relaxed/simple;
	bh=McltsGuhrdjKSLzYSZ2RB5cGI/ob/Aq3P+nHQ5SQmI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdVMUCJMxqgF4mfs2U4ROY8Zepy3DgwPF2zweBCpEdFRWJfTeQFDXU6nLC6c4FJhjfloCvo9hvc9azGyGShRe5ORbgWZqlUizB8kf49pJUObJJzp7/116Y686DZLcGp5xCZw1VSKEJICbDHGImtCRm0giZsVheHLAZI5OLKjy+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/LHoV1t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738779530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAZPH6LoBdfmC4eKY2rMSg24boi4M+z/rfTpR2/KoTE=;
	b=J/LHoV1tJWcupIYoFq6a3uY4t1fCOdMdMUzl8W3DYo1rg09DV9s+CJpDysTKdHd+0o62YN
	qsOoZnjgpHelrtEePM6dk2R2Z0zOeef/hVYQpm1mO8r3Lq9HF5a22y74LAcAZ7o69OOdYH
	13/FjDurol8x748Z/pMvcp+E5euvNsA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-eyRvOxkLMm-K86gnIv0iOQ-1; Wed,
 05 Feb 2025 13:18:47 -0500
X-MC-Unique: eyRvOxkLMm-K86gnIv0iOQ-1
X-Mimecast-MFC-AGG-ID: eyRvOxkLMm-K86gnIv0iOQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D59A180087B;
	Wed,  5 Feb 2025 18:18:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.10])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8DD721800265;
	Wed,  5 Feb 2025 18:18:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Feb 2025 19:18:18 +0100 (CET)
Date: Wed, 5 Feb 2025 19:18:12 +0100
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
Subject: [PATCH v3 2/2] pipe: don't update {a,c,m}time for anonymous pipes
Message-ID: <20250205181812.GC13817@redhat.com>
References: <20250205181716.GA13817@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205181716.GA13817@redhat.com>
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
 fs/pipe.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 2eacfde61e74..2ae75adfba64 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -248,7 +248,7 @@ static inline unsigned int pipe_update_tail(struct pipe_inode_info *pipe,
 }
 
 static ssize_t
-pipe_read(struct kiocb *iocb, struct iov_iter *to)
+anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	size_t total_len = iov_iter_count(to);
 	struct file *filp = iocb->ki_filp;
@@ -404,8 +404,15 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	if (wake_next_reader)
 		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 	kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
+	return ret;
+}
+
+static ssize_t
+fifo_pipe_read(struct kiocb *iocb, struct iov_iter *to)
+{
+	int ret = anon_pipe_read(iocb, to);
 	if (ret > 0)
-		file_accessed(filp);
+		file_accessed(iocb->ki_filp);
 	return ret;
 }
 
@@ -426,7 +433,7 @@ static inline bool pipe_writable(const struct pipe_inode_info *pipe)
 }
 
 static ssize_t
-pipe_write(struct kiocb *iocb, struct iov_iter *from)
+anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *filp = iocb->ki_filp;
 	struct pipe_inode_info *pipe = filp->private_data;
@@ -604,11 +611,21 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 	if (wake_next_writer)
 		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
-	if (ret > 0 && sb_start_write_trylock(file_inode(filp)->i_sb)) {
-		int err = file_update_time(filp);
-		if (err)
-			ret = err;
-		sb_end_write(file_inode(filp)->i_sb);
+	return ret;
+}
+
+static ssize_t
+fifo_pipe_write(struct kiocb *iocb, struct iov_iter *from)
+{
+	int ret = anon_pipe_write(iocb, from);
+	if (ret > 0) {
+		struct file *filp = iocb->ki_filp;
+		if (sb_start_write_trylock(file_inode(filp)->i_sb)) {
+			int err = file_update_time(filp);
+			if (err)
+				ret = err;
+			sb_end_write(file_inode(filp)->i_sb);
+		}
 	}
 	return ret;
 }
@@ -1234,8 +1251,8 @@ static int fifo_open(struct inode *inode, struct file *filp)
 
 const struct file_operations pipefifo_fops = {
 	.open		= fifo_open,
-	.read_iter	= pipe_read,
-	.write_iter	= pipe_write,
+	.read_iter	= fifo_pipe_read,
+	.write_iter	= fifo_pipe_write,
 	.poll		= pipe_poll,
 	.unlocked_ioctl	= pipe_ioctl,
 	.release	= pipe_release,
@@ -1245,8 +1262,8 @@ const struct file_operations pipefifo_fops = {
 
 static const struct file_operations pipeanon_fops = {
 	.open		= fifo_open,
-	.read_iter	= pipe_read,
-	.write_iter	= pipe_write,
+	.read_iter	= anon_pipe_read,
+	.write_iter	= anon_pipe_write,
 	.poll		= pipe_poll,
 	.unlocked_ioctl	= pipe_ioctl,
 	.release	= pipe_release,
-- 
2.25.1.362.g51ebf55



