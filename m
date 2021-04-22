Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9484C367BB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 10:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhDVIHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 04:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhDVIHL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:07:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21D3061426;
        Thu, 22 Apr 2021 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619078796;
        bh=aXzRqf9+8BQeSlqgcbp1fjSrmCFGS3ZTiEGv60tlPLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TGHULc1tf19ke+HZi9VgxZG1wrWq+r0eLHLjq7sETOCofwk8z8ChXve+KQPzuStiS
         32XCPa3TMJELh9ardwkf+vGu//PHYr5siRvphXl2waXtDldVfZZe4crGJ08DVYRCyx
         SrTWMudtZZmWue4jM+jHRBIowQAreCNbY7/GLifu9GMZScvsELcSFdeVLoc3pt4Oba
         sKqkHieYK9JaqpJET3fL3Dxpk3ZKSpbruN0giOAVyLtLv7YC9f9m1kqdqAfvboOsxG
         O/RXo5awd0OqYopCqGuIgf9VFNH9Fv24dUdOK2vo+9VijkZ+LFAhTzUbK8eX8rVPKk
         MKdiQ/v8zPTpA==
Date:   Thu, 22 Apr 2021 11:06:26 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Peter.Enderborg@sony.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, guro@fb.com, shakeelb@google.com,
        mhocko@suse.com, neilb@suse.de, samitolvanen@google.com,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, willy@infradead.org
Subject: Re: [PATCH v5] dma-buf: Add DmaBufTotal counter in meminfo
Message-ID: <YIEugg9RIVSReN97@kernel.org>
References: <20210417163835.25064-1-peter.enderborg@sony.com>
 <YH6Xv00ddYfMA3Lg@phenom.ffwll.local>
 <176e7e71-59b7-b288-9483-10e0f42a7a3f@sony.com>
 <YH63iPzbGWzb676T@phenom.ffwll.local>
 <a60d1eaf-f9f8-e0f3-d214-15ce2c0635c2@sony.com>
 <YH/tHFBtIawBfGBl@phenom.ffwll.local>
 <cbde932e-8887-391f-4a1d-515e5c56c01d@sony.com>
 <YIBFbh4Dd1XaDbto@kernel.org>
 <84e0c6d9-74c6-5fa8-f75a-45c8ec995ac2@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84e0c6d9-74c6-5fa8-f75a-45c8ec995ac2@sony.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 05:35:57PM +0000, Peter.Enderborg@sony.com wrote:
> On 4/21/21 5:31 PM, Mike Rapoport wrote:
> > On Wed, Apr 21, 2021 at 10:37:11AM +0000, Peter.Enderborg@sony.com wrote:
> >> On 4/21/21 11:15 AM, Daniel Vetter wrote:
> >>> We need to understand what the "correct" value is. Not in terms of kernel
> >>> code, but in terms of semantics. Like if userspace allocates a GL texture,
> >>> is this supposed to show up in your metric or not. Stuff like that.
> >> That it like that would like to only one pointer type. You need to know what
> >>
> >> you pointing at to know what it is. it might be a hardware or a other pointer.
> >>
> >> If there is a limitation on your pointers it is a good metric to count them
> >> even if you don't  know what they are. Same goes for dma-buf, they
> >> are generic, but they consume some resources that are counted in pages.
> >>
> >> It would be very good if there a sub division where you could measure
> >> all possible types separately.  We have the detailed in debugfs, but nothing
> >> for the user. A summary in meminfo seems to be the best place for such
> >> metric.
> >  
> > Let me try to summarize my understanding of the problem, maybe it'll help
> > others as well.
> 
> Thanks!
> 
> 
> > A device driver allocates memory and exports this memory via dma-buf so
> > that this memory will be accessible for userspace via a file descriptor.
> >
> > The allocated memory can be either allocated with alloc_page() from system
> > RAM or by other means from dedicated VRAM (that is not managed by Linux mm)
> > or even from on-device memory.
> >
> > The dma-buf driver tracks the amount of the memory it was requested to
> > export and the size it sees is available at debugfs and fdinfo.
> >
> > The debugfs is not available to user and maybe entirely disabled in
> > production systems.
> >
> > There could be quite a few open dma-bufs so there is no overall summary,
> > plus fdinfo in production systems your refer to is also unavailable to the
> > user because of selinux policy.
> >
> > And there are a few details that are not clear to me:
> >
> > * Since DRM device drivers seem to be the major user of dma-buf exports,
> >   why cannot we add information about their memory consumption to, say,
> >   /sys/class/graphics/drm/cardX/memory-usage?
> 
> Android is using it for binder that connect more or less everything
> internally.
 
Ok, then it rules out /sys/class/graphics indeed.

> > * How exactly user generates reports that would include the new counters?
> >   From my (mostly outdated) experience Android users won't open a terminal
> >   and type 'cat /proc/meminfo' there. I'd presume there is a vendor agent
> >   that collects the data and sends it for analysis. In this case what is
> >   the reason the vendor is unable to adjust selinix policy so that the
> >   agent will be able to access fdinfo?
> 
> When you turn on developer mode on android you can use
> usb with a program called adb. And there you get a normal shell.
> 
> (not root though)
> 
> There is applications that non developers can use to get
> information. It is very limited though and there are API's
> provide it.
> 
> 
> >
> > * And, as others already mentioned, it is not clear what are the problems
> >   that can be detected by examining DmaBufTotal except saying "oh, there is
> >   too much/too little memory exported via dma-buf". What would be user
> >   visible effects of these problems? What are the next steps to investigate
> >   them? What other data will be probably required to identify root cause?
> >
> When you debug thousands of devices it is quite nice to have
> ways to classify what the problem it is not. The normal user does not
> see anything of this. However they can generate bug-reports that
> collect information about as much they can. Then the user have
> to provide this bug-report to the manufacture or mostly the
> application developer. And when the problem is
> system related we need to reproduce the issue on a full
> debug enabled unit.

So the flow is like this:

* a user has a problem and reports it to an application developer; at best
  the user runs simple and limited app to collect some data
* if the application developer considers this issue as a system related
  they can open adb and collect some more information about the system
  using non-root shell with selinux policy restrictions and send this
  information to the device manufacturer.
* the manufacturer continues to debug the issue and at this point as much
  information is possible would have been useful.

In this flow I still fail to understand why the manufacturer cannot provide
userspace tools that will be able to collect the required information.
These tools not necessarily need to target the end user, they may be only
intended for the application developers, e.g. policy could allow such tool
to access some of the system data only when the system is in developer
mode.

-- 
Sincerely yours,
Mike.
