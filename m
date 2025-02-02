Return-Path: <linux-fsdevel+bounces-40550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC03CA24F11
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 18:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF791884B3F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 17:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E69D1FAC37;
	Sun,  2 Feb 2025 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iez53JRP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159961D5CD4
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Feb 2025 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738515732; cv=none; b=jjQep5QsloMPq7J6GcAwHrqRWV2cEyj7B2TKrMEe3mrUoQarAzahg4BABHc6RgWdzmG+fconNJz1wF1/zWY+GephNEViwP46wUiz3V4KMaSYewnw0an46JWxxdD+zTath9MjQwLioEhoWOK9iFeH4CM7LBU4We0ROAN5PZTwQ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738515732; c=relaxed/simple;
	bh=rSWIKoQZ2zuwcHermro882dMGxec3JUJOfSJ3leotTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+vXjaSWI1jMmFPpZcoFvrhlPEIIH7jSYtaoIkuN3YIkDxcLWf3r7epUIe9ndqCjGceXo0sBje7ohQCLef/3i909JwlljtnZ69kgLAd5Wpa0742SmhO6EYKTz9UG01VRCfhkDrDiMKqJs5KaBpKi92vOGXCGljLdai6G0QVmFuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iez53JRP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738515729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2bqVTTyCih6LeAwQq4LvjVnDUBe5ojk58vB3lfkM+MQ=;
	b=iez53JRPraQ+Dx/LUCwX+BtBgLi+cEOL6b9L1of06SO9Tmq9/VV4dpYJr+MHswpWQBearM
	sYwdsP0s2p+iSCQRMNVc7Huq2UId5wb/6MkhArqvjavGAx/VGo1DpDtbUhytwSdOnd4ett
	hGI5DA3jEJ7pzenUb9wPYEPRa6zUHrE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-onIMVji9NvKv4cvSsuRhJQ-1; Sun,
 02 Feb 2025 12:02:05 -0500
X-MC-Unique: onIMVji9NvKv4cvSsuRhJQ-1
X-Mimecast-MFC-AGG-ID: onIMVji9NvKv4cvSsuRhJQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5EF2195608A;
	Sun,  2 Feb 2025 17:02:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9257419560A3;
	Sun,  2 Feb 2025 17:01:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  2 Feb 2025 18:01:37 +0100 (CET)
Date: Sun, 2 Feb 2025 18:01:32 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250202170131.GA6507@redhat.com>
References: <20250102140715.GA7091@redhat.com>
 <3170d16e-eb67-4db8-a327-eb8188397fdb@amd.com>
 <CAHk-=wioaHG2P0KH=1zP0Zy=CcQb_JxZrksSS2+-FwcptHtntw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wioaHG2P0KH=1zP0Zy=CcQb_JxZrksSS2+-FwcptHtntw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 01/31, Linus Torvalds wrote:
>
> On Fri, 31 Jan 2025 at 01:50, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> >
> > On my 3rd Generation EPYC system (2 x 64C/128T), I see that on reverting
> > the changes on the above mentioned commit, sched-messaging sees a
> > regression up until the 8 group case which contains 320 tasks, however
> > with 16 groups (640 tasks), the revert helps with performance.
>
> I suspect that the extra wakeups just end up perturbing timing, and
> then you just randomly get better performance on that particular
> test-case and machine.
>
> I'm not sure this is worth worrying about, unless there's a real load
> somewhere that shows this regression.

Well yes, but the problem is that people seem to believe that hackbench
is the "real" workload, even in the "overloaded" case...

And if we do care about performance... Could you look at the trivial patch
at the end? I don't think {a,c,m}time make any sense in the !fifo case, but
as you explained before they are visible to fstat() so we probably shouldn't
remove file_accessed/file_update_time unconditionally.

This patch does help if I change hackbench to uses pipe2(O_NOATIME) instead
of pipe(). And in fact it helps even in the simplest case:

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
		int fd[2], nb = 1, noat, loop, size;

		assert(argc == 4);
		noat = atoi(argv[1]) ? O_NOATIME : 0;
		loop = atoi(argv[2]);
		size = atoi(argv[3]);

		assert(pipe2(fd, noat) == 0);
		assert(ioctl(fd[0], FIONBIO, &nb) == 0);
		assert(ioctl(fd[1], FIONBIO, &nb) == 0);

		assert(size <= sizeof(buf));
		while (loop--)
			assert(wr(fd[1], size) == rd(fd[0], size));

		printf("TW = %lu.%03lu\n", TW.tv_sec, TW.tv_usec/1000);
		printf("TR = %lu.%03lu\n", TR.tv_sec, TR.tv_usec/1000);

		return 0;
	}


Now,

	/# for i in 1 2 3; do /host/tmp/test 0 10000 100; done
	TW = 7.692
	TR = 5.704
	TW = 7.930
	TR = 5.858
	TW = 7.685
	TR = 5.697
	/#
	/# for i in 1 2 3; do /host/tmp/test 1 10000 100; done
	TW = 6.432
	TR = 4.533
	TW = 6.612
	TR = 4.638
	TW = 6.409
	TR = 4.523

Oleg.
---

diff --git a/fs/pipe.c b/fs/pipe.c
index a3f5fd7256e9..14b2c0f8b616 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1122,6 +1122,9 @@ int create_pipe_files(struct file **res, int flags)
 		}
 	}
 
+	if (flags & O_NOATIME)
+		inode->i_flags |= S_NOCMTIME;
+
 	f = alloc_file_pseudo(inode, pipe_mnt, "",
 				O_WRONLY | (flags & (O_NONBLOCK | O_DIRECT)),
 				&pipefifo_fops);
@@ -1134,7 +1137,7 @@ int create_pipe_files(struct file **res, int flags)
 	f->private_data = inode->i_pipe;
 	f->f_pipe = 0;
 
-	res[0] = alloc_file_clone(f, O_RDONLY | (flags & O_NONBLOCK),
+	res[0] = alloc_file_clone(f, O_RDONLY | (flags & (O_NONBLOCK | O_NOATIME)),
 				  &pipefifo_fops);
 	if (IS_ERR(res[0])) {
 		put_pipe_info(inode, inode->i_pipe);
@@ -1154,7 +1157,7 @@ static int __do_pipe_flags(int *fd, struct file **files, int flags)
 	int error;
 	int fdw, fdr;
 
-	if (flags & ~(O_CLOEXEC | O_NONBLOCK | O_DIRECT | O_NOTIFICATION_PIPE))
+	if (flags & ~(O_CLOEXEC | O_NONBLOCK | O_DIRECT | O_NOATIME | O_NOTIFICATION_PIPE))
 		return -EINVAL;
 
 	error = create_pipe_files(files, flags);


