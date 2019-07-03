Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6B905DCAD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 04:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfGCCzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 22:55:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43450 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbfGCCzz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:55:55 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 07FDDBF43737DCD89F98;
        Wed,  3 Jul 2019 10:55:52 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019
 10:55:48 +0800
Subject: Re: about patch <-f2fs-run-discard-jobs-when-put_super>
To:     =?UTF-8?B?6IKW6KGhIChIZW5nIFhpYW8p?= <heng.xiao@unisoc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
CC:     =?UTF-8?B?5p2O5ZCJ576kIChKaXF1biBMaSk=?= <jiqun.li@unisoc.com>,
        =?UTF-8?B?5a2f56Wl5YWJIChTaW1vbiBNZW5nKQ==?= 
        <Simon.Meng@unisoc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
References: <9bd3d9f53b7c446b9ce03ccf010efa26@shmbx04.spreadtrum.com>
 <b7e151a8-74f6-2c9c-8ed3-f169f168d8d7@huawei.com>
 <d64cdeccf50543ffb71ea5a4eff8ccaf@shmbx04.spreadtrum.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f72f482f-8d54-4e69-15ec-bdd50ae5f7fd@huawei.com>
Date:   Wed, 3 Jul 2019 10:56:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d64cdeccf50543ffb71ea5a4eff8ccaf@shmbx04.spreadtrum.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Xiao,

There are several issues:
- miss patch title
- miss Signed-off
- don't need to attach all commit message from old flawed patch

Anyway, I've send one patch for you to fix all above issues. :)

Thanks,

On 2019/7/2 20:34, 肖衡 (Heng Xiao) wrote:
> From 35f7e2f6b1b39e6b1704567c27c8cacdd836e8ff Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Mon, 14 Jan 2019 10:42:11 -0800
> Subject: [PATCH] f2fs: run discard jobs when put_super
> 
> When we umount f2fs, we need to avoid long delay due to discard commands, which
> is actually taking tens of seconds, if storage is very slow on UNMAP. So, this
> patch introduces timeout-based work on it.
> 
> By default, let me give 5 seconds for discard.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs |  7 +++++++
>  fs/f2fs/f2fs.h                          |  5 ++++-
>  fs/f2fs/segment.c                       | 11 ++++++++++-
>  fs/f2fs/super.c                         |  4 +++-
>  fs/f2fs/sysfs.c                         |  3 +++
>  5 files changed, 27 insertions(+), 3 deletions(-)
> 
> --------------------------------------------------------------
> The above patch can't cover all discard timeout scenario. It's should add following patch .
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index e1bd513..5751d84 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1532,6 +1532,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>                                 io_interrupted = true;
>                                 break;
>                         }
> +                       
> +                       if (dpolicy->timeout != 0 &&
> +                               f2fs_time_over(sbi, dpolicy->timeout))
> +                               break;
>  
>                         __submit_discard_cmd(sbi, dpolicy, dc, &issued);
>  
> 
> 
> 
> 
> Best Regards!
> Heng.xiao
> ==============================================
> PFC SZ Spreadtrum
> Mobile: 18664561142
> Tel:   +86-755-36665668 ext.2011
> ==============================================
> 
> -----Original Message-----
> From: Chao Yu [mailto:yuchao0@huawei.com] 
> Sent: Monday, July 01, 2019 5:00 PM
> To: 肖衡 (Heng Xiao); Jaegeuk Kim
> Cc: 李吉群 (Jiqun Li); 孟祥光 (Simon Meng)
> Subject: Re: about patch <-f2fs-run-discard-jobs-when-put_super>
> 
> Hi Heng,
> 
> Thanks for the report. :)
> 
> I can confirm this issue, could you send a formal patch to fix this, please note that it needs to cc f2fs mailing list.
> 
> Thanks,
> 
> On 2019/7/1 13:29, 肖衡 (Heng Xiao) wrote:
>> Sorry,
>>
>>  
>>
>>         for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
>>
>> +               if (dpolicy->timeout != 0 &&
>>
>> +                               f2fs_time_over(sbi, dpolicy->timeout))
>>
>> +               {//in some case,do not have chance to break
>>
>> +                       printk("__issue_discard_cmd,timeout and 
>> +break,i=%d\n",i);
>>
>> +                       break;
>>
>> +               }
>>
>> +
>>
>>                 if (i + 1 < dpolicy->granularity)
>>
>>                         break;
>>
>>  
>>
>> @@ -1524,6 +1539,12 @@ static int __issue_discard_cmd(struct 
>> f2fs_sb_info *sbi,
>>
>>                                 io_interrupted = true;
>>
>>                                 break;
>>
>>                         }
>>
>> +                       if (dpolicy->timeout != 0 &&
>>
>> +                               f2fs_time_over(sbi, dpolicy->timeout))
>>
>> +                       {//in some case,do need break,*please check*
>>
>> +                               printk("__issue_discard_cmd,timeout 
>> +and break
>> 222\n");
>>
>> +                               break;
>>
>> +                       }
>>
>>  
>>
>>  
>>
>> Best Regards!
>>
>> Heng.xiao
>>
>> ==============================================
>>
>> PFC SZ Spreadtrum
>>
>> Mobile: 18664561142
>>
>> Tel:   +86-755-36665668 ext.2011
>> ==============================================
>>
>>  
>>
>> *From:*肖衡(Heng Xiao)
>> *Sent:* Monday, July 01, 2019 1:22 PM
>> *To:* 'Jaegeuk Kim'; 'Chao Yu'
>> *Cc:* 李吉群(Jiqun Li); 孟祥光(Simon Meng)
>> *Subject:* about patch <-f2fs-run-discard-jobs-when-put_super>
>>
>>  
>>
>> Dear Jaegeuk and Yuchao
>>
>>  
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>
>> index 905b3c7..8630cd7 100644
>>
>> --- a/fs/f2fs/segment.c
>>
>> +++ b/fs/f2fs/segment.c
>>
>> @@ -960,6 +960,7 @@ static void __remove_discard_cmd(struct 
>> f2fs_sb_info *sbi,
>>
>>         unsigned long flags;
>>
>>  
>>
>>         trace_f2fs_remove_discard(dc->bdev, dc->start, dc->len);
>>
>> +       printk("--hengxiao--%s-, start: 0x%x, len: 0x%x\n", __func__, 
>> +dc->start,
>> dc->len);
>>
>>  
>>
>>         spin_lock_irqsave(&dc->lock, flags);
>>
>>         if (dc->bio_ref) {
>>
>> @@ -1117,6 +1118,7 @@ static void __init_discard_policy(struct 
>> f2fs_sb_info *sbi,
>>
>>  
>>
>>         dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
>>
>>         dpolicy->io_aware_gran = MAX_PLIST_NUM;
>>
>> +       dpolicy->timeout = 0;
>>
>>  
>>
>>         if (discard_type == DPOLICY_BG) {
>>
>>                 dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
>>
>> @@ -1169,6 +1171,7 @@ static int __submit_discard_cmd(struct 
>> f2fs_sb_info *sbi,
>>
>>                 return 0;
>>
>>  
>>
>>         trace_f2fs_issue_discard(bdev, dc->start, dc->len);
>>
>> +       printk("--hengxiao--%s-, start: 0x%x, len: 0x%x\n", __func__, 
>> +dc->start,
>> dc->len);
>>
>>  
>>
>>         lstart = dc->lstart;
>>
>>         start = dc->start;
>>
>> @@ -1500,7 +1503,19 @@ static int __issue_discard_cmd(struct 
>> f2fs_sb_info *sbi,
>>
>>         int i, issued = 0;
>>
>>         bool io_interrupted = false;
>>
>>  
>>
>> +      
>> printk("--hengxiao--__issue_discard_cmd,dpolicy->timeout=%d\n",dpolicy
>> ->timeout);
>>
>> +
>>
>> +       if (dpolicy->timeout != 0)
>>
>> +               f2fs_update_time(sbi, dpolicy->timeout);
>>
>> +
>>
>>         for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
>>
>> +               if (dpolicy->timeout != 0 &&
>>
>> +                               f2fs_time_over(sbi, dpolicy->timeout))
>>
>> +               {//in some case,do not have chance to break,please 
>> +check
>>
>> +                       printk("__issue_discard_cmd,timeout and 
>> +break,i=%d\n",i);
>>
>> +                       break;
>>
>> +               }
>>
>> +
>>
>>                 if (i + 1 < dpolicy->granularity)
>>
>>                         break;
>>
>>  
>>
>> @@ -1524,6 +1539,12 @@ static int __issue_discard_cmd(struct 
>> f2fs_sb_info *sbi,
>>
>>                                 io_interrupted = true;
>>
>>                                 break;
>>
>>                         }
>>
>> +                       if (dpolicy->timeout != 0 &&
>>
>> +                               f2fs_time_over(sbi, dpolicy->timeout))
>>
>> +                       {//in some case,do need break
>>
>> +                               printk("__issue_discard_cmd,timeout 
>> +and break
>> 222\n");
>>
>> +                               break;
>>
>> +                       }
>>
>>  
>>
>>  
>>
>>  
>>
>> //int the case, do not have chance to break
>>
>> [  559.306907] c5     1 init: Reboot start, reason: 
>> shutdown,userrequested,
>> rebootTarget:
>>
>> ...
>>
>> [  564.936861] c4     1 
>> --hengxiao--__issue_discard_cmd,dpolicy->timeout=5
>>
>> [  564.943425] c4     1 --hengxiao--__submit_discard_cmd-, start: 0x4a400, len:
>> 0x200
>>
>> [  564.952686] c4     1 --hengxiao--__submit_discard_cmd-, start: 0x4a600, len:
>> 0x200
>>
>> ...
>>
>> [ 1164.717728] c4     1 --hengxiao--__submit_discard_cmd-, start: 0xd9dc00, len:
>> 0x200
>>
>> //when break, 1164-559=605 second elapse
>>
>> [ 1164.765011] c4     1 --hengxiao--__issue_discard_cmd,timeout and 
>> break
>>
>>  
>>
>> Best Regards!
>>
>> Heng.xiao
>>
>> ==============================================
>>
>> PFC SZ Spreadtrum
>>
>> Mobile: 18664561142
>>
>> Tel:   +86-755-36665668 ext.2011
>> ==============================================
>>
>>  
>>
>> ----------------------------------------------------------------------
>> ---------- /This email (including its attachments) is intended only 
>> for the person or entity to which it is addressed and may contain 
>> information that is privileged, confidential or otherwise protected 
>> from disclosure. Unauthorized use, dissemination, distribution or 
>> copying of this email or the information herein or taking any action 
>> in reliance on the contents of this email or the information herein, 
>> by anyone other than the intended recipient, or an employee or agent 
>> responsible for delivering the message to the intended recipient, is 
>> strictly prohibited. If you are not the intended recipient, please do 
>> not read, copy, use or disclose any part of this e-mail to others. 
>> Please notify the sender immediately and permanently delete this 
>> e-mail and any attachments if you received it in error. Internet 
>> communications cannot be guaranteed to be timely, secure, error-free 
>> or virus-free. The sender does not accept liability for any errors or 
>> omissions. /
>> /本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。
>> 严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复
>> 制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有
>> 附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防
>> 毒。发件人对任何错漏均不承担责任。/
> 
> 
> ============================================================================
> This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions. 
> 本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。
> 
