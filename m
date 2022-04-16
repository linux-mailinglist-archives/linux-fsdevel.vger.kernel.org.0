Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72F55032D2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Apr 2022 07:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiDPCbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 22:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiDPCbd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:31:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FA134BB6;
        Fri, 15 Apr 2022 19:29:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9062F61F03;
        Sat, 16 Apr 2022 02:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BEAC385A9;
        Sat, 16 Apr 2022 02:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650076142;
        bh=64fC476XAzTfqTSPn+hnDLb+pMKn+pGg/cu9T2ZYoeo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YR2swQd5bHjAFWTiUHuzi2CBAoBviVOC618ZH6KrZjKGz54+nb14CQuuZA/rg7rT4
         HOUGUM1/um4+uLyDQbz+2PZe7eFGngBlsNfmtF55BEnpI8SeGgAW1TB9RPEF0hZ/gu
         wadS+mRuD6cvw4fVgc6pYN09yVoj6blhm7pLMwx6SJQPqerB95uO3eDsfGVZkI1tAT
         ypjbfbxn7+bT/FWjnusepnTR0gEoGRsC/NgAvlwAmFKhGsjLJGRbec9W3gsrNwS1xO
         /N5W0GD6Xr6BMAFslHSxbnYfv+w/HrqJWAmw3dvOKrGV8WDuaNAVrqQjvW1ASku3np
         CHDdJgFxl65YQ==
Message-ID: <ffa14a07-b8f9-828e-97bc-cf7a2099bab5@kernel.org>
Date:   Sat, 16 Apr 2022 10:28:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [f2fs-dev] [PATCH 26/27] block: decouple REQ_OP_SECURE_ERASE from
 REQ_OP_DISCARD
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     jfs-discussion@lists.sourceforge.net,
        linux-nvme@lists.infradead.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        dm-devel@redhat.com, target-devel@vger.kernel.org,
        linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com,
        linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, cluster-devel@redhat.com,
        xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org,
        linux-um@lists.infradead.org, nbd@other.debian.org,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
        Coly Li <colyli@suse.de>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-raid@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-mmc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org,
        =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev,
        linux-btrfs@vger.kernel.org
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-27-hch@lst.de>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220415045258.199825-27-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/4/15 12:52, Christoph Hellwig wrote:
> Secure erase is a very different operation from discard in that it is
> a data integrity operation vs hint.  Fully split the limits and helper
> infrastructure to make the separation more clear.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com> [drbd]
> Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com> [nifs2]
> Acked-by: Jaegeuk Kim <jaegeuk@kernel.org> [f2fs]
> Acked-by: Coly Li <colyli@suse.de> [bcache]
> Acked-by: David Sterba <dsterba@suse.com> [btrfs]

For f2fs part,

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
