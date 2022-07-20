Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F4157BF25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 22:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiGTUXl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 16:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGTUXl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 16:23:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180B52E9CC;
        Wed, 20 Jul 2022 13:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A85EA61B59;
        Wed, 20 Jul 2022 20:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE72C3411E;
        Wed, 20 Jul 2022 20:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658348619;
        bh=lW21q/FRWjWE3vtmO3DcbyopA+xnj8cd4DOAyFf9cFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oR/7zkojZptHam4OYQI7P7DJlDQqa1dO4av9TIdH9p+bSc+42SdnW88iuyCahtEH7
         pb5B6olrLeICizfdZrb8CPU9Ap2HwcGkVT/qGIKgcZtZja4OPRwKTiBKmRTmOsj4EV
         9boJElTA9daYSGFLWehsII5ydSGJDxoBhwfac78Scy5LeaBvWAEpDXu6Kc0/lYq/8v
         pR/Em443K3NvHJ1W+fMGILjCxkbCy81uYia3Q0li5RIHsCDVE1bUXaZPgO9d1DjK+H
         dNnrdABwRJeE+jls2LZr0JBc26AMON2mSmtfrCF+SRYlDN+mZg9xwqI+ggA+D8/Bbw
         D2M0opea0CuSw==
Date:   Wed, 20 Jul 2022 13:23:38 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] Add ioctls to get/set the ext4 superblock uuid.
Message-ID: <YthkSsZNA5g2Pqkn@magnolia>
References: <20220719234131.235187-1-bongiojp@gmail.com>
 <Ytd0G0glVWdv+iaD@casper.infradead.org>
 <Ytd28d36kwdYWkVZ@magnolia>
 <YtgNCfMcuX7DGg7z@casper.infradead.org>
 <YthCucuMk/SAL0qN@mit.edu>
 <YthI9qp+VeNbFQP3@casper.infradead.org>
 <YthNrO4PMR+5ao+6@magnolia>
 <YthSysIGldWhK6f+@casper.infradead.org>
 <CANfQU3xMtYE8egLim0MS6N0SCCNX5yihQgafptop6ACrO8MGbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANfQU3xMtYE8egLim0MS6N0SCCNX5yihQgafptop6ACrO8MGbw@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 01:11:25PM -0700, Jeremy Bongio wrote:
> On Wed, Jul 20, 2022 at 12:09 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Jul 20, 2022 at 11:47:08AM -0700, Darrick J. Wong wrote:
> > > On Wed, Jul 20, 2022 at 07:27:02PM +0100, Matthew Wilcox wrote:
> > > > On Wed, Jul 20, 2022 at 02:00:25PM -0400, Theodore Ts'o wrote:
> > > > > On Wed, Jul 20, 2022 at 03:11:21PM +0100, Matthew Wilcox wrote:
> > > > > > Uhhh.  So what are the semantics of len?  That is, on SET, what does
> > > > > > a filesystem do if userspace says "Here's 8 bytes" but the filesystem
> > > > > > usually uses 16 bytes?  What does the same filesystem do if userspace
> > > > > > offers it 32 bytes?  If the answer is "returns -EINVAL", how does
> > > > > > userspace discover what size of volume ID is acceptable to a particular
> > > > > > filesystem?
> > > > > >
> > > > > > And then, on GET, does 'len' just mean "here's the length of the buffer,
> > > > > > put however much will fit into it"?  Should filesystems update it to
> > > > > > inform userspace how much was transferred?
> > > > >
> > > > > What I'd suggest is that for GET, the length field when called should
> > > > > be the length of the buffer, and if the length is too small, we should
> > > > > return some error --- probably EINVAL or ENOSPC.  If the buffer size
> > > > > length is larger than what is needed, having the file system update it
> > > > > with the size of the UUID that was returned.
> > >
> > > I'd suggest something different -- calling the getfsuuid ioctl with a
> > > null argument should return the filesystem's volid/uuid size as the
> > > return value.  If userspace supplies a non-null argument, then fsu_len
> > > has to match the filesystem's volid/uuid size or else you get EINVAL.
> >
> > Or userspace passes in 0 for the len and the filesystem returns -EINVAL
> > and sets ->len to what the valid size would be?  There's a few ways of
> > solving this.
> 
> This solution seems more intuitive to me. If EXT4_IOCTL_GETFSUUID is
> called with fsu_len set to 0, then fsu_len will be set to the required
> UUID length and return with an error code.

Works for me!

> I discussed this solution when first developing the ioctl, but I left
> it out since for ext4 I don't have a use case. However since other
> filesystems will likely implement this ioctl, it makes sense to add.

Hee hee, future thinking.  That's what a good ARB should be for <cough>.

> I'll send out a new manpage with that detail added and update the code.

I'll look forward to it. :)

--D
