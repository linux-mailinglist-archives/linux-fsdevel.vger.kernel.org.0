Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D381AE43A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 20:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbgDQSFW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 14:05:22 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:51266 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730236AbgDQSFW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:05:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TvqiUma_1587146713;
Received: from rsjd01523.et2sqa(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0TvqiUma_1587146713)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 18 Apr 2020 02:05:19 +0800
Date:   Sat, 18 Apr 2020 02:05:13 +0800
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 20/20] fuse,virtiofs: Add logic to free up a memory range
Message-ID: <20200417180513.GA67026@rsjd01523.et2sqa>
Reply-To: bo.liu@linux.alibaba.com
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-21-vgoyal@redhat.com>
 <20200326000904.GA34937@rsjd01523.et2sqa>
 <20200327140114.GB32717@redhat.com>
 <20200327220606.GA119028@rsjd01523.et2sqa>
 <20200414193045.GB210453@redhat.com>
 <20200415172229.GA121484@rsjd01523.et2sqa>
 <20200416190507.GC276932@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416190507.GC276932@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 16, 2020 at 03:05:07PM -0400, Vivek Goyal wrote:
> On Thu, Apr 16, 2020 at 01:22:29AM +0800, Liu Bo wrote:
> > On Tue, Apr 14, 2020 at 03:30:45PM -0400, Vivek Goyal wrote:
> > > On Sat, Mar 28, 2020 at 06:06:06AM +0800, Liu Bo wrote:
> > > > On Fri, Mar 27, 2020 at 10:01:14AM -0400, Vivek Goyal wrote:
> > > > > On Thu, Mar 26, 2020 at 08:09:05AM +0800, Liu Bo wrote:
> > > > > 
> > > > > [..]
> > > > > > > +/*
> > > > > > > + * Find first mapping in the tree and free it and return it. Do not add
> > > > > > > + * it back to free pool. If fault == true, this function should be called
> > > > > > > + * with fi->i_mmap_sem held.
> > > > > > > + */
> > > > > > > +static struct fuse_dax_mapping *inode_reclaim_one_dmap(struct fuse_conn *fc,
> > > > > > > +							 struct inode *inode,
> > > > > > > +							 bool fault)
> > > > > > > +{
> > > > > > > +	struct fuse_inode *fi = get_fuse_inode(inode);
> > > > > > > +	struct fuse_dax_mapping *dmap;
> > > > > > > +	int ret;
> > > > > > > +
> > > > > > > +	if (!fault)
> > > > > > > +		down_write(&fi->i_mmap_sem);
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * Make sure there are no references to inode pages using
> > > > > > > +	 * get_user_pages()
> > > > > > > +	 */
> > > > > > > +	ret = fuse_break_dax_layouts(inode, 0, 0);
> > > > > > 
> > > > > > Hi Vivek,
> > > > > > 
> > > > > > This patch is enabling inline reclaim for fault path, but fault path
> > > > > > has already holds a locked exceptional entry which I believe the above
> > > > > > fuse_break_dax_layouts() needs to wait for, can you please elaborate
> > > > > > on how this can be avoided?
> > > > > > 
> > > > > 
> > > > > Hi Liubo,
> > > > > 
> > > > > Can you please point to the exact lock you are referring to. I will
> > > > > check it out. Once we got rid of needing to take inode lock in
> > > > > reclaim path, that opended the door to do inline reclaim in fault
> > > > > path as well. But I was not aware of this exceptional entry lock.
> > > > 
> > > > Hi Vivek,
> > > > 
> > > > dax_iomap_{pte,pmd}_fault has called grab_mapping_entry to get a
> > > > locked entry, when this fault gets into inline reclaim, would
> > > > fuse_break_dax_layouts wait for the locked exceptional entry which is
> > > > locked in dax_iomap_{pte,pmd}_fault?
> > > 
> > > Hi Liu Bo,
> > > 
> > > This is a good point. Indeed it can deadlock the way code is written
> > > currently.
> > >
> > 
> > It's 100% reproducible on 4.19, but not on 5.x which has xarray for
> > dax_layout_busy_page.
> > 
> > It was weird that on 5.x kernel the deadlock is gone, it turned out
> > that xarray search in dax_layout_busy_page simply skips the empty
> > locked exceptional entry, I didn't get deeper to find out whether it's
> > reasonable, but with that 5.x doesn't run to deadlock.
> 
> I found more problems with enabling inline reclaim in fault path. I
> am holding fi->i_mmap_sem, shared and fuse_break_dax_layouts() can
> drop fi->i_mmap_sem if page is busy. I don't think we can drop and
> reacquire fi->i_mmap_sem while in fault path.
>

Good point, yes, dropping & reacquiring lock might bring more trouble
w.r.t race on the i_mmap_sem.

> Also fuse_break_dax_layouts() does not know if we are holding it
> shared or exclusive.
> 
> So I will probably have to go back to disable inline reclaim in
> fault path. If memory range is not available go back up in
> fuse_dax_fault(), drop fi->i_mmap_sem lock and wait on wait queue for
> a range to become free and retry.
> 
> I can retain the changes I did to break layout for a 2MB range only
> and not the whole file. I think that's a good optimization to retain
> anyway.
>

That part does look reasonable to me.

thanks,
liubo
