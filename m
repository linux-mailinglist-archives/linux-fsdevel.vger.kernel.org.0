Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3FC75B38B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 17:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjGTPyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 11:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbjGTPyF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:54:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902F710D2;
        Thu, 20 Jul 2023 08:53:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 50DCD1F8AC;
        Thu, 20 Jul 2023 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689868434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AoIWfvcodiImdazBtF4GP+aiM7iZUlDUJHwoVwx2l0M=;
        b=f+NQtXBWukxnOBTDhSu4fMxYZbJGWo2G92hXZqJKiip03vBFzW0tsuUtbAzkcra1ua0QrZ
        ekgFv0gWb9JwZj2Ylfejs2aisDz77JLB5BtnaSwE0dXtRZBCTrRTWXVTYws5hZ18jkb5/t
        Jus7bV+kZA5bV/x2bylo/OHVpL8yltg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689868434;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AoIWfvcodiImdazBtF4GP+aiM7iZUlDUJHwoVwx2l0M=;
        b=/7gRpa2GQeDZgmtYTQRDFpsjs2y7Q3HMtLsVINALgujmycG22P+Fzu+ByJ1hn5i0xlMlB/
        FZy8w6o8SwtSYADQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63352133DD;
        Thu, 20 Jul 2023 15:53:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iOCeFpFYuWRkJQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 20 Jul 2023 15:53:53 +0000
Message-ID: <80507f03-86b4-6406-5ab1-5687b6d12d93@suse.de>
Date:   Thu, 20 Jul 2023 17:53:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6/6] fs: add CONFIG_BUFFER_HEAD
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230720140452.63817-1-hch@lst.de>
 <20230720140452.63817-7-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230720140452.63817-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/20/23 16:04, Christoph Hellwig wrote:
> Add a new config option that controls building the buffer_head code, and
> select it from all file systems and stacking drivers that need it.
> 
> For the block device nodes and alternative iomap based buffered I/O path
> is provided when buffer_head support is not enabled, and iomap needs a
> little tweak to be able to compile out the buffer_head based code path.
> 
> Otherwise this is just Kconfig and ifdef changes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/fops.c                 | 71 +++++++++++++++++++++++++++++++-----
>   drivers/md/Kconfig           |  1 +
>   fs/Kconfig                   |  4 ++
>   fs/Makefile                  |  2 +-
>   fs/adfs/Kconfig              |  1 +
>   fs/affs/Kconfig              |  1 +
>   fs/befs/Kconfig              |  1 +
>   fs/bfs/Kconfig               |  1 +
>   fs/efs/Kconfig               |  1 +
>   fs/exfat/Kconfig             |  1 +
>   fs/ext2/Kconfig              |  1 +
>   fs/ext4/Kconfig              |  1 +
>   fs/f2fs/Kconfig              |  1 +
>   fs/fat/Kconfig               |  1 +
>   fs/freevxfs/Kconfig          |  1 +
>   fs/gfs2/Kconfig              |  1 +
>   fs/hfs/Kconfig               |  1 +
>   fs/hfsplus/Kconfig           |  1 +
>   fs/hpfs/Kconfig              |  1 +
>   fs/iomap/buffered-io.c       | 12 ++++--
>   fs/isofs/Kconfig             |  1 +
>   fs/jfs/Kconfig               |  1 +
>   fs/minix/Kconfig             |  1 +
>   fs/nilfs2/Kconfig            |  1 +
>   fs/ntfs/Kconfig              |  1 +
>   fs/ntfs3/Kconfig             |  1 +
>   fs/ocfs2/Kconfig             |  1 +
>   fs/omfs/Kconfig              |  1 +
>   fs/qnx4/Kconfig              |  1 +
>   fs/qnx6/Kconfig              |  1 +
>   fs/reiserfs/Kconfig          |  1 +
>   fs/sysv/Kconfig              |  1 +
>   fs/udf/Kconfig               |  1 +
>   fs/ufs/Kconfig               |  1 +
>   include/linux/buffer_head.h  | 32 ++++++++--------
>   include/trace/events/block.h |  2 +
>   mm/migrate.c                 |  4 +-
>   37 files changed, 125 insertions(+), 32 deletions(-)
> 
Hmm.

I actually have a patchset which _does_ allow for large I/O blocksizes 
with buffer_heads. (And even ltp/fsx is happy on xfs...)

Can we modify this to not have a compile-time option but rather a 
setting somewhere? EG kernel option or flag in struct address_space?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

