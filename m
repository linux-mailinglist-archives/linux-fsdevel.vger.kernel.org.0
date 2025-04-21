Return-Path: <linux-fsdevel+bounces-46855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E25A95812
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 23:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3AB18949E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 21:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19BD219319;
	Mon, 21 Apr 2025 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="fa5MnfG8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g82dUIS8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D5018DF86
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745271526; cv=none; b=r+CoXKEskqEhC6qnjyUDGD+1BB84lZRsc9YsscGE9OPlVtfqQgtxWYMsBnjuIwhYRLFlzDQCyoIEx+bhVxdx5btMuBue01ZrVnouApKQ0kLAxFLMY4P4T4iRB+SAP7GJnRHg7ZXhfq6KjwFVKJTJE25gDUg3zq+sl9UV0UqAcjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745271526; c=relaxed/simple;
	bh=e8IUgdaIkUkck5TM9NTNI9xw9I6dQJ0RAMitYlTQQlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGInPtrjvMVzn7w34W17Go4B2Hu9YEx/k0UI+kR6xwzLPgkiYBnrPFOgJh8nm6FzInb/iQpxfqFVZW8jTnzlMxk7fako7Vd9Lcy0MEH8MwdGOMdoLi++EMDeyI1pZyKumPsseyanMYIsrdn3AZIbNf9HjpT5kNTkw+gf8Hz5cQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=fa5MnfG8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g82dUIS8; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4463A2540235;
	Mon, 21 Apr 2025 17:38:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 21 Apr 2025 17:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745271523;
	 x=1745357923; bh=HJ3nFV0FfVMJOnHAduxl8IAmBzmSiBw0dIYsd0g7Qgw=; b=
	fa5MnfG8uBXUh7212hkLN4vIbBJ8kDCP4g9cmlid9yMBPawR8YjeXSGSAgcwhR2v
	AnTuyYgsEgwv3ZfUcj7qHJmS3r4ADt2BsChf/TJrpp4tKrm3Ef23y4aKpdELhu5G
	5Qtrp7k854NaAHfkI4bWjhh5xBmR4Uam5QI8x6jE5WNWYfL+9NebKdPIwamDE5yh
	9AgG6tfvt867z3alaESAV1Z46P1o9vN2W8b4OGOQNKocmTW5Df4R2Jr3qlvkAqnC
	q9AkQE/mEiBPm8CT1j03zGluqW2SucjVGxG622JHdmz1ni8fKT+2BFJT/Eg2l8Ih
	7XWDfC3+aYWLJBBMho62ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745271523; x=
	1745357923; bh=HJ3nFV0FfVMJOnHAduxl8IAmBzmSiBw0dIYsd0g7Qgw=; b=g
	82dUIS8witJW6a+l6sGkkDALi0/sFJo9MBq0p3duTkEhcvEo7RmvDClAf+NUpfGr
	sRZ6jT5TRO7qOE3GBm/WJPrKa8Xfkm+UneqKx2ixpp/KmLE1pYITpJ8sT9blBfzW
	z6Y4OBBbuWyL7x33e4vcVxqF1f/ZBQ4asrUSiXQGe4tEFRt9xMJIteu2pFL1jOqM
	H/7u//xzYBPZa5ocUX9Qjo2dTPpOeQhIkIZZ8YwAKBu3VuIUVWmur8qVyJ+KCXvq
	BO+t49hB2Q7nbuqL3SXtjY4IMgKfCZcOEo/BKpV054YQI6AaAPetTpwGvBjUNUnt
	9mo0mMKsY8zbcSoITIm+g==
X-ME-Sender: <xms:4roGaGnOi5Z01WHCkrWfsVMihNdJ1gBHM98uSFhzdhUkhfIe-A9bUA>
    <xme:4roGaN1Uu1MbFMHvYBYV97vCqZitgLotqYUoEHP8G098wjelizYKVWLUG8kUMu1zi
    zt2L-Q0HR6dAIzK>
X-ME-Received: <xmr:4roGaEoIHs5BbyI2RXbzG3HnsUpFIJTw_rk-tgwRV8AmZqVd6eM_WOmXfP1mAXO_Ba6744mRdevmGVx8T30NXVawlaTemPcrByz3-tFKrG-_ebJIsZRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeduleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledt
    udfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehmih
    hklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrg
    hmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:4roGaKlvV9NFxVN88hN6bssQJGLPldtVkU0ambU7s8Nfff_HU-OnAA>
    <xmx:4roGaE0lnERx5KL6jCoxL5Bfpa-lbOgIIj96sevBxZktmEuWYCRtPg>
    <xmx:4roGaBus4Snzep1fKgJS7keEUa6r4DsuvGPWSkH66j6VJ24bWwoZ9Q>
    <xmx:4roGaAUbOBuobwPCdKCMaUtxNmMtUcQCPwYYdyPiqWugTQJ3ZcqKxg>
    <xmx:47oGaIr4hLVvB4CFK3fX3gUu21ROdIuTK3FJYjraZJsLO2pl9lZJXUBO>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 17:38:41 -0400 (EDT)
Message-ID: <a65b5034-2bae-4eec-92e2-3a9ad003b0bb@fastmail.fm>
Date: Mon, 21 Apr 2025 23:38:40 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fuse: use splice for reading user pages on servers
 that enable it
To: Jeff Layton <jlayton@kernel.org>, Joanne Koong <joannelkoong@gmail.com>,
 miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <20250419000614.3795331-1-joannelkoong@gmail.com>
 <5332002a-e444-4f62-8217-8d124182290d@fastmail.fm>
 <26673a5077b148e98a3957532f0cb445aa7ed3c7.camel@kernel.org>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <26673a5077b148e98a3957532f0cb445aa7ed3c7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/21/25 14:35, Jeff Layton wrote:
> On Mon, 2025-04-21 at 13:49 +0200, Bernd Schubert wrote:
>>
>> On 4/19/25 02:06, Joanne Koong wrote:
>>> For direct io writes, splice is disabled when forwarding pages from the
>>> client to the server. This is because the pages in the pipe buffer are
>>> user pages, which is controlled by the client. Thus if a server replies
>>> to the request and then keeps accessing the pages afterwards, there is
>>> the possibility that the client may have modified the contents of the
>>> pages in the meantime. More context on this can be found in commit
>>> 0c4bcfdecb1a ("fuse: fix pipe buffer lifetime for direct_io").
>>>
>>> For servers that do not need to access pages after answering the
>>> request, splice gives a non-trivial improvement in performance.
>>> Benchmarks show roughly a 40% speedup.
>>>
>>> Allow servers to enable zero-copy splice for servicing client direct io
>>> writes. By enabling this, the server understands that they should not
>>> continue accessing the pipe buffer after completing the request or may
>>> face incorrect data if they do so.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> ---
>>>  fs/fuse/dev.c             | 18 ++++++++++--------
>>>  fs/fuse/dev_uring.c       |  4 ++--
>>>  fs/fuse/fuse_dev_i.h      |  5 +++--
>>>  fs/fuse/fuse_i.h          |  3 +++
>>>  fs/fuse/inode.c           |  5 ++++-
>>>  include/uapi/linux/fuse.h |  8 ++++++++
>>>  6 files changed, 30 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>>> index 67d07b4c778a..1b0ea8593f74 100644
>>> --- a/fs/fuse/dev.c
>>> +++ b/fs/fuse/dev.c
>>> @@ -816,12 +816,13 @@ static int unlock_request(struct fuse_req *req)
>>>  	return err;
>>>  }
>>>  
>>> -void fuse_copy_init(struct fuse_copy_state *cs, bool write,
>>> -		    struct iov_iter *iter)
>>> +void fuse_copy_init(struct fuse_copy_state *cs, struct fuse_conn *fc,
>>> +		    bool write, struct iov_iter *iter)
>>>  {
>>>  	memset(cs, 0, sizeof(*cs));
>>>  	cs->write = write;
>>>  	cs->iter = iter;
>>> +	cs->splice_read_user_pages = fc->splice_read_user_pages;
>>>  }
>>>  
>>>  /* Unmap and put previous page of userspace buffer */
>>> @@ -1105,9 +1106,10 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
>>>  		if (cs->write && cs->pipebufs && page) {
>>>  			/*
>>>  			 * Can't control lifetime of pipe buffers, so always
>>> -			 * copy user pages.
>>> +			 * copy user pages if server does not support splice
>>> +			 * for reading user pages.
>>>  			 */
>>> -			if (cs->req->args->user_pages) {
>>> +			if (cs->req->args->user_pages && !cs->splice_read_user_pages) {
>>>  				err = fuse_copy_fill(cs);
>>>  				if (err)
>>>  					return err;
>>> @@ -1538,7 +1540,7 @@ static ssize_t fuse_dev_read(struct kiocb *iocb, struct iov_iter *to)
>>>  	if (!user_backed_iter(to))
>>>  		return -EINVAL;
>>>  
>>> -	fuse_copy_init(&cs, true, to);
>>> +	fuse_copy_init(&cs, fud->fc, true, to);
>>>  
>>>  	return fuse_dev_do_read(fud, file, &cs, iov_iter_count(to));
>>>  }
>>> @@ -1561,7 +1563,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
>>>  	if (!bufs)
>>>  		return -ENOMEM;
>>>  
>>> -	fuse_copy_init(&cs, true, NULL);
>>> +	fuse_copy_init(&cs, fud->fc, true, NULL);
>>>  	cs.pipebufs = bufs;
>>>  	cs.pipe = pipe;
>>>  	ret = fuse_dev_do_read(fud, in, &cs, len);
>>> @@ -2227,7 +2229,7 @@ static ssize_t fuse_dev_write(struct kiocb *iocb, struct iov_iter *from)
>>>  	if (!user_backed_iter(from))
>>>  		return -EINVAL;
>>>  
>>> -	fuse_copy_init(&cs, false, from);
>>> +	fuse_copy_init(&cs, fud->fc, false, from);
>>>  
>>>  	return fuse_dev_do_write(fud, &cs, iov_iter_count(from));
>>>  }
>>> @@ -2301,7 +2303,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
>>>  	}
>>>  	pipe_unlock(pipe);
>>>  
>>> -	fuse_copy_init(&cs, false, NULL);
>>> +	fuse_copy_init(&cs, fud->fc, false, NULL);
>>>  	cs.pipebufs = bufs;
>>>  	cs.nr_segs = nbuf;
>>>  	cs.pipe = pipe;
>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>> index ef470c4a9261..52b883a6a79d 100644
>>> --- a/fs/fuse/dev_uring.c
>>> +++ b/fs/fuse/dev_uring.c
>>> @@ -593,7 +593,7 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
>>>  	if (err)
>>>  		return err;
>>>  
>>> -	fuse_copy_init(&cs, false, &iter);
>>> +	fuse_copy_init(&cs, ring->fc, false, &iter);
>>>  	cs.is_uring = true;
>>>  	cs.req = req;
>>>  
>>> @@ -623,7 +623,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
>>>  		return err;
>>>  	}
>>>  
>>> -	fuse_copy_init(&cs, true, &iter);
>>> +	fuse_copy_init(&cs, ring->fc, true, &iter);
>>>  	cs.is_uring = true;
>>>  	cs.req = req;
>>>  
>>> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
>>> index db136e045925..25e593e64c67 100644
>>> --- a/fs/fuse/fuse_dev_i.h
>>> +++ b/fs/fuse/fuse_dev_i.h
>>> @@ -32,6 +32,7 @@ struct fuse_copy_state {
>>>  	bool write:1;
>>>  	bool move_pages:1;
>>>  	bool is_uring:1;
>>> +	bool splice_read_user_pages:1;
>>>  	struct {
>>>  		unsigned int copied_sz; /* copied size into the user buffer */
>>>  	} ring;
>>> @@ -51,8 +52,8 @@ struct fuse_req *fuse_request_find(struct fuse_pqueue *fpq, u64 unique);
>>>  
>>>  void fuse_dev_end_requests(struct list_head *head);
>>>  
>>> -void fuse_copy_init(struct fuse_copy_state *cs, bool write,
>>> -			   struct iov_iter *iter);
>>> +void fuse_copy_init(struct fuse_copy_state *cs, struct fuse_conn *conn,
>>> +		    bool write, struct iov_iter *iter);
>>>  int fuse_copy_args(struct fuse_copy_state *cs, unsigned int numargs,
>>>  		   unsigned int argpages, struct fuse_arg *args,
>>>  		   int zeroing);
>>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>>> index 3d5289cb82a5..e21875f16220 100644
>>> --- a/fs/fuse/fuse_i.h
>>> +++ b/fs/fuse/fuse_i.h
>>> @@ -898,6 +898,9 @@ struct fuse_conn {
>>>  	/* Use io_uring for communication */
>>>  	bool io_uring:1;
>>>  
>>> +	/* Allow splice for reading user pages */
>>> +	bool splice_read_user_pages:1;
>>> +
>>>  	/** Maximum stack depth for passthrough backing files */
>>>  	int max_stack_depth;
>>>  
>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>> index 43b6643635ee..e82e96800fde 100644
>>> --- a/fs/fuse/inode.c
>>> +++ b/fs/fuse/inode.c
>>> @@ -1439,6 +1439,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>>>  
>>>  			if (flags & FUSE_REQUEST_TIMEOUT)
>>>  				timeout = arg->request_timeout;
>>> +
>>> +			if (flags & FUSE_SPLICE_READ_USER_PAGES)
>>> +				fc->splice_read_user_pages = true;
>>
>>
>> Shouldn't that check for capable(CAP_SYS_ADMIN)? Isn't the issue
>> that one can access file content although the write is already
>> marked as completed? I.e. a fuse file system might get data
>> it was never exposed to and possibly secret data?
>> A more complex version version could check for CAP_SYS_ADMIN, but
>> also allow later on read/write to files that have the same uid as
>> the fuser-server process?
>>
> 
> IDGI. I don't see how this allows the server access to something it
> didn't have access to before.
> 
> This patchset seems to be about a "contract" between the kernel and the
> userland server. The server is agreeing to be very careful about not
> touching pages after a write request completes, and the kernel allows
> splicing the pages if that's the case.
> 
> Can you explain the potential attack vector?

Let's the server claim it does FUSE_SPLICE_READ_USER_PAGES, i.e. claims
it stops using splice buffers before completing write requests. But then
it actually first replies to the write and after an arbitrary amount
of time writes out the splice buffer. User application might be using
the buffer it send for write for other things and might not want to
expose that. I.e. application expects that after write(, buf,)
it can use 'buf' for other purposes and that the file system does not
access it anymore once write() is complete. I.e. it can put sensitive
data into the buffer, which it might not want to expose.
From my point of the issue is mainly with allow_other in combination
with "user_allow_other" in libfuse, as root has better ways to access data.


Thanks,
Bernd


