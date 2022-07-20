Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E688B57BE45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 21:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiGTTJL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 15:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiGTTJG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:09:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9796B664E5;
        Wed, 20 Jul 2022 12:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ipGaRjwQ4nH9+jZ3xFTf6qP2G+zhiq/i4K2Jn73V01c=; b=cF96UzV6r4vdnjnMeSb5pvMJ+7
        hC55QhofmMGLiXuOdUQ/Ovzd0qL4u4ELLUd+hDrEcVyYEfgex1obdE8sxHjz5RgRe0l8jie/QNCVa
        n4kDifmk+I2U3aPo6q66qg25E9cBUyDTUbkXmQSbhSVPHC+8GSXuMxU5J73ffYvbl16sCZYbqFIMa
        roHuDxffqPLpsGTqeo5DYZtn1ZXnjEb0lGoZLx79VgbzRwgOEPpQ9XpjGyLX7kOcBBXCNwEHr46eL
        hATaojekWZBusuVJwvpFCtpG2SO535mDZ2gFvjijo1cPU6P7sMBY4ddCI3TnwuBtRvH2BGjiIWj8d
        zQ/WKt8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEF46-00EiXK-86; Wed, 20 Jul 2022 19:08:58 +0000
Date:   Wed, 20 Jul 2022 20:08:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jeremy Bongio <bongiojp@gmail.com>,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] Add ioctls to get/set the ext4 superblock uuid.
Message-ID: <YthSysIGldWhK6f+@casper.infradead.org>
References: <20220719234131.235187-1-bongiojp@gmail.com>
 <Ytd0G0glVWdv+iaD@casper.infradead.org>
 <Ytd28d36kwdYWkVZ@magnolia>
 <YtgNCfMcuX7DGg7z@casper.infradead.org>
 <YthCucuMk/SAL0qN@mit.edu>
 <YthI9qp+VeNbFQP3@casper.infradead.org>
 <YthNrO4PMR+5ao+6@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YthNrO4PMR+5ao+6@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 11:47:08AM -0700, Darrick J. Wong wrote:
> On Wed, Jul 20, 2022 at 07:27:02PM +0100, Matthew Wilcox wrote:
> > On Wed, Jul 20, 2022 at 02:00:25PM -0400, Theodore Ts'o wrote:
> > > On Wed, Jul 20, 2022 at 03:11:21PM +0100, Matthew Wilcox wrote:
> > > > Uhhh.  So what are the semantics of len?  That is, on SET, what does
> > > > a filesystem do if userspace says "Here's 8 bytes" but the filesystem
> > > > usually uses 16 bytes?  What does the same filesystem do if userspace
> > > > offers it 32 bytes?  If the answer is "returns -EINVAL", how does
> > > > userspace discover what size of volume ID is acceptable to a particular
> > > > filesystem?
> > > > 
> > > > And then, on GET, does 'len' just mean "here's the length of the buffer,
> > > > put however much will fit into it"?  Should filesystems update it to
> > > > inform userspace how much was transferred?
> > > 
> > > What I'd suggest is that for GET, the length field when called should
> > > be the length of the buffer, and if the length is too small, we should
> > > return some error --- probably EINVAL or ENOSPC.  If the buffer size
> > > length is larger than what is needed, having the file system update it
> > > with the size of the UUID that was returned.
> 
> I'd suggest something different -- calling the getfsuuid ioctl with a
> null argument should return the filesystem's volid/uuid size as the
> return value.  If userspace supplies a non-null argument, then fsu_len
> has to match the filesystem's volid/uuid size or else you get EINVAL.

Or userspace passes in 0 for the len and the filesystem returns -EINVAL
and sets ->len to what the valid size would be?  There's a few ways of
solving this.
