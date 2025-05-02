Return-Path: <linux-fsdevel+bounces-47923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E20AA7328
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 15:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59C1E7B6692
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 13:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862642550A9;
	Fri,  2 May 2025 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="HOGu/oGM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aqKijeqk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F65254AF5
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746191779; cv=none; b=JDaOs0+uei+wG0g4iqeSVxZ/LoCywjcOHg9OHStDijaXXXa9W8nEHHJK6IvKKR29kTEHvf/MMXnPb5bvpgl6rCgfXwJrTnnNqVE3sHE8W9ks8c5J9JxMCClN2usTcxx2aQHbEHujvmu9pqdi92cqLQo4uTck+bjYKU0NOk2voh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746191779; c=relaxed/simple;
	bh=n0lgB4b2Bx6I8wlLQWgZ7ZRinU+5kfnUQqN+kSff0Bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pkwpawXpBjSGWgQnKZDVw3VQBVvxXglN8rjPcCPoopdkOnJ8Papzn04Lp9c2BP9CP3Jq7kZp3dhkHqxUwYEDgiZ54AmqrjJS1PGnCdnivKAcXUzNEiTj7Fe+ClOu983xhiEGVQ/wztgIttx6RF/St7dSzqyu6dtHcs8+ZG1KzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=HOGu/oGM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aqKijeqk; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5846D25400EE;
	Fri,  2 May 2025 09:16:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 02 May 2025 09:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746191774;
	 x=1746278174; bh=lyCok09Flhdnpo9gZAHP46RSJ9bt00BSWsfNVrPOGx8=; b=
	HOGu/oGMq289Izx72+PNBKJJ+3DSJ/ZczTDv+pTjUajli3C7H90XvT95zYAR4H9g
	5KiTTtaF9sXwr9E01l6nGjMB/GSPczTbIoSqccPrTIv7oQ5an5mh99cFiH3jGDvi
	C2PuzfHZQOMly88RbQ1XyyXiRb69MeosvBUlqjCDNTcZrEEZV4Un4H0+avVVK5Ie
	7lCmJsjLURwvYde1awNH7UWqhC07W+lcI132/tKCfPtxIo2W8YAg2DTKf5Cul+19
	43eqmJvx7iTamMePWh/r8EBemmA169s2O+I/lXqNjfKcgu2ezo0GuEGnK17eeoSh
	Q4pFYl4YuzW7zxQwYWn3iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746191774; x=
	1746278174; bh=lyCok09Flhdnpo9gZAHP46RSJ9bt00BSWsfNVrPOGx8=; b=a
	qKijeqkIU7QsHUTFJ0bnED9S4wzK3rwOvC+k0dXOpjTVn0DT7wxCQCniExE8eUac
	WLXf+4UUTyWW+/UZScdI28CeYVEzPeaG4nmXSTqHGzdHqfc4CsE2CK3BPGfN1/Ez
	NnAF9eyd6FZH9k+D/U4UoBzvgTlcB67MxphNo4nQJ4COTWfMxw+co3EYXqtrzaCk
	OgOKDoY92UGNpbVQuMVnw9DDwVPMA/KqW/APuumpAL/N3WLogt8UdEg2ZIB77hC4
	RIbfe8a/PwjPGFdbJvT9FQ+nZ111rA8DvgkY3EVyUsoJSo4KipBrlf3x4lk8uiBV
	GZZXZOGIS9ibgSKfsZUrw==
X-ME-Sender: <xms:ncUUaKR-Xh3TcRYS3Gxu1S61NU-b0LGtuELxMSpbNo5rDSl61NBECQ>
    <xme:ncUUaPxfKaZRSSLkssNPal6n6255f9EzaXTWI4DQnFXfR7Dk8puMExCNEQsUNH6Nc
    xSEUmS-CjfZdmfn>
X-ME-Received: <xmr:ncUUaH2eiue8XrLwhESvLE3c5W0V1yIECHEdoxyYs3M1gyaOwPdN0BX4TUm2Dsy_hzk9reY9ukSQGYNfm9hU-gcG6Uq8oGRpX_NbRnbs87pPCLpM68zZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepffejveeffeej
    gffhfefhieeuffffteeltdfghffhtddtfeeuveelvdelteefvedtnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhorghn
    nhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsii
    gvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:ncUUaGA1iebyhGyoinG3qh8taeOa8oO_P2JZi_dXIvzbaGeWaPdwFg>
    <xmx:ncUUaDi-Ix-6lPx245_Dt5qS_Ir9QxY12Hn3PrxL5M-v0UmXFmmDcw>
    <xmx:ncUUaCrqpMsMxvJ5QbNR5AmzRhkr8eY5nKUi9s4y7QhFXZkqATDeFg>
    <xmx:ncUUaGgB75zzLrzkaOyEaLZnOweB7Pz35_O9STerJO3AR60g4P27eg>
    <xmx:nsUUaDnxDrwcwStTTnmF4lgPUrn7aGyHQM93pffDCmBsfzQaxR7BI1QV>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 09:16:12 -0400 (EDT)
Message-ID: <05cdb745-632e-42b0-8c44-ee2af09e9869@fastmail.fm>
Date: Fri, 2 May 2025 15:16:12 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: use splice for reading user pages on servers
 that enable it
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, jlayton@kernel.org, kernel-team@meta.com
References: <20250422235607.3652064-1-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250422235607.3652064-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/23/25 01:56, Joanne Koong wrote:
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
> Allow servers with CAP_SYS_ADMIN privileges to enable zero-copy splice
> for servicing client direct io writes. By enabling this, the server
> understands that they should not continue accessing the pipe buffer
> after completing the request or may face incorrect data if they do so.
> Only servers with CAP_SYS_ADMIN may enable this, since having access to
> the underlying user pages may allow servers to snoop or modify the
> user pages after completing the request.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Bernd Schubert <bschubert@ddn.com>

> 
> ---
> 
> Changes from v1 -> v2:
> * Gate this behind CAP_SYS_ADMIN (Bernd)
> v1: https://lore.kernel.org/linux-fsdevel/20250419000614.3795331-1-joannelkoong@gmail.com/
> 
> ---
>  fs/fuse/dev.c             | 18 ++++++++++--------
>  fs/fuse/dev_uring.c       |  4 ++--
>  fs/fuse/fuse_dev_i.h      |  5 +++--
>  fs/fuse/fuse_i.h          |  3 +++
>  fs/fuse/inode.c           |  5 ++++-
>  include/uapi/linux/fuse.h |  9 +++++++++
>  6 files changed, 31 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 67d07b4c778a..e4949c379eaf 100644
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
> +			 * copy user pages if server does not support reading
> +			 * user pages through splice.
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
> index 43b6643635ee..8b78dacf6c97 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1439,6 +1439,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  
>  			if (flags & FUSE_REQUEST_TIMEOUT)
>  				timeout = arg->request_timeout;
> +
> +			if (flags & FUSE_SPLICE_READ_USER_PAGES && capable(CAP_SYS_ADMIN))
> +				fc->splice_read_user_pages = true;
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
> index 122d6586e8d4..fecb06921da9 100644
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
> @@ -443,6 +446,11 @@ struct fuse_file_lock {
>   * FUSE_OVER_IO_URING: Indicate that client supports io-uring
>   * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
>   *			 init_out.request_timeout contains the timeout (in secs)
> + * FUSE_SPLICE_READ_USER_PAGES: kernel supports splice on the device for reading
> + *				user pages. If the server enables this, then the
> + *				server should not access the pipe buffer after
> + *				completing the request. Only servers with
> + *				CAP_SYS_ADMIN privileges can enable this.
>   */
>  #define FUSE_ASYNC_READ		(1 << 0)
>  #define FUSE_POSIX_LOCKS	(1 << 1)
> @@ -490,6 +498,7 @@ struct fuse_file_lock {
>  #define FUSE_ALLOW_IDMAP	(1ULL << 40)
>  #define FUSE_OVER_IO_URING	(1ULL << 41)
>  #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
> +#define FUSE_SPLICE_READ_USER_PAGES (1ULL << 43)
>  
>  /**
>   * CUSE INIT request/reply flags


