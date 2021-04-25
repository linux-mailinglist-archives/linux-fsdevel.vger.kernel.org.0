Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7884F36A58B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Apr 2021 09:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhDYHeq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 03:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhDYHeq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 03:34:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D18D961245;
        Sun, 25 Apr 2021 07:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619336046;
        bh=WCsSHB91cvmf5ZeAXu+txZXJ3S/cP/GNMzA77rjuNbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1XswQI3mxMpGcDvpMyZljYfgw5fSLCE1OaoEPKuANpgRNF/l1ND6Se160hAmXY2V
         WXsK309I7CYtICtk/SZ1nvEJRBpn1+vyAb/P6rKYKnqt7swUW4G1LM16V7f3Ki5hGL
         6jIWwzqr2Uat6+NgotfFX1qhL914GSyag3QNQK8d6Fq1ux1vwZjFNqhCT53YkaLdTE
         TS2qfTejBqCr4vVDIHrt8whLwMVintjtCjDUVJJmyRNx/cBFyrNVGMPw+2ZKkhqhxJ
         c/I7P/Zd+iGUvrgWXjnwivWQGUZ9oTtanEw8H5/Digtge9jnfpQm/dvW+lGWyo3VLQ
         i6HJsRhSlKs+g==
Date:   Sun, 25 Apr 2021 10:33:57 +0300
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
Message-ID: <YIUbZWm+jW21vYJ9@kernel.org>
References: <YH6Xv00ddYfMA3Lg@phenom.ffwll.local>
 <176e7e71-59b7-b288-9483-10e0f42a7a3f@sony.com>
 <YH63iPzbGWzb676T@phenom.ffwll.local>
 <a60d1eaf-f9f8-e0f3-d214-15ce2c0635c2@sony.com>
 <YH/tHFBtIawBfGBl@phenom.ffwll.local>
 <cbde932e-8887-391f-4a1d-515e5c56c01d@sony.com>
 <YIBFbh4Dd1XaDbto@kernel.org>
 <84e0c6d9-74c6-5fa8-f75a-45c8ec995ac2@sony.com>
 <YIEugg9RIVSReN97@kernel.org>
 <ae091d3d-623b-ce18-e0f2-1591be6db83e@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae091d3d-623b-ce18-e0f2-1591be6db83e@sony.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 22, 2021 at 02:08:51PM +0000, Peter.Enderborg@sony.com wrote:
> On 4/22/21 10:06 AM, Mike Rapoport wrote:
> > So the flow is like this:
> >
> > * a user has a problem and reports it to an application developer; at best
> >   the user runs simple and limited app to collect some data
> > * if the application developer considers this issue as a system related
> >   they can open adb and collect some more information about the system
> >   using non-root shell with selinux policy restrictions and send this
> >   information to the device manufacturer.
> > * the manufacturer continues to debug the issue and at this point as much
> >   information is possible would have been useful.
> >
> > In this flow I still fail to understand why the manufacturer cannot provide
> > userspace tools that will be able to collect the required information.
> > These tools not necessarily need to target the end user, they may be only
> > intended for the application developers, e.g. policy could allow such tool
> > to access some of the system data only when the system is in developer
> > mode.
> >
> The manufacture is trying to get the tool to work. This is what the
> patch is about. Even for a application developer a commercial
> phone is locked down.

Right, but it's still in full control of the manufacturer what's flashed
there, isn't it?
So there could be some tools that are only available in the developer mode?
These tools could have different permissions etc.

> Many vendors allow that you flash some other software like a AOSP.  But
> that can be very different. Like installing a ubuntu on a PC to debug a
> Fedora issue.
> 
> And sure we can pickup parts of what using the dma-buf. But
> we can not get the total and be sure that is the total without a
> proper counter.

If I understand you correctly, a user space tool that scans fdinfo and
accumulates dma-buf size from there is not accurate enough, that's why an
atomic counter exposed by kernel is a must.

But if the changes in consumption of dma-bufs are that frequent, I cannot
see how a global counter will help to identify an issue.

And if this counter is needed to see if there is a memory leak, summing
sizes of dma-bufs from fdinfo will identify a leak.

What am I missing?

-- 
Sincerely yours,
Mike.
