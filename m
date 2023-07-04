Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D3774739C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 16:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjGDOGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 10:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjGDOGb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:06:31 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB9BF7;
        Tue,  4 Jul 2023 07:06:30 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b8303cd32aso44543055ad.2;
        Tue, 04 Jul 2023 07:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479590; x=1691071590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JV2SCOEdB9t0w6tigDexjJMYhGF54ZwsLlYmJ1gE7wU=;
        b=bMICWCFC1W076H+YN1lR/nCQau0HbgCI0H4vl8vZYXgociPXrYyV5p2vJwJSn4IvXw
         X0VdLEzWRujDjUle97qp5ejyEiOTvK9cEwtJF9fXchWUeZ3V4uQSdYUun19YJ76vkPzg
         EZ1VW7i4f34rBtELVeYa/NvSt/WWf8EGkE3xgRc0FNndIJufTeQZZj1KiqF78g6Qv4BO
         0X8PwY5ee/rPn2rjRArQ76JDuSpgQ/4XYckAc/yuSHkTasvw/OegnkRz43f6yLq3W0e3
         rRA6atJmAtXopQDEq1HSeWbL6ASsixUt+la82hfgmJxFH2y2NJEwaZhVIkeu3mm+1ick
         EadQ==
X-Gm-Message-State: ABy/qLaMBNDn1rNBaXGQB2u/UKIklMPTeUzdebm00ZhMy9QxeJpBvQHH
        tDxcOHS51TLWDp/ELdGfDOY=
X-Google-Smtp-Source: APBJJlEESj5502hCCjnCrW5aNdhMviGxH5NXIz8SFwBF+614aVB6e0+1hJtWMTw8TJzZNuQy8olTNg==
X-Received: by 2002:a17:903:447:b0:1b8:a31b:ac85 with SMTP id iw7-20020a170903044700b001b8a31bac85mr2719760plb.41.1688479589749;
        Tue, 04 Jul 2023 07:06:29 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id jk4-20020a170903330400b001b672af624esm13083569plb.164.2023.07.04.07.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 07:06:29 -0700 (PDT)
Message-ID: <bb91e76b-0bd8-a949-f8b9-868f919ebcb9@acm.org>
Date:   Tue, 4 Jul 2023 07:06:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 01/32] block: Provide blkdev_get_handle_* functions
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Alasdair Kergon <agk@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anna Schumaker <anna@kernel.org>, Chao Yu <chao@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com, Gao Xiang <xiang@kernel.org>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Joern Engel <joern@lazybastard.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Minchan Kim <minchan@kernel.org>, ocfs2-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Song Liu <song@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        target-devel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        xen-devel@lists.xenproject.org
References: <20230629165206.383-1-jack@suse.cz>
 <20230704122224.16257-1-jack@suse.cz>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230704122224.16257-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/4/23 05:21, Jan Kara wrote:
> +struct bdev_handle {
> +	struct block_device *bdev;
> +	void *holder;
> +};

Please explain in the patch description why a holder pointer is 
introduced in struct bdev_handle and how it relates to the bd_holder 
pointer in struct block_device. Is one of the purposes of this patch 
series perhaps to add support for multiple holders per block device?

Thanks,

Bart.

