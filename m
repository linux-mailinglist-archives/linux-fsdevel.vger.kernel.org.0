Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08B567D45B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 19:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjAZSjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 13:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjAZSjG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:39:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CBA45234;
        Thu, 26 Jan 2023 10:38:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B30AD1F8A8;
        Thu, 26 Jan 2023 18:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674758327;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lRfDjzIgIjwkJhFGfb4//GswabUdzG1fjNXcJDENBhE=;
        b=RqNSUOjX8IOvluYHUIyusC8t0ZKwYkz1hH9GxUYyDIMxtgfnMmdms72fGl0Xyd1FxP54VG
        0v51m0+xpCW+WL3XlwTmZ5oFJ++kEj1SEbC6brU2Qo0sAW8n8FA6vFbKNsPggcmEfTGCtl
        XL8wKCfyqYyNP0WAPhRIjaFBh8mN/Ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674758327;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lRfDjzIgIjwkJhFGfb4//GswabUdzG1fjNXcJDENBhE=;
        b=POfHEunNH1qXHfxLPhYyB8ikD4MPszz3ji+0CGdqHq+osM97o/5lmD3CUUfi7CM238GI2c
        eZYcIlbOi+U5+QBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C42313A09;
        Thu, 26 Jan 2023 18:38:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DGlyGbfI0mOCBwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 26 Jan 2023 18:38:47 +0000
Date:   Thu, 26 Jan 2023 19:33:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 23/34] btrfs: allow btrfs_submit_bio to split bios
Message-ID: <20230126183304.GZ11562@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-24-hch@lst.de>
 <Y9GkVONZJFXVe8AH@localhost.localdomain>
 <20230126052143.GA28195@lst.de>
 <Y9K7pZq2h9aXiKCJ@localhost.localdomain>
 <20230126174611.GC15999@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126174611.GC15999@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 06:46:11PM +0100, Christoph Hellwig wrote:
> On Thu, Jan 26, 2023 at 12:43:01PM -0500, Josef Bacik wrote:
> > I actually hadn't been running 125 because it wasn't in the auto group, Dave
> > noticed it, I just tried it on this VM and hit it right away.  No worries,
> > that's why we have the CI stuff, sometimes it just doesn't trigger for us but
> > will trigger with the CI setup.  Thanks,
> 
> Oh, I guess the lack of auto group means I've never tested it.  But
> it's a fairly bad bug, and I'm surprised nothing in auto hits an
> error after a bio split.  I'll need to find out if I can find a simpler
> reproducer as this warrants a regression test.

The 'auto' group is good for first tests, I'm running 'check -g all' on
my VM setups. If this is enough to trigger errors then we probably don't
need a separate regression test.
