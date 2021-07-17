Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BDC3CC4BF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jul 2021 19:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhGQRUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jul 2021 13:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232010AbhGQRUL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jul 2021 13:20:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9629E6115A;
        Sat, 17 Jul 2021 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626542234;
        bh=9M4WiUsEgOctpJxxgPigGn9zB747+l+Fi5R2vFQb6ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wgj/S5X46GZM/dB4/6vofbinxvayxhrJENOOUti3djByOLRx28R+0SFGDINC6x4R4
         mTQ7uk66leDhUC90TuI/cLFU6+2wryRy0jftVFZPyP6Omnb+eQjQRAB1gVblIGh4Na
         NY1uppnoWk8jfhgmNbwAKdGLnzxqE/zGxSj5/x+by2LXH9Wu75MluQFVDHvSPwuNL2
         G7JYVpWCoOo0bH7NzikWlRMw2CXxkt867wKNhqCLWhJL2EzEOZKC00h9lBviKi9EZ0
         vOfsqxtAwURMRgJdAxsX5nIYFRmENdUsDECTnpZZGg+DWVSvLZGN5HE11voGMICnVO
         pCd5WporbfTgw==
Date:   Sat, 17 Jul 2021 10:17:13 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [fsdax xfs] Regression panic at inode_switch_wbs_work_fn
Message-ID: <20210717171713.GB22357@magnolia>
References: <CADJHv_uitWbPquubkFJGwiFi8Vx7V0ZxhYUSiEOd1_vMhHOonA@mail.gmail.com>
 <YPBdG2pe94hRdCMC@carbon.dhcp.thefacebook.com>
 <CADJHv_sij245-dtvhSac_cwkYQLrSFBgjoXnja_-OYaZk6Cfdg@mail.gmail.com>
 <YPHoUQyWW0/02l1X@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPHoUQyWW0/02l1X@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 01:13:05PM -0700, Roman Gushchin wrote:
> On Fri, Jul 16, 2021 at 01:57:55PM +0800, Murphy Zhou wrote:
> > Hi,
> > 
> > On Fri, Jul 16, 2021 at 12:07 AM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Thu, Jul 15, 2021 at 06:10:22PM +0800, Murphy Zhou wrote:
> > > > Hi,
> > > >
> > > > #Looping generic/270 of xfstests[1] on pmem ramdisk with
> > > > mount option:  -o dax=always
> > > > mkfs.xfs option: -f -b size=4096 -m reflink=0
> > > > can hit this panic now.
> > > >
> > > > #It's not reproducible on ext4.
> > > > #It's not reproducible without dax=always.
> > >
> > > Hi Murphy!
> > >
> > > Thank you for the report!
> > >
> > > Can you, please, check if the following patch fixes the problem?
> > 
> > No. Still the same panic.
> 
> Hm, can you, please, double check this? It seems that the patch fixes the
> problem for others (of course, it can be a different problem).
> CCed you on the proper patch, just sent to the list.
> 
> Otherwise, can you, please, say on which line of code the panic happens?
> (using addr2line utility, for example)

I experience the same problem that Murphy does, and I tracked it down
to this chunk of inode_do_switch_wbs:

	/*
	 * Count and transfer stats.  Note that PAGECACHE_TAG_DIRTY points
	 * to possibly dirty pages while PAGECACHE_TAG_WRITEBACK points to
	 * pages actually under writeback.
	 */
	xas_for_each_marked(&xas, page, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
here >>>>>>>>>> if (PageDirty(page)) {
			dec_wb_stat(old_wb, WB_RECLAIMABLE);
			inc_wb_stat(new_wb, WB_RECLAIMABLE);
		}
	}

I suspect that "page" is really a pfn to a pmem mapping and not a real
struct page.

--D

> 
> Thank you!
