Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7CC3C8871
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 18:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhGNQQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 12:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230376AbhGNQQo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:16:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECE29613C0;
        Wed, 14 Jul 2021 16:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626279233;
        bh=HI5u/Es/9wk3Oi88zx/8bXgd16HbCm3oOopbQkfK+nM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FV8mtNn5u6l3tzogn20zvgjsa3KdRB5K0X9yw41SuAzxA1Abikp5QapS69hyfOTEU
         meSQ4TknL6uJu+VMsPnpI+7f9Cd0k6S3l2sy4x+r6LLr0ESzjaW1O2lH/kCVjn3A9K
         nroSwHsv7oKre7DOae9ocx8eCank0vSIy0C66bWqrjD8/BSsik9vMqddG2I9dkjmmb
         yhqN1k3AjJ2kgFMHXlpduy4nKuKv9PFa5CcPENbtJ0A7i4zIFcWXnK9G8P/mjVQxrR
         kvRhaY0V/IjJuLUrUZtjovkpCldn+wsoW/WfmApRvo3hdVCCoJWfn1Q1JemtLqDtR5
         MOoawvSZWhRLQ==
Date:   Wed, 14 Jul 2021 09:13:52 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Message-ID: <20210714161352.GA22357@magnolia>
References: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
 <CAHk-=wjW7Up3KD-2EqVg7+ca8Av0-rC5Kd7yK+=m6Dwk3D4Q+A@mail.gmail.com>
 <YO30DKw5FKLz4QuF@zeniv-ca.linux.org.uk>
 <bea2bcf2-02f6-f247-9e06-7b9ec154377a@gmail.com>
 <YO755O8JnxG44YaT@kroah.com>
 <7f4a96bc-3912-dfb6-4a32-f0c6487d977b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f4a96bc-3912-dfb6-4a32-f0c6487d977b@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 05:59:19PM +0200, Rafał Miłecki wrote:
> On 14.07.2021 16:51, Greg KH wrote:
> > On Wed, Jul 14, 2021 at 12:50:08PM +0200, Rafał Miłecki wrote:
> > > Hi Alexander,
> > > 
> > > On 13.07.2021 22:14, Al Viro wrote:
> > > > To elaborate a bit - there's one case when I want it to go through
> > > > vfs.git, and that's when there's an interference between something
> > > > going on in vfs.git and the work done in filesystem.  Other than
> > > > that, I'm perfectly fine with maintainer sending pull request directly
> > > > to Linus (provided that I hadn't spotted something obviously wrong
> > > > in the series, of course, but that's not "I want it to go through
> > > > vfs.git" - that's "I don't want it in mainline until such and such
> > > > bug is resolved").
> > > 
> > > let me take this opportunity to ask about another filesystem.
> > > 
> > > Would you advise to send pull req for the fs/ntfs3 directly to Linus?
> > > 
> > > That is a pending filesystem that happens to be highly expected by many
> > > Linux focused communities.
> > > 
> > > 
> > > Paragon Software GmbH proved it's commitment by sending as many as 26
> > > versions on it's patchset. The last set was send early April:
> > > 
> > > [PATCH v26 00/10] NTFS read-write driver GPL implementation by Paragon Software
> > > https://marc.info/?l=linux-fsdevel&m=161738417018673&q=mbox
> > > https://patchwork.kernel.org/project/linux-fsdevel/list/?series=460291
> > > 
> > > 
> > > I'd say there weren't any serious issues raised since then.
> > > 
> > > One Tested-by, one maintenance question, one remainder, one clang-12
> > > issue [0] [1].
> > > 
> > > It seems this filesystem only needs:
> > > 1. [Requirement] Adjusting to the meanwhile changed iov API [2]
> > > 2. [Clean up] Using fs/iomap/ helpers [3]
> > 
> > Why haven't those things been done and the patches resubmitted for
> > review?  Nothing we can do from our side when the developers don't want
> > to submit a new series, right?
> 
> The real issue (broken compilation) has been pointed out 2 days ago and
> is a result of a more recent commit. For months filesystem could be
> pushed but it wasn't for unknown reason.
> 
> As for fs/iomap/ helpers it's unclear to me if that is really required
> or could be worked on later as a clean up. Darrick joked his opinion on
> using those helper is biased.

Porting to fs/iomap can be done after merge, so long as the ntfs3
driver doesn't depend on crazy reworking of buffer heads or whatever.
AFAICT it didn't, so ... yes, my earlier statements still apply: "later
as a clean up".

That said, I /really would/ like answers to the questions I posted here
about how well their fs driver fares while running fstests, since that's
probably the only way for community developers to ensure they don't
accidentally bitrot the driver into disk corruption land.

--D

[1] https://lore.kernel.org/linux-fsdevel/20210520161325.GA9625@magnolia/

> In short I'd say: missing feedback.
