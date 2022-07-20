Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757C757BDBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 20:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiGTS1L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 14:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiGTS1K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:27:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3172253A;
        Wed, 20 Jul 2022 11:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mRXw6tVbG1xi5xP9es+D9NEYgmnCt2nLwBhAxVuKwoc=; b=CS1CqvW9djmlVwvpElr1pXFlNR
        y/+ZzIwbmmPy93oBlPhaNRZxAgeeCeebsLyPmhLHo9vYNwmO/8kEjDv/aDIbiZWMSfCZJILkQksgH
        1dMU3ObU+MhUAHzzH5sJp5C6ei49WGySp/8h/TQODKPyg5h5Xhz5BRPN82XVuo2O8KxLi97OeYqOT
        avIfPskPV6ocjreg+CcybP9grMKR0tDwsYo/kd905JOvC3meQVS5wOEJFWICc5IinzFja13oLSVVm
        2OhhwREhUkNhRvM9eCztrryUYoz7QARRxPo6EaHeyUd1usud9O9bSKco/YLHxEdPPicme5VwtxLIQ
        xwdqA9fA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEEPW-00EgkK-9o; Wed, 20 Jul 2022 18:27:02 +0000
Date:   Wed, 20 Jul 2022 19:27:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Jeremy Bongio <bongiojp@gmail.com>, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] Add ioctls to get/set the ext4 superblock uuid.
Message-ID: <YthI9qp+VeNbFQP3@casper.infradead.org>
References: <20220719234131.235187-1-bongiojp@gmail.com>
 <Ytd0G0glVWdv+iaD@casper.infradead.org>
 <Ytd28d36kwdYWkVZ@magnolia>
 <YtgNCfMcuX7DGg7z@casper.infradead.org>
 <YthCucuMk/SAL0qN@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YthCucuMk/SAL0qN@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 02:00:25PM -0400, Theodore Ts'o wrote:
> On Wed, Jul 20, 2022 at 03:11:21PM +0100, Matthew Wilcox wrote:
> > Uhhh.  So what are the semantics of len?  That is, on SET, what does
> > a filesystem do if userspace says "Here's 8 bytes" but the filesystem
> > usually uses 16 bytes?  What does the same filesystem do if userspace
> > offers it 32 bytes?  If the answer is "returns -EINVAL", how does
> > userspace discover what size of volume ID is acceptable to a particular
> > filesystem?
> > 
> > And then, on GET, does 'len' just mean "here's the length of the buffer,
> > put however much will fit into it"?  Should filesystems update it to
> > inform userspace how much was transferred?
> 
> What I'd suggest is that for GET, the length field when called should
> be the length of the buffer, and if the length is too small, we should
> return some error --- probably EINVAL or ENOSPC.  If the buffer size
> length is larger than what is needed, having the file system update it
> with the size of the UUID that was returned.
> 
> And this would be how the userspace can discover size of the UUID.  In
> practice, though, the human user is going to be suppliyng the UUID,
> which means the *human* is going to have to understand that "oh, this
> is a VFAT file system, so I need to give 32-bit UUID formatted as
> DEAD-BEAF" or "oh, this is a ntfs file system, so I need to enter into
> the command line a UUID formatted as the text string
> A24E62F14E62BDA3".  (The user might also end up having to ntfs or vfat
> specific uuid changing tool; that's unclear at this point.)

I think you covered all my questions there except for what happens
if the user tried to set ext4 to 0xDEADBEEF; that should return
-EINVAL?  They could specify 0xDEADBEEF'00000000'00000000'00000000 or
0x00000000'00000000'00000000'DEADBEEF, but it'd be up to them to choose
which one they wanted rather than have the filesystem pad it out for them?

> As far as Jeremy's patch is concerned, I don't think we need to change
> anything forthe SET ioctl, but for the GET util, it would be better in
> the extremely unlikely case where the user pass in a length larger
> than 16 bytes (say, 32), that we return the 16 byte UUID, and update
> the length field to be 16 bytes.
> 
> I don't think it's strictly necessary, since in practice there is no
> reason why a file system's volume identifier would ever be larger than
> 16 bytes --- the chances that we might need an extra 240 bytes to
> specify a multiverse identifier seems.... unlikely.  :-)

Yes, 128 bits is sufficiently unique for this use case.
