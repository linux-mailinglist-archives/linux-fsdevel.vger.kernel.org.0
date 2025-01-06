Return-Path: <linux-fsdevel+bounces-38428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C70A024D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 13:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CDD163ED9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 12:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679621DDC1B;
	Mon,  6 Jan 2025 12:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b="ii3eaTUz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDBC1DC9B8;
	Mon,  6 Jan 2025 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.129.21.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736165281; cv=none; b=tYpf6QUBXYLUyjMVZyZhAjVHzXekdHimkFY7zXRrmTVjxs1WqwA+pXQHqTdlCHOQ/Oi48HtasLOOul302NAeWCxuuJHqa3mUXjaN28vKTpHxJwpD3Adxjrk5/M/+xBiagdrvQoIMPPCSnQ1NKnailokyYBZ632CMpHZGgZEyEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736165281; c=relaxed/simple;
	bh=n+eqCzLhYHG7tuw4O6CIzecns+zELJBTFr3/HlBdqhg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tUueGVqmz9fHHcZahZVK8/87xq6zIl+MR1+JB/gwfKnH/k30eLkiKMQSETwPs8pucx8QFsArhCSsR/225/rQb4gIeX/P4PVhkpyb2lLZlntixxaD+1ZjufUzN4Wx0ztxo3jwB3QbNc1/aUWq3JkZNTc81sA8857hkWo7YTD3g+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr; spf=pass smtp.mailfrom=3xo.fr; dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b=ii3eaTUz; arc=none smtp.client-ip=212.129.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xo.fr
Received: from localhost (mail.3xo.fr [212.129.21.66])
	by mail.3xo.fr (Postfix) with ESMTP id EFA89C6;
	Mon,  6 Jan 2025 13:07:49 +0100 (CET)
X-Virus-Scanned: Debian amavis at nxo2.3xo.fr
Received: from mail.3xo.fr ([212.129.21.66])
 by localhost (mail.3xo.fr [212.129.21.66]) (amavis, port 10024) with ESMTP
 id yelSwzv8orKl; Mon,  6 Jan 2025 13:07:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.3xo.fr D5D0DC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xo.fr; s=3xo;
	t=1736165264; bh=UpXQpAdzuVWioOzu9/NdHU8wrAjhGB8vN3JBxloLtNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ii3eaTUzz0XJhouEH2C8MxeCAo1boJMMOyRMmxIKu/sDICAC5IIESPnKRrrg7XbZX
	 aXEJQX5Ea+EST5ZvEfrV07vsce7M+WimXFPPDoV1WeZxk/hud57EFA14qTPt2R8jXQ
	 XiCBOoApIkg73bpEfms5UFv0GAWS5vJxZ55twOMQMO35mbiYyZCo/9ugylv9QdcvLA
	 2+wio020eNt0pi55OWLHex1rHZQQsWb0NiuGOcuZS83B/+GeC3uFhXZPRWopQV85aB
	 Y0Faoe+zMABvuFysCi/80dcURH6OXN+iGg4yiOQC7Fw9/1hzdMJ+QK8iPGJXVnWGMt
	 +qCGWfhTzxWOw==
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3xo.fr (Postfix) with ESMTPSA id D5D0DC1;
	Mon,  6 Jan 2025 13:07:44 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 06 Jan 2025 13:07:44 +0100
From: nicolas.baranger@3xo.fr
To: David Howells <dhowells@redhat.com>
Cc: Steve French <smfrench@gmail.com>, Christoph Hellwig
 <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>, Christian Brauner
 <brauner@kernel.org>, netfs@lists.linux.dev, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix kernel async DIO
In-Reply-To: <286638.1736163444@warthog.procyon.org.uk>
References: <fedd8a40d54b2969097ffa4507979858@3xo.fr>
 <669f22fc89e45dd4e56d75876dc8f2bf@3xo.fr>
 <286638.1736163444@warthog.procyon.org.uk>
Message-ID: <b3e8129937055ff8971d8be44286f0b8@3xo.fr>
X-Sender: nicolas.baranger@3xo.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi David

Thanks for the job !
I will buid Linux 6.10 and mainline with the provided change and I'm 
comming here as soon as I get results from tests (CET working time).

Thanks again for help in this issue
Nicolas

Le 2025-01-06 12:37, David Howells a écrit :

> Hi Nicolas,
> 
> Does the attached fix your problem?
> 
> David
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
> index eded8afaa60b..42ce53cc216e 100644
> --- a/fs/netfs/direct_write.c
> +++ b/fs/netfs/direct_write.c
> @@ -67,7 +67,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct 
> kiocb *iocb, struct iov_iter *
> * allocate a sufficiently large bvec array and may shorten the
> * request.
> */
> -        if (async || user_backed_iter(iter)) {
> +        if (user_backed_iter(iter)) {
> n = netfs_extract_user_iter(iter, len, &wreq->buffer.iter, 0);
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
> wreq->buffer.iter = *iter;
> }
> }

