Return-Path: <linux-fsdevel+bounces-63614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65624BC636A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 19:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE9B3AD5C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 17:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD0B2BFC60;
	Wed,  8 Oct 2025 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vGFFB0PK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6651FFC48
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759946107; cv=none; b=jv7n4jV/l8lQG9AzFF+3PQpLYMKRP3t2rqppaJ5ulQrG1bVtARIXpXaE4ddhfOwq/SHQh8mM6Uz26DvsycWZXASydgvQ51dnL6pJTt9DYeHVN2wNTO4en1prdFqjugZGymwNXj3Zl2s7rbPOvU+crq/SjQpLxgQA6pVIGdu1u/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759946107; c=relaxed/simple;
	bh=u2DpBaXRZ7mJGKPOLy4KCBidsT0cH9E/K3CtFwps7PY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nq1VNEBG6uNclPS2/2KGkOn5+ECBDWddYOgXIcP4P0XpQ14y9IGFEVoa+qak2toD5465W/+/bqAuxSg+Gbq1clFmBOQu0JfkOfZjiJAbHEDEB/+Z/t+OlsWzIHuMMHLFqERfIgR5HMzTYIjBymdtGKJXbUpHN2Qs45i/3g9FNxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vGFFB0PK; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 8 Oct 2025 13:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759946090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=8qejHQWaI1fXqm3UnNSaY0lJza2hZ2urX7Ww1ERGZSs=;
	b=vGFFB0PKV1J9K7MEq/jCj2J0UL5M8a9+avSZ2Efag3dp+uJpYDjd0p7h5wBJeZ6hi6vlBl
	BMC5m3Z/kDpkZaWp4GQLwjSkz2JQiogiTZL94rT06wXh42Aecdqjw7kDypGcmLzxQpxPD8
	/j5oooQ/GbNQblraNYCvuzorG+kZYsQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: v9fs@lists.linux.dev, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>
Subject: -ENODATA from read syscall on 9p
Message-ID: <hexeb4tmfqsugdy442mkkomevnhjzpuwtsslypeo3lnbbtmpmk@ibrapupausp7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

So I recently rebased my xfstests branch and started seeing quite the
strange test failures:

00891     +cat: /ktest-out/xfstests/generic/036.dmesg: No data available

No idea why a userspace update would expose this, it's a kernel bug - in
the main netfs/9p read path, no less. Upon further investigation, cat is
indeed receiving -ENODATA from a read syscall.

No, read(2) is not allowed to return -ENODATA...

Upon further investigation, the error is generated in
netfs_read_subreq_terminated():

netfs_wait_for_in_progress (rreq=rreq@entry=0xffff8881032f3980, collector=0xffffffff81542240 <netfs_read_collection>) at /home/kent/linux/fs/netfs/misc.c:468
468             BUG_ON(ret == -ENODATA);
(gdb) bt
#0  netfs_wait_for_in_progress (rreq=rreq@entry=0xffff8881032f3980, collector=0xffffffff81542240 <netfs_read_collection>) at /home/kent/linux/fs/netfs/misc.c:468
#1  0xffffffff815412f5 in netfs_wait_for_read (rreq=rreq@entry=0xffff8881032f3980) at /home/kent/linux/fs/netfs/misc.c:492
#2  0xffffffff8153ca41 in netfs_unbuffered_read (rreq=0xffff8881032f3980, sync=<optimized out>) at /home/kent/linux/fs/netfs/direct_read.c:153
#3  netfs_unbuffered_read_iter_locked (iocb=iocb@entry=0xffffc90003a17e98, iter=iter@entry=0xffffc90003a17e70) at /home/kent/linux/fs/netfs/direct_read.c:234
#4  0xffffffff8153cb25 in netfs_unbuffered_read_iter (iocb=0xffffc90003a17e98, iter=0xffffc90003a17e70) at /home/kent/linux/fs/netfs/direct_read.c:272
#5  0xffffffff81498fb0 in new_sync_read (filp=0xffff88811234c180, buf=0x0, len=2147479552, ppos=0xffffc90003a17f00) at /home/kent/linux/fs/read_write.c:491
#6  vfs_read (file=file@entry=0xffff88811234c180, buf=buf@entry=0x7f0ab1767000 <error: Cannot access memory at address 0x7f0ab1767000>, count=count@entry=262144, pos=pos@entry=0xffffc90003a17f00) at /home/kent/linux/fs/read_write.c:572
#7  0xffffffff81499a2a in ksys_read (fd=<optimized out>, buf=0x7f0ab1767000 <error: Cannot access memory at address 0x7f0ab1767000>, count=262144) at /home/kent/linux/fs/read_write.c:717
#8  0xffffffff81bce8cc in do_syscall_x64 (regs=0xffffc90003a17f58, nr=<optimized out>) at /home/kent/linux/arch/x86/entry/syscall_64.c:63
#9  do_syscall_64 (regs=0xffffc90003a17f58, nr=<optimized out>) at /home/kent/linux/arch/x86/entry/syscall_64.c:94
#10 0xffffffff810000b0 in entry_SYSCALL_64 () at /home/kent/linux/arch/x86/entry/entry_64.S:121

void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq)
{
	struct netfs_io_request *rreq = subreq->rreq;

	switch (subreq->source) {
	case NETFS_READ_FROM_CACHE:
		netfs_stat(&netfs_n_rh_read_done);
		break;
	case NETFS_DOWNLOAD_FROM_SERVER:
		netfs_stat(&netfs_n_rh_download_done);
		break;
	default:
		break;
	}

	/* Deal with retry requests, short reads and errors.  If we retry
	 * but don't make progress, we abandon the attempt.
	 */
	if (!subreq->error && subreq->transferred < subreq->len) {
		if (test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags)) {
			trace_netfs_sreq(subreq, netfs_sreq_trace_hit_eof);
		} else if (test_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags)) {
			trace_netfs_sreq(subreq, netfs_sreq_trace_need_clear);
		} else if (test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
			trace_netfs_sreq(subreq, netfs_sreq_trace_need_retry);
		} else if (test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags)) {
			__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
			trace_netfs_sreq(subreq, netfs_sreq_trace_partial_read);
		} else {
			BUG();								<- ???
			__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
			subreq->error = -ENODATA;
			trace_netfs_sreq(subreq, netfs_sreq_trace_short);
		}
	}

	if (unlikely(subreq->error < 0)) {
		trace_netfs_failure(rreq, subreq, subreq->error, netfs_fail_read);
		if (subreq->source == NETFS_READ_FROM_CACHE) {
			netfs_stat(&netfs_n_rh_read_failed);
			__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
		} else {
			netfs_stat(&netfs_n_rh_download_failed);
			__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
		}
		trace_netfs_rreq(rreq, netfs_rreq_trace_set_pause);
		set_bit(NETFS_RREQ_PAUSE, &rreq->flags);
	}

	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
	netfs_subreq_clear_in_progress(subreq);
	netfs_put_subrequest(subreq, netfs_sreq_trace_put_terminated);
}

So, the underlying transport doesn't appear to be making forward
progress - IOW, this would appear to be a 9p bug - and then netfs
instead of a WARN() or doing anything to let people know that there's a
bug and where to look for it, returns a nonstandard error code to
userspace - fun.

Of course, this being a read, short reads are expected; another thought
is to wonder why netfs has decided that it should decide this particular
short read is unexpected instead of leaving the i_size checks to the
underlying filesystem.

