Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 917181960D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 23:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgC0WGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 18:06:14 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:8930 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727611AbgC0WGO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:06:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TtnyMjr_1585346766;
Received: from rsjd01523.et2sqa(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0TtnyMjr_1585346766)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 28 Mar 2020 06:06:11 +0800
Date:   Sat, 28 Mar 2020 06:06:06 +0800
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 20/20] fuse,virtiofs: Add logic to free up a memory range
Message-ID: <20200327220606.GA119028@rsjd01523.et2sqa>
Reply-To: bo.liu@linux.alibaba.com
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-21-vgoyal@redhat.com>
 <20200326000904.GA34937@rsjd01523.et2sqa>
 <20200327140114.GB32717@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327140114.GB32717@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 27, 2020 at 10:01:14AM -0400, Vivek Goyal wrote:
> On Thu, Mar 26, 2020 at 08:09:05AM +0800, Liu Bo wrote:
> 
> [..]
> > > +/*
> > > + * Find first mapping in the tree and free it and return it. Do not add
> > > + * it back to free pool. If fault == true, this function should be called
> > > + * with fi->i_mmap_sem held.
> > > + */
> > > +static struct fuse_dax_mapping *inode_reclaim_one_dmap(struct fuse_conn *fc,
> > > +							 struct inode *inode,
> > > +							 bool fault)
> > > +{
> > > +	struct fuse_inode *fi = get_fuse_inode(inode);
> > > +	struct fuse_dax_mapping *dmap;
> > > +	int ret;
> > > +
> > > +	if (!fault)
> > > +		down_write(&fi->i_mmap_sem);
> > > +
> > > +	/*
> > > +	 * Make sure there are no references to inode pages using
> > > +	 * get_user_pages()
> > > +	 */
> > > +	ret = fuse_break_dax_layouts(inode, 0, 0);
> > 
> > Hi Vivek,
> > 
> > This patch is enabling inline reclaim for fault path, but fault path
> > has already holds a locked exceptional entry which I believe the above
> > fuse_break_dax_layouts() needs to wait for, can you please elaborate
> > on how this can be avoided?
> > 
> 
> Hi Liubo,
> 
> Can you please point to the exact lock you are referring to. I will
> check it out. Once we got rid of needing to take inode lock in
> reclaim path, that opended the door to do inline reclaim in fault
> path as well. But I was not aware of this exceptional entry lock.

Hi Vivek,

dax_iomap_{pte,pmd}_fault has called grab_mapping_entry to get a
locked entry, when this fault gets into inline reclaim, would
fuse_break_dax_layouts wait for the locked exceptional entry which is
locked in dax_iomap_{pte,pmd}_fault?

thanks,
liubo
