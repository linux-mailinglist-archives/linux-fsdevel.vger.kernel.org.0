Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558C979B3F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbjIKUx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243979AbjIKSep (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:34:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10A3198;
        Mon, 11 Sep 2023 11:34:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7A3F61F8B3;
        Mon, 11 Sep 2023 18:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694457279;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9v3Jt/6g+t5nFOrTmf56koBNQUy/6/9gfu4eoY4EblY=;
        b=17yeN5BsMO++pJEtuT6paNE2uy6dg81sskoexYs59omHu047w4aMp8g4POm4l3J5dvxpm/
        nyO/xckMio3c45i/JMh/8Nysjfkhf0rZvMcnpN6Dd5d67yYy2HD+ZEO3Q2j5GTa2Aj4jlm
        oD7hBKQLznYm8TT6wVevYe1pOkJu/2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694457279;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9v3Jt/6g+t5nFOrTmf56koBNQUy/6/9gfu4eoY4EblY=;
        b=TW+ygxcqojzxZNzgiqAZ/EaepEdivo9iuXvsShUUguvCDYYRJ4Y4LFO5/Z+k7NBIiLss/q
        k/0eAxrcqNBNZZCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3108913780;
        Mon, 11 Sep 2023 18:34:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C6AsC79d/2RiQwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 11 Sep 2023 18:34:39 +0000
Date:   Mon, 11 Sep 2023 20:28:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, anand.jain@oracle.com,
        david@fromorbit.com, kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
Subject: Re: [PATCH V3 2/2] btrfs: Introduce the single-dev feature
Message-ID: <20230911182804.GA20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-3-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831001544.3379273-3-gpiccoli@igalia.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 30, 2023 at 09:12:34PM -0300, Guilherme G. Piccoli wrote:
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
> filesystem feature "single-dev" - when such feature is used, btrfs
> generates a random fsid for the filesystem and leverages the long-term
> present metadata_uuid infrastructure to enable the usage of this
> secondary virtual fsid, effectively requiring few non-invasive changes
> to the code and no new potential corner cases.
> 
> In order to prevent more code complexity and corner cases, given
> the nature of this mechanism (single devices), the single-dev feature
> is not allowed when the metadata_uuid flag is already present on the
> fs, or if the device is on fsid-change state. Device removal/replace
> is also disabled for devices presenting the single-dev feature.
> 
> Suggested-by: John Schoenick <johns@valvesoftware.com>
> Suggested-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

I've added Anand's patch
https://lore.kernel.org/linux-btrfs/de8d71b1b08f2c6ce75e3c45ee801659ecd4dc43.1694164368.git.anand.jain@oracle.com/
to misc-next that implements subset of your patch, namely extending
btrfs_scan_one_device() with the 'mounting' parameter. I haven't looked
if the semantics is the same so I let you take a look.

As there were more comments to V3, please fix that and resend. Thanks.
