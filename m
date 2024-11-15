Return-Path: <linux-fsdevel+bounces-34982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F7B9CF56B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 21:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC31282F12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 20:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C401E2031;
	Fri, 15 Nov 2024 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="cHfjERfY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83C710F2;
	Fri, 15 Nov 2024 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700927; cv=none; b=evUobVOiuMONUJaOYoiTzR387qolpwdmtUzML2mq273NZf489j3PYHfRVkT5puzvGeB/i1vGftK8V5ptRdLK2KFc1Dn6Wan5YFbpdHsO+HKiD8/qwrVZwGXQoYFJOkiO0xKQIzMsIbD7EcrDfG6Pd1HrvWOcHEw2uKJzRtniX6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700927; c=relaxed/simple;
	bh=kTKcI7rAzWbnFx3Ax+rm7FwXA+3N7eD2+FIgr2oP7kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nT69W+dUPLRd6Ns0ZrrxqLVsL9RUqbv8de2Iim/DeGIcPbdrPKnitUjHfgI8mLwVcqZti+uOAUHX5GJYaUV2/uR6R5A0jlOPFwV22+2M1dIdVEQCM+dH0QscfuKhjiKbzaE+9BjZ1/vIBW1okvEnAxbgDzKeIjHfLF0gMC/2PSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=cHfjERfY; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1731700922; bh=kTKcI7rAzWbnFx3Ax+rm7FwXA+3N7eD2+FIgr2oP7kg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cHfjERfY1/rAAYikk2QNbgGZwf8P76vzMPzQy0d38kXIISsg6cIu+TyONdT+1XA9d
	 dnHVgoiBK/U+Ro40XfKwbu0kYfn03m1yCclV6oORc5HF1o34pGsZmNOzLqCRhoSAH+
	 bVBVKjSR8nU5xVOSXJDnjtUPKMWJyAKcxgCzdVYtvgvWOYTpPivdsVJJLPoI2YBvDv
	 YfdiF9W8RjIdBQ3sShsTkRNGpSMMNgugIUwUnbAbuBOE3sUaWPyxt1eEG2fB+9Ojh6
	 clox9OhOuRhluFaZfycU5bW3lyo10aEcZYWTp4LajDyqEsevUsJGiGsQGbbtmUsAGw
	 zM/4cMlJZi0LxU8Iz7pva37mepW1yCxANkesaw/WVrlzxEL2BBIYcvn4Ns+IWj/Pl9
	 3xbzlIzCPENc15jBiKC3X5tUuOq6P+iM8sUBOmiD5JyFBSMXeuSuAu1HJ7Bbd4FyE/
	 PBYXB2Di/tBAed2LS23SuHO40UV3Hf8QS8rw4yLte6S2qH/ZvWXvDoEQF9H7Wt0ZGA
	 ysGoIjNlPNdRkfpyOTMNcAHMh4u1X1WsE3uuWa2Onkmd9yvzplXQr4YqjLyvanucka
	 NQVkL1t60WZZNPUDpdDPVX+iR4y9mn87zk2epeaPRvd1Pow2ipBYG6a3996OgEmpKk
	 fItX9fSiHH5XvvnpO8iKLYxA=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 7CF6618A7E9;
	Fri, 15 Nov 2024 21:02:00 +0100 (CET)
Message-ID: <b7135da8-a04f-48ec-957f-09542178b861@ijzerbout.nl>
Date: Fri, 15 Nov 2024 21:01:57 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/33] netfs: Abstract out a rolling folio buffer
 implementation
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>, Steve French <smfrench@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, Gao Xiang
 <hsiangkao@linux.alibaba.com>, Dominique Martinet <asmadeus@codewreck.org>,
 Marc Dionne <marc.dionne@auristor.com>, Paulo Alcantara <pc@manguebit.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241108173236.1382366-1-dhowells@redhat.com>
 <20241108173236.1382366-8-dhowells@redhat.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20241108173236.1382366-8-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 08-11-2024 om 18:32 schreef David Howells:
> A rolling buffer is a series of folios held in a list of folio_queues.  New
> folios and folio_queue structs may be inserted at the head simultaneously
> with spent ones being removed from the tail without the need for locking.
>
> The rolling buffer includes an iov_iter and it has to be careful managing
> this as the list of folio_queues is extended such that an oops doesn't
> incurred because the iterator was pointing to the end of a folio_queue
> segment that got appended to and then removed.
>
> We need to use the mechanism twice, once for read and once for write, and,
> in future patches, we will use a second rolling buffer to handle bounce
> buffering for content encryption.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/netfs/Makefile              |   1 +
>   fs/netfs/buffered_read.c       | 119 ++++-------------
>   fs/netfs/direct_read.c         |  14 +-
>   fs/netfs/direct_write.c        |  10 +-
>   fs/netfs/internal.h            |   4 -
>   fs/netfs/misc.c                | 147 ---------------------
>   fs/netfs/objects.c             |   2 +-
>   fs/netfs/read_pgpriv2.c        |  32 ++---
>   fs/netfs/read_retry.c          |   2 +-
>   fs/netfs/rolling_buffer.c      | 225 +++++++++++++++++++++++++++++++++
>   fs/netfs/write_collect.c       |  19 +--
>   fs/netfs/write_issue.c         |  26 ++--
>   include/linux/netfs.h          |  10 +-
>   include/linux/rolling_buffer.h |  61 +++++++++
>   include/trace/events/netfs.h   |   2 +
>   15 files changed, 375 insertions(+), 299 deletions(-)
>   create mode 100644 fs/netfs/rolling_buffer.c
>   create mode 100644 include/linux/rolling_buffer.h
> [...]
> diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
> index 88f2adfab75e..0722fb9919a3 100644
> --- a/fs/netfs/direct_write.c
> +++ b/fs/netfs/direct_write.c
> @@ -68,19 +68,19 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
>   		 * request.
>   		 */
>   		if (async || user_backed_iter(iter)) {
> -			n = netfs_extract_user_iter(iter, len, &wreq->iter, 0);
> +			n = netfs_extract_user_iter(iter, len, &wreq->buffer.iter, 0);
>   			if (n < 0) {
>   				ret = n;
>   				goto out;
>   			}
> -			wreq->direct_bv = (struct bio_vec *)wreq->iter.bvec;
> +			wreq->direct_bv = (struct bio_vec *)wreq->buffer.iter.bvec;
>   			wreq->direct_bv_count = n;
>   			wreq->direct_bv_unpin = iov_iter_extract_will_pin(iter);
>   		} else {
> -			wreq->iter = *iter;
> +			wreq->buffer.iter = *iter;
>   		}
>   
> -		wreq->io_iter = wreq->iter;
> +		wreq->buffer.iter = wreq->buffer.iter;
Is this correct, an assignment to itself?
>   	}
>   
>   	__set_bit(NETFS_RREQ_USE_IO_ITER, &wreq->flags);
> [...]


