Return-Path: <linux-fsdevel+bounces-50664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F269BACE404
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 19:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21918169894
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 17:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01C51FBEBD;
	Wed,  4 Jun 2025 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="YFjxt0E2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="io30mR1X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC6171A1
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749059871; cv=none; b=lKile+gRjGHdaXTgvzTRxSTu4Nia1hYjFb6Kxw+q9AcPfwKNnyoftb1uwQNSWdPP10XHBTxUEAM+pMhqMOVglIzBjvr49UZJUkEp5g7ecDIcQ4/Q6ghKNvL8/8uJMNfTFkVI2d8wE5fNXm5uRZp65z+1W2BmDPb31dZjbvoZzzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749059871; c=relaxed/simple;
	bh=CBDiiHsAcmpbHgfDnvEFqxc9OoFOBODRnvz4Eb/57W8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pDuyEWhtXjRJd5Q5vLQflIW3FdJvnR/6N4oqAkZFpUuXFfOI+5heSU+1fiYZlzzyJwbJq8F0Npo15evuXMPik9sfly21qnTZVkei/2juKCY6LTLAQujp6qV8dDucPBUUGHNwpiEQ+1oQwSDKwW2KwoHjpVIbRubfsS+J8FL+gGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=YFjxt0E2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=io30mR1X; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D1ECF13804AC;
	Wed,  4 Jun 2025 13:57:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Jun 2025 13:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1749059864;
	 x=1749146264; bh=BA/O21qhjIedDeqDFYBpuGcCuIV2HTJ9KXUUcjuT+jc=; b=
	YFjxt0E2k9n/E7c+ruWtllFX38sSznvam/L49AyATF0/Bp5v+OFYzhLnQSoDHui0
	frjBUdTsDj65JUBNd5jK5Wjs0k+mFlQ8HWiPpOB1cLF43tsNSG5y8JwbDO3onGwS
	2vTX8/4ZKicdXjqeKZPJSLu3tWtwrn8bZidzQl2N8Ux0zuxyNGx2ilNw8R2Qgo6c
	cWdfBniaCUK4DF5gWrGuBCAVSPZHAryrlDDLXMAd34dcZTVYtdut12R4rW8KYjeo
	bK8RW3UAiWvFdKD2lT12W+ueUHLw+kvr5gJCNEdh8D4y9r1FZtvV0qIk3s3Sfj+H
	n74ZaZqvsvGYXxb4M5bu2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749059864; x=
	1749146264; bh=BA/O21qhjIedDeqDFYBpuGcCuIV2HTJ9KXUUcjuT+jc=; b=i
	o30mR1XiJxlR1pzLad8c9lO1KH4SRBMlNujBIa8h0BU7JeXJ0rJf4g7jWRuci6/p
	ZbpOH15OvPar2nWUAzbEYVQW9+cNV8+9k+q1vqOLLKmIg4whnrO+J66pKjooZ96T
	rAcDxbsDpmysqOppsFaByJxjisU4W+u6v6D7gOpSXYD1vhkeSmrtcgUUVGlQ2wkd
	FIfQjwmuJEuUSPuUiDf70nDGRfUIZY24xjP6FsxvzIvwix+pXzCKk8e2PIgy3Sey
	Eyb1y6EbgOTXjrY+gOE13L15mHIu6v816rfFmOXTO7ZFvEIX5sJF1y5UwFIO7RfB
	5iOriayeOyVFCbgsTXbGA==
X-ME-Sender: <xms:GIlAaAn2f0wMqDwnJmWhFhhaL0saAZp02OdMO_Lbot2gaa6jbr6NWQ>
    <xme:GIlAaP3zyW8MhOeH9bnOF9ccrNITg-CEuSQ3E-hhgQ3NxHYdQr8AawrLbLu7mvUo1
    9peGv58Sevha_Tp>
X-ME-Received: <xmr:GIlAaOqIzlSoKiIW8gDS4vm0oJsu6LyPy2jT88FHdUQRgnPD4lrBDcfPflqwyVKDww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvgeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffhvfevfhgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnh
    gurdgtohhmqeenucggtffrrghtthgvrhhnpeejueevtefgkefffefgtdegtdejtddvudfg
    vefffeegveevjeefheffkeelgedtjeenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhn
    ugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgv
    rhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:GIlAaMnzjRMF_8jOG-5bMlKf78Dj8cwpWIiCvKcaO97ewcMy_MpmSg>
    <xmx:GIlAaO0mByQ5LBMR-RcQZM3MjyaAo_0uNeExiSJZ-nDoZJKDiUH9KA>
    <xmx:GIlAaDsdZ60gcLD7mwEZLmP6jITWcEnDR6Jjt9Hf0Ui8RlLdaOwULA>
    <xmx:GIlAaKUFLAjJjo0Qx3hoK608QG4x2M1j_nKDd5Ik2BSiS0sMzOX17w>
    <xmx:GIlAaGgby3_-qtJ3beWqTKtyxPOnM4a0COzRIjaaU6brDglu1iG534sa>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 13:57:43 -0400 (EDT)
Message-ID: <a30c14d3-e9a3-4de7-b0a6-d2c71dcac04a@bsbernd.com>
Date: Wed, 4 Jun 2025 19:57:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fuse: support configurable number of uring queues
From: Bernd Schubert <bernd@bsbernd.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <20250314204437.726538-1-joannelkoong@gmail.com>
 <8aca27b0-609b-44c4-90ff-314e3c086b90@fastmail.fm>
 <CAJnrk1YoN6gayDQ6hBMa9NnxgkOpf9qYmMRg9kP=2iQR9_B8Ew@mail.gmail.com>
 <1b249021-c69c-4548-b01b-0321b241d434@fastmail.fm>
 <CAJnrk1azHgMXTaUjb+c4iZ-g7S-RqqfmNPQneZaOaZrQsy_cxQ@mail.gmail.com>
 <CAJnrk1aUXaYngs1XeGjGqbXkYkTiV_BF2CiwGy_rDtZznVw29g@mail.gmail.com>
 <2f0c63f9-4441-4dfe-adf5-5133757a8d92@fastmail.fm>
Content-Language: en-US
In-Reply-To: <2f0c63f9-4441-4dfe-adf5-5133757a8d92@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/1/25 19:06, Bernd Schubert wrote:
> 
> 
> On 4/1/25 02:22, Joanne Koong wrote:
>> On Tue, Mar 18, 2025 at 4:16 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>>>
>>> On Tue, Mar 18, 2025 at 3:33 AM Bernd Schubert
>>> <bernd.schubert@fastmail.fm> wrote:
>>>>
>>>> On 3/18/25 01:55, Joanne Koong wrote:
>>>>> Hi Bernd,
>>>>> Thanks for the quick turnaround on the review!
>>>>>
>>>>> On Fri, Mar 14, 2025 at 4:11 PM Bernd Schubert
>>>>> <bernd.schubert@fastmail.fm> wrote:
>>>>>>
>>>>>> Thanks Joanne! That is rather close to what I wanted to add,
>>>>>> just a few comments.
>>>>>>
>>>>>> On 3/14/25 21:44, Joanne Koong wrote:
>>>>>>> In the current uring design, the number of queues is equal to the number
>>>>>>> of cores on a system. However, on high-scale machines where there are
>>>>>>> hundreds of cores, having such a high number of queues is often
>>>>>>> overkill and resource-intensive. As well, in the current design where
>>>>>>> the queue for the request is set to the cpu the task is currently
>>>>>>> executing on (see fuse_uring_task_to_queue()), there is no guarantee
>>>>>>> that requests for the same file will be sent to the same queue (eg if a
>>>>>>> task is preempted and moved to a different cpu) which may be problematic
>>>>>>> for some servers (eg if the server is append-only and does not support
>>>>>>> unordered writes).
>>>>>>>
>>>>>>> In this commit, the server can configure the number of uring queues
>>>>>>> (passed to the kernel through the init reply). The number of queues must
>>>>>>> be a power of two, in order to make queue assignment for a request
>>>>>>> efficient. If the server specifies a non-power of two, then it will be
>>>>>>> automatically rounded down to the nearest power of two. If the server
>>>>>>> does not specify the number of queues, then this will automatically
>>>>>>> default to the current behavior where the number of queues will be equal
>>>>>>> to the number of cores with core and numa affinity. The queue id hash
>>>>>>> is computed on the nodeid, which ensures that requests for the same file
>>>>>>> will be forwarded to the same queue.
>>>>>>>
>>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>>>> ---
>>>>>>>   fs/fuse/dev_uring.c       | 48 +++++++++++++++++++++++++++++++++++----
>>>>>>>   fs/fuse/dev_uring_i.h     | 11 +++++++++
>>>>>>>   fs/fuse/fuse_i.h          |  1 +
>>>>>>>   fs/fuse/inode.c           |  4 +++-
>>>>>>>   include/uapi/linux/fuse.h |  6 ++++-
>>>>>>>   5 files changed, 63 insertions(+), 7 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>>>>>> index 64f1ae308dc4..f173f9e451ac 100644
>>>>>>> --- a/fs/fuse/dev_uring.c
>>>>>>> +++ b/fs/fuse/dev_uring.c
>>>>>>> @@ -209,9 +209,10 @@ void fuse_uring_destruct(struct fuse_conn *fc)
>>>>>>>   static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>>>>>>>   {
>>>>>>>        struct fuse_ring *ring;
>>>>>>> -     size_t nr_queues = num_possible_cpus();
>>>>>>> +     size_t nr_queues = fc->uring_nr_queues;
>>>>>>>        struct fuse_ring *res = NULL;
>>>>>>>        size_t max_payload_size;
>>>>>>> +     unsigned int nr_cpus = num_possible_cpus();
>>>>>>>
>>>>>>>        ring = kzalloc(sizeof(*fc->ring), GFP_KERNEL_ACCOUNT);
>>>>>>>        if (!ring)
>>>>>>> @@ -237,6 +238,13 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>>>>>>>
>>>>>>>        fc->ring = ring;
>>>>>>>        ring->nr_queues = nr_queues;
>>>>>>> +     if (nr_queues == nr_cpus) {
>>>>>>> +             ring->core_affinity = 1;
>>>>>>> +     } else {
>>>>>>> +             WARN_ON(!nr_queues || nr_queues > nr_cpus ||
>>>>>>> +                     !is_power_of_2(nr_queues));
>>>>>>> +             ring->qid_hash_bits = ilog2(nr_queues);
>>>>>>> +     }
>>>>>>>        ring->fc = fc;
>>>>>>>        ring->max_payload_sz = max_payload_size;
>>>>>>>        atomic_set(&ring->queue_refs, 0);
>>>>>>> @@ -1217,12 +1225,24 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
>>>>>>>        fuse_uring_send(ent, cmd, err, issue_flags);
>>>>>>>   }
>>>>>>>
>>>>>>> -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
>>>>>>> +static unsigned int hash_qid(struct fuse_ring *ring, u64 nodeid)
>>>>>>> +{
>>>>>>> +     if (ring->nr_queues == 1)
>>>>>>> +             return 0;
>>>>>>> +
>>>>>>> +     return hash_long(nodeid, ring->qid_hash_bits);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring,
>>>>>>> +                                                     struct fuse_req *req)
>>>>>>>   {
>>>>>>>        unsigned int qid;
>>>>>>>        struct fuse_ring_queue *queue;
>>>>>>>
>>>>>>> -     qid = task_cpu(current);
>>>>>>> +     if (ring->core_affinity)
>>>>>>> +             qid = task_cpu(current);
>>>>>>> +     else
>>>>>>> +             qid = hash_qid(ring, req->in.h.nodeid);
>>>>>>
>>>>>> I think we need to handle numa affinity.
>>>>>>
>>>>>
>>>>> Could you elaborate more on this? I'm not too familiar with how to
>>>>> enforce this in practice. As I understand it, the main goal of numa
>>>>> affinity is to make sure processes access memory that's physically
>>>>> closer to the CPU it's executing on. How does this usually get
>>>>> enforced at the kernel level?
>>>>
>>>> The request comes on a specific core and that is on a numa node -
>>>> we should try to avoid switching. If there is no queue for the
>>>> current core we should try to stay on the same numa node.
>>>> And we should probably also consider the waiting requests per
>>>> queue and distribute between that, although that is a bit
>>>> independent.
>>>>
>>>
>>> In that case then, there's no guarantee that requests on the same file
>>> will get sent to the same queue. But thinking more about this, maybe
>>> it doesn't matter after all if they're sent to different queues. I
>>> need to think some more about this. But I agree, if we don't care
>>> about requests for the same inode getting routed to the same queue,
>>> then we should aim for numa affinity. I'll look more into this.
>>>
>>
>> Thought about this some more... is this even worth doing? AFAICT,
>> there's no guarantee that the same number of CPUs are distributed
>> evenly across numa nodes. For example, one numa node may have CPUs 0
>> to 5 on them, then another numa node might have CPU 6 and 7. If
>> there's two queues, each associated with a numa node, then requests
>> will be disproportionately / unevenly allocated. Eg most of the
>> workload will be queued on the numa node with CPUs 0 to 5. Moreover, I
>> don't think there's a good way to enforce this in the cases where
>> number of queues < number of numa nodes. For example if there's 3 numa
>> nodes with say 3 CPUs each and there's 2 queues. The logic for which
>> cpu gets sent to which queue gets a little messy here.
>>
>> imo, this is an optimization that could be added in the future if the
>> need for this comes up. WDYT?
> 
> 
> I will eventually come to this this week. My plan is to use queue
> lengths for distribution. We should do that for background requests
> anyway.
> I.e. first try the local core, if queue length to large or no queue.
> try queues within the same numa domain, if all queues are busy check
> if foreign queues are more suitable.


Sorry for the delay, and just a heads up. Had to find the time to get 
there.

https://github.com/bsbernd/linux/commits/reduced-nr-ring-queues/

Totally untested and I don't like the loops for queue selection. Will
try to find a faster way (currently thinking about queue bitmaps).



Thanks,
Bernd



