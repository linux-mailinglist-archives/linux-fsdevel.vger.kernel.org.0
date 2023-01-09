Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846BF662935
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 16:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjAIPCd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 10:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjAIPC3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:02:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A40D17E22
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 07:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673276508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5BnqkcP/B7SGlD7ivTZ2uRzTlawgLKPgKJY+C2gEHLI=;
        b=CqJBcKMyt9OifljU/s+bd92+WgKHcGH5vn31p7JOTRGnBltT0ArRodpmtLWprkFx/7bpNR
        Llm2MOMmbTTJyebHNjUw5ofDhOolPolV3XJHk7ZdTWE+bciaOBo6iMx6EzK0+1CV9/XYa9
        zfJGGxjfXgvVWvXAcZmEzKSn3wi8Et8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-22-S-RSuztqObCiHxob0Q9vQw-1; Mon, 09 Jan 2023 10:01:47 -0500
X-MC-Unique: S-RSuztqObCiHxob0Q9vQw-1
Received: by mail-qt1-f198.google.com with SMTP id fp22-20020a05622a509600b003ab920c4c89so3968824qtb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jan 2023 07:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BnqkcP/B7SGlD7ivTZ2uRzTlawgLKPgKJY+C2gEHLI=;
        b=A2FS/eJn8gWN2PNVXgnx0EwEpX9ukpF8/QBHh5/hTkMifIdFuf2MqkXrEVhTADCg7d
         8qOCuxRefKPHaUlZlXJSoI7DhDbZneyOWJtRIC0myjtoSsWe/QcoOUeh76qpjM1tBWgk
         66zvjadfG5mWCT6V9NfPkYIsFl2Jm74dLxQaMZ/z747A/xnsrk8mHKEJv5KYNVBuWb+S
         7iVBumH3TntSEkD+ciR3MeqB42vPYZF9VYK3lW1rdx/XdzQ2fXM9uMQdYtqJsE0lmUC6
         3GPOKiWCHGh7HBKurYbIeGZLHjZbleUuZ+gHj9VRpuSepWIhWgLSeII3f1/VSPsMjvzE
         SymQ==
X-Gm-Message-State: AFqh2kob1ZPkU/vhQ/Rg1mFkUMwFjtQqcXj0zCuFVke2hRNRifxv9dLF
        m8fAAMhxDtlFGp2egKG+ztC5zbj+AETxRQhckUotQeuRWcimzY35B9eFCmJmlQDZOFBRMUfa5Ua
        J680yJ1+C1577b826WtuLyk0FIw==
X-Received: by 2002:ac8:6b4c:0:b0:39c:da20:d47c with SMTP id x12-20020ac86b4c000000b0039cda20d47cmr84648930qts.17.1673276506394;
        Mon, 09 Jan 2023 07:01:46 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvzZP+QWbMTML85dKaCimKI1eGsnIuLcS2Bp/8ib3jUiLno1dRkiK90vxVouiizF3DOW2wqRA==
X-Received: by 2002:ac8:6b4c:0:b0:39c:da20:d47c with SMTP id x12-20020ac86b4c000000b0039cda20d47cmr84648900qts.17.1673276506083;
        Mon, 09 Jan 2023 07:01:46 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id bi1-20020a05620a318100b006fb0e638f12sm5457812qkb.4.2023.01.09.07.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 07:01:45 -0800 (PST)
Date:   Mon, 9 Jan 2023 10:02:46 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 6/7] ext4: Add mount option for provisioning blocks
 during allocations
Message-ID: <Y7wsluqX+eFqV1XB@bfoster>
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
 <20221229081252.452240-7-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229081252.452240-7-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 29, 2022 at 12:12:51AM -0800, Sarthak Kukreti wrote:
> Add a mount option that sets the default provisioning mode for
> all files within the filesystem.
> 

There's not much description here to explain what a user should expect
from this mode. Should the user expect -ENOSPC from the lower layers
once out of space? What about files that are provisioned by the fs and
then freed? Should the user/admin know to run fstrim or also enable an
online discard mechanism to ensure freed filesystem blocks are returned
to the free pool in the block/dm layer in order to avoid premature fs
-ENOSPC conditions?

Also, what about dealing with block level snapshots? There is some
discussion on previous patches wrt to expectations on how provision
might handle unsharing of cow'd blocks. If the fs only provisions on
initial allocation, then a subsequent snapshot means we run into the
same sort of ENOSPC problem on overwrites of already allocated blocks.
That also doesn't consider things like an internal log, which may have
been physically allocated (provisioned?) at mkfs time and yet is subject
to the same general problem.

So what is the higher level goal with this sort of mode? Is
provision-on-alloc sufficient to provide a practical benefit to users,
or should this perhaps consider other scenarios where a provision might
be warranted before submitting writes to a thinly provisioned device?

FWIW, it seems reasonable to me to introduce this without snapshot
support and work toward it later, but it should be made clear what is
being advertised in the meantime. Unless there's some nice way to
explicitly limit the scope of use, such as preventing snapshots or
something, the fs might want to consider this sort of feature
experimental until it is more fully functional.

Brian

> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  fs/ext4/ext4.h    | 1 +
>  fs/ext4/extents.c | 7 +++++++
>  fs/ext4/super.c   | 7 +++++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 49832e90b62f..29cab2e2ea20 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1269,6 +1269,7 @@ struct ext4_inode_info {
>  #define EXT4_MOUNT2_MB_OPTIMIZE_SCAN	0x00000080 /* Optimize group
>  						    * scanning in mballoc
>  						    */
> +#define EXT4_MOUNT2_PROVISION		0x00000100 /* Provision while allocating file blocks */
>  
>  #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
>  						~EXT4_MOUNT_##opt
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 2e64a9211792..a73f44264fe2 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4441,6 +4441,13 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
>  	unsigned int credits;
>  	loff_t epos;
>  
> +	/*
> +	 * Attempt to provision file blocks if the mount is mounted with
> +	 * provision.
> +	 */
> +	if (test_opt2(inode->i_sb, PROVISION))
> +		flags |= EXT4_GET_BLOCKS_PROVISION;
> +
>  	BUG_ON(!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS));
>  	map.m_lblk = offset;
>  	map.m_len = len;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 260c1b3e3ef2..5bc376f6a6f0 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1591,6 +1591,7 @@ enum {
>  	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
>  	Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan,
>  	Opt_errors, Opt_data, Opt_data_err, Opt_jqfmt, Opt_dax_type,
> +	Opt_provision, Opt_noprovision,
>  #ifdef CONFIG_EXT4_DEBUG
>  	Opt_fc_debug_max_replay, Opt_fc_debug_force
>  #endif
> @@ -1737,6 +1738,8 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
>  	fsparam_flag	("reservation",		Opt_removed),	/* mount option from ext2/3 */
>  	fsparam_flag	("noreservation",	Opt_removed),	/* mount option from ext2/3 */
>  	fsparam_u32	("journal",		Opt_removed),	/* mount option from ext2/3 */
> +	fsparam_flag	("provision",		Opt_provision),
> +	fsparam_flag	("noprovision",		Opt_noprovision),
>  	{}
>  };
>  
> @@ -1826,6 +1829,8 @@ static const struct mount_opts {
>  	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
>  	{Opt_no_prefetch_block_bitmaps, EXT4_MOUNT_NO_PREFETCH_BLOCK_BITMAPS,
>  	 MOPT_SET},
> +	{Opt_provision, EXT4_MOUNT2_PROVISION, MOPT_SET | MOPT_2},
> +	{Opt_noprovision, EXT4_MOUNT2_PROVISION, MOPT_CLEAR | MOPT_2},
>  #ifdef CONFIG_EXT4_DEBUG
>  	{Opt_fc_debug_force, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
>  	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
> @@ -2977,6 +2982,8 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
>  		SEQ_OPTS_PUTS("dax=never");
>  	} else if (test_opt2(sb, DAX_INODE)) {
>  		SEQ_OPTS_PUTS("dax=inode");
> +	} else if (test_opt2(sb, PROVISION)) {
> +		SEQ_OPTS_PUTS("provision");
>  	}
>  
>  	if (sbi->s_groups_count >= MB_DEFAULT_LINEAR_SCAN_THRESHOLD &&
> -- 
> 2.37.3
> 

