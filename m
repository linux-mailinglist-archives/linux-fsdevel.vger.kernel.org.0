Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5775C51C457
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 17:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381490AbiEEQAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 12:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242926AbiEEQAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 12:00:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F7B515A3;
        Thu,  5 May 2022 08:56:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C462F1F8BD;
        Thu,  5 May 2022 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651766200;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cL+4NgDwH9ZmYz4p41+cMuu6+x1SjxMmlCJ6V8UIMec=;
        b=AowiNG7z5jnDZjKwF1Ez98ZpgbgQ4hz74454qGvevFWR5E7a9vjHV6JR4rqMMOkwTUZkRM
        nMXID/7zK/J6aHh0RHlDIqUNNME3DGtgvLs6GtxpqE47+tDdkkBQp7b4uhtajaygAThXFH
        Q0vjHac8lsxWnoWqA+GcecJlO/BNQnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651766200;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cL+4NgDwH9ZmYz4p41+cMuu6+x1SjxMmlCJ6V8UIMec=;
        b=1lG+dZmoFrvxISC2fPKlp7czn5aLqFCcJpV6s1vOa5gNdOU+c/9j3WCQBYwBh3EhX1Vsn6
        H2ozrAD3gIKjbyCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EF3A13B11;
        Thu,  5 May 2022 15:56:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wcv2Ibjzc2KlWwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 05 May 2022 15:56:40 +0000
Date:   Thu, 5 May 2022 17:52:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: allocate the btrfs_dio_private as part of the
 iomap dio bio
Message-ID: <20220505155228.GX18596@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220504162342.573651-1-hch@lst.de>
 <20220504162342.573651-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504162342.573651-6-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 04, 2022 at 09:23:42AM -0700, Christoph Hellwig wrote:
> -	if (!write) {
> +	if (!write && !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
>  		/*
>  		 * Load the csums up front to reduce csum tree searches and
>  		 * contention when submitting bios.
> -		 *
> -		 * If we have csums disabled this will do nothing.
>  		 */
> +		status = BLK_STS_RESOURCE;
> +		dip->csums = kzalloc(fs_info->csum_size *
> +			(dio_bio->bi_iter.bi_size >> fs_info->sectorsize_bits),
> +			GFP_NOFS);

This should be either kmalloc_array or kcalloc, otherwise OK.
