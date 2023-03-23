Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711906C65EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 11:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjCWK5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 06:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjCWK5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:57:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68508211F3;
        Thu, 23 Mar 2023 03:57:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5F20E1FD91;
        Thu, 23 Mar 2023 10:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679569031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TvurBpsiIzqWG/nAqLntTGjrhV3SzoNwAZafzGBmxck=;
        b=X1tecy4IxjxJzYzg/QoDKuQ0BOg44rPkOqUkS/spndV8Qp83qy+BXikquaYCEtVaz+XNU7
        S1+3djxCvubvSBpjivXSFZ3ph2J4XTvKNpKdKCTCGiBfMbbHFm38wadm6ZPsx3oVUn4Kvc
        DrY/5zHbE8wHh4VVIlA+t/rE9feIuD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679569031;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TvurBpsiIzqWG/nAqLntTGjrhV3SzoNwAZafzGBmxck=;
        b=2ToYUX+LlsSoZ18d4vzutPUmD/P0QZV7CzVhAC7fYshG79IHaYhx5xBaeX6QqftD50YpFW
        Ko/48jelYiYHdUAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BC0D13596;
        Thu, 23 Mar 2023 10:57:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V5VGGocwHGR2ewAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 23 Mar 2023 10:57:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DE03DA071C; Thu, 23 Mar 2023 11:57:10 +0100 (CET)
Date:   Thu, 23 Mar 2023 11:57:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [RFC 08/11] ext4: Don't skip prefetching BLOCK_UNINIT groups
Message-ID: <20230323105710.mdhamc3hza4223cb@quack3>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <4881693a4f5ba1fed367310b27c793e4e78520d3.1674822311.git.ojaswin@linux.ibm.com>
 <20230309141422.b2nbl554ngna327k@quack3>
 <ZBRHCHySeQ0KC/f7@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBRHCHySeQ0KC/f7@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 17-03-23 16:25:04, Ojaswin Mujoo wrote:
> On Thu, Mar 09, 2023 at 03:14:22PM +0100, Jan Kara wrote:
> > On Fri 27-01-23 18:07:35, Ojaswin Mujoo wrote:
> > > Currently, ext4_mb_prefetch() and ext4_mb_prefetch_fini() skip
> > > BLOCK_UNINIT groups since fetching their bitmaps doesn't need disk IO.
> > > As a consequence, we end not initializing the buddy structures and CR0/1
> > > lists for these BGs, even though it can be done without any disk IO
> > > overhead. Hence, don't skip such BGs during prefetch and prefetch_fini.
> > > 
> > > This improves the accuracy of CR0/1 allocation as earlier, we could have
> > > essentially empty BLOCK_UNINIT groups being ignored by CR0/1 due to their buddy
> > > not being initialized, leading to slower CR2 allocations. With this patch CR0/1
> > > will be able to discover these groups as well, thus improving performance.
> > > 
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > 
> > The patch looks good. I just somewhat wonder - this change may result in
> > uninitialized groups being initialized and used earlier (previously we'd
> > rather search in other already initialized groups) which may spread
> > allocations more. But I suppose that's fine and uninit groups are not
> > really a feature meant to limit fragmentation and as the filesystem ages
> > the differences should be minimal. So feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> > 								Honza
> Thanks for the review. As for the allocation spread, I agree that it
> should be something our goal determination logic should take care of
> rather than limiting the BGs available to the allocator.
> 
> Another point I wanted to discuss wrt this patch series was why were the
> BLOCK_UNINIT groups not being prefetched earlier. One point I can think
> of is that this might lead to memory pressure when we have too many
> empty BGs in a very large (say terabytes) disk.
> 
> But i'd still like to know if there's some history behind not
> prefetching block uninit.

Hum, I don't remember anything. Maybe Ted will. You can ask him today on a
call.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
