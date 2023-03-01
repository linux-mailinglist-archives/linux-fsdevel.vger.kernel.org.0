Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702886A76A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 23:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCAWJ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 17:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCAWJ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 17:09:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB2319692;
        Wed,  1 Mar 2023 14:09:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 73A65CE1DFF;
        Wed,  1 Mar 2023 22:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA25C433EF;
        Wed,  1 Mar 2023 22:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677708561;
        bh=ZsyVlWE7WL5rcOZbd/YT2jM0SzkNfV8oGFDt/qStDYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J3c7byeC5yuzXtlQq1fHWpqGs3yv8eptDWUjUCrVErLALtwjBzui16GtdjlNYyJqc
         iB2HRr2qWaplBJacLT9dFyz1nAkdTUOlKKWKr05lFw75qrc8kjccFAChkPGEBE7fXt
         4UxlzX0dLs33Am2MX3ytrpZKNp7qTfPEYV5f+L9EnBQFmpNbSev96yc6/5T8dSDMXK
         roCKp7gqqf3KdqJ5AocvRm8J8FOTIi16JFC/Pal85Nxijc7KHCOjfAg3W1lV6YbiY+
         2mmqiZ7xbJZJxLfg18L9l/yCA34UU99R243gzhIdd9D2HgfQBU1IQSXxcizIplcXJ2
         Sgu1PfFyqsYqQ==
Date:   Wed, 1 Mar 2023 14:09:21 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Chandan Babu <chandan.babu@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 10/14] xfs: document full filesystem scans for online fsck
Message-ID: <Y//NEcbvtdl8IzSc@magnolia>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
 <167243825302.682859.6563684998299886921.stgit@magnolia>
 <81d41ce2c183f8bbb7c28d5aa688e23348c87bdc.camel@oracle.com>
 <Y+6ywAO0fdddf79C@magnolia>
 <04811ecc7a2e7abc7e14e248f7389a37ee4d8ded.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04811ecc7a2e7abc7e14e248f7389a37ee4d8ded.camel@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 25, 2023 at 07:33:38AM +0000, Allison Henderson wrote:

<snip>

> > > Mostly looks good nits aside, I do sort of wonder if this patch
> > > would
> > > do better to appear before patch 6 (or move 6 down), since it gets
> > > into
> > > more challenges concerning locks and hooks, where as here we are
> > > mostly
> > > discussing what they are and how they work.  So it might build
> > > better
> > > to move this patch up a little.
> > 
> > (I might be a tad confused here, bear with me.)
> > 
> > Patch 6, the section about eventual consistency?
> > 
> > Hmm.  The intent drains exist to quiesce intent chains targeting
> > specific AGs.  It briefly mentions "fshooks" in the context of using
> > jump labels to avoid the overhead of calling notify_all on the drain
> > waitqueue when scrub isn't running.  That's perhaps bad naming on my
> > part, since the other "fshooks" are jump labels to avoid bouncing
> > through the notifier chain code when scrub isn't running.  The jump
> > labels themselves are not hooks, they're structured dynamic code
> > patching.
> > 
> > I probably should've named those something else.  fsgates?
> Oh, i see, yes I did sort of try to correlate them, so maybe the
> different name would help.

Done.

> > Or maybe you were talking specifically about "Case Study: Rebuilding
> > Reverse Mapping Records"?  In which case I remark that the case study
> > needs both the intent drains to quiesce the AG and the live scans to
> > work properly, which is why the case study of it couldn't come
> > earlier.
> > The intent drains section still ought to come before the refcountbt
> > section, because it's the refcountbt scrubber that first hit the
> > coordination problem.
> > 
> > Things are getting pretty awkward like this because there are sooo
> > many
> > interdependent pieces. :(
> 
> I see, ok no worries then, I think people will figure it out either
> way.  I mostly look for ways to make the presentation easier but it is
> getting harder to move stuff with chicken and egg dependencies.

Indeed.  Thank you so much for your patience. :)

--D

> > 
> > Regardless, thank you very much for slogging through.
> > 
> > --D
> > 
> > > Allison
> > > 
> 
