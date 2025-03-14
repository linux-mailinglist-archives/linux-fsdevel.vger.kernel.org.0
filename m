Return-Path: <linux-fsdevel+bounces-44100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 490D3A6215C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 00:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82498839CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 23:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23491F3FCB;
	Fri, 14 Mar 2025 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="D0AnImFc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1Rg2oL9X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BC91F92E
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993919; cv=none; b=Lpy8E9MoZRfqcT5zYyCP4brZ/y8GY6n449rdmMsk6zEyk/w1rvS+iKNLC28tiHNMmLVzt3MucRXMnlMxPeoRdU2R71sAm9yDZLr7UOXwhziJY1KVp+tbODAOA97i6QewQ5tGeEi0joUKhxS5O96QfwjJ/4pvEkuWiHCdBhiMLrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993919; c=relaxed/simple;
	bh=556HJkKwzMZFWmzoajXIE4VFJMWnlEB/51tSGEq0i70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZJpIuTUgB03RSa+Jj9tcyZtKKc+a3xTRlqfsj2YPktuz7QtOFzYpvRQpwLhyxe4/AY7ZMGyAQAVqLVZcnGXZbkEmPcsVBkZz4B4FSjv5PxTYifvYAaje/zci3uIuwBIvCpQpvYDa8DlhdPZwJPrV2GIm2RQKDj+EdnssdwEk38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=D0AnImFc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1Rg2oL9X; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 10FBC1382CF7;
	Fri, 14 Mar 2025 19:11:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 14 Mar 2025 19:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741993907;
	 x=1742080307; bh=X+eIMbBdMSmRSvTq4eSDsMe5w4F9gXWs8myEodpNKCQ=; b=
	D0AnImFchcUAvDS7wxgJCppNBKVqhn5uNt2GM30CkJkhe7M4oiSyXQC/vHo/iQx4
	BQE8/Fh490FBLQ0S2/rvUayCX04htHxNSXhvDk14ShvNzqSbLrix7ytKyAuEJ6/Z
	wmXIdoDWSlMUXzd19nhQoVf5lIK3opN2Zrd20AtzQ6oPRoNbxz1SQg3tJ15ZwEuM
	qWl55cFX0gTEGA5++Dx5LXCYf6KcV6m0LSriUyrX786c2rjgCm0JIVcwGeQ2KqCR
	dMMS42/hvzhKqIDTGmzK/IFinP/5tEWntdfS2ymxDIJQTZWiQ8aoYu0GXrbn4qN7
	pid+Huav28IX50eELMzYIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741993907; x=
	1742080307; bh=X+eIMbBdMSmRSvTq4eSDsMe5w4F9gXWs8myEodpNKCQ=; b=1
	Rg2oL9XwcMmSW8EFdsXcF2BDR6TW+ej9X9eY22PrDkUq7ieqzq5uwnBPUoVpc2yN
	Kka10EFT0MFar9MZmLWVZSlcLgSjYTx3pEOFZR1cQV5EhDTtWRIEgP/6pirpuAH/
	hRHpCdXcFnYkb7Dkw40HWDRtzKfctID+0l8/h7ukpwFg+3sgRJ1tWooI+0EF3YNU
	EPKzi8s5AStHrrrWhFjWFnmMVVmjKOAGZGbju4MkDypY39EKyXcHqXe2XsvTFWzy
	T2n2WRns8LtN5fzQrelpsCe8IkJgVbI98xCQJA9Nc3Zgyw7Uu/uCx7vmxncqVsNf
	joPW7EoiQ5pfRECo8bUag==
X-ME-Sender: <xms:sbfUZwyphthuxbDgEJPQ5GTQYIpRxUJe_OQrHf86N25yc_6BtEhGNw>
    <xme:sbfUZ0TePLSMJguVfMLWRG4iEpp5pK1XlvQIEZ9gNjq3z6jkZh3VWsZdPz3t8dRje
    7q8DtAoirll4mfK>
X-ME-Received: <xmr:sbfUZyUTrENB8oMkjB1q_bF-mbjIEQ8wWd3J8tSnKlSvCQczTazXh94KLZCmGHhBmzrGF2NvAmXXe4640YzhUij21uXiAH7zpvVmpHoYQmFOo0sKZDlj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedvudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledt
    udfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    vghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:sbfUZ-jQdmo4BHMUq1xmJtH9lGIN966C0V6bEKbC76MUia0JOxGodQ>
    <xmx:sbfUZyAnaxYmxaMBGHoXMUfN5Lwm5fkiuEgCmQCN8sKyLM72oN24rg>
    <xmx:sbfUZ_IELSMhUvyx18vNUIp1Y8i61HEjPhkg2Bxy-78XkFN1p295Rg>
    <xmx:sbfUZ5AYUkosMxysFf0oajG7Gr3muAd0_y3ywxrRxZpQ20per9HKjA>
    <xmx:s7fUZ18pmOP2n1TiwcCLTVBI4prntidnC04W320s0b19Mfct4GqncE77>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 19:11:45 -0400 (EDT)
Message-ID: <8aca27b0-609b-44c4-90ff-314e3c086b90@fastmail.fm>
Date: Sat, 15 Mar 2025 00:11:44 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fuse: support configurable number of uring queues
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: kernel-team@meta.com
References: <20250314204437.726538-1-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250314204437.726538-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks Joanne! That is rather close to what I wanted to add,
just a few comments.

On 3/14/25 21:44, Joanne Koong wrote:
> In the current uring design, the number of queues is equal to the number
> of cores on a system. However, on high-scale machines where there are
> hundreds of cores, having such a high number of queues is often
> overkill and resource-intensive. As well, in the current design where
> the queue for the request is set to the cpu the task is currently
> executing on (see fuse_uring_task_to_queue()), there is no guarantee
> that requests for the same file will be sent to the same queue (eg if a
> task is preempted and moved to a different cpu) which may be problematic
> for some servers (eg if the server is append-only and does not support
> unordered writes).
> 
> In this commit, the server can configure the number of uring queues
> (passed to the kernel through the init reply). The number of queues must
> be a power of two, in order to make queue assignment for a request
> efficient. If the server specifies a non-power of two, then it will be
> automatically rounded down to the nearest power of two. If the server
> does not specify the number of queues, then this will automatically
> default to the current behavior where the number of queues will be equal
> to the number of cores with core and numa affinity. The queue id hash
> is computed on the nodeid, which ensures that requests for the same file
> will be forwarded to the same queue.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev_uring.c       | 48 +++++++++++++++++++++++++++++++++++----
>  fs/fuse/dev_uring_i.h     | 11 +++++++++
>  fs/fuse/fuse_i.h          |  1 +
>  fs/fuse/inode.c           |  4 +++-
>  include/uapi/linux/fuse.h |  6 ++++-
>  5 files changed, 63 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 64f1ae308dc4..f173f9e451ac 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -209,9 +209,10 @@ void fuse_uring_destruct(struct fuse_conn *fc)
>  static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>  {
>  	struct fuse_ring *ring;
> -	size_t nr_queues = num_possible_cpus();
> +	size_t nr_queues = fc->uring_nr_queues;
>  	struct fuse_ring *res = NULL;
>  	size_t max_payload_size;
> +	unsigned int nr_cpus = num_possible_cpus();
>  
>  	ring = kzalloc(sizeof(*fc->ring), GFP_KERNEL_ACCOUNT);
>  	if (!ring)
> @@ -237,6 +238,13 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>  
>  	fc->ring = ring;
>  	ring->nr_queues = nr_queues;
> +	if (nr_queues == nr_cpus) {
> +		ring->core_affinity = 1;
> +	} else {
> +		WARN_ON(!nr_queues || nr_queues > nr_cpus ||
> +			!is_power_of_2(nr_queues));
> +		ring->qid_hash_bits = ilog2(nr_queues);
> +	}
>  	ring->fc = fc;
>  	ring->max_payload_sz = max_payload_size;
>  	atomic_set(&ring->queue_refs, 0);
> @@ -1217,12 +1225,24 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
>  	fuse_uring_send(ent, cmd, err, issue_flags);
>  }
>  
> -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
> +static unsigned int hash_qid(struct fuse_ring *ring, u64 nodeid)
> +{
> +	if (ring->nr_queues == 1)
> +		return 0;
> +
> +	return hash_long(nodeid, ring->qid_hash_bits);
> +}
> +
> +static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring,
> +							struct fuse_req *req)
>  {
>  	unsigned int qid;
>  	struct fuse_ring_queue *queue;
>  
> -	qid = task_cpu(current);
> +	if (ring->core_affinity)
> +		qid = task_cpu(current);
> +	else
> +		qid = hash_qid(ring, req->in.h.nodeid);

I think we need to handle numa affinity.

>  
>  	if (WARN_ONCE(qid >= ring->nr_queues,
>  		      "Core number (%u) exceeds nr queues (%zu)\n", qid,
> @@ -1253,7 +1273,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
>  	int err;
>  
>  	err = -EINVAL;
> -	queue = fuse_uring_task_to_queue(ring);
> +	queue = fuse_uring_task_to_queue(ring, req);
>  	if (!queue)
>  		goto err;
>  
> @@ -1293,7 +1313,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>  	struct fuse_ring_queue *queue;
>  	struct fuse_ring_ent *ent = NULL;
>  
> -	queue = fuse_uring_task_to_queue(ring);
> +	queue = fuse_uring_task_to_queue(ring, req);
>  	if (!queue)
>  		return false;
>  
> @@ -1344,3 +1364,21 @@ static const struct fuse_iqueue_ops fuse_io_uring_ops = {
>  	.send_interrupt = fuse_dev_queue_interrupt,
>  	.send_req = fuse_uring_queue_fuse_req,
>  };
> +
> +void fuse_uring_set_nr_queues(struct fuse_conn *fc, unsigned int nr_queues)
> +{
> +	if (!nr_queues) {
> +		fc->uring_nr_queues = num_possible_cpus();
> +		return;
> +	}
> +
> +	if (!is_power_of_2(nr_queues)) {
> +		unsigned int old_nr_queues = nr_queues;
> +
> +		nr_queues = rounddown_pow_of_two(nr_queues);
> +		pr_debug("init: uring_nr_queues=%u is not a power of 2. "
> +			 "Rounding down uring_nr_queues to %u\n",
> +			 old_nr_queues, nr_queues);
> +	}
> +	fc->uring_nr_queues = min(nr_queues, num_possible_cpus());
> +}
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index ce823c6b1806..81398b5b8bf2 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -122,6 +122,12 @@ struct fuse_ring {
>  	 */
>  	unsigned int stop_debug_log : 1;
>  
> +	/* Each core has its own queue */
> +	unsigned int core_affinity : 1;
> +
> +	/* Only used if core affinity is not set */
> +	unsigned int qid_hash_bits;
> +
>  	wait_queue_head_t stop_waitq;
>  
>  	/* async tear down */
> @@ -143,6 +149,7 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
>  void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req);
>  bool fuse_uring_queue_bq_req(struct fuse_req *req);
>  bool fuse_uring_request_expired(struct fuse_conn *fc);
> +void fuse_uring_set_nr_queues(struct fuse_conn *fc, unsigned int nr_queues);
>  
>  static inline void fuse_uring_abort(struct fuse_conn *fc)
>  {
> @@ -200,6 +207,10 @@ static inline bool fuse_uring_request_expired(struct fuse_conn *fc)
>  	return false;
>  }
>  
> +static inline void fuse_uring_set_nr_queues(struct fuse_conn *fc, unsigned int nr_queues)
> +{
> +}
> +
>  #endif /* CONFIG_FUSE_IO_URING */
>  
>  #endif /* _FS_FUSE_DEV_URING_I_H */
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 38a782673bfd..7c3010bda02d 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -962,6 +962,7 @@ struct fuse_conn {
>  #ifdef CONFIG_FUSE_IO_URING
>  	/**  uring connection information*/
>  	struct fuse_ring *ring;
> +	uint8_t uring_nr_queues;
>  #endif
>  
>  	/** Only used if the connection opts into request timeouts */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index fd48e8d37f2e..c168247d87f2 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1433,8 +1433,10 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  				else
>  					ok = false;
>  			}
> -			if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
> +			if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled()) {
>  				fc->io_uring = 1;
> +				fuse_uring_set_nr_queues(fc, arg->uring_nr_queues);
> +			}
>  
>  			if (flags & FUSE_REQUEST_TIMEOUT)
>  				timeout = arg->request_timeout;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 5ec43ecbceb7..0d73b8fcd2be 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -232,6 +232,9 @@
>   *
>   *  7.43
>   *  - add FUSE_REQUEST_TIMEOUT
> + *
> + * 7.44
> + * - add uring_nr_queues to fuse_init_out
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -915,7 +918,8 @@ struct fuse_init_out {
>  	uint32_t	flags2;
>  	uint32_t	max_stack_depth;
>  	uint16_t	request_timeout;
> -	uint16_t	unused[11];
> +	uint8_t		uring_nr_queues;
> +	uint8_t		unused[21];


I'm a bit scared that uint8_t might not be sufficient at some.
The largest system we have in the lab has 244 cores. So far
I'm still not sure if we are going to do queue-per-core or
are going to reduce it. That even might become a generic tuning
for us. If we add this value it probably would need to be
uint16_t. Though I wonder if we can do without this variable
and just set initialization to completed once the first
queue had an entry.


Thanks,
Bernd



