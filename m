Return-Path: <linux-fsdevel+bounces-45697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D40A7B007
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 23:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C71417A6B53
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 21:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D0B55897;
	Thu,  3 Apr 2025 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="pX4O/d+R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H0ZW5B+5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5D535949
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743711222; cv=none; b=nnxy13gdc1JQepthvo5x1ityiWvWQCNK7H9+Fm+G2NcasQiZ+edo/3U3TRocsyiZOk0qME8mZFu+wHwjTX13YGVNwmkoGqZ+fSU+v8oGtvbXUf1AXGnfkjDmIwyyAzIEtjZvrOSDuWoWHgdnvSQ/yWka7X0+hX7TgAPqABIF4jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743711222; c=relaxed/simple;
	bh=vhGojg604M828Iloy/Mw5UFFdRnxIqiWSZWVsCv6TgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0vRndFEuAWcETNsQI0GY5P1wugmCynDI/bBZ91JUXcAq8g/RzOdZmCSuYo8PE4wjZJWemfwqXnqbRVk6ycc85fCMVEeNwnF2+Re8T1aGslUuuqrLHY+j6mKHNfoWZqzhZiDeKgpZ5rLMeCy0ww1k4wttKoyIAEACjiL5uE3PUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=pX4O/d+R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H0ZW5B+5; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 919B91140200;
	Thu,  3 Apr 2025 16:13:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 03 Apr 2025 16:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1743711217;
	 x=1743797617; bh=3buFU2CbC2P/esj6E27qZ62IBxKOWSAcb5UP/um97e0=; b=
	pX4O/d+RQsanXxh/dVzmXk5t/ofIWWJY1hczH6JRRj5jlUXICYrXwZQM3FrrLjxd
	mJriWiNaaxyWhsu0nWWDsdGskXZWMcd9YB19NmTT7J5wzil5MPIGweIDFPTuD3mB
	WeSG4CFZK9e+Fi61/volThgR/pAtrUWKViRs25zLCIzGShik4CTx4N8nbwnPd694
	JXrESNx1yG4laM3VpB4B/OQDCn+0QEj55lG0r3TQfK1uFqSSydZYNAu+4HBI6kQH
	j6OgQWlXh451LCC/IhuGxmjhsKBYjW6R/Ao5Ol8QLslTqpbb+R9ikUuGcSJy9L4Z
	5014X6WoH5UWHHe16jUo2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743711217; x=
	1743797617; bh=3buFU2CbC2P/esj6E27qZ62IBxKOWSAcb5UP/um97e0=; b=H
	0ZW5B+56wFTLigwQAtunheYXlPk0xKDf73OUNJQ/Q9UZWQB9xWLyWY+uAnx8IQJw
	ParliVmh/XPRIsXwWtRdlxZaxlyy+xCvURUOvVoXvPo5fEWAFkz0Asxr/BJH8KeV
	TFZ3Vy4mwmB4ZADA1l+gWlCIgW5wbLD75BegBj/Fem1x4uTQHib17gzxtTKCmPhn
	sZV6gFGeqCMdn6U1+/MtQxq+TZasPLeqFPtGbZ8WiwiKMUvydqv9uNMStjUPpPUl
	wabc5iU//CGvcKVVzPE9rDPJLWR56Z+O2fT3U6cX/ovDubG6ht48F249QfNbC9uq
	y0LRoznJN9li8anI6Du9Q==
X-ME-Sender: <xms:8OvuZy7eCo8w_cxtFpWSZkV7wsjb-o6JYkCeuOX6Q1U49hR8uUKhsA>
    <xme:8OvuZ74JnKmgaxc7QTGUASkL6JqglxqfJ8JE2M99u5GqdKyzvaZC7Eutr2olpSVxd
    zq3BDgUfR0n7sls>
X-ME-Received: <xmr:8OvuZxcyuR4yiJuKvMHst69Dbpg-OG7Fc_z424kBkTjeyOVT-IjOwybrxjBY-xELes5XuEXEJI6QF9Y-Rami1uwWdvgApFc2ICJblSW2KDRxla_VQGkd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeelgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvg
    hrnhgurdgtohhmqeenucggtffrrghtthgvrhhnpeefgeegfeffkeduudelfeehleelhefg
    ffehudejvdfgteevvddtfeeiheeflefgvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohgrnhhnvg
    hlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopegsshgthhhusggvrhhtsegu
    ughnrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtph
    htthhopehvghhohigrlhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshhtvghfrghn
    hhgrsehrvgguhhgrthdrtghomhdprhgtphhtthhopegvphgvrhgviihmrgesrhgvughhrg
    htrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomh
X-ME-Proxy: <xmx:8evuZ_Jp8tsv7xWzz7W6JgNE48tzqtpsnnO6MbS0NX5TjO96nzPWJQ>
    <xmx:8evuZ2JMwjTxlkTmoiGYn7O3lyGkawdQaxA-bXj-i6m2sXl48lySAQ>
    <xmx:8evuZwwume79j3xJcOxw5w1ow76073ZAwDAYn9cxAOrGdMjYM8USVA>
    <xmx:8evuZ6L0RIRkBT1fOqiaZf0clckntSr9PV9wVQx1-w-LVYagWTJyTA>
    <xmx:8evuZ8SHs97XYxZ5ktJJIAE99ssgn5ZVxWQkeSH0E1vdL1-crtFnq5Ur>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 16:13:35 -0400 (EDT)
Message-ID: <8a0386e3-50ca-4779-93b3-2fa8e00446d5@bsbernd.com>
Date: Thu, 3 Apr 2025 22:13:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] fuse: Make the fuse unique value a per-cpu counter
To: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, linux-fsdevel@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>
References: <20250403-fuse-io-uring-trace-points-v2-0-bd04f2b22f91@ddn.com>
 <20250403-fuse-io-uring-trace-points-v2-1-bd04f2b22f91@ddn.com>
 <CAJnrk1bMWWkDXUmrrUFsUgr6MDKH2XtoF1mtZwEfXNOyh9Kkow@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1bMWWkDXUmrrUFsUgr6MDKH2XtoF1mtZwEfXNOyh9Kkow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for your review Joanne!

On 4/3/25 20:27, Joanne Koong wrote:
> On Thu, Apr 3, 2025 at 6:05 AM Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> No need to take lock, we can have that per cpu and
>> add in the current cpu as offset.
>>
>> fuse-io-uring and virtiofs especially benefit from it
>> as they don't need the fiq lock at all.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  fs/fuse/dev.c        | 24 +++---------------------
>>  fs/fuse/fuse_dev_i.h |  4 ----
>>  fs/fuse/fuse_i.h     | 23 ++++++++++++++++++-----
>>  fs/fuse/inode.c      |  1 +
>>  4 files changed, 22 insertions(+), 30 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 51e31df4c54613280a9c295f530b18e1d461a974..e9592ab092b948bacb5034018bd1f32c917d5c9f 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -204,24 +204,6 @@ unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args)
>>  }
>>  EXPORT_SYMBOL_GPL(fuse_len_args);
>>
>> -static u64 fuse_get_unique_locked(struct fuse_iqueue *fiq)
>> -{
>> -       fiq->reqctr += FUSE_REQ_ID_STEP;
>> -       return fiq->reqctr;
>> -}
>> -
>> -u64 fuse_get_unique(struct fuse_iqueue *fiq)
>> -{
>> -       u64 ret;
>> -
>> -       spin_lock(&fiq->lock);
>> -       ret = fuse_get_unique_locked(fiq);
>> -       spin_unlock(&fiq->lock);
>> -
>> -       return ret;
>> -}
>> -EXPORT_SYMBOL_GPL(fuse_get_unique);
>> -
>>  unsigned int fuse_req_hash(u64 unique)
>>  {
>>         return hash_long(unique & ~FUSE_INT_REQ_BIT, FUSE_PQ_HASH_BITS);
>> @@ -278,7 +260,7 @@ static void fuse_dev_queue_req(struct fuse_iqueue *fiq, struct fuse_req *req)
>>         spin_lock(&fiq->lock);
>>         if (fiq->connected) {
>>                 if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
>> -                       req->in.h.unique = fuse_get_unique_locked(fiq);
>> +                       req->in.h.unique = fuse_get_unique(fiq);
>>                 list_add_tail(&req->list, &fiq->pending);
>>                 fuse_dev_wake_and_unlock(fiq);
>>         } else {
>> @@ -1177,7 +1159,7 @@ __releases(fiq->lock)
>>         struct fuse_in_header ih = {
>>                 .opcode = FUSE_FORGET,
>>                 .nodeid = forget->forget_one.nodeid,
>> -               .unique = fuse_get_unique_locked(fiq),
>> +               .unique = fuse_get_unique(fiq),
>>                 .len = sizeof(ih) + sizeof(arg),
>>         };
>>
>> @@ -1208,7 +1190,7 @@ __releases(fiq->lock)
>>         struct fuse_batch_forget_in arg = { .count = 0 };
>>         struct fuse_in_header ih = {
>>                 .opcode = FUSE_BATCH_FORGET,
>> -               .unique = fuse_get_unique_locked(fiq),
>> +               .unique = fuse_get_unique(fiq),
>>                 .len = sizeof(ih) + sizeof(arg),
>>         };
>>
>> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
>> index 3b2bfe1248d3573abe3b144a6d4bf6a502f56a40..e0afd837a8024450bab77312c7eebdcc7a39bd36 100644
>> --- a/fs/fuse/fuse_dev_i.h
>> +++ b/fs/fuse/fuse_dev_i.h
>> @@ -8,10 +8,6 @@
>>
>>  #include <linux/types.h>
>>
>> -/* Ordinary requests have even IDs, while interrupts IDs are odd */
>> -#define FUSE_INT_REQ_BIT (1ULL << 0)
>> -#define FUSE_REQ_ID_STEP (1ULL << 1)
>> -
>>  struct fuse_arg;
>>  struct fuse_args;
>>  struct fuse_pqueue;
>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>> index fee96fe7887b30cd57b8a6bbda11447a228cf446..73c612dd58e45ecde0b8f72fd58ac603d12cf202 100644
>> --- a/fs/fuse/fuse_i.h
>> +++ b/fs/fuse/fuse_i.h
>> @@ -9,6 +9,8 @@
>>  #ifndef _FS_FUSE_I_H
>>  #define _FS_FUSE_I_H
>>
>> +#include "linux/percpu-defs.h"
> 
> Think the convention is #include <linux/percpu-defs.h> though I wonder
> if you even need this. I see other filesystems using percpu counters
> but they don't explicitly include this header. Compilation seems fine
> without it.
> 
>> +#include "linux/threads.h"
> 
> Do you need threads.h?

Oh, I fixed my .clangd settings, it had added headers itself.

> 
>>  #ifndef pr_fmt
>>  # define pr_fmt(fmt) "fuse: " fmt
>>  #endif
>> @@ -44,6 +46,10 @@
>>  /** Number of dentries for each connection in the control filesystem */
>>  #define FUSE_CTL_NUM_DENTRIES 5
>>
>> +/* Ordinary requests have even IDs, while interrupts IDs are odd */
>> +#define FUSE_INT_REQ_BIT (1ULL << 0)
>> +#define FUSE_REQ_ID_STEP (1ULL << 1)
>> +
>>  /** Maximum of max_pages received in init_out */
>>  extern unsigned int fuse_max_pages_limit;
>>
>> @@ -490,7 +496,7 @@ struct fuse_iqueue {
>>         wait_queue_head_t waitq;
>>
>>         /** The next unique request id */
>> -       u64 reqctr;
>> +       u64 __percpu *reqctr;
>>
>>         /** The list of pending requests */
>>         struct list_head pending;
>> @@ -1065,6 +1071,17 @@ static inline void fuse_sync_bucket_dec(struct fuse_sync_bucket *bucket)
>>         rcu_read_unlock();
>>  }
>>
>> +/**
>> + * Get the next unique ID for a request
>> + */
>> +static inline u64 fuse_get_unique(struct fuse_iqueue *fiq)
>> +{
>> +       int step = FUSE_REQ_ID_STEP * (task_cpu(current) + 1);
> 
> I don't think you need the + 1 here. This works fine even if
> task_cpu() returns 0.

Yeah right, I had a version that was multiplying by the step

> 
>> +       u64 cntr = this_cpu_inc_return(*fiq->reqctr);
>> +
>> +       return cntr * FUSE_REQ_ID_STEP * NR_CPUS + step;
> 
> if you want to save a multiplication, I think we could just do
> 
>  static inline u64 fuse_get_unique(struct fuse_iqueue *fiq) {
>    u64 cntr = this_cpu_inc_return(*fiq->reqctr);
>    return (cntr * NR_CPUS + task_cpu(current)) * FUSE_REQ_ID_STEP;
> }
> 

I find this harder to read - the compiler will optimize that anyway?



>> +}
>> +
>>  /** Device operations */
>>  extern const struct file_operations fuse_dev_operations;
>>
>> @@ -1415,10 +1432,6 @@ int fuse_readdir(struct file *file, struct dir_context *ctx);
>>   */
>>  unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
>>
>> -/**
>> - * Get the next unique ID for a request
>> - */
>> -u64 fuse_get_unique(struct fuse_iqueue *fiq);
>>  void fuse_free_conn(struct fuse_conn *fc);
>>
>>  /* dax.c */
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index e9db2cb8c150878634728685af0fa15e7ade628f..12012bfbf59a93deb9d27e0e0641e4ea2ec4c233 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -930,6 +930,7 @@ static void fuse_iqueue_init(struct fuse_iqueue *fiq,
>>         memset(fiq, 0, sizeof(struct fuse_iqueue));
>>         spin_lock_init(&fiq->lock);
>>         init_waitqueue_head(&fiq->waitq);
>> +       fiq->reqctr = alloc_percpu(u64);
>>         INIT_LIST_HEAD(&fiq->pending);
>>         INIT_LIST_HEAD(&fiq->interrupts);
>>         fiq->forget_list_tail = &fiq->forget_list_head;
>>
> 
> I think we need a free_percpu(fiq->reqctr); as well when the last ref
> on the connection is dropped or else this is leaked

Right, totally forgot.


Thanks,
Bernd

