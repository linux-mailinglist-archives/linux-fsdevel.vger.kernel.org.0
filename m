Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875CA229275
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 09:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGVHok (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 03:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgGVHok (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:44:40 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A2AC0619DC;
        Wed, 22 Jul 2020 00:44:40 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jy9QW-000ABC-Ed; Wed, 22 Jul 2020 07:44:32 +0000
Date:   Wed, 22 Jul 2020 08:44:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 06/24] md: open code vfs_stat in md_setup_drive
Message-ID: <20200722074432.GD2786714@ZenIV.linux.org.uk>
References: <20200721162818.197315-1-hch@lst.de>
 <20200721162818.197315-7-hch@lst.de>
 <20200721165539.GT2786714@ZenIV.linux.org.uk>
 <20200721182701.GB14450@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721182701.GB14450@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 08:27:01PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 21, 2020 at 05:55:39PM +0100, Al Viro wrote:
> > How about fs/for_init.c and putting the damn helpers there?  With
> > calling conventions as close to syscalls as possible, and a fat
> > comment regarding their intended use being _ONLY_ the setup
> > in should-have-been-done-in-userland parts of init?
> 
> Where do you want the prototypes to go?  Also do you want devtmpfs
> use the same helpers, which then't can't be marked __init (mount,
> chdir, chroot), or separate copies?

Hmm...  mount still can be __init (devtmpfs_mount() is), and I suspect
devtmpfs_setup() could also be made such - just turn devtmpfsd()
into
static int __init devtmpfsd(void *p)
{
        int err = devtmpfs_setup(p);

	if (!err)
		devtmpfsd_real();	/* never returns */
	return err;
}
and you are done.  As for the prototypes... include/linux/init_syscalls.h,
perhaps?
