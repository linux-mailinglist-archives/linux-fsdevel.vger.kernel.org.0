Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABDC36CDA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 23:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbhD0VDD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 17:03:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239374AbhD0VDB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 17:03:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28CB461076;
        Tue, 27 Apr 2021 21:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619557337;
        bh=ZyEFO0UZmtzRXpGPw4m+WSG2Cik+Q2X0pU40CBrGO/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cm7Xwhk9OLG/dXXM9XBXe6Fm4chKaGqilEKkQvvtoaSjW0wSmrwv35Rp3FriZO9FI
         MPSoV4ynnCS1BSbADyTAV8ejf8XzfwmYS9QxIz7QoYGBMSfwaUKxnwfA9FFt5bbHhq
         SJ4jR1ceDMkXK1IFHuLK5+MNWUih3zg0myLcjbhX6UwX1gFNfUHCDGVbbif8Fc7qJq
         JHktRJ0NvwakH9tnpae24ebgMT8T6C5sqx0wXBR2a2BC/W0zSWS4nNWfmIDnZMnQFo
         6LoWrFhGn3U/IkRSAl43nXmc8XA4UxRcdT8CC1mbdNjUDHqW7f70AXRX1bu1CIFHC/
         oSVoYN4uqzkQA==
Date:   Tue, 27 Apr 2021 14:02:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Eryu Guan <eguan@linux.alibaba.com>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 3/3] Use --yes option to lvcreate
Message-ID: <YIh719wtNOiipwc3@gmail.com>
References: <20210427164419.3729180-1-kent.overstreet@gmail.com>
 <20210427164419.3729180-4-kent.overstreet@gmail.com>
 <20210427170339.GA9611@e18g06458.et15sqa>
 <YIh0Iy+BiY4zzhB1@moria.home.lan>
 <20210427204319.GD235567@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427204319.GD235567@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 09:43:19PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 27, 2021 at 04:29:23PM -0400, Kent Overstreet wrote:
> > On Wed, Apr 28, 2021 at 01:03:39AM +0800, Eryu Guan wrote:
> > > On Tue, Apr 27, 2021 at 12:44:19PM -0400, Kent Overstreet wrote:
> > > > This fixes spurious test failures caused by broken pipe messages.
> > > > 
> > > > Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> > > > ---
> > > >  tests/generic/081 | 2 +-
> > > >  tests/generic/108 | 2 +-
> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/tests/generic/081 b/tests/generic/081
> > > > index 5dff079852..26702007ab 100755
> > > > --- a/tests/generic/081
> > > > +++ b/tests/generic/081
> > > > @@ -70,7 +70,7 @@ _scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1
> > > >  $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
> > > >  # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
> > > >  # (like 2.02.95 in RHEL6) don't support --yes option
> > > > -yes | $LVM_PROG lvcreate -L 256M -n $lvname $vgname >>$seqres.full 2>&1
> > > > +$LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1
> > > 
> > > Please see above comments, we use yes pipe intentionally. I don't see
> > > how this would result in broken pipe. Would you please provide more
> > > details? And let's see if we could fix the broken pipe issue.
> > 
> > If lvcreate never ask y/n - never reads from standard input, then echo sees a
> > broken pipe when it tries to write. That's what I get without this patch.
> 
> I think it's something in how ktest sets up the environment.  I also see
> the SIGPIPEs when using your ktest scripts, but not when ssh'ing into
> the guest and running the test.
> 
> What that thing is, I don't know.  I'm not tall enough to understand
> signal handling.

See xfstests commit 9bcb266cd778 ("generic/397: be compatible with ignored
SIGPIPE") for an example of the same problem being fixed in another test, with
some more explanation.

But it's better to just not execute xfstests (or any shell script, for that
matter) in an environment where SIGPIPE is ignored.

- Eric
