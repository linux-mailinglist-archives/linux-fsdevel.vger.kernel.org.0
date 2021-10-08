Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8B5426302
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 05:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbhJHDeA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 23:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbhJHDd7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 23:33:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DA7C061714;
        Thu,  7 Oct 2021 20:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=VSeLCmemXSSseFE6GWGfLbL5+eucGh3/N220YyPpMd0=; b=sOdirM9AOuaWTrkR2EPQPI1Sqy
        uC1Ttna+a3wXn0EF9uQrPYtq+MjJ65W0IjFFDdcmUjt3rDuGr2c6N4OhZue2zntvo8BzPJ+VcbSGM
        v4yy7sFOb0DXXNcLfuoeU8+Z/Jrfa8MiR8VCIzbGOUeTz62KFb4Nbp45I4THHDxm3r6N5Yr6N3gNV
        oBZwIVPwzRWbUg5i91zsInHQM5GRgB4r6E3YqNEMcKEPecTCsEs2XT/fbGRPIZc+PJwC0RrVBHjo+
        RMiihpEF2vOFTTiN0NYwpPuPYx6mDKHJoi9UX12arZC5wXtUZXfqs7pbOGFxEoaJu7ZAFkAlkTec+
        IKOYw9Ww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYgbC-002kMQ-B6; Fri, 08 Oct 2021 03:31:20 +0000
Date:   Fri, 8 Oct 2021 04:31:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Yang Shi <shy828301@gmail.com>
Subject: Re: kernel BUG in block_invalidatepage
Message-ID: <YV+7eslze4LhMSWp@casper.infradead.org>
References: <CACkBjsZh7DCs+N+R=0+mnNqFZW8ck5cSgV4MpGM6ySbfenUJ+g@mail.gmail.com>
 <CACkBjsb0Hxam_e5+vOOanF_BfGAcf5UY+=Cc-pyphQftETTe8Q@mail.gmail.com>
 <YV8B+VGQ7TZoeJ8W@casper.infradead.org>
 <CACkBjsZ8vxzSAnhVqnkJwQi1a5oCddGRZrK5bmvUQYzDKBDsjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACkBjsZ8vxzSAnhVqnkJwQi1a5oCddGRZrK5bmvUQYzDKBDsjw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 08, 2021 at 11:02:14AM +0800, Hao Sun wrote:
> Matthew Wilcox <willy@infradead.org> 于2021年10月7日周四 下午10:20写道：
> >
> > On Thu, Oct 07, 2021 at 02:40:29PM +0800, Hao Sun wrote:
> > > Hello,
> > >
> > > This crash can still be triggered repeatedly on the latest kernel.
> >
> > I asked you three days ago to try a patch and report the results:
> >
> > https://lore.kernel.org/linux-mm/YVtWhVNFhLbA9+Tl@casper.infradead.org/
> 
> Sorry, I missed that.
> 
> Here are the results.
> Used reproducer: https://paste.ubuntu.com/p/yrYsn4zpcn/
> Kernel log *before* applying the patch: https://paste.ubuntu.com/p/WtkFKB6Vy9/
> Kernel log *after* applying the patch: https://paste.ubuntu.com/p/S2VrtDdggp/
> Symbolized log: https://paste.ubuntu.com/p/RwXjCXDxB8/

OK, so that's ioctl(fd, BLKRRPART).  That reproducer is a beast, and I
can't help but think it could be minimised.

I think I see what's going on here though.  We open a block device, mount
some stuff on it.  khugepaged comes through and decides to create a THP
for some of the pages on it.  Nobody has it open for write, so why not?
But then the filesystem on top of it dirties something -- it doesn't
need to go through an open file descriptor because it's a filesystem.
So when we call BLKRRPART, it tries to write the dirty things back
(which it should) and things go wrong because the writeback path is not
equipped to handle compound pages.

So, yeah, let's do what Yang Shi suggested and tell khugepaged to never
try to work on block devices.  I can't think how any of this could happen
except to a block device, so there's no more insight to be gained here.
