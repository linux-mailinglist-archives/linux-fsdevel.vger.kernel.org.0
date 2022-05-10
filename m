Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450CA520F39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 09:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiEJIAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 04:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbiEJIAg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 04:00:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8A11E250C;
        Tue, 10 May 2022 00:56:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E8EF21ACC;
        Tue, 10 May 2022 07:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652169396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikXWKPX8o/GouZvJ9LZIaWDEDBv8HrzgGRMfitoYhn0=;
        b=pX9etHdQYf6mCTXowBEDw+EnB3HcyZvG6ZnhjcKQvpA72vPEdCXNdrJZ2Y8Asw/+HuMqi7
        pue33o0zxyIN1M4zKXKO9R6576UZr/0UM/7n1FBacp1HCc21QnoKPHCJM5vPB8U11pWl51
        /7xHguKCZCw15PcViG5VyZfUKwtWHOM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A9BE13AC1;
        Tue, 10 May 2022 07:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WiRzO7MaemImBQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 10 May 2022 07:56:35 +0000
Message-ID: <3b294abc-1cec-278a-1d74-3eef938c683f@suse.com>
Date:   Tue, 10 May 2022 10:56:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: reduce memory allocation in the btrfs direct I/O path v2
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220505201115.937837-1-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220505201115.937837-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5.05.22 г. 23:11 ч., Christoph Hellwig wrote:
> Hi all,
> 
> this series adds two minor improvements to iomap that allow btrfs
> to avoid a memory allocation per read/write system call and another
> one per submitted bio.  I also have at last two other pending uses
> for the iomap functionality later on, so they are not really btrfs
> specific either.
> 
> Changes since v1:
>   - pass the private data direct to iomap_dio_rw instead of through the
>     iocb
>   - better document the bio_set in iomap_dio_ops
>   - split a patch into three
>   - use kcalloc to allocate the checksums
> 
> Diffstat:
>   fs/btrfs/btrfs_inode.h |   25 --------
>   fs/btrfs/ctree.h       |    6 -
>   fs/btrfs/file.c        |    6 -
>   fs/btrfs/inode.c       |  152 +++++++++++++++++++++++--------------------------
>   fs/erofs/data.c        |    2
>   fs/ext4/file.c         |    4 -
>   fs/f2fs/file.c         |    4 -
>   fs/gfs2/file.c         |    4 -
>   fs/iomap/direct-io.c   |   26 ++++++--
>   fs/xfs/xfs_file.c      |    6 -
>   fs/zonefs/super.c      |    4 -
>   include/linux/iomap.h  |   16 ++++-
>   12 files changed, 123 insertions(+), 132 deletions(-)
> 


Reviewed-by: Nikolay Borisov <nborisov@suse.com>
