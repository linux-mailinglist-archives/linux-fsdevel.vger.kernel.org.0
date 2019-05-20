Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5A97237AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 15:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387890AbfETMyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 08:54:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731662AbfETMyF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 08:54:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D89D3091782;
        Mon, 20 May 2019 12:54:00 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BBDB6085B;
        Mon, 20 May 2019 12:53:56 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 06ECD220386; Mon, 20 May 2019 08:53:56 -0400 (EDT)
Date:   Mon, 20 May 2019 08:53:55 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Eric Ren <ericdotren@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com, swhiteho@redhat.com
Subject: Re: [PATCH v2 26/30] fuse: Add logic to free up a memory range
Message-ID: <20190520125355.GA28008@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
 <20190515192715.18000-27-vgoyal@redhat.com>
 <CAN+Pk99SNKSf+GjSQUUWt_eu1fSjTy_ByUOEQUXHi8zNqXY1zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN+Pk99SNKSf+GjSQUUWt_eu1fSjTy_ByUOEQUXHi8zNqXY1zA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 20 May 2019 12:54:05 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 19, 2019 at 03:48:05PM +0800, Eric Ren wrote:
> Hi,
> 
> @@ -1784,8 +1822,23 @@ static int fuse_iomap_begin(struct inode *inode,
> > loff_t pos, loff_t length,
> >                 if (pos >= i_size_read(inode))
> >                         goto iomap_hole;
> >
> > -               alloc_dmap = alloc_dax_mapping(fc);
> > -               if (!alloc_dmap)
> > +               /* Can't do reclaim in fault path yet due to lock ordering.
> > +                * Read path takes shared inode lock and that's not
> > sufficient
> > +                * for inline range reclaim. Caller needs to drop lock,
> > wait
> > +                * and retry.
> > +                */
> > +               if (flags & IOMAP_FAULT || !(flags & IOMAP_WRITE)) {
> > +                       alloc_dmap = alloc_dax_mapping(fc);
> > +                       if (!alloc_dmap)
> > +                               return -ENOSPC;
> > +               } else {
> > +                       alloc_dmap = alloc_dax_mapping_reclaim(fc, inode);
> >
> 
> alloc_dmap could be NULL as follows:
> 
> alloc_dax_mapping_reclaim
>    -->fuse_dax_reclaim_first_mapping
>              -->fuse_dax_reclaim_first_mapping_locked
>                   --> fuse_dax_interval_tree_iter_first  ==> return NULL
> and
> 
> IS_ERR(NULL) is false, so we may miss that error case.

Hi Eric,

Good catch. I will fix it next version. 

Thanks
Vivek
