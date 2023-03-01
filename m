Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFBD6A71D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 18:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCARI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 12:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCARI1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:08:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D382069A
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 09:08:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F5B261419
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 17:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86060C433D2;
        Wed,  1 Mar 2023 17:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677690504;
        bh=20lsOtTm3VJqpNG3SKHu4vMMMyKHulIUG/bHI55Os4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5r/1J8Xe9cZzoqSPWjbfbKOqkRDCHtzjModu0bIIgoW6l4y0Qm4/I4dG5vSxZy14
         FocsRvLqt48DOnLr4eD8fXogzp1NcAE0PfyIUA3qbpBXV30yp+jjj28syRfTesW6wk
         r0fSkgzlE3oOYlFixNO5eNSmR4y0UPsw+C+9EsK03UkfSXrcKHMTZAYuNFZ406LfaY
         295CGP3m8iMHMaw4F4kNjNNusobdfJgfqhXapsbjgAJ3NCtJlhG+AxxMR3miD8nmcG
         AwSxElXJQLKTly59PBXTHbdujUPmjivceaZ3AwS8v07CdwT0AIAnEA0YySYCamxW9k
         MBNUbcJeToC0g==
Date:   Wed, 1 Mar 2023 09:08:23 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        lsf-pc@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "kbus >> Keith Busch" <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: LSF/MM/BPF 2023 IOMAP conversion status update
Message-ID: <Y/+GhyKDhLCULAm2@magnolia>
References: <20230129044645.3cb2ayyxwxvxzhah@garbanzo>
 <87wn40mmpf.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn40mmpf.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 01, 2023 at 10:29:56PM +0530, Ritesh Harjani wrote:
> Luis Chamberlain <mcgrof@kernel.org> writes:
> 
> > One of the recurring themes that comes up at LSF is "iomap has little
> > to no documentation, it is hard to use". I've only recently taken a
> > little nose dive into it, and so I also can frankly admit to say I don't
> > grok it well either yet. However, the *general* motivation and value is clear:
> > avoiding the old ugly monster of struct buffer_head, and abstracting
> > the page cache for non network filesystems, and that is because for
> > network filesystems my understanding is that we have another side effort
> > for that. We could go a bit down memory lane on prior attempts to kill
> > the struct buffer_head evil demon from Linux, or why its evil, but I'm not
> > sure if recapping that is useful at this point in time, let me know, I could
> > do that if it helps if folks want to talk about this at LSF. For now I rather
> 
> It would certainly help to hear on what are our plans of
> IOMAP_F_BUFFER_HEAD flag and it's related code. I know it is there
> for gfs2, but it would be good to know on what are our plans before we
> start converting all other filesystems to move to iomap?
> Do we advise on not to use this path for other filesystems? Do we plan
> to deprecate it in order to kill buffer heads in future?
> e.g.
> root> git grep "buffer_head" fs/iomap/
> fs/iomap/buffered-io.c:#include <linux/buffer_head.h>
> 
> Wanted more insights on this and our plans w.r.t other filesystem
> wanting to use it. So a short walk down the memory lane and our plans
> for future w.r.t IOMAP_F_BUFFER_HEAD would certainly help.

For filesystems considering an iomap port, my advice is:

If your filesystem is simple (e.g. direct overwrites, no cow, no verity,
no fscrypt, etc) then you ought to consider jumping to iomap directly
and moving off bufferheads forever.  If I were working on a port of
something simple(ish) like ext2 or fat or something, that's how I'd go.

Obviously, any filesystem that does not use bufferheads and ports to
iomap should go straight there.  Do not *start* using bufferheads.

For filesystems where things are more complicated (ext4/jbd2) it might
make more sense to port to iomap with bufferheads in one release to make
sure you've gotten the locking, iomap-ops, and writeback working
correctly.  Once that's done, then move off bufferheads.

gfs2 might want to move off of bufferheads some day, but I think they're
still letting the dust settle on the new iomap plumbing.

IOWs, I don't see IOMAP_F_BUFFER_HEAD going away until there's no longer
any interest in it.

--D

> Thanks
> -ritesh
