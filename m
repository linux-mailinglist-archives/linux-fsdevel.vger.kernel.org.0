Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEA9BE882
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 00:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbfIYWww (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 18:52:52 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:56809 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729604AbfIYWww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 18:52:52 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A96B2362AFF;
        Thu, 26 Sep 2019 08:52:44 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iDG9L-0006ca-Lw; Thu, 26 Sep 2019 08:52:43 +1000
Date:   Thu, 26 Sep 2019 08:52:43 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Colin Walters <walters@verbum.org>
Cc:     Jann Horn <jannh@google.com>, Omar Sandoval <osandov@osandov.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH 2/3] fs: add RWF_ENCODED for writing compressed data
Message-ID: <20190925225243.GF804@dread.disaster.area>
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
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
        a=7-415B0cAAAA:8 a=ao4zJSXK-2lq-feLaEsA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
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
> What happens with BTRFS today if userspace provides invalid compressed
> data via this interface?

Then the filesystem returns EIO or ENODATA on read because it can't
decompress it.

User can read it back in compressed format (i.e. same way they wrote
it), try to fix it themselves.

> Does that show up as filesystem corruption later?

Nope. Just bad user data.

> If the data is verified at write time, wouldn't that be losing most of the speed advantages of providing pre-compressed data?

It's a direct IO interface. User writes garbage, then they get
garbage back. The user can still retreive the compressed data
directly, so the data is not lost....

> Ability for a user to cause fsck errors later would be a new thing
> that would argue for a privilege check I think.

fsck doesn't validate the correctness of user data - it validates
the filesystem structure is consistent. i.e. user data in unreadable
format != corrupt filesystem structure.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
