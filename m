Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9615C22E416
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 04:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgG0Clz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 22:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgG0Clz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 22:41:55 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BEEC0619D2;
        Sun, 26 Jul 2020 19:41:55 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzt5J-003N6N-Ej; Mon, 27 Jul 2020 02:41:49 +0000
Date:   Mon, 27 Jul 2020 03:41:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Lukasz Stelmach <l.stelmach@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Song Liu <song@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 16/23] initramfs: simplify clean_rootfs
Message-ID: <20200727024149.GB795125@ZenIV.linux.org.uk>
References: <20200714190427.4332-1-hch@lst.de>
 <20200714190427.4332-17-hch@lst.de>
 <CGME20200717205549eucas1p13fca9a8496836faa71df515524743648@eucas1p1.samsung.com>
 <7f37802c-d8d9-18cd-7394-df51fa785988@samsung.com>
 <20200718100035.GA8856@lst.de>
 <20200723092200.GA19922@lst.de>
 <dleftjblk6b95t.fsf%l.stelmach@samsung.com>
 <20200723142734.GA11080@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723142734.GA11080@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 23, 2020 at 04:27:34PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 23, 2020 at 04:25:34PM +0200, Lukasz Stelmach wrote:
> > >> Can you comment out the call to d_genocide?  It seems like for your
> > >> the fact that clean_rootfs didn't actually clean up was a feature and
> > >> not a bug.
> > >> 
> > >> I guess the old, pre-2008 code also wouldn't have worked for you in
> > >> that case.
> > >
> > > Did you get a chance to try this?
> > 
> > Indeed, commenting out d_genocide() helps.
> 
> So given that people have relied on at least the basic device nodes
> like /dev/console to not go away since 2008, I wonder if we should just
> remove clean_rootfs entirely
> 
> Linus, Al?

First of all, d_genocide() is simply wrong here from VFS point of view.  _IF_
you want recursive removal, you need simple_recursive_remove(path.dentry, NULL).
And it's a userland-visible change of behaviour.

As for removal of clean_rootfs()...  FWIW, the odds of an image that would
eventually fail accidentally getting past the signature mismatch check are
fairly low.  I've no idea what scenario the author of that thing used to have;
that would be Shaohua Li <shaohua.li@intel.com>.  Cc'd...
