Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88EB1A5A9E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 17:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfIBPcz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 11:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfIBPcz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:32:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFC302087E;
        Mon,  2 Sep 2019 15:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567437927;
        bh=3FyOb3NOmdW+LRdn0QHv4m2ODQwf2BoW2WsJbsDPHUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YO49k8S8nQ/tbOklUjSrjl0gNhWws9QAu6j3zCuwsvbsdanEBHUUFhcshnCaryu4P
         58s+2PtPXWNvOtqZkudV4cmVvwNAb6jugZQcX5Xq2hkmlu4rJ1kcqFdU3TH/mgeOds
         lXpGXrx+H9QF4feX4kUa/OyYwhSCczkgzJdmotzo=
Date:   Mon, 2 Sep 2019 17:25:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of
 fat/vfat
Message-ID: <20190902152524.GA4964@kroah.com>
References: <245727.1567183359@turing-police>
 <20190830164503.GA12978@infradead.org>
 <267691.1567212516@turing-police>
 <20190831064616.GA13286@infradead.org>
 <295233.1567247121@turing-police>
 <20190902073525.GA18988@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190902073525.GA18988@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 02, 2019 at 12:35:25AM -0700, Christoph Hellwig wrote:
> On Sat, Aug 31, 2019 at 06:25:21AM -0400, Valdis Klētnieks wrote:
> > On Fri, 30 Aug 2019 23:46:16 -0700, Christoph Hellwig said:
> > 
> > > Since when did Linux kernel submissions become "show me a better patch"
> > > to reject something obviously bad?
> > 
> > Well, do you even have a *suggestion* for a better idea?  Other than "just rip
> > it out"?  Keeping in mind that:
> 
> The right approach in my opinion is to start submitting patches to fs/fat
> to add exfat support.  But more importantly it is to first coordinate
> with other stakeholder most importantly the fs/fat/ maintainer and the
> dosfstools maintainers as our local experts for fat-like file systems
> instead of shooting from the hip.

I dug up my old discussion with the current vfat maintainer and he said
something to the affect of, "leave the existing code alone, make a new
filesystem, I don't want anything to do with exfat".

And I don't blame them, vfat is fine as-is and stable and shouldn't be
touched for new things.

We can keep non-vfat filesystems from being mounted with the exfat
codebase, and make things simpler for everyone involved.

> > Now, if what you want is "Please make it so the fat16/fat32 code is in separate
> > files that aren't built unless requested", that's in fact doable and a
> > reasonable request, and one that both doesn't conflict with anything other
> > directions we might want to go, and also prepares the code for more easy
> > separation if it's decided we really do want an exfat-only module.
> 
> No.  Assuming we even want the current codebase (which only you and
> Greg seem to think so), that fat16/32 code simply has to go.

I don't think it should stay in there, let's drop it from the exfat
code.

As for the other issues discussed here in this thread:
  - yes, putting a filesystem in staging is extra work overall, but for
    projects that want to do that extra work, wonderful, do it here in a
    common place for everyone to work on together.
  - working on in a common place is what we need for exfat right now,
    as there are 40+ different github forks and no one knows which one
    is "correct" or most up to date.  We needed to decide on "one" and
    here it is, the in-tree one.
  - for vfs developers who don't want to even look at the crud in
    staging (remember, it's TAINT_CRAP if you load code from here),
    don't.  Just keep on your own normal development cycles and if you
    break any staging code, it's fine, I will fix it up no complaints at
    all.
  - staging code is for crappy code to get fixed up.  If it isn't
    constantly updated, it will be dropped.  Yes, there is code in there
    that probably should be dropped now as I haven't done a sweep in a
    few years, suggestions always welcome.  There is also code that
    needs to be moved out with just a bit more work needed (greybus,
    comedi, speakup, etc.)  Some of that is underway right now.

thanks,

greg k-h
