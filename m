Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663F37B5F34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 05:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjJCDAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 23:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjJCDAP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 23:00:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08258AC;
        Mon,  2 Oct 2023 20:00:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F59DC433C8;
        Tue,  3 Oct 2023 03:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696302011;
        bh=6G/ueFuWEcQKsuh5W2JpGGX6FBNexvvd8Q/l4pQONpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DmJCYlni//qtXa3x5SP4sdoXhy9qmyQDPjVd3ebmxA+B4S9VST1efkK0rr/t+Oacz
         tAoY/Qma7ocW7DcbYlr5p24LZKBAekgEWj50hV9UBZ8IpXEJkYY3R7UM9EiFib36XM
         az/ES8zcAkj8lhqtUuJ3lXp9XaDdigowNFxcgfEETJmTvjj7Uv27TTTYhTKdrvessb
         sfxlxGWrcaXrGG+RoHKR7eJEMgi/j/VqRh/5QFGXJMuErowsTaKXyDaJYONyFdCQ6i
         j7Khz/yMEwyhtjr9riThwbcESL7OmpqTmkrHfHOlGdpz7zDX4uwkFpKnIM/V1C1Ah+
         FqqNI6nnb/Ypg==
Date:   Mon, 2 Oct 2023 20:00:10 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 11/21] fs: xfs: Don't use low-space allocator for
 alignment > 1
Message-ID: <20231003030010.GE21298@frogsfrogsfrogs>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-12-john.g.garry@oracle.com>
 <ZRtrap9v9xJrf6nq@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRtrap9v9xJrf6nq@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 03, 2023 at 12:16:26PM +1100, Dave Chinner wrote:
> On Fri, Sep 29, 2023 at 10:27:16AM +0000, John Garry wrote:
> > The low-space allocator doesn't honour the alignment requirement, so don't
> > attempt to even use it (when we have an alignment requirement).
> > 
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > ---
> >  fs/xfs/libxfs/xfs_bmap.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> > index 30c931b38853..328134c22104 100644
> > --- a/fs/xfs/libxfs/xfs_bmap.c
> > +++ b/fs/xfs/libxfs/xfs_bmap.c
> > @@ -3569,6 +3569,10 @@ xfs_bmap_btalloc_low_space(
> >  {
> >  	int			error;
> >  
> > +	/* The allocator doesn't honour args->alignment */
> > +	if (args->alignment > 1)
> > +		return 0;
> > +
> 
> How does this happen?
> 
> The earlier failing aligned allocations will clear alignment before
> we get here....

I was thinking the predicate should be xfs_inode_force_align(ip) to save
me/us from thinking about all the other weird ways args->alignment could
end up 1.

	/* forced-alignment means we don't use low mode */
	if (xfs_inode_force_align(ip))
		return -ENOSPC;

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
