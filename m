Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B08536239F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 17:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343565AbhDPPQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 11:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245607AbhDPPPe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:15:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBE5C061760
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 08:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PU2zCwS/Qv6b1mmm7MYSjXwyl88SOWkJFLmy1YTNvpE=; b=fr40blTGBi0mReACgRFRj3i5CK
        EQVXGvjjGqbONfxml7WrtbWkmAR4pV7AI/4ul9rsLP9yYLxFrEuJ6+2uOQ75IcyAkOdMTov9veWaD
        KO0ebU/XHJl8QPmWTTWgKjhMURNQYfp5LmHzTPfiY2rmN8vRYt9ZXhz+xMntJBA4GHmGybJfjFiAc
        USk7WVZoRGmJWCuraGfL+yNV0WfiXlU758/v1mNHGvbeR0E8zXF8VGCaGoisiToPVW5UwYagLh4J/
        ZvABEcJUcduS3tuupbWnYaELU62BS6CI+hST0lNV2ryMHXdkMg9hOkyzeE2k6ebcT9Cldi8ZJjd/W
        jX4V0jKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXQAX-00A6WF-Pv; Fri, 16 Apr 2021 15:14:07 +0000
Date:   Fri, 16 Apr 2021 16:14:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
Message-ID: <20210416151405.GK2531743@casper.infradead.org>
References: <20210327135659.GH1719932@casper.infradead.org>
 <CAOg9mSRCdaBfLABFYvikHPe1YH6TkTx2tGU186RDso0S=z-S4A@mail.gmail.com>
 <20210327155630.GJ1719932@casper.infradead.org>
 <CAOg9mSSxrPEd4XsWseMOnpMGzDAE5Pm0YHcZE7gBdefpsReRzg@mail.gmail.com>
 <CAOg9mSSaDsEEQD7cwbsCi9WA=nSAD78wSJV_5Gu=Kc778z57zA@mail.gmail.com>
 <1720948.1617010659@warthog.procyon.org.uk>
 <CAOg9mSTEepP-BjV85dOmk6hbhQXYtz2k1y5G1RbN9boN7Mw3wA@mail.gmail.com>
 <CAOg9mSQTRfS1Wyd_ULbN8cS7FstH9ix-um9ZeKLa2O=xLgF+-Q@mail.gmail.com>
 <1268214.1618326494@warthog.procyon.org.uk>
 <CAOg9mSSxZUwZ0-OdCfb7gLgETkCJOd-9PCrpqWwzqXffwMSejA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOg9mSSxZUwZ0-OdCfb7gLgETkCJOd-9PCrpqWwzqXffwMSejA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:36:52AM -0400, Mike Marshall wrote:
> So... I think all your stuff is working well from my perspective
> and that I need to figure out why my orangefs_readahead patch
> is causing the regressions I listed. My readahead implementation (via your
> readahead_expand) is really fast, but it is bare-bones... I'm probably
> leaving out some important stuff... I see other filesystem's
> readahead implementations doing stuff like avoiding doing readahead
> on pages that have yet to be written back for example.

You do?!  Actual readahead implementations, or people still implementing
the old ->readpages() method?  The ->readahead() method is _only_ called
for pages which are freshly allocated, Locked and !Uptodate.  If you ever
see a page which is Dirty or Writeback, something has gone very wrong.
Could you tell me which filesystem you saw that bogosity in?

> The top two commits at https://github.com/hubcapsc/linux/tree/readahead_v3
> is the current state of my readahead implementation.
> 
> Please do add
> Tested-by: Mike Marshall <hubcap@omnibond.com>
> 
> -Mike
> 
> On Tue, Apr 13, 2021 at 11:08 AM David Howells <dhowells@redhat.com> wrote:
> >
> > Mike Marshall <hubcap@omnibond.com> wrote:
> >
> > > Hi David... I've been gone on a motorcycle adventure,
> > > sorry for the delay... here's my public branch...
> > >
> > > https://github.com/hubcapsc/linux/tree/readahead_v3
> >
> > That seems to have all of my fscache-iter branch in it.  I thought you'd said
> > you'd dropped them because they were causing problems.
> >
> > Anyway, I've distilled the basic netfs lib patches, including the readahead
> > expansion patch and ITER_XARRAY patch here:
> >
> >         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-lib
> >
> > if that's of use to you?
> >
> > If you're using any of these patches, would it be possible to get a Tested-by
> > for them that I can add?
> >
> > David
> >
