Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A9B51B9C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 10:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346670AbiEEIQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 04:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346607AbiEEIQ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 04:16:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C5434650;
        Thu,  5 May 2022 01:12:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EAA6D210DF;
        Thu,  5 May 2022 08:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651738366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGfkHmL6KmlVj6pZAi3STwQ0RmidrXyDtqZLzLzqijk=;
        b=ZS0oR4l0/0MSqoHoCdZLpwKADTs9WVrqS/3GEPNiv1MRcBuQeHlHe62Yhh32ZjGNm0r3lc
        FaaLobX0GHYzDf5UJqCsvNi+eMHJEcTJ0rZnFr1rN8kUvUqTPJLyTY5PSqnrdTUHCXhoIX
        pazJKdndbuyHhxmKFnTXl7fIqjBlj74=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F43213A65;
        Thu,  5 May 2022 08:12:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BfxnHP6Gc2LbBQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 05 May 2022 08:12:46 +0000
Message-ID: <c0335baa-3df5-5523-3537-6c419ace9f82@suse.com>
Date:   Thu, 5 May 2022 11:12:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 5/5] btrfs: allocate the btrfs_dio_private as part of the
 iomap dio bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220504162342.573651-1-hch@lst.de>
 <20220504162342.573651-6-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220504162342.573651-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4.05.22 г. 19:23 ч., Christoph Hellwig wrote:
> Create a new bio_set that contains all the per-bio private data needed
> by btrfs for direct I/O and tell the iomap code to use that instead
> of separately allocation the btrfs_dio_private structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/btrfs_inode.h |  25 ----------
>   fs/btrfs/ctree.h       |   1 -
>   fs/btrfs/inode.c       | 108 ++++++++++++++++++++---------------------
>   3 files changed, 53 insertions(+), 81 deletions(-)
> 
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 32131a5d321b3..33811e896623f 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -395,31 +395,6 @@ static inline bool btrfs_inode_can_compress(const struct btrfs_inode *inode)
>   	return true;
>   }
>   
> -struct btrfs_dio_private {
> -	struct inode *inode;
> -
> -	/*
> -	 * Since DIO can use anonymous page, we cannot use page_offset() to
> -	 * grab the file offset, thus need a dedicated member for file offset.
> -	 */
> -	u64 file_offset;
> -	u64 disk_bytenr;

nit: You are actually removing this member when copying the struct, 
that's an independent change (albeit I'd say insignificant). Generally 
we prefer such changes to be in separate patches with rationale when the 
given member became redundant.

<snip>
