Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B3F22E419
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 04:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgG0Coj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 22:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgG0Coj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 22:44:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB83C0619D2;
        Sun, 26 Jul 2020 19:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZKcV0ox/lLpxIzJ0hzm2hE1hqEes29OdpJh8YDdSZ80=; b=eqN5Hme3pioJ8foIOvGn7kVn6s
        eagnHWU5NQgFh/tDKI7kGQ8FfaD4j6xUBjicP+0BJwRYRdqs1RBi5loQxdu990XSwXuVUPADi77Ju
        nZaBrCk2ozwbKEtKCT8Mn9wABN9zGzj+wo7ZletduXtL/O6yNnCUypSVvgMxVaO+5/knoRrAE4SDS
        MUUFrdTFDdCeNzJq0GvLN+DFzea/uC8Ih4aZFpwh5YDKIBQ7mveX7qw0KKwB1XsS9hX8iBXUoAfCQ
        JnGzXQvp37ahr0R3ZPa7QrMVqSc2UexLM3xG5+vU3AriSd/PqLR4y0cDrcm/FTmJyvs7ZDP+2tfUD
        6E4m+eZA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzt7r-0004Tv-2P; Mon, 27 Jul 2020 02:44:27 +0000
Date:   Mon, 27 Jul 2020 03:44:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Lukasz Stelmach <l.stelmach@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Song Liu <song@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 16/23] initramfs: simplify clean_rootfs
Message-ID: <20200727024426.GI23808@casper.infradead.org>
References: <20200714190427.4332-1-hch@lst.de>
 <20200714190427.4332-17-hch@lst.de>
 <CGME20200717205549eucas1p13fca9a8496836faa71df515524743648@eucas1p1.samsung.com>
 <7f37802c-d8d9-18cd-7394-df51fa785988@samsung.com>
 <20200718100035.GA8856@lst.de>
 <20200723092200.GA19922@lst.de>
 <dleftjblk6b95t.fsf%l.stelmach@samsung.com>
 <20200723142734.GA11080@lst.de>
 <20200727024149.GB795125@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727024149.GB795125@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 03:41:49AM +0100, Al Viro wrote:
> On Thu, Jul 23, 2020 at 04:27:34PM +0200, Christoph Hellwig wrote:
> > On Thu, Jul 23, 2020 at 04:25:34PM +0200, Lukasz Stelmach wrote:
> > > >> Can you comment out the call to d_genocide?  It seems like for your
> > > >> the fact that clean_rootfs didn't actually clean up was a feature and
> > > >> not a bug.
> > > >> 
> > > >> I guess the old, pre-2008 code also wouldn't have worked for you in
> > > >> that case.
> > > >
> > > > Did you get a chance to try this?
> > > 
> > > Indeed, commenting out d_genocide() helps.
> > 
> > So given that people have relied on at least the basic device nodes
> > like /dev/console to not go away since 2008, I wonder if we should just
> > remove clean_rootfs entirely
> > 
> > Linus, Al?
> 
> First of all, d_genocide() is simply wrong here from VFS point of view.  _IF_
> you want recursive removal, you need simple_recursive_remove(path.dentry, NULL).
> And it's a userland-visible change of behaviour.
> 
> As for removal of clean_rootfs()...  FWIW, the odds of an image that would
> eventually fail accidentally getting past the signature mismatch check are
> fairly low.  I've no idea what scenario the author of that thing used to have;
> that would be Shaohua Li <shaohua.li@intel.com>.  Cc'd...

Shaohua is now at Facebook.
