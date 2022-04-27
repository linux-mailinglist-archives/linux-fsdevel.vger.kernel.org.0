Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C5C511618
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 13:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiD0K4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 06:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiD0K4N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:56:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4690D3A03F7;
        Wed, 27 Apr 2022 03:30:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF7831F38D;
        Wed, 27 Apr 2022 10:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651055458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SYO6S4wSS5TgNnn69ULkvPYv5FP7agaVxb8vZruMBA=;
        b=ZtMWsp/vgSv0x+hV9X6XBgzBRpYAhz2Ni1JKSL4BLbE+tikPu/yDLv/LYgJmCiEku80xrF
        1X5NMCVCrTj2gFM7w18PXmyMw4bPUaS1tJuAbxhTAsejm5cXz2+5gSgVWmlBgvv1zUAQUj
        N9wH0oEGf1mWY6CurDEf3E9c9npyslo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651055458;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SYO6S4wSS5TgNnn69ULkvPYv5FP7agaVxb8vZruMBA=;
        b=6X6DqUjKXVYhZDBL9goi/XEUFK1JQuukpkPAwhQWeog8eUle97FBRv3cZZK8i/BbQk5H41
        5dC/EF6L72Lx8jCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73EA91323E;
        Wed, 27 Apr 2022 10:30:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wzGnGmEbaWJ0AgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 27 Apr 2022 10:30:57 +0000
Message-ID: <96acbc76-1de8-4be0-314c-4a6a9284c5a3@suse.de>
Date:   Wed, 27 Apr 2022 12:30:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 01/10] block: Introduce queue limits for copy-offload
 support
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, kbusch@kernel.org, hch@lst.de,
        Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Kanchan Joshi <joshi.k@samsung.com>,
        Arnav Dawn <arnav.dawn@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <20220426101241.30100-1-nj.shetty@samsung.com>
 <CGME20220426101910epcas5p4fd64f83c6da9bbd891107d158a2743b5@epcas5p4.samsung.com>
 <20220426101241.30100-2-nj.shetty@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220426101241.30100-2-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/26/22 12:12, Nitesh Shetty wrote:
> Add device limits as sysfs entries,
>          - copy_offload (RW)
>          - copy_max_bytes (RW)
>          - copy_max_hw_bytes (RO)
>          - copy_max_range_bytes (RW)
>          - copy_max_range_hw_bytes (RO)
>          - copy_max_nr_ranges (RW)
>          - copy_max_nr_ranges_hw (RO)
> 
> Above limits help to split the copy payload in block layer.
> copy_offload, used for setting copy offload(1) or emulation(0).
> copy_max_bytes: maximum total length of copy in single payload.
> copy_max_range_bytes: maximum length in a single entry.
> copy_max_nr_ranges: maximum number of entries in a payload.
> copy_max_*_hw_*: Reflects the device supported maximum limits.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
> ---
>   Documentation/ABI/stable/sysfs-block |  83 ++++++++++++++++
>   block/blk-settings.c                 |  59 ++++++++++++
>   block/blk-sysfs.c                    | 138 +++++++++++++++++++++++++++
>   include/linux/blkdev.h               |  13 +++
>   4 files changed, 293 insertions(+)
> 

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
