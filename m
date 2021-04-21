Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C03366F37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 17:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244032AbhDUPco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 11:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244024AbhDUPcm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:32:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F277861445;
        Wed, 21 Apr 2021 15:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619019129;
        bh=RC899umZ0BwpHoFBaQEd03wqXFYBjtGaL5NqM7dfCT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CpNQszCLq4n8vEbp+4q9qxxt6foYHXA6LMbxM0pUASXfc28rRQcnHijjCXk/bU4TR
         TdDYeNqRAnnuj8/VLcS5qJ+U07HSMDxPsyQDrG7EJzs2PCv4MxVSBtSYtwYW+PNk62
         KPitZe+vN9l/HeCKZkA695LuhNegPcRtu6FLyojANSpA0XhVRnYVDfv4MxiPKnPyaa
         s33u6+4RK9KDcho9/4XcQ0uBmY7Nh+0+l0fdoIHE8WzrDzLSrBN5K5PIpOTmbJh780
         NBpCEJ2w2VdcFapAACBUQ6BQdb5B+z9QC/dLgLEdzQHHEZlz953zvRL+EwG6ghuB8k
         P/eYtCOFPaOGg==
Date:   Wed, 21 Apr 2021 18:31:58 +0300
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
Message-ID: <YIBFbh4Dd1XaDbto@kernel.org>
References: <20210417163835.25064-1-peter.enderborg@sony.com>
 <YH6Xv00ddYfMA3Lg@phenom.ffwll.local>
 <176e7e71-59b7-b288-9483-10e0f42a7a3f@sony.com>
 <YH63iPzbGWzb676T@phenom.ffwll.local>
 <a60d1eaf-f9f8-e0f3-d214-15ce2c0635c2@sony.com>
 <YH/tHFBtIawBfGBl@phenom.ffwll.local>
 <cbde932e-8887-391f-4a1d-515e5c56c01d@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbde932e-8887-391f-4a1d-515e5c56c01d@sony.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 10:37:11AM +0000, Peter.Enderborg@sony.com wrote:
> On 4/21/21 11:15 AM, Daniel Vetter wrote:
> >
> > We need to understand what the "correct" value is. Not in terms of kernel
> > code, but in terms of semantics. Like if userspace allocates a GL texture,
> > is this supposed to show up in your metric or not. Stuff like that.
> That it like that would like to only one pointer type. You need to know what
> 
> you pointing at to know what it is. it might be a hardware or a other pointer.
> 
> If there is a limitation on your pointers it is a good metric to count them
> even if you don't  know what they are. Same goes for dma-buf, they
> are generic, but they consume some resources that are counted in pages.
> 
> It would be very good if there a sub division where you could measure
> all possible types separately.  We have the detailed in debugfs, but nothing
> for the user. A summary in meminfo seems to be the best place for such
> metric.
 
Let me try to summarize my understanding of the problem, maybe it'll help
others as well.

A device driver allocates memory and exports this memory via dma-buf so
that this memory will be accessible for userspace via a file descriptor.

The allocated memory can be either allocated with alloc_page() from system
RAM or by other means from dedicated VRAM (that is not managed by Linux mm)
or even from on-device memory.

The dma-buf driver tracks the amount of the memory it was requested to
export and the size it sees is available at debugfs and fdinfo.

The debugfs is not available to user and maybe entirely disabled in
production systems.

There could be quite a few open dma-bufs so there is no overall summary,
plus fdinfo in production systems your refer to is also unavailable to the
user because of selinux policy.

And there are a few details that are not clear to me:

* Since DRM device drivers seem to be the major user of dma-buf exports,
  why cannot we add information about their memory consumption to, say,
  /sys/class/graphics/drm/cardX/memory-usage?

* How exactly user generates reports that would include the new counters?
  From my (mostly outdated) experience Android users won't open a terminal
  and type 'cat /proc/meminfo' there. I'd presume there is a vendor agent
  that collects the data and sends it for analysis. In this case what is
  the reason the vendor is unable to adjust selinix policy so that the
  agent will be able to access fdinfo?

* And, as others already mentioned, it is not clear what are the problems
  that can be detected by examining DmaBufTotal except saying "oh, there is
  too much/too little memory exported via dma-buf". What would be user
  visible effects of these problems? What are the next steps to investigate
  them? What other data will be probably required to identify root cause?

-- 
Sincerely yours,
Mike.
