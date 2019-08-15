Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB0E8F50B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 21:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733177AbfHOTqi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 15:46:38 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39855 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733171AbfHOTqh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:46:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id 125so2798256qkl.6;
        Thu, 15 Aug 2019 12:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdkqCNrsYGZD/efIVrpgf4pItvwMxmRiBzolCMfFZmI=;
        b=QCa/Cdo4uDI2awDb2aD6tAFyu11TJDCYhTcqQbD8Xo6Symdikzf7+T+rvJtn31iMfg
         FU1TEjcJum2g9L01GfgAFpeDSjj363lsonsh/bMa1pqmEt2eefHR2V/OVF0JBvBtWYJR
         1K3OlC5F2z9JKHOHkMoc+6iJLoeM3tyCMt3ABZTHv6uEn2lKDvyxNTp22ZGLbpvnpR+f
         7VK2/tkDQMNkQ3DTUEeGaocILjz2PqB9Nd+LH73ITfyV5/ESNQ0mhXppbK/xpRv2duIX
         X4Ua5OqSCikh38vaYWVVOTkaoCDewiou1r2MKg/KKlKltUSWjFhYURD3Os4hApAfy9jt
         EjZw==
X-Gm-Message-State: APjAAAW8h6hAksu+q45zOEHNOm9byTP9rNF5LYjLBUFh8riv0v8ItSbF
        SeQGSFvMJHK5ZI5+c1WpQn7zsZkAah6F/h5q+aE=
X-Google-Smtp-Source: APXvYqy13T7uVMDYpTqi18IlN7TrofLdgzVCO7AjQuCbroE3LCMOg++BJL4RQskx1N+5yUUInsGdvvlV44WsYbx1mWQ=
X-Received: by 2002:a05:620a:b:: with SMTP id j11mr5687756qki.352.1565898396389;
 Thu, 15 Aug 2019 12:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190814204259.120942-1-arnd@arndb.de> <20190814204259.120942-2-arnd@arndb.de>
 <20190814213753.GP6129@dread.disaster.area> <20190815071314.GA6960@infradead.org>
 <CAK8P3a2Hjfd49XY18cDr04ZpvC5ZBGudzxqpCesbSsDf1ydmSA@mail.gmail.com>
 <20190815080211.GA17055@infradead.org> <20190815102649.GA10821@infradead.org>
 <20190815121511.GR6129@dread.disaster.area> <20190815140355.GA11012@infradead.org>
 <CAK8P3a1iNu7m=gy-NauXVBky+cBk8TPWwfWXO4gSw1mRPJefJA@mail.gmail.com> <20190815192827.GE15186@magnolia>
In-Reply-To: <20190815192827.GE15186@magnolia>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 15 Aug 2019 21:46:20 +0200
Message-ID: <CAK8P3a2XCKF2W3ktF+DBeatarA_ALoVuGh=qGaNA+PqX1OSBog@mail.gmail.com>
Subject: Re: [PATCH v5 01/18] xfs: compat_ioctl: use compat_ptr()
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        Nick Bowler <nbowler@draconx.ca>,
        Eric Sandeen <sandeen@sandeen.net>,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 9:28 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Thu, Aug 15, 2019 at 09:20:32PM +0200, Arnd Bergmann wrote:
> > On Thu, Aug 15, 2019 at 4:04 PM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Thu, Aug 15, 2019 at 10:15:12PM +1000, Dave Chinner wrote:
> > > > > http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/xfs-ioctl-table
> > > >
> > > > Lots to like in that handful of patches. :)
> > > >
> > > > It can easily go before or after Arnd's patch, and the merge
> > > > conflict either way would be minor, so I'm not really fussed either
> > > > way this gets sorted out...
> > >
> > > The other thing we could do is to just pick the two important ones:
> > >
> > > http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/xfs-ioctl-table-5.3
> > >
> > > and throw that into Arnds series, or even 5.3, and then defer the
> > > table thing until later.
> >
> > If we can have your "xfs: fall back to native ioctls for unhandled compat
> > ones" in 5.3, that would be ideal from my side, then I can just drop the
> > corresponding patch from my series and have the rest merged for 5.4.
> >
> > The compat_ptr addition is independent of my series, I just added it
> > because I noticed it was missing, so we can merged that through
> > the xfs tree along with your other changes, either for 5.3 or 5.4.
>
> Er... do the two patches in the -5.3 branch actually fix something
> that's broken?  I sense s390 is missing a pointer sanitization check or
> something...?

s390 is indeed missing the pointer conversion, the other patch
adds compat ioctl support for FS_IOC_GETFSLABEL and
FS_IOC_SETFSLABEL, which were missing, and it ensures that
FITRIM keeps working after I remove it from the list in
fs/compat_ioctl.c

       Arnd
