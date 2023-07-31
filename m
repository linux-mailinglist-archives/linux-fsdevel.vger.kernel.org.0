Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FCB7693F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 12:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjGaK7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 06:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjGaK6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:58:41 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EC419A4;
        Mon, 31 Jul 2023 03:58:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Voe5MEo_1690801095;
Received: from 10.120.130.14(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Voe5MEo_1690801095)
          by smtp.aliyun-inc.com;
          Mon, 31 Jul 2023 18:58:17 +0800
Message-ID: <9b57e5f7-62b6-fd65-4dac-a71c9dc08abc@linux.alibaba.com>
Date:   Mon, 31 Jul 2023 18:58:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [syzbot] [erofs?] [fat?] WARNING in erofs_kill_sb
To:     Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>
Cc:     brauner@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jack@suse.cz, jefflexu@linux.alibaba.com, linkinjeon@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <000000000000f43cab0601c3c902@google.com>
 <20230731093744.GA1788@lst.de>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230731093744.GA1788@lst.de>
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



On 2023/7/31 17:37, Christoph Hellwig wrote:
> On Mon, Jul 31, 2023 at 12:57:58AM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    d7b3af5a77e8 Add linux-next specific files for 20230728
> 
> Hmm, the current linux-next tree does not seem to have that commit ID
> any more, and the line numbers don't match up.  I think it is the
> WARN_ON for the magic, which could probably be just removed.  I'll
> try the reproducers when I find a bit more time.

Previously, deactivate_locked_super() or .kill_sb() will only be
called after fill_super is called, and .s_magic will be set at
the very beginning of erofs_fc_fill_super().

After ("fs: open block device after superblock creation"), such
convension is changed now.  Yet at a quick glance,

WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);

in erofs_kill_sb() can be removed since deactivate_locked_super()
will also be called if setup_bdev_super() is falled.  I'd suggest
that removing this WARN_ON() in the related commit, or as
a following commit of the related branch of the pull request if
possible.

Thanks,
Gao Xiang
