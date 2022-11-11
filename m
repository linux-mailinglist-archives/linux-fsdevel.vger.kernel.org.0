Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0C36260BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 18:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiKKR5w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 12:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiKKR5s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:57:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262FC6A771;
        Fri, 11 Nov 2022 09:57:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD37222276;
        Fri, 11 Nov 2022 17:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668189465;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Ps/5tt8PL9Kli93ryITYZsunBP9bcRiS3HUPMTLqE8=;
        b=NwPSMiZ/DbpkxWCUTylmJGjJ8FYX3KHF+ZueQ2KSE7BY8J/y71tz2euMIQkBgNRtgYfutH
        5LAjjh9XGhbdLeE/2ZS2zbWg6o0GPPVy4H+2ImW87dsAW8km/6ckB95ESjTLmAloEZxSZf
        R0tjQagMIxnDKr63p6tDJioIJzzhlEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668189465;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Ps/5tt8PL9Kli93ryITYZsunBP9bcRiS3HUPMTLqE8=;
        b=yLu2EWk7+WYKHlqBiIOAiEK5GfDDFtG1GWtiyPZRzyvkbMN+4oWzO+hT4l6foFxdUxRkN/
        XWhK4S3AJ1/yk1BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7055613273;
        Fri, 11 Nov 2022 17:57:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4jT8GRmNbmO9AwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Nov 2022 17:57:45 +0000
Date:   Fri, 11 Nov 2022 18:57:20 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>, Chris Mason <clm@meta.com>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Message-ID: <20221111175720.GV5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220901074216.1849941-1-hch@lst.de>
 <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
 <20221024144411.GA25172@lst.de>
 <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com>
 <20221024171042.GF5824@suse.cz>
 <9f443843-4145-155b-2fd0-50613a9f7913@wdc.com>
 <20221026074145.2be5ca09@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026074145.2be5ca09@gandalf.local.home>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 26, 2022 at 07:41:45AM -0400, Steven Rostedt wrote:
> On Wed, 26 Oct 2022 07:36:45 +0000
> Johannes Thumshirn <Johannes.Thumshirn@wdc.com> wrote:
> 
> > [+Cc Steven ]
> > 
> > Steven, you're on the TAB, can you help with this issue?
> > Or bring it up with other TAB members?

Let me reply here in summary, based on what was discussed in the btrfs
developer group:

I got an answer from LF that I will use for contributions 'add copyright
or reject patches', thank you Steve. Btrfs stays open to contributions,
valid copyright notices will be added on request. I'll update the wiki
to reflect the status. Patches from Christoph are in the backlog and are
planned for merge.
