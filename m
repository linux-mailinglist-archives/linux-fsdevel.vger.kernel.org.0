Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEDD79F05B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 19:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjIMRYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 13:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjIMRYa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:24:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F090E9E;
        Wed, 13 Sep 2023 10:24:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B43A7218E2;
        Wed, 13 Sep 2023 17:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694625864;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZgWv7ujgw/gSFj4LjGadP28FYlTRSCmp56N+ZxFtiiE=;
        b=pbd33CYZXPoFtYtKEhxQe0pwyuDmj4DW/DCgiOCYg3psGfcQfXehYekiBU3EshSEdpsAKG
        /eHs161GLcPgGRJlyWCZi27LNnvLoYmtssGpDcnyVhTcXCf5iTrEWp4UBTH/7OJh7FXWi4
        vg+GB3YmY7pY3s+cBiv9XGHJFzVskd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694625864;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZgWv7ujgw/gSFj4LjGadP28FYlTRSCmp56N+ZxFtiiE=;
        b=F7SH0ZHbY2rQ1EyOLrAEToND58/z9UTuCnzFpQ/fnC/6SlENjq1RIpUKWdaZhfux/Bh7nj
        3zKnT41arp7HTUCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 551FD13440;
        Wed, 13 Sep 2023 17:24:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8jeUE0jwAWXaOAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Sep 2023 17:24:24 +0000
Date:   Wed, 13 Sep 2023 19:24:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
Subject: Re: [PATCH V3 2/2] btrfs: Introduce the single-dev feature
Message-ID: <20230913172422.GW20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-3-gpiccoli@igalia.com>
 <20230911182804.GA20408@twin.jikos.cz>
 <b25f8b8b-8408-e563-e813-18ec58d3b5ca@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b25f8b8b-8408-e563-e813-18ec58d3b5ca@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 12, 2023 at 05:20:42PM +0800, Anand Jain wrote:
> 
> 
> On 12/09/2023 02:28, David Sterba wrote:
> > On Wed, Aug 30, 2023 at 09:12:34PM -0300, Guilherme G. Piccoli wrote:
> >> Btrfs doesn't currently support to mount 2 different devices holding the
> >> same filesystem - the fsid is exposed as a unique identifier by the
> >> driver. This case is supported though in some other common filesystems,
> >> like ext4.
> >>
> >> Supporting the same-fsid mounts has the advantage of allowing btrfs to
> >> be used in A/B partitioned devices, like mobile phones or the Steam Deck
> >> for example. Without this support, it's not safe for users to keep the
> >> same "image version" in both A and B partitions, a setup that is quite
> >> common for development, for example. Also, as a big bonus, it allows fs
> >> integrity check based on block devices for RO devices (whereas currently
> >> it is required that both have different fsid, breaking the block device
> >> hash comparison).
> >>
> >> Such same-fsid mounting is hereby added through the usage of the
> >> filesystem feature "single-dev" - when such feature is used, btrfs
> >> generates a random fsid for the filesystem and leverages the long-term
> >> present metadata_uuid infrastructure to enable the usage of this
> >> secondary virtual fsid, effectively requiring few non-invasive changes
> >> to the code and no new potential corner cases.
> >>
> >> In order to prevent more code complexity and corner cases, given
> >> the nature of this mechanism (single devices), the single-dev feature
> >> is not allowed when the metadata_uuid flag is already present on the
> >> fs, or if the device is on fsid-change state. Device removal/replace
> >> is also disabled for devices presenting the single-dev feature.
> >>
> >> Suggested-by: John Schoenick <johns@valvesoftware.com>
> >> Suggested-by: Qu Wenruo <wqu@suse.com>
> >> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> > 
> > I've added Anand's patch
> > https://lore.kernel.org/linux-btrfs/de8d71b1b08f2c6ce75e3c45ee801659ecd4dc43.1694164368.git.anand.jain@oracle.com/
> > to misc-next that implements subset of your patch, namely extending
> > btrfs_scan_one_device() with the 'mounting' parameter. I haven't looked
> > if the semantics is the same so I let you take a look.
> > 
> > As there were more comments to V3, please fix that and resend. Thanks.
> 
> Guliherme,
> 
>    Please also add the newly sent patch to the latest misc-next branch:
>      [PATCH] btrfs: scan forget for no instance of dev
> 
>    The test case btrfs/254 fails without it.

The mention patch has been folded to the scanning/register patch so you
may now use misc-next as a base.
