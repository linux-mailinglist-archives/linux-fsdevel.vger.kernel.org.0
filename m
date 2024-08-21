Return-Path: <linux-fsdevel+bounces-26456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB22395966F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 10:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3F3284B75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C84E1C4EF9;
	Wed, 21 Aug 2024 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tMALKuI1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8E21C4EF0
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226973; cv=none; b=g6ON0PXKzbp1yH+fzNDpnXYpDI62vMtURIJEkohoz51o9PtNCIV3/x0IPSTdUYSyK2B8rRyB2BqooZ7ReRlw1JCVb7m3oUzAvjp9tQKgfB9ECTHOMzPFL5/sYxkvI0G7I0GdKPyHImyYjet+Zp5vYrfckfb503uBc9F47GDBWTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226973; c=relaxed/simple;
	bh=+04NDL6egi37Nl74C+c9DsekUHQPtXTS9n5+VAtzWPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1/oDA89thILcNg0kP2p4Td2x3zfEIq/i6TJYP2aEcgTsNcMOZCxvYJEw2awRXR/+OATo4j10goKNfDmmDo74y/geWYxf+55vZHSHKZuQddfPl1XDmT1yDgsYTNPxg/Ht12fJwAhMoaSs/f72x2ve2ivD6dCug4f/opIIYtXu0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tMALKuI1; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724226962; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wNt8in5ljCuP62A0+wpVPdI5G9Eawfr0asDac+ZzaD4=;
	b=tMALKuI1C2TPJRVvXNDCruGbsLUrlu3Fk8o5UV9MWgWMI5O92yoFbyPmHCFumCF5IXhblB+mA34bJw/KdqEETvYjx6flowbiCmpS6oULZtOD/DzCiEx5psPt9j7Q7aE67wSapLZxM8sKk72ucGtao6fRWdm9fm9fTwp+FM8vpIU=
Received: from 30.221.144.101(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WDLCNbi_1724226960)
          by smtp.aliyun-inc.com;
          Wed, 21 Aug 2024 15:56:01 +0800
Message-ID: <b6850802-1440-4e38-af90-756b656a5f78@linux.alibaba.com>
Date: Wed, 21 Aug 2024 15:55:59 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] fuse: add optional kernel-enforced timeout for
 requests
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, laoar.shao@gmail.com,
 kernel-team@meta.com
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
 <20240813232241.2369855-2-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240813232241.2369855-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Joanne,

On 8/14/24 7:22 AM, Joanne Koong wrote:
> There are situations where fuse servers can become unresponsive or take
> too long to reply to a request. Currently there is no upper bound on
> how long a request may take, which may be frustrating to users who get
> stuck waiting for a request to complete.
> 
> This commit adds a timeout option (in seconds) for requests. If the
> timeout elapses before the server replies to the request, the request
> will fail with -ETIME.
> 
> There are 3 possibilities for a request that times out:
> a) The request times out before the request has been sent to userspace
> b) The request times out after the request has been sent to userspace
> and before it receives a reply from the server
> c) The request times out after the request has been sent to userspace
> and the server replies while the kernel is timing out the request
> 
> While a request timeout is being handled, there may be other handlers
> running at the same time if:
> a) the kernel is forwarding the request to the server
> b) the kernel is processing the server's reply to the request
> c) the request is being re-sent
> d) the connection is aborting
> e) the device is getting released
> 
> Proper synchronization must be added to ensure that the request is
> handled correctly in all of these cases. To this effect, there is a new
> FR_FINISHING bit added to the request flags, which is set atomically by
> either the timeout handler (see fuse_request_timeout()) which is invoked
> after the request timeout elapses or set by the request reply handler
> (see dev_do_write()), whichever gets there first. If the reply handler
> and the timeout handler are executing simultaneously and the reply handler
> sets FR_FINISHING before the timeout handler, then the request will be
> handled as if the timeout did not elapse. If the timeout handler sets
> FR_FINISHING before the reply handler, then the request will fail with
> -ETIME and the request will be cleaned up.
> 
> Currently, this is the refcount lifecycle of a request:
> 
> Synchronous request is created:
> fuse_simple_request -> allocates request, sets refcount to 1
>   __fuse_request_send -> acquires refcount
>     queues request and waits for reply...
> fuse_simple_request -> drops refcount
> 
> Background request is created:
> fuse_simple_background -> allocates request, sets refcount to 1
> 
> Request is replied to:
> fuse_dev_do_write
>   fuse_request_end -> drops refcount on request
> 
> Proper acquires on the request reference must be added to ensure that the
> timeout handler does not drop the last refcount on the request while
> other handlers may be operating on the request. Please note that the
> timeout handler may get invoked at any phase of the request's
> lifetime (eg before the request has been forwarded to userspace, etc).
> 
> It is always guaranteed that there is a refcount on the request when the
> timeout handler is executing. The timeout handler will be either
> deactivated by the reply/abort/release handlers, or if the timeout
> handler is concurrently executing on another CPU, the reply/abort/release
> handlers will wait for the timeout handler to finish executing first before
> it drops the final refcount on the request.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c    | 192 +++++++++++++++++++++++++++++++++++++++++++++--
>  fs/fuse/fuse_i.h |  14 ++++
>  fs/fuse/inode.c  |   7 ++
>  3 files changed, 205 insertions(+), 8 deletions(-)

> @@ -1951,9 +2105,10 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
>  		goto copy_finish;
>  	}
>  
> +	__fuse_get_request(req);
> +

While re-inspecting the patch, I doubt if acquiring an extra req->count
here is really needed here.

There are three conditions for concurrency between reply receiving and
timeout handler:

1. timeout handler acquires fpq->lock first and delets the request from
processing[] table.  In this case, fuse_dev_write() has no chance of
accessing this request since it has previously already been removed from
the processing[] table.  No concurrency and no extra refcount needed here.

2. fuse_dev_write() acquires fpq->lock first and sets FR_FINISHING.  In
this case the timeout handler will be disactivated when seeing
FR_FINISHING.  Also No concurrency and no extra refcount needed here.

2. fuse_dev_write() acquires fpq->lock first but timeout handler sets
FR_FINISHING first.  In this case, fuse_dev_write() handler will return,
leaving the request to the timeout hadler. The access to fuse_req from
fuse_dev_write() is safe as long as fuse_dev_write() still holds
fpq->lock, as the timeout handler may free the request only after
acquiring and releasing fpq->lock.  Besides, as for fuse_dev_write(),
the only operation after releasing fpq->lock is fuse_copy_finish(cs),
which shall be safe even when the fuse_req may have been freed by the
timeout handler (not seriously confirmed though)?

Please correct me if I missed something.

>  	/* Is it an interrupt reply ID? */
>  	if (oh.unique & FUSE_INT_REQ_BIT) {
> -		__fuse_get_request(req);
>  		spin_unlock(&fpq->lock);
>  
>  		err = 0;
> @@ -1969,6 +2124,18 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
>  		goto copy_finish;
>  	}
>  
> +	if (test_and_set_bit(FR_FINISHING, &req->flags)) {
> +		/* timeout handler is already finishing the request */
> +		spin_unlock(&fpq->lock);
> +		fuse_put_request(req);
> +		goto copy_finish;
> +	}
> +
> +	/*
> +	 * FR_FINISHING ensures the timeout handler will be a no-op if it runs,
> +	 * but unset req->fpq here as an extra safeguard
> +	 */
> +	req->fpq = NULL;
>  	clear_bit(FR_SENT, &req->flags);
>  	list_move(&req->list, &fpq->io);
>  	req->out.h = oh;
> @@ -1995,6 +2162,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
>  	spin_unlock(&fpq->lock);
>  
>  	fuse_request_end(req);
> +	fuse_put_request(req);
>  out:
>  	return err ? err : nbytes;
>  


-- 
Thanks,
Jingbo

