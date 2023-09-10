Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF41F799F18
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Sep 2023 19:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjIJRft (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 13:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjIJRfs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 13:35:48 -0400
Received: from out-228.mta1.migadu.com (out-228.mta1.migadu.com [95.215.58.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BAE136
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 10:35:43 -0700 (PDT)
Date:   Sun, 10 Sep 2023 13:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694367341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m8/9jq03lTWziCKJusVMjMJ1fIBgHcboUgFPp3NDs7U=;
        b=PpJ1ds0ibaRbqI08l7g0QJVxOcRfNVvJSD7x+Rd1IBwYvU0tkEplfE6Oyzize04RnCfPZh
        lJYUdWpy4+Nm4pOVjs3VNTOBw1THIjfKQY8m/EZ2eNlDbEEd754r+KlAObkWm81T5HcyoH
        AAM9BwNmBGo7IgKy/D3hgk95oyDbP50=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <20230910173536.sc4irdvxlbgigbxo@moria.home.lan>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
 <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
 <20230909224230.3hm4rqln33qspmma@moria.home.lan>
 <CAMuHMdW3waT489ZyUPn-Qp_Nvq_E-N0uimV=iw5Nex+=Tc++xA@mail.gmail.com>
 <20230910163533.ysbcztauujywrbk4@moria.home.lan>
 <CAMuHMdV0VLMKdZbZnWbs8CrO_h-1bx6HW25bnN6Agq+N3PYatQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdV0VLMKdZbZnWbs8CrO_h-1bx6HW25bnN6Agq+N3PYatQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 10, 2023 at 07:26:26PM +0200, Geert Uytterhoeven wrote:
> On Sun, Sep 10, 2023 at 6:35 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> > On Sun, Sep 10, 2023 at 10:19:30AM +0200, Geert Uytterhoeven wrote:
> > > On Sun, Sep 10, 2023 at 12:42 AM Kent Overstreet
> > > <kent.overstreet@linux.dev> wrote:
> > > > On Sat, Sep 09, 2023 at 08:50:39AM -0400, James Bottomley wrote:
> > > > > So why can't we figure out that easier way? What's wrong with trying to
> > > > > figure out if we can do some sort of helper or library set that assists
> > > > > supporting and porting older filesystems. If we can do that it will not
> > > > > only make the job of an old fs maintainer a lot easier, but it might
> > > > > just provide the stepping stones we need to encourage more people climb
> > > > > up into the modern VFS world.
> > > >
> > > > What if we could run our existing filesystem code in userspace?
> > > >
> > > > bcachefs has a shim layer (like xfs, but more extensive) to run nearly
> > > > the entire filesystem - about 90% by loc - in userspace.
> > > >
> > > > Right now this is used for e.g. userspace fsck, but one of my goals is
> > > > to have the entire filesystem available as a FUSE filesystem. I'd been
> > > > planning on doing the fuse port as a straight fuse implementation, but
> > > > OTOH if we attempted a sh vfs iops/aops/etc. -> fuse shim, then we would
> > > > have pretty much everything we need to run any existing fs (e.g.
> > > > reiserfs) as a fuse filesystem.
> > > >
> > > > It'd be a nontrivial project with some open questions (e.g. do we have
> > > > to lift all of bufferheads to userspace?) but it seems worth
> > > > investigating.
> > >
> > >   1. https://xkcd.com/1200/ (not an exact match, but you should get the idea),
> > >   2. Once a file system is removed from the kernel, would the user space
> > >      implementation be maintained better?
> >
> > This would be for the filesystems that aren't getting maintained and
> > tested, to eliminate accidental breakage from in-kernel refactoring and
> > changing of APIs.
> >
> > Getting that code out of the kernel would also greatly help with
> > security concerns.
> 
> OK, xkcd 1200 it is...

A fuse filesystem process can be restricted to only having access to the
device the filesystem is on.

Not so if it's running in the kernel...
