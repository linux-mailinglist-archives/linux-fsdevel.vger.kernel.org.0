Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353952746DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 18:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgIVQlZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 12:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgIVQlZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:41:25 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FB9A20738;
        Tue, 22 Sep 2020 16:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600792885;
        bh=wx7/YLK1ta9vM++KObo0xxZNA7B0+eewl8ef4mZwaH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a6xfYEsPLF+w/j7MqYQRQIrhEjibJe8SdxHSdoWvy+pTWxHSiD98qv696yvp1b3Oj
         LEZ2U0GOcK1ai0TvvilNXX7AwmAHX5FbyEI6p+WJcZymFzgNcHLR15HggAsM2hSnw2
         4TAStKThe1Lw6dXhrpv5JLa9WRv/FMbWpMp2YLTA=
Date:   Tue, 22 Sep 2020 09:41:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Daeho Jeong <daeho43@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: don't unnecessarily clone write access for
 writable fds
Message-ID: <20200922164123.GA9538@sol.localdomain>
References: <20200611160534.55042-1-ebiggers@kernel.org>
 <20200629165014.GA20492@sol.localdomain>
 <20200916035914.GA825@sol.localdomain>
 <20200917005441.GP3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917005441.GP3421308@ZenIV.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 01:54:41AM +0100, Al Viro wrote:
> On Tue, Sep 15, 2020 at 08:59:14PM -0700, Eric Biggers wrote:
> > On Mon, Jun 29, 2020 at 09:50:14AM -0700, Eric Biggers wrote:
> > > On Thu, Jun 11, 2020 at 09:05:34AM -0700, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > There's no need for mnt_want_write_file() to increment mnt_writers when
> > > > the file is already open for writing, provided that
> > > > mnt_drop_write_file() is changed to conditionally decrement it.
> > > > 
> > > > We seem to have ended up in the current situation because
> > > > mnt_want_write_file() used to be paired with mnt_drop_write(), due to
> > > > mnt_drop_write_file() not having been added yet.  So originally
> > > > mnt_want_write_file() had to always increment mnt_writers.
> > > > 
> > > > But later mnt_drop_write_file() was added, and all callers of
> > > > mnt_want_write_file() were paired with it.  This makes the compatibility
> > > > between mnt_want_write_file() and mnt_drop_write() no longer necessary.
> 
> Umm...  That really needs to be put into D/f/porting; this kind of rule changes
> (from "it used to work both ways" to "things quietly break if you use the
> old variant") should come with explicit statement in there.
> 
> I'm certainly fine with unexporting mnt_clone_write() and making the damn
> thing static, but as for the rest I would put an explicit "don't pair
> mnt_drop_write() with mnt_want_write_file()" and wait for a cycle.

Is there any point in waiting a cycle between adding the note to
Documentation/filesystems/porting.rst and making the behavior change?  It seems
that all the other notes just get added at the same time the change is made.

- Eric
