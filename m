Return-Path: <linux-fsdevel+bounces-7591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F67982833E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 10:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740841C24AC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 09:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BE532C63;
	Tue,  9 Jan 2024 09:32:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out187-19.us.a.mail.aliyun.com (out187-19.us.a.mail.aliyun.com [47.90.187.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB3C36091
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047188;MF=winters.zc@antgroup.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---.W1vAE2v_1704791809;
Received: from 30.46.227.141(mailfrom:winters.zc@antgroup.com fp:SMTPD_---.W1vAE2v_1704791809)
          by smtp.aliyun-inc.com;
          Tue, 09 Jan 2024 17:16:50 +0800
Message-ID: <b37f6148-4e94-4f8d-a231-95663ab538dd@antgroup.com>
Date: Tue, 09 Jan 2024 17:16:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND 1/2] fuse: Introduce a new notification type for
 resend pending requests
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
References: <20231220084928.298302-1-winters.zc@antgroup.com>
 <20231220084928.298302-2-winters.zc@antgroup.com>
 <CAJfpegtTzwANHiZty89qo77ryz0XAN4_uDP9oZ4Syx4D4YkiDA@mail.gmail.com>
From: "Zhao Chen" <winters.zc@antgroup.com>
In-Reply-To: <CAJfpegtTzwANHiZty89qo77ryz0XAN4_uDP9oZ4Syx4D4YkiDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/1/4 20:03, Miklos Szeredi 写道:
> On Wed, 20 Dec 2023 at 09:49, Zhao Chen <winters.zc@antgroup.com> wrote:
>>
>> When a FUSE daemon panics and failover, we aim to minimize the impact on
>> applications by reusing the existing FUSE connection. During this process,
>> another daemon is employed to preserve the FUSE connection's file
>> descriptor. The new started FUSE Daemon will takeover the fd and continue
>> to provide service.
>>
>> However, it is possible for some inflight requests to be lost and never
>> returned. As a result, applications awaiting replies would become stuck
>> forever. To address this, we can resend these pending requests to the
>> new started FUSE daemon.
>>
>> This patch introduces a new notification type "FUSE_NOTIFY_RESEND", which
>> can trigger resending of the pending requests, ensuring they are properly
>> processed again.
>>
>> Signed-off-by: Zhao Chen <winters.zc@antgroup.com>
>> ---
>>   fs/fuse/dev.c             | 64 +++++++++++++++++++++++++++++++++++++++
>>   include/uapi/linux/fuse.h |  1 +
>>   2 files changed, 65 insertions(+)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 1a8f82f478cb..a5a874b2f2e2 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -1775,6 +1775,67 @@ static int fuse_notify_retrieve(struct fuse_conn *fc, unsigned int size,
>>          return err;
>>   }
>>
>> +/*
>> + * Resending all processing queue requests.
>> + *
>> + * During a FUSE daemon panics and failover, it is possible for some inflight
>> + * requests to be lost and never returned. As a result, applications awaiting
>> + * replies would become stuck forever. To address this, we can use notification
>> + * to trigger resending of these pending requests to the FUSE daemon, ensuring
>> + * they are properly processed again.
>> + *
>> + * Please note that this strategy is applicable only to idempotent requests or
>> + * if the FUSE daemon takes careful measures to avoid processing duplicated
>> + * non-idempotent requests.
>> + */
>> +static void fuse_resend(struct fuse_conn *fc)
>> +{
>> +       struct fuse_dev *fud;
>> +       struct fuse_req *req, *next;
>> +       struct fuse_iqueue *fiq = &fc->iq;
>> +       LIST_HEAD(to_queue);
>> +       unsigned int i;
>> +
>> +       spin_lock(&fc->lock);
>> +       if (!fc->connected) {
>> +               spin_unlock(&fc->lock);
>> +               return;
>> +       }
>> +
>> +       list_for_each_entry(fud, &fc->devices, entry) {
>> +               struct fuse_pqueue *fpq = &fud->pq;
>> +
>> +               spin_lock(&fpq->lock);
>> +               list_for_each_entry_safe(req, next, &fpq->io, list) {
> 
> Handling of requests on fpq->io is tricky, since they are in the state
> of being read or written by the fuse server.   Re-queuing it in this
> state likely can result in some sort of corruption.
> 
> The simplest solution is to just ignore requests in the I/O state.  Is
> this a good solution for your use case?
> 
> Thanks,
> Miklos

Thank you for your insightful review!

The initial intention behind handling fpq->io was to ensure that we 
attempted to resend all the inflight requests. Upon reflection, I agree 
that only handling fpq->processing is sufficient for us. This solution 
is both reasonable and simple.

I will remove the code related to fpq->io in the upcoming patch.

Best regards,
Zhao Chen

