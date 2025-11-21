Return-Path: <linux-fsdevel+bounces-69342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ECEC773E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 05:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EAB7C35E12F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 04:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6412F068E;
	Fri, 21 Nov 2025 04:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cMQZgExc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B392222A1;
	Fri, 21 Nov 2025 04:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763699390; cv=none; b=d1fLK0+HZk3OIf21/O67+C8eTMvsN4l1HclecOhDlRyfstmlA5aOjsmD/yqTbm4cYFrahYUPWeIuC2FsOhhSFRz5P1wBIhTGygZrixjKqLCcN/TZX3gamz00K0MQriOETnvMQkIH1Mp4Yx/Lr1Q/rGhasTrBSG0YVQn9y4q05ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763699390; c=relaxed/simple;
	bh=haFxdMn70B7RfQpBJCDsLSYaiGjJqhUnhskps9vNZ9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEEpRntPZDY/D4krKj7uubmq+6ob3n+BFMdwFofDqsZOyBXxhhY6DnI2rNY6UrVW2UBWNk2FUXHz47jPwu3epU5mISGsBCHVxj+M92cZsM79X47L3VTzG0jT8fZMUurnaxMP45biBeem8UtNtEW1hug4gsZCKhGu4yWPiihHC/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cMQZgExc; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763699384; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lUkaoYS9MtxtwNYtPqlY1z+Phvth7Wxy9T76yQ4yfsE=;
	b=cMQZgExc+pAkP5tEVOLTelT5e0OXlkRpfmiCvxQ3KFT+pD3vt/AMJN90qnqzFKyPLWjJglakcQd+cTS6Za5hKOYbRm+y6C/ZCXie4ZLmEmQBU6pkNazGQz8zqLSwNNZ426tZVOFyz0eoV8MJEReZTLLwZTV1WeUHlogfvw9YAr4=
Received: from 30.221.131.79(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WszYFdT_1763699383 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Nov 2025 12:29:43 +0800
Message-ID: <86b0ce55-60f5-4bf4-84a8-6d612478baa3@linux.alibaba.com>
Date: Fri, 21 Nov 2025 12:29:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: correct FSDAX detection
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com"
 <syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com>
References: <691af9f6.a70a0220.3124cb.0097.GAE@google.com>
 <20251117115729.626525-1-hsiangkao@linux.alibaba.com>
 <PUZPR04MB6316EBBEFB9F1878D1691E2481D5A@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <PUZPR04MB6316EBBEFB9F1878D1691E2481D5A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/21 12:12, Yuezhang.Mo@sony.com wrote:
> On November 17, 2025 19:57 Gao Xiang wrote:
>> The detection of the primary device is skipped incorrectly
>> if the multiple or flattened feature is enabled.
>>
>> It also fixes the FSDAX misdetection for non-block extra blobs.
>>
>> Fixes: c6993c4cb918 ("erofs: Fallback to normal access if DAX is not supported on extra device")
>> Reported-by: syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/r/691af9f6.a70a0220.3124cb.0097.GAE@google.com
>> Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   fs/erofs/super.c | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index f3f8d8c066e4..cd8ff98c2938 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -174,15 +174,15 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>>                  if (!erofs_is_fileio_mode(sbi)) {
>>                          dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
>>                                          &dif->dax_part_off, NULL, NULL);
>> -                       if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWAYS)) {
>> -                               erofs_info(sb, "DAX unsupported by %s. Turning off DAX.",
>> -                                          dif->path);
>> -                               clear_opt(&sbi->opt, DAX_ALWAYS);
>> -                       }
>>                  } else if (!S_ISREG(file_inode(file)->i_mode)) {
>>                          fput(file);
>>                          return -EINVAL;
>>                  }
>> +               if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWAYS)) {
>> +                       erofs_info(sb, "DAX unsupported by %s. Turning off DAX.",
>> +                                  dif->path);
>> +                       clear_opt(&sbi->opt, DAX_ALWAYS);
>> +               }
>>                  dif->file = file;
>>          }
>>
>> @@ -215,13 +215,13 @@ static int erofs_scan_devices(struct super_block *sb,
>>                            ondisk_extradevs, sbi->devs->extra_devices);
>>                  return -EINVAL;
>>          }
>> -       if (!ondisk_extradevs) {
>> -               if (test_opt(&sbi->opt, DAX_ALWAYS) && !sbi->dif0.dax_dev) {
>> -                       erofs_info(sb, "DAX unsupported by block device. Turning off DAX.");
>> -                       clear_opt(&sbi->opt, DAX_ALWAYS);
>> -               }
>> -               return 0;
>> +
>> +       if (test_opt(&sbi->opt, DAX_ALWAYS) && !sbi->dif0.dax_dev) {
>> +               erofs_info(sb, "DAX unsupported by block device. Turning off DAX.");
>> +               clear_opt(&sbi->opt, DAX_ALWAYS);
>>          }
>> +       if (!ondisk_extradevs)
>> +               return 0;
> 
> Hi Gao Xiang,
> 
> If using multiple devices, is there still file data on the primary device?
> If the primary device only contains metadata, the primary device does not need
> to support DAX.

Hi Yuezhang,

Currently we don't have a per-device/file fsdax selection
design/implementation.

If fsdax is on, for example, directory data arranged in the primary
device will go through fsdax path (but your case above is that the
primary device does not need to support fsdax.)

Anyway, in principle, we could make them work, but per-device FSDAX
needs a detailed design, I think we should restrict them on the
per-filesystem basis now.

Thanks,
Gao Xiang

> 
>>
>>          if (!sbi->devs->extra_devices && !erofs_is_fscache_mode(sb))
>>                  sbi->devs->flatdev = true;
>> --
>> 2.43.5



