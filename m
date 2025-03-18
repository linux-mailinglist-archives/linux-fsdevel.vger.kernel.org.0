Return-Path: <linux-fsdevel+bounces-44307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D79A67156
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 11:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C808D16DAB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 10:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEE720767B;
	Tue, 18 Mar 2025 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="v+pLjI8+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K0rBO2sp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6920459F
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293993; cv=none; b=mQOjJaHP7j1Fbeot+qEGRGzhOPyjVJJ8sWZqKJLkOpixBzEdUG6F/j4SkB1ytHh4fRh8V+86F7FpglfSIkHk9YpgjiCdHt+Cvr7F6kkN5TQkKMjZ53r5bhVEr7FsaXnh/hUEmQQgPhhvu4gHy2XPx+eCPa+YjPQNX69xGLROI6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293993; c=relaxed/simple;
	bh=Md7SOUyTz98BAQTjS09GESFyT/x/SNz9zmJbelaZ000=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sde/5R3z/uz1OSlveR76lUAFPD4kNSkgYjvYRmvm1iCJioV5VIk5vngq+JQK3YJFL3IUAdIdqZS8AOmp9zMdx42JdgEsuH9MuVhRMZnzdk0og89qsZl9i3BTgrf2fNtPq8frTQxsyAsbFITGChFrTYeC/lfUOs1dFv8OHIt9+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=v+pLjI8+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K0rBO2sp; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E6AC425400C7;
	Tue, 18 Mar 2025 06:33:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 18 Mar 2025 06:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742293984;
	 x=1742380384; bh=oROQlZrLGhEBfYDqt5Y8DK6xEx5JQXJq71gnjt/CaC0=; b=
	v+pLjI8+40lCMei3oLavCv3g8MXH9tjAXQmIDiU5wgUn8+iBO/DnrxukwjoHmqVK
	NmSPpui/cVniW9VdFy6BX4s/B9mFnXSnPljlmp9zYm+x/k6azMK1+rB1v59+fL0T
	1i97lcUXC3e31XcrefP3y+MoAeSw5zkqnT1BhWFLBAIBWtXFj23fhniRejh8IbM2
	cSJiyBb7cTnLwrFzrm9u4nHr9Ys1Gu1bfrbxQpQeqP6rj/v41fR07V7y5rWK5bZe
	5LBkgU3FMvfy/gICsIydYDMiKR9iH1htIJRhU+ii8rPbT6DVn12Rl2P+hl9Zpkx+
	wOEuukWgZNTkebZTssTAYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742293984; x=
	1742380384; bh=oROQlZrLGhEBfYDqt5Y8DK6xEx5JQXJq71gnjt/CaC0=; b=K
	0rBO2sp+3ngSpTVQugZPd7ZzUDbOnuWJ2sSHJjujnZgs7wR85j8f4gkf+kiD8A7F
	pFEYaEtPJCCHD2g8I29swpeDhuzkjjHRBdkchu4YoiR5AD6AL6SyBbxqzTakYgFA
	E7NMTdIWh7F7GujQwoUiKS2030LBhSvLyBwatdb2wa9yZCzRJ+TPbicZmQBfOXGS
	j/a7Sy4L+Bnra/SI+41G9TJ6nlSS6NYxfIxNA3ormy02AzCc/fJdVYtIZiBq9Hbm
	RKdKD1EDWTodisr4xhtG2ijzKy/tv0QDhEe71GR+yILmu9HOlgjKyEaRPGUFwPP1
	OCMOXkd7MgljCc4KPerCA==
X-ME-Sender: <xms:4EvZZ0SeuoIAsCBiD1Lw3yaXu8_xG0ZFNijViC4zEjTT27G_F05wAQ>
    <xme:4EvZZxyXTHob9TzM_r8ktO9Gbaq0-msH9EWKCCqBmElg8L6XErtxnObLdGWp5RfPK
    Fxr69bWA39pLQpO>
X-ME-Received: <xmr:4EvZZx3Xj29HKgGBSUR1axrPyR_c8JlaMYLyq2Y2ZxH14LBlkQ2URea1k1n9fR1TjKxZqJmI_ItiPVSLrJa6GiUASN48S1EIY5X55t_2ZH8ICCXRXRfH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepudelfedvudev
    udevleegleffffekudekgeevlefgkeeluedvheekheehheekhfefnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    vghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:4EvZZ4ARInU1q3Lf__9QK1ECZhVRDWJ3pGjnSrtsv9srrrhrkQxBPQ>
    <xmx:4EvZZ9g3ftmbgEqgEfU_CrGzyl-lvAJb3dw79MccV5tFNDkdoHSo1A>
    <xmx:4EvZZ0pz8EzhLbmU4jKFVoPaH8d6JJfOR1naorx5FNm3ETc4dFnYww>
    <xmx:4EvZZwgky7ASvm1RV61HsdDO9HPGhlXxWKd42cRC05g1LBxAjdDP2w>
    <xmx:4EvZZ9crqneEZEeRfh9pFqrxhliJg8n-HFDdyM4Wr3me8qis9C_rgOgn>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 06:33:03 -0400 (EDT)
Message-ID: <1b249021-c69c-4548-b01b-0321b241d434@fastmail.fm>
Date: Tue, 18 Mar 2025 11:33:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fuse: support configurable number of uring queues
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <20250314204437.726538-1-joannelkoong@gmail.com>
 <8aca27b0-609b-44c4-90ff-314e3c086b90@fastmail.fm>
 <CAJnrk1YoN6gayDQ6hBMa9NnxgkOpf9qYmMRg9kP=2iQR9_B8Ew@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1YoN6gayDQ6hBMa9NnxgkOpf9qYmMRg9kP=2iQR9_B8Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/18/25 01:55, Joanne Koong wrote:
> Hi Bernd,
> Thanks for the quick turnaround on the review!
> 
> On Fri, Mar 14, 2025 at 4:11 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>> Thanks Joanne! That is rather close to what I wanted to add,
>> just a few comments.
>>
>> On 3/14/25 21:44, Joanne Koong wrote:
>>> In the current uring design, the number of queues is equal to the number
>>> of cores on a system. However, on high-scale machines where there are
>>> hundreds of cores, having such a high number of queues is often
>>> overkill and resource-intensive. As well, in the current design where
>>> the queue for the request is set to the cpu the task is currently
>>> executing on (see fuse_uring_task_to_queue()), there is no guarantee
>>> that requests for the same file will be sent to the same queue (eg if a
>>> task is preempted and moved to a different cpu) which may be problematic
>>> for some servers (eg if the server is append-only and does not support
>>> unordered writes).
>>>
>>> In this commit, the server can configure the number of uring queues
>>> (passed to the kernel through the init reply). The number of queues must
>>> be a power of two, in order to make queue assignment for a request
>>> efficient. If the server specifies a non-power of two, then it will be
>>> automatically rounded down to the nearest power of two. If the server
>>> does not specify the number of queues, then this will automatically
>>> default to the current behavior where the number of queues will be equal
>>> to the number of cores with core and numa affinity. The queue id hash
>>> is computed on the nodeid, which ensures that requests for the same file
>>> will be forwarded to the same queue.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> ---
>>>  fs/fuse/dev_uring.c       | 48 +++++++++++++++++++++++++++++++++++----
>>>  fs/fuse/dev_uring_i.h     | 11 +++++++++
>>>  fs/fuse/fuse_i.h          |  1 +
>>>  fs/fuse/inode.c           |  4 +++-
>>>  include/uapi/linux/fuse.h |  6 ++++-
>>>  5 files changed, 63 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>> index 64f1ae308dc4..f173f9e451ac 100644
>>> --- a/fs/fuse/dev_uring.c
>>> +++ b/fs/fuse/dev_uring.c
>>> @@ -209,9 +209,10 @@ void fuse_uring_destruct(struct fuse_conn *fc)
>>>  static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>>>  {
>>>       struct fuse_ring *ring;
>>> -     size_t nr_queues = num_possible_cpus();
>>> +     size_t nr_queues = fc->uring_nr_queues;
>>>       struct fuse_ring *res = NULL;
>>>       size_t max_payload_size;
>>> +     unsigned int nr_cpus = num_possible_cpus();
>>>
>>>       ring = kzalloc(sizeof(*fc->ring), GFP_KERNEL_ACCOUNT);
>>>       if (!ring)
>>> @@ -237,6 +238,13 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>>>
>>>       fc->ring = ring;
>>>       ring->nr_queues = nr_queues;
>>> +     if (nr_queues == nr_cpus) {
>>> +             ring->core_affinity = 1;
>>> +     } else {
>>> +             WARN_ON(!nr_queues || nr_queues > nr_cpus ||
>>> +                     !is_power_of_2(nr_queues));
>>> +             ring->qid_hash_bits = ilog2(nr_queues);
>>> +     }
>>>       ring->fc = fc;
>>>       ring->max_payload_sz = max_payload_size;
>>>       atomic_set(&ring->queue_refs, 0);
>>> @@ -1217,12 +1225,24 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
>>>       fuse_uring_send(ent, cmd, err, issue_flags);
>>>  }
>>>
>>> -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
>>> +static unsigned int hash_qid(struct fuse_ring *ring, u64 nodeid)
>>> +{
>>> +     if (ring->nr_queues == 1)
>>> +             return 0;
>>> +
>>> +     return hash_long(nodeid, ring->qid_hash_bits);
>>> +}
>>> +
>>> +static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring,
>>> +                                                     struct fuse_req *req)
>>>  {
>>>       unsigned int qid;
>>>       struct fuse_ring_queue *queue;
>>>
>>> -     qid = task_cpu(current);
>>> +     if (ring->core_affinity)
>>> +             qid = task_cpu(current);
>>> +     else
>>> +             qid = hash_qid(ring, req->in.h.nodeid);
>>
>> I think we need to handle numa affinity.
>>
> 
> Could you elaborate more on this? I'm not too familiar with how to
> enforce this in practice. As I understand it, the main goal of numa
> affinity is to make sure processes access memory that's physically
> closer to the CPU it's executing on. How does this usually get
> enforced at the kernel level?

The request comes on a specific core and that is on a numa node - 
we should try to avoid switching. If there is no queue for the
current core we should try to stay on the same numa node.
And we should probably also consider the waiting requests per
queue and distribute between that, although that is a bit
independent.

> 
>>>
>>>       if (WARN_ONCE(qid >= ring->nr_queues,
>>>                     "Core number (%u) exceeds nr queues (%zu)\n", qid,
>>> @@ -1253,7 +1273,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
>>>       int err;
>>>
>>>       err = -EINVAL;
>>> -     queue = fuse_uring_task_to_queue(ring);
>>> +     queue = fuse_uring_task_to_queue(ring, req);
>>>       if (!queue)
>>>               goto err;
>>>
>>> @@ -1293,7 +1313,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>>>       struct fuse_ring_queue *queue;
>>>       struct fuse_ring_ent *ent = NULL;
>>>
>>> -     queue = fuse_uring_task_to_queue(ring);
>>> +     queue = fuse_uring_task_to_queue(ring, req);
>>>       if (!queue)
>>>               return false;
>>>
>>> @@ -1344,3 +1364,21 @@ static const struct fuse_iqueue_ops fuse_io_uring_ops = {
>>>       .send_interrupt = fuse_dev_queue_interrupt,
>>>       .send_req = fuse_uring_queue_fuse_req,
>>>  };
>>> +
>>> +void fuse_uring_set_nr_queues(struct fuse_conn *fc, unsigned int nr_queues)
>>> +{
>>> +     if (!nr_queues) {
>>> +             fc->uring_nr_queues = num_possible_cpus();
>>> +             return;
>>> +     }
>>> +
>>> +     if (!is_power_of_2(nr_queues)) {
>>> +             unsigned int old_nr_queues = nr_queues;
>>> +
>>> +             nr_queues = rounddown_pow_of_two(nr_queues);
>>> +             pr_debug("init: uring_nr_queues=%u is not a power of 2. "
>>> +                      "Rounding down uring_nr_queues to %u\n",
>>> +                      old_nr_queues, nr_queues);
>>> +     }
>>> +     fc->uring_nr_queues = min(nr_queues, num_possible_cpus());
>>> +}
>>> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
>>> index ce823c6b1806..81398b5b8bf2 100644
>>> --- a/fs/fuse/dev_uring_i.h
>>> +++ b/fs/fuse/dev_uring_i.h
>>> @@ -122,6 +122,12 @@ struct fuse_ring {
>>>        */
>>>       unsigned int stop_debug_log : 1;
>>>
>>> +     /* Each core has its own queue */
>>> +     unsigned int core_affinity : 1;
>>> +
>>> +     /* Only used if core affinity is not set */
>>> +     unsigned int qid_hash_bits;
>>> +
>>>       wait_queue_head_t stop_waitq;
>>>
>>>       /* async tear down */
>>> @@ -143,6 +149,7 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
>>>  void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req);
>>>  bool fuse_uring_queue_bq_req(struct fuse_req *req);
>>>  bool fuse_uring_request_expired(struct fuse_conn *fc);
>>> +void fuse_uring_set_nr_queues(struct fuse_conn *fc, unsigned int nr_queues);
>>>
>>>  static inline void fuse_uring_abort(struct fuse_conn *fc)
>>>  {
>>> @@ -200,6 +207,10 @@ static inline bool fuse_uring_request_expired(struct fuse_conn *fc)
>>>       return false;
>>>  }
>>>
>>> +static inline void fuse_uring_set_nr_queues(struct fuse_conn *fc, unsigned int nr_queues)
>>> +{
>>> +}
>>> +
>>>  #endif /* CONFIG_FUSE_IO_URING */
>>>
>>>  #endif /* _FS_FUSE_DEV_URING_I_H */
>>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>>> index 38a782673bfd..7c3010bda02d 100644
>>> --- a/fs/fuse/fuse_i.h
>>> +++ b/fs/fuse/fuse_i.h
>>> @@ -962,6 +962,7 @@ struct fuse_conn {
>>>  #ifdef CONFIG_FUSE_IO_URING
>>>       /**  uring connection information*/
>>>       struct fuse_ring *ring;
>>> +     uint8_t uring_nr_queues;
>>>  #endif
>>>
>>>       /** Only used if the connection opts into request timeouts */
>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>> index fd48e8d37f2e..c168247d87f2 100644
>>> --- a/fs/fuse/inode.c
>>> +++ b/fs/fuse/inode.c
>>> @@ -1433,8 +1433,10 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>>>                               else
>>>                                       ok = false;
>>>                       }
>>> -                     if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
>>> +                     if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled()) {
>>>                               fc->io_uring = 1;
>>> +                             fuse_uring_set_nr_queues(fc, arg->uring_nr_queues);
>>> +                     }
>>>
>>>                       if (flags & FUSE_REQUEST_TIMEOUT)
>>>                               timeout = arg->request_timeout;
>>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>>> index 5ec43ecbceb7..0d73b8fcd2be 100644
>>> --- a/include/uapi/linux/fuse.h
>>> +++ b/include/uapi/linux/fuse.h
>>> @@ -232,6 +232,9 @@
>>>   *
>>>   *  7.43
>>>   *  - add FUSE_REQUEST_TIMEOUT
>>> + *
>>> + * 7.44
>>> + * - add uring_nr_queues to fuse_init_out
>>>   */
>>>
>>>  #ifndef _LINUX_FUSE_H
>>> @@ -915,7 +918,8 @@ struct fuse_init_out {
>>>       uint32_t        flags2;
>>>       uint32_t        max_stack_depth;
>>>       uint16_t        request_timeout;
>>> -     uint16_t        unused[11];
>>> +     uint8_t         uring_nr_queues;
>>> +     uint8_t         unused[21];
>>
>>
>> I'm a bit scared that uint8_t might not be sufficient at some.
>> The largest system we have in the lab has 244 cores. So far
>> I'm still not sure if we are going to do queue-per-core or
>> are going to reduce it. That even might become a generic tuning
>> for us. If we add this value it probably would need to be
>> uint16_t. Though I wonder if we can do without this variable
>> and just set initialization to completed once the first
>> queue had an entry.
> 
> The only thing I could think of for not having it be part of the init was:
> a) adding another ioctl call, something like FUSE_IO_URING_CMD_INIT
> where we pass that as an init param before FUSE_IO_URING_CMD_REGISTERs
> get called
> or
> b) adding the nr_queues to fuse_uring_cmd_req (in the padding bits)
> for FUSE_IO_URING_CMD_REGISTER calls
> 
> but I don't think either of these are backwards-compatible unfortunately.
> 
> I think the issue with setting initialization to completed once the
> first queue has an entry is that we need to allocate the queues at
> ring creation time, so we need to know nr_queues from the beginning.
> 
> If we do go with the init approach, having uring_nr_queues be a
> uint16_t sounds reasonable to me.

I will take an hour a bit later today and try to update the patch.


Thanks,
Bernd

