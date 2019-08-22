Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53E5599650
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 16:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbfHVOWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 10:22:04 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49646 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728042AbfHVOWE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:22:04 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7MELgVm006640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Aug 2019 10:21:43 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7F9C942049E; Thu, 22 Aug 2019 10:21:42 -0400 (EDT)
Date:   Thu, 22 Aug 2019 10:21:42 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Gao Xiang <hsiangkao@aol.com>, Richard Weinberger <richard@nod.at>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: erofs: Question on unused fields in on-disk structs
Message-ID: <20190822142142.GB2730@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Gao Xiang <hsiangkao@aol.com>, Richard Weinberger <richard@nod.at>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1323459733.69859.1566234633793.JavaMail.zimbra@nod.at>
 <20190819204504.GB10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAFLxGvxr2UMeVa29M9pjLtWMFPz7w6udRV38CRxEF1moyA9_Rw@mail.gmail.com>
 <20190821220251.GA3954@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAFLxGvzLPgD22pVOV_jz1EvC-c7YU_2dEFbBt4q08bSkZ3U0Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvzLPgD22pVOV_jz1EvC-c7YU_2dEFbBt4q08bSkZ3U0Dg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 22, 2019 at 10:33:01AM +0200, Richard Weinberger wrote:
> > super block chksum could be a compatible feature right? which means
> > new kernel can support it (maybe we can add a warning if such image
> > doesn't have a chksum then when mounting) but old kernel doesn't
> > care it.
> 
> Yes. But you need some why to indicate that the chksum field is now
> valid and must be used.
> 
> The features field can be used for that, but you don't use it right now.
> I recommend to check it for being 0, 0 means then "no features".
> If somebody creates in future a erofs with more features this code
> can refuse to mount because it does not support these features.

The whole point of "compat" features is that the kernel can go ahead
and mount the file system even if there is some new "compat" feature
which it doesn't understand.  So the fact that right now erofs doesn't
have any "compat" features means it's not surprising, and perfectly
OK, if it's not referenced by the kernel.

For ext4, we have some more complex feature bitmasks, "compat",
"ro_compat" (OK to mount read-only if there are features you don't
understand) and "incompat" (if there are any bits you don't
understand, fail the mount).  But since erofs is a read-only file
system, things are much simpler.

It might make life easier for other kernel developers if "features"
was named "compat_features" and "requirements" were named
"incompat_features", just because of the long-standing use of that in
ext2, ext3, ext4, ocfs2, etc.  But that naming scheme really is a
legacy of ext2 and its descendents, and there's no real reason why it
has to be that way on other file systems.

Cheers,

						- Ted
