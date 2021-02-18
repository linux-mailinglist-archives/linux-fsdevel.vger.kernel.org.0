Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FB131ED0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 18:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhBRRNb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 12:13:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232893AbhBRQVA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:21:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51A6C61606;
        Thu, 18 Feb 2021 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613665218;
        bh=GHp96I/gVd4EmUFAptDHDpHWkNykmmfyndnECL0NAbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eyayc5+YfPPtm0uaK+Eoc1D452WYMv+Gsf/tSxdxcgIBxZ47Sz4L0Yy8hVK/SLqx6
         XO/kXCl8dDL5C/rADkEKSc8s4mF1h1M9xk6GJieFChIq611ekNwu520by4ngKi9Uby
         5Jkkh9IZ/FM3Dq6PiiUBUQDvkRQFGFJxeYPu2GzlIm2GGGkbYOaTBSbmp/Zu7sH8M+
         5zJuAWQtKw0mt4Qm5XdwLhrzBFUZmIYmx0gUxsOEJi3AAUQYJnPjqP3SmvfrudqHl3
         DcnpOpt/ULK5VHeAqy8g9d6NbAjYHgry/RNbogkUYu6b26kGS+4zN6U7HzRiK/aCtQ
         vcPx7EI2hpCkA==
Date:   Thu, 18 Feb 2021 08:20:18 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, david@fromorbit.com, rgoldwyn@suse.de,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 5/7] fsdax: Dedup file range to use a compare function
Message-ID: <20210218162018.GT7193@magnolia>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
 <20210207170924.2933035-6-ruansy.fnst@cn.fujitsu.com>
 <20210208151920.GE12872@lst.de>
 <9193e305-22a1-3928-0675-af1cecd28942@cn.fujitsu.com>
 <20210209093438.GA630@lst.de>
 <79b0d65c-95dd-4821-e412-ab27c8cb6942@cn.fujitsu.com>
 <20210210131928.GA30109@lst.de>
 <b00cfda5-464c-6161-77c6-6a25b1cc7a77@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b00cfda5-464c-6161-77c6-6a25b1cc7a77@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 11:24:18AM +0800, Ruan Shiyang wrote:
> 
> 
> On 2021/2/10 下午9:19, Christoph Hellwig wrote:
> > On Tue, Feb 09, 2021 at 05:46:13PM +0800, Ruan Shiyang wrote:
> > > 
> > > 
> > > On 2021/2/9 下午5:34, Christoph Hellwig wrote:
> > > > On Tue, Feb 09, 2021 at 05:15:13PM +0800, Ruan Shiyang wrote:
> > > > > The dax dedupe comparison need the iomap_ops pointer as argument, so my
> > > > > understanding is that we don't modify the argument list of
> > > > > generic_remap_file_range_prep(), but move its code into
> > > > > __generic_remap_file_range_prep() whose argument list can be modified to
> > > > > accepts the iomap_ops pointer.  Then it looks like this:
> > > > 
> > > > I'd say just add the iomap_ops pointer to
> > > > generic_remap_file_range_prep and do away with the extra wrappers.  We
> > > > only have three callers anyway.
> > > 
> > > OK.
> > 
> > So looking at this again I think your proposal actaully is better,
> > given that the iomap variant is still DAX specific.  Sorry for
> > the noise.
> > 
> > Also I think dax_file_range_compare should use iomap_apply instead
> > of open coding it.
> > 
> 
> There are two files, which are not reflinked, need to be direct_access()
> here.  The iomap_apply() can handle one file each time.  So, it seems that
> iomap_apply() is not suitable for this case...
> 
> 
> The pseudo code of this process is as follows:
> 
>   srclen = ops->begin(&srcmap)
>   destlen = ops->begin(&destmap)
> 
>   direct_access(&srcmap, &saddr)
>   direct_access(&destmap, &daddr)
> 
>   same = memcpy(saddr, daddr, min(srclen,destlen))
> 
>   ops->end(&destmap)
>   ops->end(&srcmap)
> 
> I think a nested call like this is necessary.  That's why I use the open
> code way.

This might be a good place to implement an iomap_apply2() loop that
actually /does/ walk all the extents of file1 and file2.  There's now
two users of this idiom.

(Possibly structured as a "get next mappings from both" generator
function like Matthew Wilcox keeps asking for. :))

--D

> 
> --
> Thanks,
> Ruan Shiyang.
> > 
> 
> 
