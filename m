Return-Path: <linux-fsdevel+bounces-40927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D46BA29501
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 16:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 612F37A5FBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 15:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C67192598;
	Wed,  5 Feb 2025 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvXzj7vL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF65019F121
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738769670; cv=none; b=Cq076Oz+2I8TzfWwffeWYSXtOVW/q1kjlycd1lao3sQz1gNllE8WndY8YtmOSWV9PexHuy11+i+CnKIZv1fTTGhxMLdVkIha+EW1CHje+GLXLdM2iyfkEt/y3JQX6F3/TbQSUTy7wlNWxDNU1QJS3Zg9LfssQjfyQ0BIErCdACw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738769670; c=relaxed/simple;
	bh=NkwVJuFwbmro6D09UcQWrrhpAKhpU7MvCrQQ5WiccZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6V0ptWypqycb11M+sAw9bfu7ahNHA0G9a7lP1R+kr5H2VyTkwTx9o0dgMbrA/s0VwgPYivPwkVhWY0IdYFuiE4TEimsGjtYpPZYhnFm87SHg2uQJ8+mYtKOeu8slt7/01OMDlOwY0odmMpNXySb+lgyiQJ6PMUO4piOY2EWpTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvXzj7vL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738769667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xqTAo0pAonNELM7F6v+5zbpfquf/T3IQ8Tjo6CWKfSs=;
	b=gvXzj7vLxVItM+YYVhLX3xlkkVtEgPmZF9GRvQuxrDHkSxdL3qt2KOPE0JdchIGAiO48ex
	XROAPaXmhBRJu+IWZLB/l+nbYhhVl+eAMUdMGqNdC1h9/lPv6lJCLYs08+RyNq5cOXbiPb
	QoA/PJv4zfDLa5Hfl88iCXTMfcnbUVo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-HSPirgIcOv-MKHOB_Gj_eg-1; Wed,
 05 Feb 2025 10:34:26 -0500
X-MC-Unique: HSPirgIcOv-MKHOB_Gj_eg-1
X-Mimecast-MFC-AGG-ID: HSPirgIcOv-MKHOB_Gj_eg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23BCD180087A;
	Wed,  5 Feb 2025 15:34:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.10])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4ED361800570;
	Wed,  5 Feb 2025 15:34:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Feb 2025 16:33:57 +0100 (CET)
Date: Wed, 5 Feb 2025 16:33:51 +0100
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
Subject: [PATCH v2 2/2] pipe: don't update {a,c,m}time for anonymous pipes
Message-ID: <20250205153351.GB2255@redhat.com>
References: <20250205153302.GA2216@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205153302.GA2216@redhat.com>
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
index b05cded28d9b..e772637c622c 100644
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
@@ -1232,8 +1249,8 @@ static int fifo_open(struct inode *inode, struct file *filp)
 
 const struct file_operations pipefifo_fops = {
 	.open		= fifo_open,
-	.read_iter	= pipe_read,
-	.write_iter	= pipe_write,
+	.read_iter	= fifo_pipe_read,
+	.write_iter	= fifo_pipe_write,
 	.poll		= pipe_poll,
 	.unlocked_ioctl	= pipe_ioctl,
 	.release	= pipe_release,
@@ -1243,8 +1260,8 @@ const struct file_operations pipefifo_fops = {
 
 const struct file_operations pipeanon_fops = {
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



