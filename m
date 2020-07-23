Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EDC22ABA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 11:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgGWJWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 05:22:04 -0400
Received: from verein.lst.de ([213.95.11.211]:59394 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGWJWE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:22:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 972CA68AFE; Thu, 23 Jul 2020 11:22:00 +0200 (CEST)
Date:   Thu, 23 Jul 2020 11:22:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 16/23] initramfs: simplify clean_rootfs
Message-ID: <20200723092200.GA19922@lst.de>
References: <20200714190427.4332-1-hch@lst.de> <20200714190427.4332-17-hch@lst.de> <CGME20200717205549eucas1p13fca9a8496836faa71df515524743648@eucas1p1.samsung.com> <7f37802c-d8d9-18cd-7394-df51fa785988@samsung.com> <20200718100035.GA8856@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718100035.GA8856@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 18, 2020 at 12:00:35PM +0200, Christoph Hellwig wrote:
> On Fri, Jul 17, 2020 at 10:55:48PM +0200, Marek Szyprowski wrote:
> > Hi Christoph,
> > 
> > On 14.07.2020 21:04, Christoph Hellwig wrote:
> > > Just use d_genocide instead of iterating through the root directory with
> > > cumbersome userspace-like APIs.  This also ensures we actually remove files
> > > that are not direct children of the root entry, which the old code failed
> > > to do.
> > >
> > > Fixes: df52092f3c97 ("fastboot: remove duplicate unpack_to_rootfs()")
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > This patch breaks initrd support ;-(
> > 
> > I use initrd to deploy kernel modules on my test machines. It was 
> > automatically mounted on /initrd. /lib/modules is just a symlink to 
> > /initrd. I know that initrd support is marked as deprecated, but it 
> > would be really nice to give people some time to update their machines 
> > before breaking the stuff.
> 
> Looks like your setup did rely on the /dev/ notes from the built-in
> initramfs to be preserved.
> 
> Can you comment out the call to d_genocide?  It seems like for your
> the fact that clean_rootfs didn't actually clean up was a feature and
> not a bug.
> 
> I guess the old, pre-2008 code also wouldn't have worked for you in
> that case.

Did you get a chance to try this?
