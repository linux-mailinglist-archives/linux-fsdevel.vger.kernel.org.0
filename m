Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06446BE0D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 17:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbfIYPIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 11:08:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58412 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727297AbfIYPIx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:08:53 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8PF8WXY009959
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Sep 2019 11:08:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3B2284200BF; Wed, 25 Sep 2019 11:08:32 -0400 (EDT)
Date:   Wed, 25 Sep 2019 11:08:32 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Colin Walters <walters@verbum.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Omar Sandoval <osandov@osandov.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH 2/3] fs: add RWF_ENCODED for writing compressed data
Message-ID: <20190925150832.GA20227@mit.edu>
References: <cover.1568875700.git.osandov@fb.com>
 <230a76e65372a8fb3ec62ce167d9322e5e342810.1568875700.git.osandov@fb.com>
 <CAG48ez2GKv15Uj6Wzv0sG5v2bXyrSaCtRTw5Ok_ovja_CiO_fQ@mail.gmail.com>
 <20190924171513.GA39872@vader>
 <20190924193513.GA45540@vader>
 <CAG48ez1NQBNR1XeVQYGoopEk=g_KedUr+7jxLQTaO+V8JCeweQ@mail.gmail.com>
 <20190925071129.GB804@dread.disaster.area>
 <60c48ac5-b215-44e1-a628-6145d84a4ce3@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c48ac5-b215-44e1-a628-6145d84a4ce3@www.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 25, 2019 at 08:07:12AM -0400, Colin Walters wrote:
> 
> 
> On Wed, Sep 25, 2019, at 3:11 AM, Dave Chinner wrote:
> >
> > We're talking about user data read/write access here, not some
> > special security capability. Access to the data has already been
> > permission checked, so why should the format that the data is
> > supplied to the kernel in suddenly require new privilege checks?
> 
> What happens with BTRFS today if userspace provides invalid
> compressed data via this interface?  Does that show up as filesystem
> corruption later?  If the data is verified at write time, wouldn't
> that be losing most of the speed advantages of providing
> pre-compressed data?

Not necessarily, most compression algorithms are far more expensive to
compress than to decompress.

If there is a buggy decompressor, it's possible that invalid data
could result in a buffer overrun.  So that's an argument for verifying
the compressed code at write time.  OTOH, the verification could be
just as vulnerability to invalid data as the decompressor, so it
doesn't buy you that much.

> Ability for a user to cause fsck errors later would be a new thing
> that would argue for a privilege check I think.

Well, if it's only invalid data in a user file, there's no reason why
it should cause the kernel declare that the file system is corrupt; it
can just return EIO.

What fsck does is a different question, of course; it might be that
the fsck code isn't going to check compressed user data.  After all,
if all of the files on the file system are compressed, requiring fsck
to check all compressed data blocks is tantamount to requiring it to
read all of the blocks in the file system.  Much better would be some
kind of online scrub operation which validates data files while the
file system is mounted and the system can be in a serving state.

						- Ted
