Return-Path: <linux-fsdevel+bounces-45468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786D6A7811D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 19:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E37EB7A4B7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319062144D7;
	Tue,  1 Apr 2025 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="YyG2RaMD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FjZF7GYu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ACA20E33F
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743527199; cv=none; b=bt41QiT5Y8MI0y2Qr/sYZC+JtqHUo/iG9nzCORVScfvtL1WuXMmDWLPLjmkFcbACMMbVz7QR3a4mavqVQzPyPGaWvR5q6hZpXUpEyXPlzar5PE1RiFOBKXTwZomGRtyVarZZeJeCMiOinG6nmzkshZR2Q5yDwJ9FeahUKpOjpq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743527199; c=relaxed/simple;
	bh=3/PdOj53w6A9bVybOJKSs713KdNAxnyN/bqmxFTU0mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Euee0yv36eZYfeI9FfYVxK3jvxgRcdnPmBa25PPzdhvCgJWmoHzXUXXxVxsNHE0GYN2qSyl+pbRvNCrA4xnTBhYHwoOoZ+pU3kvpQq8R8UpQWnqgoIF47che6NB7JCzAh8l2Nhe++gzJ3eGPmhBHO/g1fL07oesa/h11pwSOo6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=YyG2RaMD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FjZF7GYu; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A6CA2540108;
	Tue,  1 Apr 2025 13:06:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 01 Apr 2025 13:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743527195;
	 x=1743613595; bh=Z2eRsbA9ie+kwY6ovGUM7UoczXtfT5eXLFXTtMV1zsg=; b=
	YyG2RaMDlxt5Tj55Zos2UJDHYY7U5+lnMMb9U7JpwfXeMXBCd8i5APi/DzH6ZsUF
	gGUXegsPZoDI+aUkL2+/yuhWKpkL/diVPr5viGFLeIzJkF5kdhvKV8xo9glU9J3G
	8gjw6VtmGxgyht9fPyEMssv+dqjavDsRwFYn5yJfjIabdmo9AvzE3omQ15aLWiu6
	3MDo25FgmXGhjSW7qf9ELV27BFGYW9rvszZ8i7fU9ga9Imr1pHuVn3YNtV7UHAiv
	6Sp4sizqdj9AwZ4u6LXDJ6tfAbuIpRkGk0a5iWU5RWofIbJDaQCWTLnTjv47909d
	zkAJsjM41O52JtD81PsEag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743527195; x=
	1743613595; bh=Z2eRsbA9ie+kwY6ovGUM7UoczXtfT5eXLFXTtMV1zsg=; b=F
	jZF7GYufeq5HV0kdgFib4wv5NpMWbezHMZT25KYBsskx1FqdLPwZJ7udN66PumjB
	MtpdoUadCIxDTmtiW/bCXEJR5h8+Vb2upmXh5N2vp3CNg20boZTCdjmd3DJC08E7
	EgpnNO6fPlnI2thmyY6TVIRH+Y+XOLjTmSBhT4OIbo3+JeIY8UxeE0l453Ry8qk3
	Y6mOQJeCab6l5iF8zOt19up4aqt5Pd5itWdY/nLZeER+A6bYdQ0kaB1a3FDYmqiC
	vCgrcq/RHbfquQ7umMhl47O6fsj4ZhomtIQ1/AcFjVN0jzyvqxUqqaOMlIE8+qLf
	bAyM3fFGBIdDItujiJuhA==
X-ME-Sender: <xms:Gh3sZ8dGxzR9esxRbU7irWCmihLypuv_4DJ9o6-XQWfmVLNQ5wobFg>
    <xme:Gh3sZ-MI2pt_djjNrxX_lqTAD3jCer2LCmGin5-gg8X-V99oCqyaz2uYGQZKB0MsB
    bRAICNpXX0KmaVZ>
X-ME-Received: <xmr:Gh3sZ9gSdkLU8Hcvzm3AGnoHiBuiMTwUmKFKKPMTJ1onDm0GZdspzrt_vWE6PWqDwjXfqrJ1HzST7EXHHxy5HEmJUORm8bYiVEcFcXjQmILt7w-6LWkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeeffeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Gh3sZx-CN1Xg-2jxQdAatxoA64-tF6MACn-_-7_pxD3LeD8SpDRxmA>
    <xmx:Gh3sZ4sFYjrvU92llnZKXjlamyER3oVJGMgO4H8qYHPIcnY7DJy1uw>
    <xmx:Gh3sZ4HawROzz4FLf82oeTfakmNGmILSBmIl-Az778Jk3sknsjXIpA>
    <xmx:Gh3sZ3OAY1NB2GonOGle-xJHnur_eb21hUSTIZxZYt1T_-axRq-iJQ>
    <xmx:Gx3sZ6KKK9-4u2hVW9dVBhzjH1fZHLt1rlqa9kLoDoCecS1QQ4G3hhsU>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 13:06:34 -0400 (EDT)
Message-ID: <2f0c63f9-4441-4dfe-adf5-5133757a8d92@fastmail.fm>
Date: Tue, 1 Apr 2025 19:06:32 +0200
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
 <1b249021-c69c-4548-b01b-0321b241d434@fastmail.fm>
 <CAJnrk1azHgMXTaUjb+c4iZ-g7S-RqqfmNPQneZaOaZrQsy_cxQ@mail.gmail.com>
 <CAJnrk1aUXaYngs1XeGjGqbXkYkTiV_BF2CiwGy_rDtZznVw29g@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1aUXaYngs1XeGjGqbXkYkTiV_BF2CiwGy_rDtZznVw29g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/1/25 02:22, Joanne Koong wrote:
> On Tue, Mar 18, 2025 at 4:16 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> On Tue, Mar 18, 2025 at 3:33 AM Bernd Schubert
>> <bernd.schubert@fastmail.fm> wrote:
>>>
>>> On 3/18/25 01:55, Joanne Koong wrote:
>>>> Hi Bernd,
>>>> Thanks for the quick turnaround on the review!
>>>>
>>>> On Fri, Mar 14, 2025 at 4:11 PM Bernd Schubert
>>>> <bernd.schubert@fastmail.fm> wrote:
>>>>>
>>>>> Thanks Joanne! That is rather close to what I wanted to add,
>>>>> just a few comments.
>>>>>
>>>>> On 3/14/25 21:44, Joanne Koong wrote:
>>>>>> In the current uring design, the number of queues is equal to the number
>>>>>> of cores on a system. However, on high-scale machines where there are
>>>>>> hundreds of cores, having such a high number of queues is often
>>>>>> overkill and resource-intensive. As well, in the current design where
>>>>>> the queue for the request is set to the cpu the task is currently
>>>>>> executing on (see fuse_uring_task_to_queue()), there is no guarantee
>>>>>> that requests for the same file will be sent to the same queue (eg if a
>>>>>> task is preempted and moved to a different cpu) which may be problematic
>>>>>> for some servers (eg if the server is append-only and does not support
>>>>>> unordered writes).
>>>>>>
>>>>>> In this commit, the server can configure the number of uring queues
>>>>>> (passed to the kernel through the init reply). The number of queues must
>>>>>> be a power of two, in order to make queue assignment for a request
>>>>>> efficient. If the server specifies a non-power of two, then it will be
>>>>>> automatically rounded down to the nearest power of two. If the server
>>>>>> does not specify the number of queues, then this will automatically
>>>>>> default to the current behavior where the number of queues will be equal
>>>>>> to the number of cores with core and numa affinity. The queue id hash
>>>>>> is computed on the nodeid, which ensures that requests for the same file
>>>>>> will be forwarded to the same queue.
>>>>>>
>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>>> ---
>>>>>>  fs/fuse/dev_uring.c       | 48 +++++++++++++++++++++++++++++++++++----
>>>>>>  fs/fuse/dev_uring_i.h     | 11 +++++++++
>>>>>>  fs/fuse/fuse_i.h          |  1 +
>>>>>>  fs/fuse/inode.c           |  4 +++-
>>>>>>  include/uapi/linux/fuse.h |  6 ++++-
>>>>>>  5 files changed, 63 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>>>>> index 64f1ae308dc4..f173f9e451ac 100644
>>>>>> --- a/fs/fuse/dev_uring.c
>>>>>> +++ b/fs/fuse/dev_uring.c
>>>>>> @@ -209,9 +209,10 @@ void fuse_uring_destruct(struct fuse_conn *fc)
>>>>>>  static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>>>>>>  {
>>>>>>       struct fuse_ring *ring;
>>>>>> -     size_t nr_queues = num_possible_cpus();
>>>>>> +     size_t nr_queues = fc->uring_nr_queues;
>>>>>>       struct fuse_ring *res = NULL;
>>>>>>       size_t max_payload_size;
>>>>>> +     unsigned int nr_cpus = num_possible_cpus();
>>>>>>
>>>>>>       ring = kzalloc(sizeof(*fc->ring), GFP_KERNEL_ACCOUNT);
>>>>>>       if (!ring)
>>>>>> @@ -237,6 +238,13 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>>>>>>
>>>>>>       fc->ring = ring;
>>>>>>       ring->nr_queues = nr_queues;
>>>>>> +     if (nr_queues == nr_cpus) {
>>>>>> +             ring->core_affinity = 1;
>>>>>> +     } else {
>>>>>> +             WARN_ON(!nr_queues || nr_queues > nr_cpus ||
>>>>>> +                     !is_power_of_2(nr_queues));
>>>>>> +             ring->qid_hash_bits = ilog2(nr_queues);
>>>>>> +     }
>>>>>>       ring->fc = fc;
>>>>>>       ring->max_payload_sz = max_payload_size;
>>>>>>       atomic_set(&ring->queue_refs, 0);
>>>>>> @@ -1217,12 +1225,24 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
>>>>>>       fuse_uring_send(ent, cmd, err, issue_flags);
>>>>>>  }
>>>>>>
>>>>>> -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
>>>>>> +static unsigned int hash_qid(struct fuse_ring *ring, u64 nodeid)
>>>>>> +{
>>>>>> +     if (ring->nr_queues == 1)
>>>>>> +             return 0;
>>>>>> +
>>>>>> +     return hash_long(nodeid, ring->qid_hash_bits);
>>>>>> +}
>>>>>> +
>>>>>> +static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring,
>>>>>> +                                                     struct fuse_req *req)
>>>>>>  {
>>>>>>       unsigned int qid;
>>>>>>       struct fuse_ring_queue *queue;
>>>>>>
>>>>>> -     qid = task_cpu(current);
>>>>>> +     if (ring->core_affinity)
>>>>>> +             qid = task_cpu(current);
>>>>>> +     else
>>>>>> +             qid = hash_qid(ring, req->in.h.nodeid);
>>>>>
>>>>> I think we need to handle numa affinity.
>>>>>
>>>>
>>>> Could you elaborate more on this? I'm not too familiar with how to
>>>> enforce this in practice. As I understand it, the main goal of numa
>>>> affinity is to make sure processes access memory that's physically
>>>> closer to the CPU it's executing on. How does this usually get
>>>> enforced at the kernel level?
>>>
>>> The request comes on a specific core and that is on a numa node -
>>> we should try to avoid switching. If there is no queue for the
>>> current core we should try to stay on the same numa node.
>>> And we should probably also consider the waiting requests per
>>> queue and distribute between that, although that is a bit
>>> independent.
>>>
>>
>> In that case then, there's no guarantee that requests on the same file
>> will get sent to the same queue. But thinking more about this, maybe
>> it doesn't matter after all if they're sent to different queues. I
>> need to think some more about this. But I agree, if we don't care
>> about requests for the same inode getting routed to the same queue,
>> then we should aim for numa affinity. I'll look more into this.
>>
> 
> Thought about this some more... is this even worth doing? AFAICT,
> there's no guarantee that the same number of CPUs are distributed
> evenly across numa nodes. For example, one numa node may have CPUs 0
> to 5 on them, then another numa node might have CPU 6 and 7. If
> there's two queues, each associated with a numa node, then requests
> will be disproportionately / unevenly allocated. Eg most of the
> workload will be queued on the numa node with CPUs 0 to 5. Moreover, I
> don't think there's a good way to enforce this in the cases where
> number of queues < number of numa nodes. For example if there's 3 numa
> nodes with say 3 CPUs each and there's 2 queues. The logic for which
> cpu gets sent to which queue gets a little messy here.
> 
> imo, this is an optimization that could be added in the future if the
> need for this comes up. WDYT?


I will eventually come to this this week. My plan is to use queue
lengths for distribution. We should do that for background requests
anyway. 
I.e. first try the local core, if queue length to large or no queue.
try queues within the same numa domain, if all queues are busy check
if foreign queues are more suitable.

Thanks,
Bernd

