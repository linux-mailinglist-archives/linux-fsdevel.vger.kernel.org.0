Return-Path: <linux-fsdevel+bounces-12939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E483868DAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 11:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA04428E86B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 10:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749CD1386AA;
	Tue, 27 Feb 2024 10:34:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8601B1DFF0;
	Tue, 27 Feb 2024 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030076; cv=none; b=YDWxLdQisWVxGY0QY0U44gp0ZAx0w/KefpkmDRDeUWZFd8VLlHxZIU2KAvEye39R54OxBa/a3oWEtVR0+4DvUvwMUkJCqO4avL0gffO+98yG9f9vbJSy2ix3BfCkwDX7VdhqRIYo0Bl/G48F7vGmjG0iPZ6gdBO+vQclnxM0Rkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030076; c=relaxed/simple;
	bh=rq30rbnIvctTRtsZdN+r5jwNIkoDDZRInFyNbgXLyHo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcekGOgyS/NsUj86wjFlNa3HrVh5szNXCHX4rCJC+hz1XwdyyU1NzXvb0KGLCQC18TYfZG0gYbOPkcUk3KR3o1QuN1tLl9wl6GsqOCss0w097wJ7Hy8XffFN7+LNPVYpAZzVheAQ3K6TOUnvWpEQMjbKeqhjVtBZqshsb0pherA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TkYdS29fTz6J9Zy;
	Tue, 27 Feb 2024 18:29:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F26F614058E;
	Tue, 27 Feb 2024 18:34:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 10:34:24 +0000
Date: Tue, 27 Feb 2024 10:34:23 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: John Groves <John@groves.net>
CC: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, "Dan
 Williams" <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <john@jagalactic.com>, Dave Chinner
	<david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>,
	<dave.hansen@linux.intel.com>, <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 09/20] famfs: Add super_operations
Message-ID: <20240227103423.0000510e@Huawei.com>
In-Reply-To: <z3tnfxbbvhtbyantbm3yr3yv2qsih7darbm3p5pwwdsknuxlqa@rvexwleaixiy>
References: <cover.1708709155.git.john@groves.net>
	<537f836056c141ae093c42b9623d20de919083b1.1708709155.git.john@groves.net>
	<20240226125136.00002e64@Huawei.com>
	<z3tnfxbbvhtbyantbm3yr3yv2qsih7darbm3p5pwwdsknuxlqa@rvexwleaixiy>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 26 Feb 2024 15:47:53 -0600
John Groves <John@groves.net> wrote:

> On 24/02/26 12:51PM, Jonathan Cameron wrote:
> > On Fri, 23 Feb 2024 11:41:53 -0600
> > John Groves <John@Groves.net> wrote:
> >   
> > > Introduce the famfs superblock operations
> > > 
> > > Signed-off-by: John Groves <john@groves.net>
> > > ---
> > >  fs/famfs/famfs_inode.c | 72 ++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 72 insertions(+)
> > >  create mode 100644 fs/famfs/famfs_inode.c
> > > 
> > > diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
> > > new file mode 100644
> > > index 000000000000..3329aff000d1
> > > --- /dev/null
> > > +++ b/fs/famfs/famfs_inode.c
> > > @@ -0,0 +1,72 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * famfs - dax file system for shared fabric-attached memory
> > > + *
> > > + * Copyright 2023-2024 Micron Technology, inc
> > > + *
> > > + * This file system, originally based on ramfs the dax support from xfs,
> > > + * is intended to allow multiple host systems to mount a common file system
> > > + * view of dax files that map to shared memory.
> > > + */
> > > +
> > > +#include <linux/fs.h>
> > > +#include <linux/pagemap.h>
> > > +#include <linux/highmem.h>
> > > +#include <linux/time.h>
> > > +#include <linux/init.h>
> > > +#include <linux/string.h>
> > > +#include <linux/backing-dev.h>
> > > +#include <linux/sched.h>
> > > +#include <linux/parser.h>
> > > +#include <linux/magic.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/uaccess.h>
> > > +#include <linux/fs_context.h>
> > > +#include <linux/fs_parser.h>
> > > +#include <linux/seq_file.h>
> > > +#include <linux/dax.h>
> > > +#include <linux/hugetlb.h>
> > > +#include <linux/uio.h>
> > > +#include <linux/iomap.h>
> > > +#include <linux/path.h>
> > > +#include <linux/namei.h>
> > > +#include <linux/pfn_t.h>
> > > +#include <linux/blkdev.h>  
> > 
> > That's a lot of header for such a small patch.. I'm going to guess
> > they aren't all used - bring them in as you need them - I hope
> > you never need some of these!  
> 
> I didn't phase in headers in this series. Based on these recommendations,
> the next version of this series is gonna have to be 100% constructed from
> scratch, but okay. My head hurts just thinking about it. I need a nap...
> 
> I've been rebasing for 3 weeks to get this series out, and it occurs to
> me that maybe there are tools I'm not aware of that make it eaiser? I'm
> just typing "rebase -i..." 200 times a day. Is there a less soul-crushing way?

Hmm. There are things that make it easier to pick and chose parts of a
big diff for different patches.  Some combination of 
git reset HEAD~1
and one of the 'graphical' tools like tig that let you pick lines.

That lets you quickly break up a patch where you want to move things, then
you can reorder the patches to put them next to where you want to move
changes to and rely on git rebase -i with f or s to squash them.

Figuring out optimum path to the eventual break up you want is
a skill though.  When doing this sort of mangling I tend to get it wrong
and shout at my computer a few times a day ;)
Then git rebase --abort and try again.

End result is that you end up with coherent series and it looks like
you wrote perfect code in nice steps from the start!

Jonathan



