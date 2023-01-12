Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25F1667872
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 16:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbjALPCr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 10:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239778AbjALPCX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:02:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3D86A0C5;
        Thu, 12 Jan 2023 06:48:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BD0B03F0CB;
        Thu, 12 Jan 2023 14:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673534912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zsa+fdfwdlDM2GetrLrqpou94nUfON/csukFq2m/izo=;
        b=kSH/6kvbmwFCrzEEWGGvL2I7yKz/0cDBLQGnVISP472mTr6ExKDickiXG6C6K+KZtX5iuG
        tOz/EgxbD9EltuY8CoTfas6xed9+rz+XZSvZD5nZq5QFCAPmfEStsRo2imWcxLR4WSq3Bj
        UUU+eukN0ulxKY0Yv+szQQi4rm476TQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673534912;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zsa+fdfwdlDM2GetrLrqpou94nUfON/csukFq2m/izo=;
        b=2KNJsOzqPWJTzkRPymaNqNliovVGM6bjPs1WxlGHd0wVD9lIsbdd9Y3kxcnBOE7z9QB0Ne
        s3obyhpx6c60AwBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 836B913776;
        Thu, 12 Jan 2023 14:48:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /6ZkH8AdwGOIEQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 Jan 2023 14:48:32 +0000
Message-ID: <20d7fde4-dd17-de97-53e8-aa808a325efd@suse.de>
Date:   Thu, 12 Jan 2023 15:48:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 3/9] block: add emulation for copy
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Vincent Fu <vincent.fu@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20230112115908.23662-1-nj.shetty@samsung.com>
 <CGME20230112120054epcas5p3ec5887c4e1de59f7529dafca1cd6aa65@epcas5p3.samsung.com>
 <20230112115908.23662-4-nj.shetty@samsung.com>
 <bfec42d1-a1bf-3b3a-10dd-8d3db0a6e6a0@suse.de>
In-Reply-To: <bfec42d1-a1bf-3b3a-10dd-8d3db0a6e6a0@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/12/23 15:46, Hannes Reinecke wrote:
> On 1/12/23 12:58, Nitesh Shetty wrote:
>> For the devices which does not support copy, copy emulation is
>> added. Copy-emulation is implemented by reading from source ranges
>> into memory and writing to the corresponding destination asynchronously.
>> For zoned device we maintain a linked list of read submission and try to
>> submit corresponding write in same order.
>> Also emulation is used, if copy offload fails or partially completes.
>>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>> ---
>>   block/blk-lib.c        | 241 ++++++++++++++++++++++++++++++++++++++++-
>>   block/blk-map.c        |   4 +-
>>   include/linux/blkdev.h |   3 +
>>   3 files changed, 245 insertions(+), 3 deletions(-)
>>
> I'm not sure if I agree with this one.
> 
> You just submitted a patch for device-mapper to implement copy offload, 
> which (to all intents and purposes) _is_ an emulation.
> 
> So why do we need to implement it in the block layer as an emulation?
> Or, if we have to, why do we need the device-mapper emulation?
> This emulation will be doing the same thing, no?
> 
Sheesh. One should read the entire patchset.

Disregard the above comment.

Cheers,

Hannes

