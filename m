Return-Path: <linux-fsdevel+bounces-4355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBCA7FED0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 11:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EF36B20AC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD19338DD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out0-211.mail.aliyun.com (out0-211.mail.aliyun.com [140.205.0.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2BA10F0
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 02:34:20 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047213;MF=winters.zc@antgroup.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---.VZRTs3Q_1701340458;
Received: from 30.46.227.138(mailfrom:winters.zc@antgroup.com fp:SMTPD_---.VZRTs3Q_1701340458)
          by smtp.aliyun-inc.com;
          Thu, 30 Nov 2023 18:34:18 +0800
Message-ID: <b1161d2c-5503-4dac-8db2-3fb987e98d84@antgroup.com>
Date: Thu, 30 Nov 2023 18:34:17 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND 1/2] fuse: Introduce sysfs API for resend
 pending reque
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
References: <20231129094317.453025-1-winters.zc@antgroup.com>
 <20231129094317.453025-2-winters.zc@antgroup.com>
 <CAJfpegscW2xFSNd-EFhD2OzAyDt0r4OffKKuS_uwUx09O+hcvg@mail.gmail.com>
From: "Zhao Chen" <winters.zc@antgroup.com>
In-Reply-To: <CAJfpegscW2xFSNd-EFhD2OzAyDt0r4OffKKuS_uwUx09O+hcvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2023/11/29 下午10:41, Miklos Szeredi 写道:
> On Wed, 29 Nov 2023 at 10:43, Zhao Chen <winters.zc@antgroup.com> wrote:
>>
>> From: Peng Tao <bergwolf@antgroup.com>
>>
>> When a FUSE daemon panic and failover, we aim to minimize the impact on
>> applications by reusing the existing FUSE connection. During this
>> process, another daemon is employed to preserve the FUSE connection's file
>> descriptor.
>>
>> However, it is possible for some inflight requests to be lost and never
>> returned. As a result, applications awaiting replies would become stuck
>> forever. To address this, we can resend these pending requests to the
>> FUSE daemon, which is done by fuse_resend_pqueue(), ensuring they are
>> properly processed again.
>>
>> Signed-off-by: Peng Tao <bergwolf@antgroup.com>
>> Signed-off-by: Zhao Chen <winters.zc@antgroup.com>
>> ---
>>   fs/fuse/control.c | 20 ++++++++++++++++
>>   fs/fuse/dev.c     | 59 +++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/fuse/fuse_i.h  |  5 +++-
>>   3 files changed, 83 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
>> index 284a35006462..fd2258d701dd 100644
>> --- a/fs/fuse/control.c
>> +++ b/fs/fuse/control.c
>> @@ -44,6 +44,18 @@ static ssize_t fuse_conn_abort_write(struct file *file, const char __user *buf,
>>          return count;
>>   }
>>
>> +static ssize_t fuse_conn_resend_write(struct file *file, const char __user *buf,
>> +                                     size_t count, loff_t *ppos)
>> +{
>> +       struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
>> +
>> +       if (fc) {
>> +               fuse_resend_pqueue(fc);
>> +               fuse_conn_put(fc);
>> +       }
>> +       return count;
>> +}
>> +
> 
> How about triggering this with a notification (FUSE_NOTIFY_RESEND)?
> 
> Thanks,
> Miklos

Yes, I think using notification is better, I will try to implement it in 
v3. Thank you for the review!

Regards,
Zhao Chen

