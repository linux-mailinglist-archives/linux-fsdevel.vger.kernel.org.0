Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB706D0ED6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 21:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjC3TbW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 15:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjC3TbU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:31:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA24213C;
        Thu, 30 Mar 2023 12:31:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 96F501FE07;
        Thu, 30 Mar 2023 19:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680204678;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Etjp+xE3FIW3A1xPIHa1sQtyQ4/Nn9crT5hD184o2SA=;
        b=aHv++cdpXPaXb26/G1LMYwclQgZ4Qx/cyWFa0fjo70P5nNjzjoHIeWQSajl20M1XZZkoz2
        ZwgPzABCzOE8C4i0glI8NLuVt6p2eWDvwk3FK3zK7SXAeXYSpz3JpQIfG2AbcvOChVT7+9
        1qTNvdPzYgEM+d96UTjl0NgotnSkQr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680204678;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Etjp+xE3FIW3A1xPIHa1sQtyQ4/Nn9crT5hD184o2SA=;
        b=wYPbuyHqUYLobbGSEtgz4W8ycI8q3CtaKnbPUQGE+5MzS+bueBw/fljFzrPU/2rA5fyNzR
        A2+wNxH4qiVKtHBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 200FE133E0;
        Thu, 30 Mar 2023 19:31:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 77P7BobjJWQBRQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 30 Mar 2023 19:31:18 +0000
Date:   Thu, 30 Mar 2023 21:25:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Song Liu <song@kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 00/19] bio: check return values of bio_add_page
Message-ID: <20230330192503.GT10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1680172791.git.johannes.thumshirn@wdc.com>
 <20230330154529.GS10580@twin.jikos.cz>
 <9835fc72-18b4-517d-0861-b5b413252eb9@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9835fc72-18b4-517d-0861-b5b413252eb9@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 04:41:58PM +0000, Johannes Thumshirn wrote:
> On 30.03.23 17:52, David Sterba wrote:
> > On Thu, Mar 30, 2023 at 03:43:42AM -0700, Johannes Thumshirn wrote:
> >> We have two functions for adding a page to a bio, __bio_add_page() which is
> >> used to add a single page to a freshly created bio and bio_add_page() which is
> >> used to add a page to an existing bio.
> >>
> >> While __bio_add_page() is expected to succeed, bio_add_page() can fail.
> >>
> >> This series converts the callers of bio_add_page() which can easily use
> >> __bio_add_page() to using it and checks the return of bio_add_page() for
> >> callers that don't work on a freshly created bio.
> >>
> >> Lastly it marks bio_add_page() as __must_check so we don't have to go again
> >> and audit all callers.
> >>
> >> Changes to v1:
> >> - Removed pointless comment pointed out by Willy
> >> - Changed commit messages pointed out by Damien
> >> - Colledted Damien's Reviews and Acks
> >>
> >> Johannes Thumshirn (19):
> > 
> >>   btrfs: repair: use __bio_add_page for adding single page
> >>   btrfs: raid56: use __bio_add_page to add single page
> > 
> > The btrfs patches added to misc-next, thanks.
> > 
> 
> Thanks but wouldn't it make more sense for Jens to pick up all of them?
> The last patch in the series flips bio_add_pages() over to
> __must_check and so it'll create an interdependency between the
> btrfs and the block tree.

I'd rather take it via btrfs tree, this avoids future merge conflicts.
