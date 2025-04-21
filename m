Return-Path: <linux-fsdevel+bounces-46796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13FBA95065
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 13:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFCE3B05AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046E625A2C3;
	Mon, 21 Apr 2025 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="oNdWHgIR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PXnTznZ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901C64C85
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745236151; cv=none; b=gs5z8zBD5HVm7vHTSMe9ObrH9DrRvn2hNSX0Dm/jj74kza1gRq4lDpq2wKPXRmiHkCsRyIX8oFewNl3XiRK0rsAaikrEqQbJK3KbV42zmSJbnQI7WzCTrwMGuLo1aaQJXuMLbdWhZNrrVduOM0XkpBTqMFUZBaqCzgmDqRO62fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745236151; c=relaxed/simple;
	bh=wnDz40pXpTbPOK2qXeuXYTl1grBp1CrmffnPWUDso1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxZgbx8kYwLgrohXdfYtKOcQiMem81f23HRPKjmXhgDadeo2k6mX32qNljz94rFrJVgoCFn7OgCErZrz3314nbT3p9c2nHyBxTnP49yVcM9+wjEKQHZ1S4EXqb2gCOP2KcyaSmoZUzyB0ctowYFy6RN9BQLjemdYWhVIGgyeDwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=oNdWHgIR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PXnTznZ8; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7EC4D13803E1;
	Mon, 21 Apr 2025 07:49:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 21 Apr 2025 07:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745236147;
	 x=1745322547; bh=GYrVchP95o3lewvOr3MSy60TY/Dz3w/qtJXYB/wWZGg=; b=
	oNdWHgIRWCJz7DvCBpQzJouWoPhR78ju4OGBTj6zxBWAEQM3C+ZKWom9cO+cP0fE
	yFxj6dJEQWPhFtL2Tc1Q0znEAqomVLQmE4+OfvouE6BL6aRrbR6SbRC9UzxLumB8
	Xamb0zWaZR18mWRGPxaHIMquqfKA2NyqLIUxzdyuhlvyb4fX2uBwrk4vDJdgwbG3
	7MjmIe8O3jqOFxQybBLDIUMcQf1QN13/dGzh4peJttwlgRCZ/gSgEkXeDEZLIgkO
	JHOI+3dVlT1vOowM4PwQMj5TLDo+lSka5A3jFkAVk3POdJ2qh8y5S3Uxp9Pw7DW5
	qGmwiPoOH2ZxYGP++pphcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745236147; x=
	1745322547; bh=GYrVchP95o3lewvOr3MSy60TY/Dz3w/qtJXYB/wWZGg=; b=P
	XnTznZ8CRmlFut22yL82FuAwXVrzge4W38Oe/IiO5XMbsdjK+hWhAD1WYHS22v9I
	YfkOALkPAXPDC+fP0Ad8H6vJjFdV0GCzr7ToA8gXCOmOXfDL6w5VQfHQtHXBks+p
	iZh92JnKixoS899kFCnuZUTdvVVeLCVaJF//o53Yz9cRqAP9J0csvgp5IBaGQr6D
	75ID20/zA4IvLIpkEW2u7UDdlZ8cJ2h2zAXtj+EAk9oin7RtsmieT7g7PoyZ2NUt
	EEuNfw9z4cJp11L3Egcd9SOdcES4+9N/S82pAjdtcAWsNCIZXkRcAwXuyWFHT3yP
	7dfqj97F1oORce7SguOQw==
X-ME-Sender: <xms:szAGaCct-X63z_L4UgU76O3CrVWIsgmLwO0skY45CskZ6D5klUppNg>
    <xme:szAGaMNfk6hjxJENiYKnBhyUDQCrRlDB34J_MP1zmqG7ZJnFpP4m51qaxqziEHiaQ
    O6csJPPvEnCoCdJ>
X-ME-Received: <xmr:szAGaDhQ7Yc4_UqHavzhq8s5e68ats58R-Z6-2BtrLw6bCqJsftEFHe_VZt752jCtxkTDoLtTS24aKO6i48ncijez2WbD_8Y4tIcE9LKnXRz-cZ9QA_J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledt
    udfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    lhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrg
    hmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:szAGaP_joN6jdNNfzNm64WezNi0bTs9Nnbh99E8NuQvPqp_lrhpfSQ>
    <xmx:szAGaOvxr-TPcGXZp_ni_Q5My6xzBJMBNPGmnxmnHdzal88XiNuBWg>
    <xmx:szAGaGG_zcFXA_L6aUd2lzvo0oIaiMIAIG2_9-g6bM98Yx_1ks6fPg>
    <xmx:szAGaNMzlVyT-wbAGpVGXWELcaKzCCHYND_C4iCg8MwDC6C90I8TVQ>
    <xmx:szAGaBBonZnN1VQf6Uriqf8s6Bb4MHf9F6VTMrYw86iK6p-foGH2CGeQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 07:49:06 -0400 (EDT)
Message-ID: <5332002a-e444-4f62-8217-8d124182290d@fastmail.fm>
Date: Mon, 21 Apr 2025 13:49:05 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fuse: use splice for reading user pages on servers
 that enable it
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, jlayton@kernel.org, kernel-team@meta.com
References: <20250419000614.3795331-1-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250419000614.3795331-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/19/25 02:06, Joanne Koong wrote:
> For direct io writes, splice is disabled when forwarding pages from the
> client to the server. This is because the pages in the pipe buffer are
> user pages, which is controlled by the client. Thus if a server replies
> to the request and then keeps accessing the pages afterwards, there is
> the possibility that the client may have modified the contents of the
> pages in the meantime. More context on this can be found in commit
> 0c4bcfdecb1a ("fuse: fix pipe buffer lifetime for direct_io").
> 
> For servers that do not need to access pages after answering the
> request, splice gives a non-trivial improvement in performance.
> Benchmarks show roughly a 40% speedup.
> 
> Allow servers to enable zero-copy splice for servicing client direct io
> writes. By enabling this, the server understands that they should not
> continue accessing the pipe buffer after completing the request or may
> face incorrect data if they do so.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c             | 18 ++++++++++--------
>  fs/fuse/dev_uring.c       |  4 ++--
>  fs/fuse/fuse_dev_i.h      |  5 +++--
>  fs/fuse/fuse_i.h          |  3 +++
>  fs/fuse/inode.c           |  5 ++++-
>  include/uapi/linux/fuse.h |  8 ++++++++
>  6 files changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 67d07b4c778a..1b0ea8593f74 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -816,12 +816,13 @@ static int unlock_request(struct fuse_req *req)
>  	return err;
>  }
>  
> -void fuse_copy_init(struct fuse_copy_state *cs, bool write,
> -		    struct iov_iter *iter)
> +void fuse_copy_init(struct fuse_copy_state *cs, struct fuse_conn *fc,
> +		    bool write, struct iov_iter *iter)
>  {
>  	memset(cs, 0, sizeof(*cs));
>  	cs->write = write;
>  	cs->iter = iter;
> +	cs->splice_read_user_pages = fc->splice_read_user_pages;
>  }
>  
>  /* Unmap and put previous page of userspace buffer */
> @@ -1105,9 +1106,10 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
>  		if (cs->write && cs->pipebufs && page) {
>  			/*
>  			 * Can't control lifetime of pipe buffers, so always
> -			 * copy user pages.
> +			 * copy user pages if server does not support splice
> +			 * for reading user pages.
>  			 */
> -			if (cs->req->args->user_pages) {
> +			if (cs->req->args->user_pages && !cs->splice_read_user_pages) {
>  				err = fuse_copy_fill(cs);
>  				if (err)
>  					return err;
> @@ -1538,7 +1540,7 @@ static ssize_t fuse_dev_read(struct kiocb *iocb, struct iov_iter *to)
>  	if (!user_backed_iter(to))
>  		return -EINVAL;
>  
> -	fuse_copy_init(&cs, true, to);
> +	fuse_copy_init(&cs, fud->fc, true, to);
>  
>  	return fuse_dev_do_read(fud, file, &cs, iov_iter_count(to));
>  }
> @@ -1561,7 +1563,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
>  	if (!bufs)
>  		return -ENOMEM;
>  
> -	fuse_copy_init(&cs, true, NULL);
> +	fuse_copy_init(&cs, fud->fc, true, NULL);
>  	cs.pipebufs = bufs;
>  	cs.pipe = pipe;
>  	ret = fuse_dev_do_read(fud, in, &cs, len);
> @@ -2227,7 +2229,7 @@ static ssize_t fuse_dev_write(struct kiocb *iocb, struct iov_iter *from)
>  	if (!user_backed_iter(from))
>  		return -EINVAL;
>  
> -	fuse_copy_init(&cs, false, from);
> +	fuse_copy_init(&cs, fud->fc, false, from);
>  
>  	return fuse_dev_do_write(fud, &cs, iov_iter_count(from));
>  }
> @@ -2301,7 +2303,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
>  	}
>  	pipe_unlock(pipe);
>  
> -	fuse_copy_init(&cs, false, NULL);
> +	fuse_copy_init(&cs, fud->fc, false, NULL);
>  	cs.pipebufs = bufs;
>  	cs.nr_segs = nbuf;
>  	cs.pipe = pipe;
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index ef470c4a9261..52b883a6a79d 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -593,7 +593,7 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
>  	if (err)
>  		return err;
>  
> -	fuse_copy_init(&cs, false, &iter);
> +	fuse_copy_init(&cs, ring->fc, false, &iter);
>  	cs.is_uring = true;
>  	cs.req = req;
>  
> @@ -623,7 +623,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
>  		return err;
>  	}
>  
> -	fuse_copy_init(&cs, true, &iter);
> +	fuse_copy_init(&cs, ring->fc, true, &iter);
>  	cs.is_uring = true;
>  	cs.req = req;
>  
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index db136e045925..25e593e64c67 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -32,6 +32,7 @@ struct fuse_copy_state {
>  	bool write:1;
>  	bool move_pages:1;
>  	bool is_uring:1;
> +	bool splice_read_user_pages:1;
>  	struct {
>  		unsigned int copied_sz; /* copied size into the user buffer */
>  	} ring;
> @@ -51,8 +52,8 @@ struct fuse_req *fuse_request_find(struct fuse_pqueue *fpq, u64 unique);
>  
>  void fuse_dev_end_requests(struct list_head *head);
>  
> -void fuse_copy_init(struct fuse_copy_state *cs, bool write,
> -			   struct iov_iter *iter);
> +void fuse_copy_init(struct fuse_copy_state *cs, struct fuse_conn *conn,
> +		    bool write, struct iov_iter *iter);
>  int fuse_copy_args(struct fuse_copy_state *cs, unsigned int numargs,
>  		   unsigned int argpages, struct fuse_arg *args,
>  		   int zeroing);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 3d5289cb82a5..e21875f16220 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -898,6 +898,9 @@ struct fuse_conn {
>  	/* Use io_uring for communication */
>  	bool io_uring:1;
>  
> +	/* Allow splice for reading user pages */
> +	bool splice_read_user_pages:1;
> +
>  	/** Maximum stack depth for passthrough backing files */
>  	int max_stack_depth;
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 43b6643635ee..e82e96800fde 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1439,6 +1439,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  
>  			if (flags & FUSE_REQUEST_TIMEOUT)
>  				timeout = arg->request_timeout;
> +
> +			if (flags & FUSE_SPLICE_READ_USER_PAGES)
> +				fc->splice_read_user_pages = true;


Shouldn't that check for capable(CAP_SYS_ADMIN)? Isn't the issue
that one can access file content although the write is already
marked as completed? I.e. a fuse file system might get data
it was never exposed to and possibly secret data?
A more complex version version could check for CAP_SYS_ADMIN, but
also allow later on read/write to files that have the same uid as
the fuser-server process?


Thanks,
Bernd


>  		} else {
>  			ra_pages = fc->max_read / PAGE_SIZE;
>  			fc->no_lock = true;
> @@ -1489,7 +1492,7 @@ void fuse_send_init(struct fuse_mount *fm)
>  		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
>  		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
>  		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP |
> -		FUSE_REQUEST_TIMEOUT;
> +		FUSE_REQUEST_TIMEOUT | FUSE_SPLICE_READ_USER_PAGES;
>  #ifdef CONFIG_FUSE_DAX
>  	if (fm->fc->dax)
>  		flags |= FUSE_MAP_ALIGNMENT;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 122d6586e8d4..b35f6bbcb322 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -235,6 +235,9 @@
>   *
>   *  7.44
>   *  - add FUSE_NOTIFY_INC_EPOCH
> + *
> + *  7.45
> + *  - add FUSE_SPLICE_READ_USER_PAGES
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -443,6 +446,10 @@ struct fuse_file_lock {
>   * FUSE_OVER_IO_URING: Indicate that client supports io-uring
>   * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
>   *			 init_out.request_timeout contains the timeout (in secs)
> + * FUSE_SPLICE_READ_USER_PAGES: kernel supports splice on the device for reading
> + *				user pages. If the server enables this, then the
> + *				server should not access the pipe buffer after
> + *				completing the request.
>   */
>  #define FUSE_ASYNC_READ		(1 << 0)
>  #define FUSE_POSIX_LOCKS	(1 << 1)
> @@ -490,6 +497,7 @@ struct fuse_file_lock {
>  #define FUSE_ALLOW_IDMAP	(1ULL << 40)
>  #define FUSE_OVER_IO_URING	(1ULL << 41)
>  #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
> +#define FUSE_SPLICE_READ_USER_PAGES (1ULL << 43)
>  
>  /**
>   * CUSE INIT request/reply flags


