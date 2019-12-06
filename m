Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF08114B83
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 04:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfLFDyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 22:54:17 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:43768 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbfLFDyR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 22:54:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Tk5aP4X_1575604447;
Received: from ali-186590e05fa3.local(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0Tk5aP4X_1575604447)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Dec 2019 11:54:07 +0800
Subject: Re: [PATCH V2 0/2] ovl: implement async IO routines
To:     miklos@szeredi.hu, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1574243126-59283-1-git-send-email-jiufei.xue@linux.alibaba.com>
 <052a9b10-1cca-35d0-622a-d597421b3ecf@linux.alibaba.com>
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
Message-ID: <7ff1ed40-ef1c-32e6-a539-1f10aa46dd42@linux.alibaba.com>
Date:   Fri, 6 Dec 2019 11:54:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <052a9b10-1cca-35d0-622a-d597421b3ecf@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping again.

From my test, the patchset can improve the performance significantly.

The following data are tested on INTEL P4510 NVMe using fio with iodepth
128 and blocksize 4k.

----------------------------------------------------------------
                      |       RANDREAD     |     RANDWRITE     |
----------------------------------------------------------------
w/ async IO routines  |        377MB/s     |      405MB/s      |
----------------------------------------------------------------
w/o async IO routines |        32.0MB/s	   |      62.3MB/s     |
----------------------------------------------------------------

Regards,
Jiufei

On 2019/11/26 上午10:00, Jiufei Xue wrote:
> Hi miklos,
> 
> Could you please kindly review this patch and give some advice?
> 
> Thanks,
> Jiufei
> 
> On 2019/11/20 下午5:45, Jiufei Xue wrote:
>> ovl stacks regular file operations now. However it doesn't implement
>> async IO routines and will convert async IOs to sync IOs which is not
>> expected.
>>
>> This patchset implements overlayfs async IO routines.
>>
>> Jiufei Xue (2)
>> vfs: add vfs_iocb_iter_[read|write] helper functions
>> ovl: implement async IO routines
>>
>>  fs/overlayfs/file.c      |  116 +++++++++++++++++++++++++++++++++++++++++------
>>  fs/overlayfs/overlayfs.h |    2
>>  fs/overlayfs/super.c     |   12 ++++
>>  fs/read_write.c          |   58 +++++++++++++++++++++++
>>  include/linux/fs.h       |   16 ++++++
>>  5 files changed, 188 insertions(+), 16 deletions(-)
>>
> 
