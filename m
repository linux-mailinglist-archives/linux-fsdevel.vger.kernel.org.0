Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A713B424D14
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 08:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhJGGKB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 02:10:01 -0400
Received: from n169-114.mail.139.com ([120.232.169.114]:9964 "EHLO
        n169-114.mail.139.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhJGGKB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 02:10:01 -0400
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.255.10] (unknown[116.30.194.209])
        by rmsmtp-lg-appmail-37-12051 (RichMail) with SMTP id 2f13615e8ec1772-7b31d;
        Thu, 07 Oct 2021 14:08:05 +0800 (CST)
X-RM-TRANSID: 2f13615e8ec1772-7b31d
Message-ID: <c7bf6194-2613-0245-e133-8b6ad1386eb8@139.com>
Date:   Thu, 7 Oct 2021 14:08:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [RFC PATCH v5 03/10] ovl: implement overlayfs' ->evict_inode
 operation
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210923130814.140814-1-cgxu519@mykernel.net>
 <20210923130814.140814-4-cgxu519@mykernel.net>
 <CAJfpegvh9if1tZOdnzn87JmDBZC0XBzf63NoOydkCGyX4ssaag@mail.gmail.com>
From:   Chengguang Xu <cgxu519@139.com>
In-Reply-To: <CAJfpegvh9if1tZOdnzn87JmDBZC0XBzf63NoOydkCGyX4ssaag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

在 2021/10/6 23:33, Miklos Szeredi 写道:
> On Thu, 23 Sept 2021 at 15:08, Chengguang Xu <cgxu519@mykernel.net> wrote:
>> Implement overlayfs' ->evict_inode operation,
>> so that we can clear dirty flags of overlayfs inode.
>>
>> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>> ---
>>   fs/overlayfs/super.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
>> index 51886ba6130a..2ab77adf7256 100644
>> --- a/fs/overlayfs/super.c
>> +++ b/fs/overlayfs/super.c
>> @@ -406,11 +406,18 @@ static int ovl_remount(struct super_block *sb, int *flags, char *data)
>>          return ret;
>>   }
>>
>> +static void ovl_evict_inode(struct inode *inode)
>> +{
>> +       inode->i_state &= ~I_DIRTY_ALL;
>> +       clear_inode(inode);
> clear_inode() should already clear the dirty flags; the default
> eviction should work fine without having to define an ->evict_inode.
> What am I missing?

Yeah, you are right, we don't need overlayfs' own ->evict_inode anymore

because we wait all writeback upper inodes in overlayfs' ->sync_fs.


Thanks,

Chengguang


