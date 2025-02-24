Return-Path: <linux-fsdevel+bounces-42417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E66A422ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 325AE7A8DAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E215E13AA2D;
	Mon, 24 Feb 2025 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXCDRzoH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC741386B4
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407116; cv=none; b=pnygIDhpRMBWINIJ7Zd2alOuXlKzF2/a0C+MCiRA74Gf3cPAyoBGN7qay4mskNZYTeV/VndnDgEl8U/1hfsJo0yJISaLjcjQUt4zQR8AtVeYRErpdgEUeADnG7FICdguaSnYCbA+PvZkFH8bDiOxIRvWN3Zz/xOiak73sf/y2hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407116; c=relaxed/simple;
	bh=Sq1Y8IC+TkK16PhjzgHqjuFsB8AmqFLAL13Hhk9ypkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQyKiP8RkxE1COHqQscKm9ajQaQppMC60OUCGjG2FkkgpPlbtF810o8lyzeQIRnqTXgGJPmClmJUp5f4c1JdOeIsRj4404t9WpeVlpVjVRO12UuF9AwK1lJscYxZOLzfaHuWCHd6db4iTkozFabdUdRDzZWqDqJwLwQV76h08Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXCDRzoH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740407113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7UueaCy/3NVQVw6UzkkNyuSPosg3+jMEY4vs1dTQYlM=;
	b=OXCDRzoH25ShewC8E1qa2uI/RRjsSjJleb+3rthYUMD+Gan8PlXAlZ0GuDd7aCQqvstaOh
	ADbK681p6wNInHUeEQX4m2w4FMAioNVrrf8qxCk0adO1JuM7hyP9W8bdmP8mv1Q2JDIwkf
	7A1pKOFCibvC1hN4LV1wH+MA4dNe0MI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-B57fuXfIM2K22U8Gqgj2jg-1; Mon,
 24 Feb 2025 09:25:08 -0500
X-MC-Unique: B57fuXfIM2K22U8Gqgj2jg-1
X-Mimecast-MFC-AGG-ID: B57fuXfIM2K22U8Gqgj2jg_1740407107
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D317A19783B7;
	Mon, 24 Feb 2025 14:25:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.142])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CE57319560AA;
	Mon, 24 Feb 2025 14:25:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 24 Feb 2025 15:24:37 +0100 (CET)
Date: Mon, 24 Feb 2025 15:24:32 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
Cc: Manfred Spraul <manfred@colorfullife.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250224142329.GA19016@redhat.com>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Sapkal,

On 02/24, Sapkal, Swapnil wrote:
>
> We saw hang in hackbench in our weekly regression testing on mainline
> kernel. The bisect pointed to this commit.

OMG. This patch caused a lot of "hackbench performance degradation" reports,
but hang??

Just in case, did you use

	https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/hackbench/hackbench.c

?

OK, I gave up ;) I'll send the revert patch tomorrow (can't do this today)
even if I still don't see how this patch can be wrong.

> Whenever I compare the case where was_full would have been set but
> wake_writer was not set, I see the following pattern:
>
> ret = 100 (Read was successful)
> pipe_full() = 1
> total_len = 0
> buf->len != 0
>
> total_len is computed using iov_iter_count() while the buf->len is the
> length of the buffer corresponding to tail(pipe->bufs[tail & mask].len).
> Looking at pipe_write(), there seems to be a case where the writer can make
> progress when (chars && !was_empty) which only looks at iov_iter_count().
> Could it be the case that there is still room in the buffer but we are not
> waking up the writer?

I don't think so, but perhaps I am totally confused.

If the writer sleeps on pipe->wr_wait, it has already tried to write into
the pipe->bufs[head - 1] buffer before the sleep.

Yes, the reader can read from that buffer, but this won't make it more "writable"
for this particular writer, "PAGE_SIZE - buf->offset + buf->len" won't be changed.
I even wrote the test-case, let me quote my old email below.

Thanks,

Oleg.
--------------------------------------------------------------------------------

Meanwhile I wrote a stupid test-case below.

Without the patch

	State:	S (sleeping)
	voluntary_ctxt_switches:	74
	nonvoluntary_ctxt_switches:	5
	State:	S (sleeping)
	voluntary_ctxt_switches:	4169
	nonvoluntary_ctxt_switches:	5
	finally release the buffer
	wrote next char!

With the patch

	State:	S (sleeping)
	voluntary_ctxt_switches:	74
	nonvoluntary_ctxt_switches:	3
	State:	S (sleeping)
	voluntary_ctxt_switches:	74
	nonvoluntary_ctxt_switches:	3
	finally release the buffer
	wrote next char!

As you can see, without this patch pipe_read() wakes the writer up
4095 times for no reason, the writer burns a bit of CPU and blocks
again after wakeup until the last read(fd[0], &c, 1).

Oleg.

-------------------------------------------------------------------------------
#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <errno.h>

int main(void)
{
	int fd[2], nb, cnt;
	char cmd[1024], c;

	assert(pipe(fd) == 0);

	nb = 1; assert(ioctl(fd[1], FIONBIO, &nb) == 0);
	while (write(fd[1], &c, 1) == 1);
	assert(errno = -EAGAIN);
	nb = 0; assert(ioctl(fd[1], FIONBIO, &nb) == 0);

	// The pipe is full, the next write() will block.

	sprintf(cmd, "grep -e State -e ctxt_switches /proc/%d/status", getpid());

	if (!fork()) {
		// wait until the parent sleeps in pipe_write()
		usleep(10000);

		system(cmd);
		// trigger 4095 unnecessary wakeups
		for (cnt = 0; cnt < 4095; ++cnt) {
			assert(read(fd[0], &c, 1) == 1);
			usleep(1000);
		}
		system(cmd);

		// this should actually wake the writer
		printf("finally release the buffer\n");
		assert(read(fd[0], &c, 1) == 1);
		return 0;
	}

	assert(write(fd[1], &c, 1) == 1);
	printf("wrote next char!\n");

	return 0;
}


