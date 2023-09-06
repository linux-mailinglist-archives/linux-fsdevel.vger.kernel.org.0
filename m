Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D747479338C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 04:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjIFCJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 22:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjIFCJq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:09:46 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D00DA
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 19:09:41 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68c576d35feso2663819b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Sep 2023 19:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1693966181; x=1694570981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTAsNdwvWKWydIi6ckbpeAxwOPtaF/pZ8rx8qyYY7/o=;
        b=yqx+Gd3/fIngBz1n7zcBPDh1VC+PfPB1d6XfKXsDn21md+O0iYNrJZzvBctv02TQQo
         9gnzycPuRcki89TTGr8rGI/TxfuBP+AvO/Sf3e5Mj39T/SA5KpT5SL8uy3NXo/kXE33Y
         FVl+RSun1CXvcAy2zCJUgsnio4w8wfDoP4NvL4Nx6bU1Mc8ccwUZOpdNDdarjaF2s9Zx
         92vdvaRj+c2/uCG+VR0NHfQETqGZ5OGJNGNjD8eOV/7FnAbvokrIoOUsjUewCZrM2b+T
         VpjGDCVPM4puzCAA8QCckds6MfFRdWkL71JXjKBFDY271iuKLhF4TTGabBxrggMWLI2A
         qTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693966181; x=1694570981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTAsNdwvWKWydIi6ckbpeAxwOPtaF/pZ8rx8qyYY7/o=;
        b=ViGbV46rWo5A0si7zo65EHW+vsavrOWNd1M8hheaWJMy4kvJPSzbLaTiebujxgzMHl
         59iWsrFnfC2p4XCW5eYMU/VDPwnEaa5srG54f6FtMrjhaPukInxT/kRdliEY3j6HLOJG
         4/6Hae5h4giO5ShuFIFwKyH++vOtI4NOdbe8+C/FmZt3hw4EaCG95QHG5wOMk/d8DVUf
         OFL3TrFMBDFv3iTZzQOMGhT7sb62l/KX4pCcxAdVWX30yJemZfYe22U6SXuFU/j1i3q6
         c1Hs3F1ysF99e8pfemuOSyBpad/1cHPkP2A7lTsE40KGr9GQwBekfmquFub85RBQvhTw
         jIvg==
X-Gm-Message-State: AOJu0YwAdcBibHeo04DO3lkgeG1lTVwCIAqepnl3eOA65TMzG9OetpIg
        AWC1zf9K94nAFeWtMfBiYrqkx9lfbz4yqvpPvP0=
X-Google-Smtp-Source: AGHT+IFmUaraMZ1t8x+DsaWyFvo4m03+6GwPdceP7NlcXUTFXpVhHid9k7dYdde9VPP2wSfXks5QMw==
X-Received: by 2002:a05:6a21:19e:b0:152:375d:ceea with SMTP id le30-20020a056a21019e00b00152375dceeamr10769086pzb.15.1693966181390;
        Tue, 05 Sep 2023 19:09:41 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id 25-20020aa79119000000b0068878437b9dsm9723646pfh.50.2023.09.05.19.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 19:09:40 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qdhz7-00BOnk-2K;
        Wed, 06 Sep 2023 12:09:37 +1000
Date:   Wed, 6 Sep 2023 12:09:37 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZPffYYnVMIkuCK9x@dread.disaster.area>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 12:23:22AM +0100, Matthew Wilcox wrote:
> On Wed, Sep 06, 2023 at 09:06:21AM +1000, Dave Chinner wrote:
> > > Part 2: unmaintained file systems
> > > 
> > > A lot of our file system drivers are either de facto or formally
> > > unmaintained.  If we want to move the kernel forward by finishing
> > > API transitions (new mount API, buffer_head removal for the I/O path,
> > > ->writepage removal, etc) these file systems need to change as well
> > > and need some kind of testing.  The easiest way forward would be
> > > to remove everything that is not fully maintained, but that would
> > > remove a lot of useful features.
> > 
> > Linus has explicitly NACKed that approach.
> > 
> > https://lore.kernel.org/linux-fsdevel/CAHk-=wg7DSNsHY6tWc=WLeqDBYtXges_12fFk1c+-No+fZ0xYQ@mail.gmail.com/
> > 
> > Which is a problem, because historically we've taken code into
> > the kernel without requiring a maintainer, or the people who
> > maintained the code have moved on, yet we don't have a policy for
> > removing code that is slowly bit-rotting to uselessness.
> > 
> > > E.g. the hfsplus driver is unmaintained despite collecting odd fixes.
> > > It collects odd fixes because it is really useful for interoperating
> > > with MacOS and it would be a pity to remove it.  At the same time
> > > it is impossible to test changes to hfsplus sanely as there is no
> > > mkfs.hfsplus or fsck.hfsplus available for Linux.  We used to have
> > > one that was ported from the open source Darwin code drops, and
> > > I managed to get xfstests to run on hfsplus with them, but this
> > > old version doesn't compile on any modern Linux distribution and
> > > new versions of the code aren't trivially portable to Linux.
> > > 
> > > Do we have volunteers with old enough distros that we can list as
> > > testers for this code?  Do we have any other way to proceed?
> > >
> > > If we don't, are we just going to untested API changes to these
> > > code bases, or keep the old APIs around forever?
> > 
> > We do slowly remove device drivers and platforms as the hardware,
> > developers and users disappear. We do also just change driver APIs
> > in device drivers for hardware that no-one is actually able to test.
> > The assumption is that if it gets broken during API changes,
> > someone who needs it to work will fix it and send patches.
> > 
> > That seems to be the historical model for removing unused/obsolete
> > code from the kernel, so why should we treat unmaintained/obsolete
> > filesystems any differently?  i.e. Just change the API, mark it
> > CONFIG_BROKEN until someone comes along and starts fixing it...
> 
> Umm.  If I change ->write_begin and ->write_end to take a folio,
> convert only the filesystems I can test via Luis' kdevops and mark the
> rest as CONFIG_BROKEN, I can guarantee you that Linus will reject that
> pull request.

No, that's not what I was suggesting. I suggest that we -change all
the API users when we need to, but in doing so we also need to 
formalise the fact we do not know if the filesystems nobody can/will
maintain function correctly or not.

Reflect that with CONFIG_BROKEN or some other mechanism that
forces people to acknowledge that the filesystem implementation is
not fit for purpose before they attempt to use it. e.g.
write some code that emits a log warning about the filesystem being
unmaintained at mount time and should not be used in situations
where stability, security or data integrity guarantees are required.

> I really feel we're between a rock and a hard place with our unmaintained
> filesystems.  They have users who care passionately, but not the ability
> to maintain them.

Well, yes. IMO, it is even worse to maintain the lie that these
unmaintained filesystems actually work correctly. Just because it's
part of the kernel it doesn't mean it is functional or that users
should be able to trust that it will not lose their data...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
