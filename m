Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D71798203
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 08:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbjIHGLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 02:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjIHGLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:11:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6891BD8;
        Thu,  7 Sep 2023 23:11:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A5672218EE;
        Fri,  8 Sep 2023 06:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694153469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CxtGgeCI2XmJq+6uhOvPYw8KuX0iEZhv0646A0+eifI=;
        b=opQEIfC83i2wcgbt16HIXvt47F5wmUlXEhVo82kSwfiHm8cHrdNU7xQwYsZDHsQDOiSx9A
        2UDFUQsC8sWBwmD3w3YK2hTKnWiDhHDW9jjIka/nInlr6F0w8VP1roojv2T6ek4Juu/ehg
        BK3Pu8hXvjEuPmma5MzGQPBwvZBhHsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694153469;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CxtGgeCI2XmJq+6uhOvPYw8KuX0iEZhv0646A0+eifI=;
        b=axkhXS8d1Lqav0ruVLS2Xy5XMJKSwzUXyWdUmiAbfEEC/WaX7Wc5EWl5yVfdxbxYuAD92D
        hHejxJLV0p4RtcCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35602131FD;
        Fri,  8 Sep 2023 06:11:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iNHICv26+mQYaQAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 08 Sep 2023 06:11:09 +0000
Message-ID: <5e0271d9-d3a3-45cf-8ba7-fd4617fb6557@suse.de>
Date:   Fri, 8 Sep 2023 08:11:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 08/12] nvmet: add copy command support for bdev and
 file ns
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
References: <20230906163844.18754-1-nj.shetty@samsung.com>
 <CGME20230906164359epcas5p326df3257e93d1f5454b8c6b6c642e61c@epcas5p3.samsung.com>
 <20230906163844.18754-9-nj.shetty@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230906163844.18754-9-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/6/23 18:38, Nitesh Shetty wrote:
> Add support for handling nvme_cmd_copy command on target.
> 
> For bdev-ns if backing device supports copy offload we call device copy
> offload (blkdev_copy_offload).
> In case of partial completion from above or absence of device copy offload
> capability, we fallback to copy emulation (blkdev_copy_emulation)
> 
> For file-ns we call vfs_copy_file_range to service our request.
> 
> Currently target always shows copy capability by setting
> NVME_CTRL_ONCS_COPY in controller ONCS.
> 
> loop target has copy support, which can be used to test copy offload.
> trace event support for nvme_cmd_copy.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>   drivers/nvme/target/admin-cmd.c   |  9 ++-
>   drivers/nvme/target/io-cmd-bdev.c | 97 +++++++++++++++++++++++++++++++
>   drivers/nvme/target/io-cmd-file.c | 50 ++++++++++++++++
>   drivers/nvme/target/nvmet.h       |  4 ++
>   drivers/nvme/target/trace.c       | 19 ++++++
>   5 files changed, 177 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

