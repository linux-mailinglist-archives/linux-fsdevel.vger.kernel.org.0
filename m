Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D87D2299BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 16:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732482AbgGVOF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 10:05:29 -0400
Received: from verein.lst.de ([213.95.11.211]:56460 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbgGVOF2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:05:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7C57268B05; Wed, 22 Jul 2020 16:05:25 +0200 (CEST)
Date:   Wed, 22 Jul 2020 16:05:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 06/24] md: open code vfs_stat in md_setup_drive
Message-ID: <20200722140525.GA16395@lst.de>
References: <20200721162818.197315-1-hch@lst.de> <20200721162818.197315-7-hch@lst.de> <20200721165539.GT2786714@ZenIV.linux.org.uk> <20200721182701.GB14450@lst.de> <20200722074432.GD2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722074432.GD2786714@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 22, 2020 at 08:44:32AM +0100, Al Viro wrote:
> On Tue, Jul 21, 2020 at 08:27:01PM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 21, 2020 at 05:55:39PM +0100, Al Viro wrote:
> > > How about fs/for_init.c and putting the damn helpers there?  With
> > > calling conventions as close to syscalls as possible, and a fat
> > > comment regarding their intended use being _ONLY_ the setup
> > > in should-have-been-done-in-userland parts of init?
> > 
> > Where do you want the prototypes to go?  Also do you want devtmpfs
> > use the same helpers, which then't can't be marked __init (mount,
> > chdir, chroot), or separate copies?
> 
> Hmm...  mount still can be __init (devtmpfs_mount() is), and I suspect
> devtmpfs_setup() could also be made such - just turn devtmpfsd()
> into
> static int __init devtmpfsd(void *p)
> {
>         int err = devtmpfs_setup(p);
> 
> 	if (!err)
> 		devtmpfsd_real();	/* never returns */
> 	return err;
> }
> and you are done.

Yes, that seems to work.  We can obviously call non-__init functions
from __init ones, and kthread_run doesn't seem to care if it gets passed
a __init function.

Here is what I have now:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/init_path
