Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D017699467
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 13:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjBPMdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 07:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBPMdT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:33:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FD5CDE6;
        Thu, 16 Feb 2023 04:33:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 46F69221DB;
        Thu, 16 Feb 2023 12:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676550797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EEFjBECoUujr76fxWPlosXBvyHr6ZjAdBgnYwY2gd0Y=;
        b=3Jd0JGXqKmv5jjbXISg82FCjUUIGOVSPlL7CSoQbAqsi6SXRqXVmHLvZ+yRT10XR7aVn9e
        m+eKkLOnxVHasKBWphBoKwopG/Ou/Nt9IGlHrLSRQg1GLw0Rxiz+DDCT8sSPs3Yi+bXQIT
        x05yX1rYbI8PxoI3NJ3KPa/9h8mVHQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676550797;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EEFjBECoUujr76fxWPlosXBvyHr6ZjAdBgnYwY2gd0Y=;
        b=yqq9896s/+5dFzrTaV3DTo8raRXR9Y7PeTdFFzflOs3tTpkbMceClRulcHCNhECbh1dwMG
        hlA4lcTctUBKwNDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AC0B131FD;
        Thu, 16 Feb 2023 12:33:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UFxODo0i7mOzQwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 16 Feb 2023 12:33:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B50CEA06E1; Thu, 16 Feb 2023 13:33:16 +0100 (CET)
Date:   Thu, 16 Feb 2023 13:33:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/5] block: Add support for bouncing pinned pages
Message-ID: <20230216123316.vkmtucazg33vidzg@quack3>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-4-jack@suse.cz>
 <Y+oKAB/epmJNyDbQ@infradead.org>
 <20230214135604.s5bygnthq7an5eoo@quack3>
 <20230215045952.GF2825702@dread.disaster.area>
 <Y+x6oQkLex8PbfgL@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+x6oQkLex8PbfgL@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 14-02-23 22:24:33, Christoph Hellwig wrote:
> On Wed, Feb 15, 2023 at 03:59:52PM +1100, Dave Chinner wrote:
> > I don't think this works, especially if the COW mechanism relies on
> > delayed allocation to prevent ENOSPC during writeback. That is, we
> > need a write() or page fault (to run ->page_mkwrite()) after every
> > call to folio_clear_dirty_for_io() in the writeback path to ensure
> > that new space is reserved for the allocation that will occur
> > during a future writeback of that page.
> > 
> > Hence we can't just leave the page dirty on COW filesystems - it has
> > to go through a clean state so that the clean->dirty event can be
> > gated on gaining the space reservation that allows it to be written
> > back again.
> 
> Exactly.  Although if we really want we could do the redirtying without
> formally moving to a clean state, but it certainly would require special
> new code to the same steps as if we were redirtying.

Yes.

> Which is another reason why I'd prefer to avoid all that if we can.
> For that we probably need an inventory of what long term pins we have
> in the kernel tree that can and do operate on shared file mappings,
> and what kind of I/O semantics they expect.

I'm a bit skeptical we can reasonably assess that (as much as I would love
to just not write these pages and be done with it) because a lot of
FOLL_LONGTERM users just pin passed userspace address range, then allow
userspace to manipulate it with other operations, and finally unpin it with
another call. Who knows whether shared pagecache pages are passed in and
what userspace is doing with them while they are pinned? 

We have stuff like io_uring using FOLL_LONGTERM for IO buffers passed from
userspace (e.g. IORING_REGISTER_BUFFERS operation), we have V4L2 which
similarly pins buffers for video processing (and I vaguely remember one
bugreport due to some phone passing shared file pages there to acquire
screenshots from a webcam), and we have various infiniband drivers doing
this (not all of them are using FOLL_LONGTERM but they should AFAICS). We
even have vmsplice(2) that should be arguably using pinning with
FOLL_LONGTERM (at least that's the plan AFAIK) and not writing such pages
would IMO provide an interesting attack vector...

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
