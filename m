Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B08E1073
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 05:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbfJWDRQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 23:17:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47212 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfJWDRQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 23:17:16 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iN795-0007Lx-Tp; Wed, 23 Oct 2019 03:17:12 +0000
Date:   Wed, 23 Oct 2019 04:17:11 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v6 11/43] compat_ioctl: move drivers to compat_ptr_ioctl
Message-ID: <20191023031711.GA26530@ZenIV.linux.org.uk>
References: <20191009190853.245077-1-arnd@arndb.de>
 <20191009191044.308087-11-arnd@arndb.de>
 <20191022043451.GB20354@ZenIV.linux.org.uk>
 <CAK8P3a1C=skow522Ge7w=ya2hK8TPS8ncusdyX-Ne4GBWB1H4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1C=skow522Ge7w=ya2hK8TPS8ncusdyX-Ne4GBWB1H4A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 22, 2019 at 12:26:09PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 22, 2019 at 6:34 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Wed, Oct 09, 2019 at 09:10:11PM +0200, Arnd Bergmann wrote:
> > > Each of these drivers has a copy of the same trivial helper function to
> > > convert the pointer argument and then call the native ioctl handler.
> > >
> > > We now have a generic implementation of that, so use it.
> >
> > I'd rather flipped your #7 (ceph_compat_ioctl() introduction) past
> > that one...
> 
> The idea was to be able to backport the ceph patch as a bugfix
> to stable kernels without having to change it or backport
> compat_ptr_ioctl() as well.
> 
> If you still prefer it that way, I'd move to a simpler version of this
> patch and drop the Cc:stable.

What I'm going to do is to put the introduction of compat_ptr_ioctl()
into a never-rebased branch; having e.g. ceph patch done on top of
it should suffice - it can go into -stable just fine.  Trivially
backported all the way back, has no prereqs and is guaranteed to
cause no conflicts, so if any -stable fodder ends up depending upon
it, there will be no problem whatsoever.  IMO that commit should
precede everything else in the queue...

Another thing is that I'd fold #8 into #6 - it clearly belongs
in there.
