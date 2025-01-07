Return-Path: <linux-fsdevel+bounces-38598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC67A048EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 19:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D4E162081
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 18:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3040198A0D;
	Tue,  7 Jan 2025 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b="t20gnFjE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C016749652;
	Tue,  7 Jan 2025 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.129.21.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273316; cv=none; b=QJqsFstOsfcwnec5TFa66QlL4tlswLFFTIs7GR66j1j2yfTmWYVYZS5ZFrKtkvFsKR0RmDHhCnQxkwXu7Lk/7zt3AE0VYuiWQVyLE8CBPHGoFHi67c/7P8dVKLu5TuW6SWEH7GpXv9As0WzTL92Y+yAaljpHLjc2GUB57u90by0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273316; c=relaxed/simple;
	bh=DQ3nqgC+a7Gk2yp+F1zJDb5j38I24K/y7V8EU+q1tfs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tASqSdrO8Fg70clXL+CpGL/twJIIgsjj8R0+Iz9rM/Z+rEt6gRK6X90/6Qv/DjtRG6uK1fBsfgu/lCXDh0nohMkI6AhbMhtD85D3k6iQpKAyr1aVRSqGksKrP8GWIf/s7kAZ/zHkinufzmS2YequGTZIZvoc8KZjZ94DxNrWbYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr; spf=pass smtp.mailfrom=3xo.fr; dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b=t20gnFjE; arc=none smtp.client-ip=212.129.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xo.fr
Received: from localhost (mail.3xo.fr [212.129.21.66])
	by mail.3xo.fr (Postfix) with ESMTP id A7C7FC6;
	Tue,  7 Jan 2025 19:08:23 +0100 (CET)
X-Virus-Scanned: Debian amavis at nxo2.3xo.fr
Received: from mail.3xo.fr ([212.129.21.66])
 by localhost (mail.3xo.fr [212.129.21.66]) (amavis, port 10024) with ESMTP
 id KbCLaDkcSIhM; Tue,  7 Jan 2025 19:08:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.3xo.fr 51DA49A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xo.fr; s=3xo;
	t=1736273298; bh=bRwhxHfmIxxbjng+D/WKOrd85HcvY8pgd0ECxPTeUVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t20gnFjEOlo1npzMGWTQuIFZ8VHN6Vd7MEJwjsgcgwm/Tkj+okL97nGWCUXxsDaJe
	 df6lkqrVECvNCN4XMD2LeZ6ZO+cwXGt0Xo1clRgYREAlMKUSBA6rQuxRHgV0dYG+X7
	 5v1Xt2DiRhiRSAisPrj19dc00lmNjT4tc8kpzFlEo7UFyqT1bNwVx3a22pF56ESh7C
	 ccLVj9EaPijovzMt9MMiPFEiXOmGcApZYzQWJ0BZEehJCxIWiQ+4hsI5T7YUPIl8Jg
	 Zx4+5lwHAveksM6szQXqc1ONFJjg43LibkzmgfkblPLd42pkQksXZYrLHCcboi3tEl
	 50nBhxbc1O3Bg==
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3xo.fr (Postfix) with ESMTPSA id 51DA49A;
	Tue,  7 Jan 2025 19:08:18 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 07 Jan 2025 19:08:18 +0100
From: Nicolas Baranger <nicolas.baranger@3xo.fr>
To: David Howells <dhowells@redhat.com>
Cc: Steve French <smfrench@gmail.com>, Christoph Hellwig
 <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>, Christian Brauner
 <brauner@kernel.org>, netfs@lists.linux.dev, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix kernel async DIO
In-Reply-To: <529745.1736261368@warthog.procyon.org.uk>
References: <d98ca4470c447182020b576841115a20@3xo.fr>
 <fedd8a40d54b2969097ffa4507979858@3xo.fr>
 <669f22fc89e45dd4e56d75876dc8f2bf@3xo.fr>
 <286638.1736163444@warthog.procyon.org.uk>
 <b3e8129937055ff8971d8be44286f0b8@3xo.fr>
 <529745.1736261368@warthog.procyon.org.uk>
Message-ID: <bb21f2c816e75425c9200a7f9700d216@3xo.fr>
X-Sender: nicolas.baranger@3xo.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi David

Sure you can !

Please also note that after building 'linux-next' and applying the first 
patch you provide I sucessfully test DIO write (same test process as 
before).
It works fine too !

I stay availiable for further testing

Thanks again for help (special thanks to Christoph and David)
Nicolas



Le 2025-01-07 15:49, David Howells a écrit :

> Thanks!
> 
> I ported the patch to linus/master (see below) and it looks pretty much 
> the
> same as yours, give or take tabs getting converted to spaces.
> 
> Could I put you down as a Tested-by?
> 
> David
> 
> ---
> netfs: Fix kernel async DIO
> 
> Netfslib needs to be able to handle kernel-initiated asynchronous DIO 
> that
> is supplied with a bio_vec[] array.  Currently, because of the async 
> flag,
> this gets passed to netfs_extract_user_iter() which throws a warning 
> and
> fails because it only handles IOVEC and UBUF iterators.  This can be
> triggered through a combination of cifs and a loopback blockdev with
> something like:
> 
> mount //my/cifs/share /foo
> dd if=/dev/zero of=/foo/m0 bs=4K count=1K
> losetup --sector-size 4096 --direct-io=on /dev/loop2046 /foo/m0
> echo hello >/dev/loop2046
> 
> This causes the following to appear in syslog:
> 
> WARNING: CPU: 2 PID: 109 at fs/netfs/iterator.c:50 
> netfs_extract_user_iter+0x170/0x250 [netfs]
> 
> and the write to fail.
> 
> Fix this by removing the check in netfs_unbuffered_write_iter_locked() 
> that
> causes async kernel DIO writes to be handled as userspace writes.  Note
> that this change relies on the kernel caller maintaining the existence 
> of
> the bio_vec array (or kvec[] or folio_queue) until the op is complete.
> 
> Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
> Reported by: Nicolas Baranger <nicolas.baranger@3xo.fr>
> Closes: 
> https://lore.kernel.org/r/fedd8a40d54b2969097ffa4507979858@3xo.fr/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <smfrench@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: netfs@lists.linux.dev
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
> fs/netfs/direct_write.c |    7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
> index 173e8b5e6a93..f9421f3e6d37 100644
> --- a/fs/netfs/direct_write.c
> +++ b/fs/netfs/direct_write.c
> @@ -67,7 +67,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct 
> kiocb *iocb, struct iov_iter *
> * allocate a sufficiently large bvec array and may shorten the
> * request.
> */
> -        if (async || user_backed_iter(iter)) {
> +        if (user_backed_iter(iter)) {
> n = netfs_extract_user_iter(iter, len, &wreq->iter, 0);
> if (n < 0) {
> ret = n;
> @@ -77,6 +77,11 @@ ssize_t netfs_unbuffered_write_iter_locked(struct 
> kiocb *iocb, struct iov_iter *
> wreq->direct_bv_count = n;
> wreq->direct_bv_unpin = iov_iter_extract_will_pin(iter);
> } else {
> +            /* If this is a kernel-generated async DIO request,
> +             * assume that any resources the iterator points to
> +             * (eg. a bio_vec array) will persist till the end of
> +             * the op.
> +             */
> wreq->iter = *iter;
> }

