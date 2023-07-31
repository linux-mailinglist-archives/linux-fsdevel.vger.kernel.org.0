Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C79476979E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 15:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGaN3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 09:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjGaN3s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:29:48 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39ED10E3;
        Mon, 31 Jul 2023 06:29:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VoglcAp_1690810177;
Received: from 172.20.10.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VoglcAp_1690810177)
          by smtp.aliyun-inc.com;
          Mon, 31 Jul 2023 21:29:39 +0800
Message-ID: <9fb82ade-e8a4-8b8a-25f3-b71dadc6dab1@linux.alibaba.com>
Date:   Mon, 31 Jul 2023 21:29:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [syzbot] [erofs?] [fat?] WARNING in erofs_kill_sb
To:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>,
        chao@kernel.org, huyue2@coolpad.com, jack@suse.cz,
        jefflexu@linux.alibaba.com, linkinjeon@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <000000000000f43cab0601c3c902@google.com>
 <20230731093744.GA1788@lst.de>
 <9b57e5f7-62b6-fd65-4dac-a71c9dc08abc@linux.alibaba.com>
 <20230731111622.GA3511@lst.de>
 <20230731-augapfel-penibel-196c3453f809@brauner>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230731-augapfel-penibel-196c3453f809@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/7/31 20:43, Christian Brauner wrote:
> On Mon, Jul 31, 2023 at 01:16:22PM +0200, Christoph Hellwig wrote:
>> On Mon, Jul 31, 2023 at 06:58:14PM +0800, Gao Xiang wrote:
>>> Previously, deactivate_locked_super() or .kill_sb() will only be
>>> called after fill_super is called, and .s_magic will be set at
>>> the very beginning of erofs_fc_fill_super().
>>>
>>> After ("fs: open block device after superblock creation"), such
>>> convension is changed now.  Yet at a quick glance,
>>>
>>> WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
>>>
>>> in erofs_kill_sb() can be removed since deactivate_locked_super()
>>> will also be called if setup_bdev_super() is falled.  I'd suggest
>>> that removing this WARN_ON() in the related commit, or as
>>> a following commit of the related branch of the pull request if
>>> possible.
>>
>> Agreed.  I wonder if we should really call into ->kill_sb before
>> calling into fill_super, but I need to carefull look into the
>> details.
> 
> I think checking for s_magic in erofs kill sb is wrong as it introduces
> a dependency on both fill_super() having been called and that s_magic is
> initialized first. If someone reorders erofs_kill_sb() such that s_magic
> is only filled in once everything else succeeded it would cause the same
> bug. That doesn't sound nice to me.

Many many years ago, strange .kill_sb called on our smartphone products
without proper call chain.  That was why it was added and s_magic was
initialized first and at least it reminds a slight behavior change for
us (this time).

Anyway, I also think it's almost useless upstream so I'm fine to drop
this WARN_ON().

Thanks,
Gao Xiang

> 
> I think ->fill_super() should only be called after successfull
> superblock allocation and after the device has been successfully opened.
> Just as this code does now. So ->kill_sb() should only be called after
> we're guaranteed that ->fill_super() has been called.
> 
> We already mostly express that logic through the fs_context object.
> Anything that's allocated in fs_context->init_fs_context() is freed in
> fs_context->free() before fill_super() is called. After ->fill_super()
> is called fs_context->s_fs_info will have been transferred to
> sb->s_fs_info and will have to be killed via ->kill_sb().
> 
> Does that make sense?
