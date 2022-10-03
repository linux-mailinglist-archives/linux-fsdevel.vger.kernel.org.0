Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DADE5F2B9A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 10:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJCIWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 04:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJCIVu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:21:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6972A7AC15;
        Mon,  3 Oct 2022 00:56:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 03A3B2199D;
        Mon,  3 Oct 2022 07:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664783704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dwt0M+3sS5jciWoEfZ361h/7J8CUArjkqTvOekaboQM=;
        b=zkThJ2TFJKFUEK3VylwDrcuP3qR0r+8zOoVjqqSHzXOI6usNom6OffXeZGMpe/GynYzi73
        sQWnjyKxPucXtNlJ0gwCXCDOSp3Mxit3ZmYug0ZB8d6NdYAHk5apFRG/smhDgljnOMnWl0
        oXPm/fEAi0u86y4+Bd97IzG2zIrXUoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664783704;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dwt0M+3sS5jciWoEfZ361h/7J8CUArjkqTvOekaboQM=;
        b=Ka3lq+tWamkJuoOp3to1B+06t8Js1FGSUPVxo2WCOJ4jJRaSTRqb4l+c0nHC3luZKW2MOy
        L7hngvV2S5HeraCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E61881332F;
        Mon,  3 Oct 2022 07:55:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3yUiOFeVOmODUgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 03 Oct 2022 07:55:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7768DA06E6; Mon,  3 Oct 2022 09:55:03 +0200 (CEST)
Date:   Mon, 3 Oct 2022 09:55:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>, akpm@linux-foundation.org,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <20221003075503.k7h6aqvlnoi5bo52@quack3>
References: <20220923001846.GX3600936@dread.disaster.area>
 <632d00a491d0d_4a67429488@dwillia2-xfh.jf.intel.com.notmuch>
 <20220923021012.GZ3600936@dread.disaster.area>
 <20220923093803.nroajmvn7twuptez@quack3>
 <20220925235407.GA3600936@dread.disaster.area>
 <20220926141055.sdlm3hkfepa7azf2@quack3>
 <63362b4781294_795a6294f0@dwillia2-xfh.jf.intel.com.notmuch>
 <20220930134144.pd67rbgahzcb62mf@quack3>
 <63372dcbc7f13_739029490@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <YzcwN67+QOqXpvfg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzcwN67+QOqXpvfg@nvidia.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 30-09-22 15:06:47, Jason Gunthorpe wrote:
> On Fri, Sep 30, 2022 at 10:56:27AM -0700, Dan Williams wrote:
> > Jan Kara wrote:
> > [..]
> > > I agree this is doable but there's the nasty sideeffect that inode reclaim
> > > may block for abitrary time waiting for page pinning. If the application
> > > that has pinned the page requires __GFP_FS memory allocation to get to a
> > > point where it releases the page, we even have a deadlock possibility.
> > > So it's better than the UAF issue but still not ideal.
> > 
> > I expect VMA pinning would have similar deadlock exposure if pinning a
> > VMA keeps the inode allocated. Anything that puts a page-pin release
> > dependency in the inode freeing path can potentially deadlock a reclaim
> > event that depends on that inode being freed.
> 
> I think the desire would be to go from the VMA to an inode_get and
> hold the inode reference for the from the pin_user_pages() to the
> unpin_user_page(), ie prevent it from being freed in the first place.

Yes, that was the idea how to avoid UAF problems.

> It is a fine idea, the trouble is just the high complexity to get
> there.
> 
> However, I wonder if the trucate/hole punch paths have the same
> deadlock problem?

Do you mean someone requiring say truncate(2) to complete on file F in
order to unpin pages of F? That is certainly a deadlock but it has always
worked this way for DAX so at least applications knowingly targetted at DAX
will quickly notice and avoid such unwise dependency ;).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
