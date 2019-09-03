Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1978BA7768
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 01:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfICXDg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 19:03:36 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52781 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726440AbfICXDf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 19:03:35 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-96.corp.google.com [104.133.0.96] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x83N3PY0026192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Sep 2019 19:03:26 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0FD5242049E; Tue,  3 Sep 2019 19:03:25 -0400 (EDT)
Date:   Tue, 3 Sep 2019 19:03:25 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Qian Cai <cai@lca.pw>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: "beyond 2038" warnings from loopback mount is noisy
Message-ID: <20190903230324.GI2899@mit.edu>
References: <1567523922.5576.57.camel@lca.pw>
 <CABeXuvoPdAbDr-ELxNqUPg5n84fubZJZKiryERrXdHeuLhBQjQ@mail.gmail.com>
 <20190903211747.GD2899@mit.edu>
 <CABeXuvoYh0mhg049+pXbMqh-eM=rw+Ui1=rDree4Yb=7H7mQRg@mail.gmail.com>
 <CAK8P3a0AcPzuGeNFMW=ymO0wH_cmgnynLGYXGjqyrQb65o6aOw@mail.gmail.com>
 <20190903223815.GH2899@mit.edu>
 <CABeXuvp2F4cr_77UJDYVfQ=gD8QXn+t4X3Qxs6YbyMXYJYO7mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABeXuvp2F4cr_77UJDYVfQ=gD8QXn+t4X3Qxs6YbyMXYJYO7mg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 03:47:54PM -0700, Deepa Dinamani wrote:
> > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > index 9e3ae3be3de9..5a971d1b6d5e 100644
> > > --- a/fs/ext4/ext4.h
> > > +++ b/fs/ext4/ext4.h
> > > @@ -835,7 +835,9 @@ do {
> > >                                  \
> > >                 }
> > >          \
> > >         else    {\
> > >                 (raw_inode)->xtime = cpu_to_le32(clamp_t(int32_t,
> > > (inode)->xtime.tv_sec, S32_MIN, S32_MAX));    \
> > > -               ext4_warning_inode(inode, "inode does not support
> > > timestamps beyond 2038"); \
> > > +               if (((inode)->xtime.tv_sec != (raw_inode)->xtime) &&     \
> > > +                   ((inode)->i_sb->s_time_max > S32_MAX))
> > >          \
> > > +                       ext4_warning_inode(inode, "inode does not
> > > support timestamps beyond 2038"); \
> > >         } \
> > >  } while (0)
> >
> > Sure, that's much less objectionable.
> 
> The reason it was warning for every update was because of the
> ratelimiting. I think ratelimiting is not working well here. I will
> check that part.

If you are calling ext4_warning_inode() on every single update, you
really can't depend on rate limiting to prevent log spam.  The problem
is sometimes we *do* need more than say, one ext4 warning every hour.
Rate limiting is a last-ditch prevention against an unintentional
denial of service attack against the system, but we can't depend on it
as license to call ext4_warning() every time we set a timestamp.  That
happens essentially constantly on a running system.  So if you set the
limits aggressively enough that it's not seriously annoying, it will
suppress all other potential uses of ext4_warning() --- essentially,
it will make ext4_warning useless.

The other concern I would have if that warning message is being
constantly called, post 2038, is that even *with* rate limiting, it
will turn into a massive scalability bottleneck --- remember, the
ratelimit structure has a spinlock, so even if you are suppressing
things so that we're only logging one message an hour, if it's being
called hundreds of times a second from multiple CPU's, the cache line
thrashing will make this to be a performance *nightmare*.

		       	    	       - Ted
