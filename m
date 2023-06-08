Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8A4727CA8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 12:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbjFHKWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 06:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjFHKWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:22:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCB3E2;
        Thu,  8 Jun 2023 03:22:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 79F181FDE9;
        Thu,  8 Jun 2023 10:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686219732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ayRJTvrnmOfJwDrSeWFMGSYC6CQeMiIa/RwpAE213X8=;
        b=CZ/kBlQRdUsNuLKR6xrT3ogbLODNzef0icCizic2BE71TjRGqwyw3I/uep2qNnyotF3Z2N
        ZG83jZWcct1Drm+nzZ86GBoFRcKSODX3hzwdFUIEWjr3JeqPhbI0NCVgPUhLKrsVM7+YzZ
        7U0BYK5OqY/2ElizoD8LTGOJ1O4vdbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686219732;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ayRJTvrnmOfJwDrSeWFMGSYC6CQeMiIa/RwpAE213X8=;
        b=HjC/Se3o9kNNB/CGAXgmZz1CIvIRtF9/JP6ONlLZeHtr+ACKHaUEEEqT3Suz9ADNaMsOD2
        3w00FxTLpGBBRyCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65E7F138E6;
        Thu,  8 Jun 2023 10:22:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jPDTGNSrgWQOCAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Jun 2023 10:22:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F0D82A0749; Thu,  8 Jun 2023 12:22:11 +0200 (CEST)
Date:   Thu, 8 Jun 2023 12:22:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hch@infradead.org, djwong@kernel.org, dchinner@redhat.com,
        kbusch@kernel.org, willy@infradead.org, hare@suse.de,
        ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        patches@lists.linux.dev, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, corbet@lwn.net, jake@lwn.net
Subject: Re: [RFC 1/4] bdev: replace export of blockdev_superblock with
 BDEVFS_MAGIC
Message-ID: <20230608102211.wg5kptxmt4ixygfd@quack3>
References: <20230608032404.1887046-1-mcgrof@kernel.org>
 <20230608032404.1887046-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608032404.1887046-2-mcgrof@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 07-06-23 20:24:01, Luis Chamberlain wrote:
> There is no need to export blockdev_superblock because we can just
> use the magic value of the block device cache super block, which is
> already in place, BDEVFS_MAGIC. So just check for that.
> 
> This let's us remove the export of blockdev_superblock and also
> let's this block dev cache scale as it wishes internally. For
> instance in the future we may have different super block for each
> block device. Right now it is all shared on one super block.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  block/bdev.c       | 1 -
>  include/linux/fs.h | 4 ++--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 21c63bfef323..91477c3849d2 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -379,7 +379,6 @@ static struct file_system_type bd_type = {
>  };
>  
>  struct super_block *blockdev_superblock __read_mostly;
> -EXPORT_SYMBOL_GPL(blockdev_superblock);

You can even make blockdev_superblock static. I like this! Otherwise the
patch looks good.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
