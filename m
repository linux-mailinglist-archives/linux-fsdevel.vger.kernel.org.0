Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18478183BB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 22:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgCLVtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 17:49:07 -0400
Received: from hr2.samba.org ([144.76.82.148]:24712 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgCLVtH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Cc:To:From:Date;
        bh=1JcRWJgIjBZEatikoz0G3mL9EJsdG0P/Ykm3OGVRQo4=; b=M0zd3UDimz2yegwwlZBWRu1Sjm
        Hb2a9sq9I/B2kDBeJsob+VR2XNQaYH9Iy1mlh80tLPM12bcDfMTE7Vl1rQta5McDePT92ZD8iJVx9
        4tIkUFiaXRuJxqXRY1b3LYV5TT9y0Y51MUhnzpAXCmeCh50oytdBZauYcQ24b2HFNK/RLcTAtOrD5
        hTBFgTzdVQ0ofrJuWOVAaffympfy8PogEB8b5bMOrBCYsIUxsV32VOqKq22+55Ix0JZtWjbxJNRV1
        6vDfCbps6fckISnbwkJA83CC45iVr8ot0VEw954sESPpX3S08kajgNhTB7NTflfsu+IYxtRNf86CY
        b+xx302xd92v1CkKTYCFMBwqmCqn0RvpztruQ3/4/poqm41ia+R5OfQLbgustha/L4tkO0VQG5NXK
        fyDcx1FGbGK/vnFmBQd79m7VBcS1nIU1N2SRWXJu2fLt8wJuxfBAzUQjf6/twU2w9n5Gnq5D+R541
        DWEaB6FUBoQZBsoGn8v9YsSo;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1jCVhO-0001fg-IM; Thu, 12 Mar 2020 21:49:02 +0000
Date:   Thu, 12 Mar 2020 14:48:54 -0700
From:   Jeremy Allison <jra@samba.org>
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralph =?iso-8859-1?Q?B=F6hme?= <slow@samba.org>,
        Volker Lendecke <vl@sernet.de>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
Message-ID: <20200312214854.GA19247@jeremy-acer>
Reply-To: Jeremy Allison <jra@samba.org>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin>
 <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk>
 <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
 <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
 <8d24e9f6-8e90-96bb-6e98-035127af0327@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d24e9f6-8e90-96bb-6e98-035127af0327@samba.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 06:11:09PM +0100, Stefan Metzmacher wrote:
> Am 12.03.20 um 17:24 schrieb Linus Torvalds:
> > On Thu, Mar 12, 2020 at 2:08 AM Stefan Metzmacher <metze@samba.org> wrote:
> >>
> >> The whole discussion was triggered by the introduction of a completely
> >> new fsinfo() call:
> >>
> >> Would you propose to have 'at_flags' and 'resolve_flags' passed in here?
> > 
> > Yes, I think that would be the way to go.
> 
> Ok, that's also fine for me:-)
> 
> >>> If we need linkat2() and friends, so be it. Do we?
> >>
> >> Yes, I'm going to propose something like this, as it would make the life
> >> much easier for Samba to have the new features available on all path
> >> based syscalls.
> > 
> > Will samba actually use them? I think we've had extensions before that
> > weren't worth the non-portability pain?
> 
> Yes, we're currently moving to the portable *at() calls as a start.
> And we already make use of Linux only feature for performance reasons
> in other places. Having the new resolve flags will make it possible to
> move some of the performance intensive work into non-linux specific
> modules as fallback.
> 
> I hope that we'll use most of this through io_uring in the end,
> that's the reason Jens added the IORING_REGISTER_PERSONALITY feature
> used for IORING_OP_OPENAT2.
> 
> > But yes, if we have a major package like samba use it, then by all
> > means let's add linkat2(). How many things are we talking about? We
> > have a number of system calls that do *not* take flags, but do do
> > pathname walking. I'm thinking things like "mkdirat()"?)
> 
> I haven't looked them up in detail yet.
> Jeremy can you provide a list?

Fixing the flags argument on fchmodat() to actually *implement*
AT_SYMLINK_NOFOLLOW would be a good start :-).

As for the syscalls that don't have
flags I'm thinking of the things like:

getxattr/setxattr/removexattr just off the top of my head.

Jeremy.
