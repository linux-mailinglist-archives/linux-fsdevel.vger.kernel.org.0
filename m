Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6C65A4FFE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 09:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfIBHf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 03:35:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfIBHf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Xo//RA2Kg22xiMnWI9sRNfs3eA1/ngoPCoiS4ohdYnI=; b=gxgwfEHn1d/y1iCkpC2lSC+5/L
        XBF2zcQzbwWlP6nSTBSZQ2QMfzmwEwapqDKN9XpCj1w3R7HFlea+kz2NIa/1jJJka+f9WuQ1oFxAa
        gwFV9A9rBYpmcnNVLMcwCyAZzzsFzk5ufodqv4SLbXQIqaquqSkNuu2Quh1eTh+e+QPJEuJgUPa8j
        Jd243HwEwjMQzworpC6xuCGfgxQko8XXuDwBoSI1n3xlqYcrglXkGBmeRFc4+9e/QZkhjmEJOGzur
        pUyQ0kUhFgPfohucJCwBYPuCCS+bCgqZ/WImE+fe0D1TLTPD446zyt5eqf3qQLPIjjpNqgnnT0xyP
        i0EraOAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4gs1-0007tO-O9; Mon, 02 Sep 2019 07:35:25 +0000
Date:   Mon, 2 Sep 2019 00:35:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of
 fat/vfat
Message-ID: <20190902073525.GA18988@infradead.org>
References: <245727.1567183359@turing-police>
 <20190830164503.GA12978@infradead.org>
 <267691.1567212516@turing-police>
 <20190831064616.GA13286@infradead.org>
 <295233.1567247121@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <295233.1567247121@turing-police>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 31, 2019 at 06:25:21AM -0400, Valdis Klētnieks wrote:
> On Fri, 30 Aug 2019 23:46:16 -0700, Christoph Hellwig said:
> 
> > Since when did Linux kernel submissions become "show me a better patch"
> > to reject something obviously bad?
> 
> Well, do you even have a *suggestion* for a better idea?  Other than "just rip
> it out"?  Keeping in mind that:

The right approach in my opinion is to start submitting patches to fs/fat
to add exfat support.  But more importantly it is to first coordinate
with other stakeholder most importantly the fs/fat/ maintainer and the
dosfstools maintainers as our local experts for fat-like file systems
instead of shooting from the hip.

> I think at that point, we can safely say that if it mounts a vfat filesystem,
> it's because the person building the kernel has gone out of their way to
> request that it do so.

Especially with boot time automounting it could happen.  Never mind that
we do not add duplicate file system drivers (or drivers in general) to
the kernel.

> Now, if what you want is "Please make it so the fat16/fat32 code is in separate
> files that aren't built unless requested", that's in fact doable and a
> reasonable request, and one that both doesn't conflict with anything other
> directions we might want to go, and also prepares the code for more easy
> separation if it's decided we really do want an exfat-only module.

No.  Assuming we even want the current codebase (which only you and
Greg seem to think so), that fat16/32 code simply has to go.

> And by the way, it seems like other filesystems rely on "others" to help out.
> Let's look at the non-merge commit for fs/ext4. And these are actual patches,
> not just reviewer comments....
> 
> (For those who don't feel like scrolling - 77.6% of the non-merge ext4 commits
> are from a total of 463 somebodies other than Ted Ts'o)
> 
> Even some guy named Christoph Hellwig gave Ted Ts'o a bunch of help.

That isn't the point.  Everyone who submitted a file system had a clear
plan where they wanted to go.  You just took someone elses out of tree
code, apparently didn't even try to understand it and are not able to
come up with what your plan for it is.  And even after repeated
questions on what that plan is duck the question and instead attack the
people asking for it.
