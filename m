Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813A07A5548
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 23:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjIRV7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 17:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRV7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:59:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382C083;
        Mon, 18 Sep 2023 14:59:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E6FBE2227E;
        Mon, 18 Sep 2023 21:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695074366;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kafxTI+BSZmY2bgOabB7wFu0DWToQS6M+EsMUgAF/VQ=;
        b=j1L3//wjPPjHUQ8+5lFTVJzFVBsjcwdVWkdT3A7QI/CbvYBZzdMptQRA0ByH6bjHB8cnOH
        9Dtocrb+7gY5hc2NBxFgy3sP4qSOMfVWyoq2gkaEukx3D12x2J2YoT1tv7uHhuNsjoNeRw
        KdVCcKncQsxXpxoV0QmvqUtHui5qEOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695074366;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kafxTI+BSZmY2bgOabB7wFu0DWToQS6M+EsMUgAF/VQ=;
        b=MKntjdUGkc4F9wRrqoyOLCdFLP5y0cX8BsybJUSzXP/8UsdeitvsSzgyupSJ1iepfs6Bk6
        g4lUsuSzal7TgpDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82E411358A;
        Mon, 18 Sep 2023 21:59:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vKafHj7ICGV6CAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Sep 2023 21:59:26 +0000
Date:   Mon, 18 Sep 2023 23:52:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, dsterba@suse.cz, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, anand.jain@oracle.com,
        david@fromorbit.com, kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
Subject: Re: [PATCH v4 2/2] btrfs: Introduce the temp-fsid feature
Message-ID: <20230918215250.GQ2747@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230913224402.3940543-1-gpiccoli@igalia.com>
 <20230913224402.3940543-3-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913224402.3940543-3-gpiccoli@igalia.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 07:36:16PM -0300, Guilherme G. Piccoli wrote:
> Btrfs doesn't currently support to mount 2 different devices holding the
> same filesystem - the fsid is exposed as a unique identifier by the
> driver. This case is supported though in some other common filesystems,
> like ext4.
> 
> Supporting the same-fsid mounts has the advantage of allowing btrfs to
> be used in A/B partitioned devices, like mobile phones or the Steam Deck
> for example. Without this support, it's not safe for users to keep the
> same "image version" in both A and B partitions, a setup that is quite
> common for development, for example. Also, as a big bonus, it allows fs
> integrity check based on block devices for RO devices (whereas currently
> it is required that both have different fsid, breaking the block device
> hash comparison).
> 
> Such same-fsid mounting is hereby added through the usage of the
> filesystem feature "temp-fsid" - when such feature is used, btrfs
> generates a random fsid for the filesystem and leverages the long-term
> present metadata_uuid infrastructure to enable the usage of this
> secondary "virtual" fsid, effectively requiring few non-invasive
> changes to the code and no new potential corner cases.
> 
> In order to prevent more code complexity and corner cases, the
> temp-fsid feature is not allowed when the metadata_uuid flag is
> present on the fs, or if the device is on fsid-change state. Device
> removal/replace is also disabled for filesystems presenting the feature.
> 
> Cc: Anand Jain <anand.jain@oracle.com>
> Suggested-by: John Schoenick <johns@valvesoftware.com>
> Suggested-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> V4:
> 
> - Rebased against the github misc-next branch (of 2023-09-13); notice
> it already includes the patch: ("btrfs: scan forget for no instance of dev"),
> that was folded into the original commit;
> 
> - Patch ("btrfs: scan but don't register device on single device filesystem")
> was took into account - now we don't need to mess with the function
> btrfs_scan_one_device() here, since it already has the "mounting" argument;
> 
> - Improved the description of the fsid/metadata_uuid relation in volumes.h
> comment (thanks Anand!);
> 
> - Dropped the '\n' in the btrfs_{err/info} prints (also thanks Anand!);
> 
> - Switched the feature name for temp-fsid - seems the "less disliked"
> name, though personally I'd prefer virtual-fsid; also, that could be
> easily changed according the maintainers agreement.

Let's stick to temp-fsid for now, I like that it says the fsid is
temporary, virtual could be potentially stored permanently (like another
metadata_uuid).

I've added the patch to for-next, with some fixups, mostly stylistic.
I'll add the btrfs-progs part soon so we have the support for testing.
The feature seems to be complete regarding the original idea, if you
have any updates please send them separate patches or replies to this
thread. Thanks.
