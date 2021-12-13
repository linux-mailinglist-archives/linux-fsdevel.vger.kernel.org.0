Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897E1472250
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 09:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhLMIXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 03:23:24 -0500
Received: from verein.lst.de ([213.95.11.211]:46642 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232838AbhLMIXX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:23:23 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B4C9368BFE; Mon, 13 Dec 2021 09:23:18 +0100 (CET)
Date:   Mon, 13 Dec 2021 09:23:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 4/5] dax: remove the copy_from_iter and copy_to_iter
 methods
Message-ID: <20211213082318.GB21462@lst.de>
References: <20211209063828.18944-1-hch@lst.de> <20211209063828.18944-5-hch@lst.de> <YbNhPXBg7G/ridkV@redhat.com> <CAPcyv4g4_yFqDeS+pnAZOxcB=Ua+iArK5mqn0iMG4PX6oL=F_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g4_yFqDeS+pnAZOxcB=Ua+iArK5mqn0iMG4PX6oL=F_A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 12, 2021 at 06:44:26AM -0800, Dan Williams wrote:
> On Fri, Dec 10, 2021 at 6:17 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > Going forward, I am wondering should virtiofs use flushcache version as
> > well. What if host filesystem is using DAX and mapping persistent memory
> > pfn directly into qemu address space. I have never tested that.
> >
> > Right now we are relying on applications to do fsync/msync on virtiofs
> > for data persistence.
> 
> This sounds like it would need coordination with a paravirtualized
> driver that can indicate whether the host side is pmem or not, like
> the virtio_pmem driver. However, if the guest sends any fsync/msync
> you would still need to go explicitly cache flush any dirty page
> because you can't necessarily trust that the guest did that already.

Do we?  The application can't really know what backend it is on, so
it sounds like the current virtiofs implementation doesn't really, does it?
