Return-Path: <linux-fsdevel+bounces-41809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A411DA3786C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 00:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672F7168D82
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 23:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D1B19C543;
	Sun, 16 Feb 2025 23:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="bATKkpIo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DjnkEGNf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2499C2EF
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Feb 2025 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739747784; cv=none; b=d23PrgiWnhXopF1C090o/RDXU9mjpBE9t2yMyCrP8oaQJByaffGPVvlC8YuOycPdfmUKGNTBqg7DuuYuRmJYGuwkVrlJsV/j7xQiT2HqPzqKOhjTxwsRhiCZXtg0Fh50uiPMaXQdIQc32oBtcSYTSQMT2L230kKawLyE0yMNpM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739747784; c=relaxed/simple;
	bh=5oVsLOxYNL1QLjcrFt7TTIhU0dCEc0t6ZjKm4OzjdaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SU2CVrOIzh1nqcELZj+Hc/n3A/o13e1Yct0FKqr9L1HoLwd9zHngrGrZGavaR2EMdZyseQ0/iNXwI7+CkgiOm0FRE54GNrns4CRmb5Zs6fE+NsDw4e6e2tfbsSKbcQkdxJJFL7p4ar+00aym/x9e+UAk7h5jPic48slzJB+xV/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=bATKkpIo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DjnkEGNf; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5D60E1140190;
	Sun, 16 Feb 2025 18:16:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 16 Feb 2025 18:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739747780;
	 x=1739834180; bh=VQLeaYKzsmDkgVA04IkWN8c78EdmGQzw/bc3psoPbe8=; b=
	bATKkpIoKukT8pAfytKgxCCDSGAr+WYLvFXOPHGsJR7BNzY0gEGLDCf5USAtr15U
	22BweJYq+q5qGGs4meuVbqJU5hpHdnMClWm7fP3VW7FZuoTMcO/DJ/JOJo5uI+JH
	tObKd1UgbgKW/3emiivLY894EUJAvIydoIjZIsoccjsySZcW0e7V3N48w1HD5+a0
	XQn+xYrMiw8IKt5ntvdiLG+WS1ckyaumZk3T7i0qaeLKDWSEj4mWDaT+UXYEUSeF
	mKMpgDAPn+HUtgUeY6c29O4LC/9uzsAfq0r3k41w5ga/J5envhZ9wASCBJjuwNLX
	9Djmfgwo4JFyC5oZnLcL2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739747780; x=
	1739834180; bh=VQLeaYKzsmDkgVA04IkWN8c78EdmGQzw/bc3psoPbe8=; b=D
	jnkEGNf5cOeCUijMlPhENgNj9dyM/f9rsTU/TmKtT5tWMMgvtgfKuA8w8ATDFHsw
	Nhs7hdtXvx2CuSQqc7I+pYAJfRhXVl1v7+2+ExtQP8pO1RFlV1XO2XY1O9j2bzNt
	YjWGm8eZNnWYkgUvLuXx6Iu03jZYKhAmB0Z4fIURlp0fRFmVh41PXooRvfbUu0Q2
	qq5JAfN7T2G+e73TUtQf8euzsEe6MB+2f0PamlMDZ/9m1QA2fMRrY3qwnOaeG8W/
	6CttSZ11fk5pvLat+KbwDJxT3WIOMydTVqEG+E8GldSvS9rYq33ixykUScIEBEzS
	R68qVUBkICu2Mx3y20KGg==
X-ME-Sender: <xms:w3GyZ0rrIF5UMlnIqtzwMARfENCe1-cJXR2EdB0bGLbz7vkKMT2uKw>
    <xme:w3GyZ6rGlgPicU5UndNZ26SgJjR_qwjHLsQ5qtVbNoj_9BDQ3xluGEMC4o2g2ctQJ
    tP8DLCfj0lmULOy>
X-ME-Received: <xmr:w3GyZ5Oqx4Wezn1QdWqwwjt__yWuZMZRbLEfOLaqdqEeDCwqkbgI_z_z-5J4iAqlOXNfGff04aj2onQqOK0ugNwOuOhzOOOO1qePgxiQXPeJWDplNRpB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehieejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugessghssggvrh
    hnugdrtghomheqnecuggftrfgrthhtvghrnheptdeuvdeuudeltddukefhueeludduieej
    vdevveevteduvdefuedvkeffjeelueeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghr
    nhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    vghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:w3GyZ74eq1dnHaYErPI4lJY96yL4oIgMTAsyYLPLTqoVyrJgoLz4nA>
    <xmx:w3GyZz6P5mguM_Qe1bBCt0zEl25LIYjiFVeHdGI6UVvMFunvCDzQ9A>
    <xmx:w3GyZ7hN6yBwnoKzWG7p6R8rdZ-wAyiRqmIJVryyfU1ryY-Jq_wy6Q>
    <xmx:w3GyZ974QBQIedMv3Ex3T6nt2X2uJnspI3PGTIFZwCqJ8VY5girqUw>
    <xmx:xHGyZ22F-SUIiFZvaYH1EdAvsSt7UBvC_2PBiZ8iZAcyXOuqXJnosMzm>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Feb 2025 18:16:18 -0500 (EST)
Message-ID: <bdb3980b-65e3-4bd5-aa5b-0a48d6d6e7a0@bsbernd.com>
Date: Mon, 17 Feb 2025 00:16:18 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: optimize over-io-uring request expiration check
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: kernel-team@meta.com
References: <20250203193022.2583830-1-joannelkoong@gmail.com>
 <CAJnrk1a9zdW2GfcEHmM=QMouMV8m_huUzZao+SsMgtK7Anx=BQ@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1a9zdW2GfcEHmM=QMouMV8m_huUzZao+SsMgtK7Anx=BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/3/25 20:37, Joanne Koong wrote:
> On Mon, Feb 3, 2025 at 11:30 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> Currently, when checking whether a request has timed out, we check
>> fpq processing, but fuse-over-io-uring has one fpq per core and 256
>> entries in the processing table. For systems where there are a
>> large number of cores, this may be too much overhead.
>>
>> Instead of checking the fpq processing list, check ent_w_req_queue
>> and ent_in_userspace.
>>
>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>> ---
>>  fs/fuse/dev.c        |  2 +-
>>  fs/fuse/dev_uring.c  | 26 +++++++++++++++++++++-----
>>  fs/fuse/fuse_dev_i.h |  1 -
>>  3 files changed, 22 insertions(+), 7 deletions(-)
>>
> 
> v1: https://lore.kernel.org/linux-fsdevel/20250123235251.1139078-1-joannelkoong@gmail.com/
> Changes from v1 -> v2:
> * Remove commit queue check, which should be fine since if the request
> has expired while on this queue, it will be shortly processed anyways
> 
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 3c03aac480a4..80a11ef4b69a 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -45,7 +45,7 @@ bool fuse_request_expired(struct fuse_conn *fc, struct list_head *list)
>>         return time_is_before_jiffies(req->create_time + fc->timeout.req_timeout);
>>  }
>>
>> -bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct list_head *processing)
>> +static bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct list_head *processing)
>>  {
>>         int i;
>>
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> index ab8c26042aa8..50f5b4e32ed5 100644
>> --- a/fs/fuse/dev_uring.c
>> +++ b/fs/fuse/dev_uring.c
>> @@ -140,6 +140,21 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring)
>>         }
>>  }
>>
>> +static bool ent_list_request_expired(struct fuse_conn *fc, struct list_head *list)
>> +{
>> +       struct fuse_ring_ent *ent;
>> +       struct fuse_req *req;
>> +
>> +       ent = list_first_entry_or_null(list, struct fuse_ring_ent, list);
>> +       if (!ent)
>> +               return false;
>> +
>> +       req = ent->fuse_req;
>> +
>> +       return time_is_before_jiffies(req->create_time +
>> +                                     fc->timeout.req_timeout);
>> +}
>> +
>>  bool fuse_uring_request_expired(struct fuse_conn *fc)
>>  {
>>         struct fuse_ring *ring = fc->ring;
>> @@ -157,7 +172,8 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
>>                 spin_lock(&queue->lock);
>>                 if (fuse_request_expired(fc, &queue->fuse_req_queue) ||
>>                     fuse_request_expired(fc, &queue->fuse_req_bg_queue) ||
>> -                   fuse_fpq_processing_expired(fc, queue->fpq.processing)) {
>> +                   ent_list_request_expired(fc, &queue->ent_w_req_queue) ||
>> +                   ent_list_request_expired(fc, &queue->ent_in_userspace)) {
>>                         spin_unlock(&queue->lock);
>>                         return true;
>>                 }
>> @@ -495,7 +511,7 @@ static void fuse_uring_cancel(struct io_uring_cmd *cmd,
>>         spin_lock(&queue->lock);
>>         if (ent->state == FRRS_AVAILABLE) {
>>                 ent->state = FRRS_USERSPACE;
>> -               list_move(&ent->list, &queue->ent_in_userspace);
>> +               list_move_tail(&ent->list, &queue->ent_in_userspace);
>>                 need_cmd_done = true;
>>                 ent->cmd = NULL;
>>         }
>> @@ -715,7 +731,7 @@ static int fuse_uring_send_next_to_ring(struct fuse_ring_ent *ent,
>>         cmd = ent->cmd;
>>         ent->cmd = NULL;
>>         ent->state = FRRS_USERSPACE;
>> -       list_move(&ent->list, &queue->ent_in_userspace);
>> +       list_move_tail(&ent->list, &queue->ent_in_userspace);
>>         spin_unlock(&queue->lock);
>>
>>         io_uring_cmd_done(cmd, 0, 0, issue_flags);
>> @@ -769,7 +785,7 @@ static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ent,
>>         spin_unlock(&fiq->lock);
>>         ent->fuse_req = req;
>>         ent->state = FRRS_FUSE_REQ;
>> -       list_move(&ent->list, &queue->ent_w_req_queue);
>> +       list_move_tail(&ent->list, &queue->ent_w_req_queue);
>>         fuse_uring_add_to_pq(ent, req);
>>  }
>>
>> @@ -1185,7 +1201,7 @@ static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
>>
>>         spin_lock(&queue->lock);
>>         ent->state = FRRS_USERSPACE;
>> -       list_move(&ent->list, &queue->ent_in_userspace);
>> +       list_move_tail(&ent->list, &queue->ent_in_userspace);
>>         ent->cmd = NULL;
>>         spin_unlock(&queue->lock);
>>
>> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
>> index 3c4ae4d52b6f..19c29c6000a7 100644
>> --- a/fs/fuse/fuse_dev_i.h
>> +++ b/fs/fuse/fuse_dev_i.h
>> @@ -63,7 +63,6 @@ void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
>>  void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req);
>>
>>  bool fuse_request_expired(struct fuse_conn *fc, struct list_head *list);
>> -bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct list_head *processing);
>>
>>  #endif
>>
>> --
>> 2.43.5
>>
> 


Reviewed-by: Bernd Schubert <bernd@bsbernd.com>

