Return-Path: <linux-fsdevel+bounces-58036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8249CB28390
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 18:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918AD5C7C24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBA83090F0;
	Fri, 15 Aug 2025 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="Tfw4aE2F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA432FCBFC;
	Fri, 15 Aug 2025 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274195; cv=none; b=Qk0XDvxGlu+QY4EJVG14B7tRCbVNJyhE6dL3Cb/bJZQaqeJlzU9RqTNr3Iq0CHGfR2AVfDo0ugdzwUmczQ2QNQFBqGApOrce0RkTsw02a0E2/rcIeIj1zAagnWKZ+PS74o9Vbke98r19Kjlqw8JMIPpMzxV8VWfLbTxTqkVUEqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274195; c=relaxed/simple;
	bh=xWRha5g+4qCtv7pPT3fMcHVlknNoOr8+sOOJTQ4fHsk=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=bNcclvy0Mx22b2w3Iqiv7hj8U6u0bFqWocqr6XSEOvYUu2ItiDjljpr7s6nENY2/16vHEPeogvHuAaE04YhD8ouPGn1/31IveBh3VqLuX0yVTyzeDAgkN8OmR9JMaA3AJm5aYSCjNBqThmH6LDeNNki8KvpXL7fQ5iY3zOUeFFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=Tfw4aE2F; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P+mIahC1TK4UaHtb99symdtf78QWaiS/LIx941Zy32I=; b=Tfw4aE2F9YThy7BzyD2Ek00ZgV
	8cA/qo7vVJUgL52YDDd6Q0Nlk2bIaFEY39VMk3qrPwC+3h82lFdnbhVPDHPM5o/DlYh+6LYxtWx0P
	cD7ON5M0XMnd7z5Ngb4T3Cf4am5qAF/NGB3qnEu7vY+s58tCjzUnk0LljBTKA8twvKPPepgkixNjl
	cL57a4Kq/5fXuGVL19kkSqaZA08jJ3DwTajin0txHZUGRU7vfsPaSnDvggeKF/zaJm767vO7rAFC2
	UnN38olzQSN4rhqgLLWFN7xz1UOiYvqWqsYUPx8vBFVlc4WZHyNgZWxX1fs6B91gNAk28Mfzk/N3q
	zNkMCI3w==;
Received: from pc by mx1.manguebit.org with local (Exim 4.98.2)
	id 1umwzu-00000000HtL-3wjB;
	Fri, 15 Aug 2025 13:09:42 -0300
Message-ID: <6ae175d2126c31b023ef1bc6d61a0a39@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: David Howells <dhowells@redhat.com>, Christian Brauner
 <brauner@kernel.org>, Steve French <sfrench@samba.org>
Cc: dhowells@redhat.com, Xiaoli Feng <fengxiaoli0714@gmail.com>, Shyam
 Prasad N <sprasad@microsoft.com>, netfs@lists.linux.dev,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix unbuffered write error handling
In-Reply-To: <915443.1755207950@warthog.procyon.org.uk>
References: <915443.1755207950@warthog.procyon.org.uk>
Date: Fri, 15 Aug 2025 13:09:35 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> If all the subrequests in an unbuffered write stream fail, the subrequest
> collector doesn't update the stream->transferred value and it retains its
> initial LONG_MAX value.  Unfortunately, if all active streams fail, then we
> take the smallest value of { LONG_MAX, LONG_MAX, ... } as the value to set
> in wreq->transferred - which is then returned from ->write_iter().
>
> LONG_MAX was chosen as the initial value so that all the streams can be
> quickly assessed by taking the smallest value of all stream->transferred -
> but this only works if we've set any of them.
>
> Fix this by adding a flag to indicate whether the value in
> stream->transferred is valid and checking that when we integrate the
> values.  stream->transferred can then be initialised to zero.
>
> This was found by running the generic/750 xfstest against cifs with
> cache=none.  It splices data to the target file.  Once (if) it has used up
> all the available scratch space, the writes start failing with ENOSPC.
> This causes ->write_iter() to fail.  However, it was returning
> wreq->transferred, i.e. LONG_MAX, rather than an error (because it thought
> the amount transferred was non-zero) and iter_file_splice_write() would
> then try to clean up that amount of pipe bufferage - leading to an oops
> when it overran.  The kernel log showed:
>
>     CIFS: VFS: Send error in write = -28
>
> followed by:
>
>     BUG: kernel NULL pointer dereference, address: 0000000000000008
>
> with:
>
>     RIP: 0010:iter_file_splice_write+0x3a4/0x520
>     do_splice+0x197/0x4e0
>
> or:
>
>     RIP: 0010:pipe_buf_release (include/linux/pipe_fs_i.h:282)
>     iter_file_splice_write (fs/splice.c:755)
>
> Also put a warning check into splice to announce if ->write_iter() returned
> that it had written more than it was asked to.
>
> Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
> Reported-by: Xiaoli Feng <fengxiaoli0714@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220445
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Steve French <sfrench@samba.org>
> cc: Shyam Prasad N <sprasad@microsoft.com>
> cc: netfs@lists.linux.dev
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: stable@vger.kernel.org
> ---
>  fs/netfs/read_collect.c  |    4 +++-
>  fs/netfs/write_collect.c |   10 ++++++++--
>  fs/netfs/write_issue.c   |    4 ++--
>  fs/splice.c              |    3 +++
>  include/linux/netfs.h    |    1 +
>  5 files changed, 17 insertions(+), 5 deletions(-)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

