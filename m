Return-Path: <linux-fsdevel+bounces-72869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06801D0487D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4445A322B71B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C69E219E8D;
	Thu,  8 Jan 2026 15:20:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE82EFD81;
	Thu,  8 Jan 2026 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885621; cv=none; b=Os6S/PoBKyAqF8E4TPwesHGOffOiljfs9KufYG58hY21MgKF8lhFrfl2y0mY4GZQRE7woxRDUUGl9abpuADLLVkH9q8QtIFQlaLkWPH5Z6zXPWiPI55iHknM8N8VxVvQ6F0a2gJhswlWdk3e/3Mp/z2po0reJT4LJqj6bPp55yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885621; c=relaxed/simple;
	bh=NpUv25TlkIkzmuTKGn5h5KirEBQRahvysXG/JgpQMGY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbJ30AT+X63dZR+vmB4AWkxmFgFlx+5hC0febx6gZ0NRFdPU5gAQSpn1Q4fCZrx3QtKhDossNssYwZxKsXBlsvH7fcKBdi8awElGh0uv5ELOTMv3V1131neJ/bbHpfFv3LtW6EyIc0WM9kky/uGHOfkue8G5ZNbJbt+qMX7HEbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn7r84ZjSzJ467y;
	Thu,  8 Jan 2026 23:20:08 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C48540569;
	Thu,  8 Jan 2026 23:20:13 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 15:20:12 +0000
Date: Thu, 8 Jan 2026 15:20:10 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: John Groves <John@groves.net>
CC: Miklos Szeredi <miklos@szeredi.hu>, Dan Williams
	<dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, "Alison
 Schofield" <alison.schofield@intel.com>, John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, "David
 Hildenbrand" <david@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Stefan
 Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, Josef
 Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Chen
 Linxuan <chenlinxuan@uniontech.com>, "James Morse" <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>, "Sean Christopherson" <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>, Ajay
 Joshi <ajayjoshi@micron.com>, <venkataravis@micron.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V3 01/21] dax: move dax_pgoff_to_phys from
 [drivers/dax/] device.c to bus.c
Message-ID: <20260108152010.00003829@huawei.com>
In-Reply-To: <3kylgjwvrdrfe5hcgqka2x2jsgicnnjssdpjrqe32p6cdbw33x@vpm5gpcb5utm>
References: <20260107153244.64703-1-john@groves.net>
	<20260107153332.64727-1-john@groves.net>
	<20260107153332.64727-2-john@groves.net>
	<20260108104352.000079c3@huawei.com>
	<3kylgjwvrdrfe5hcgqka2x2jsgicnnjssdpjrqe32p6cdbw33x@vpm5gpcb5utm>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 8 Jan 2026 07:25:47 -0600
John Groves <John@groves.net> wrote:

> On 26/01/08 10:43AM, Jonathan Cameron wrote:
> > On Wed,  7 Jan 2026 09:33:10 -0600
> > John Groves <John@Groves.net> wrote:
> >   
> > > This function will be used by both device.c and fsdev.c, but both are
> > > loadable modules. Moving to bus.c puts it in core and makes it available
> > > to both.
> > > 
> > > No code changes - just relocated.
> > > 
> > > Signed-off-by: John Groves <john@groves.net>  
> > Hi John,
> > 
> > I don't know the code well enough to offer an opinion on whether this
> > move causes any issues or if this is the best location, so review is superficial
> > stuff only.
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/dax/bus.c    | 27 +++++++++++++++++++++++++++
> > >  drivers/dax/device.c | 23 -----------------------
> > >  2 files changed, 27 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > > index fde29e0ad68b..a2f9a3cc30a5 100644
> > > --- a/drivers/dax/bus.c
> > > +++ b/drivers/dax/bus.c
> > > @@ -7,6 +7,9 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/dax.h>
> > >  #include <linux/io.h>
> > > +#include <linux/backing-dev.h>  
> > 
> > I'm not immediately spotting why this one.  Maybe should be in a different
> > patch?
> >   
> > > +#include <linux/range.h>
> > > +#include <linux/uio.h>  
> > 
> > Why this one?  
> 
> Good eye, thanks. These must have leaked from some of the many dead ends
> that I tried before coming up with this approach.
> 
> I've dropped all new includes and it still builds :D

Range one should be there... 

> 
> > 
> > Style wise, dax seems to use reverse xmas tree for includes, so
> > this should keep to that.
> >   
> > >  #include "dax-private.h"
> > >  #include "bus.h"
> > >  
> > > @@ -1417,6 +1420,30 @@ static const struct device_type dev_dax_type = {
> > >  	.groups = dax_attribute_groups,
> > >  };
> > >  
> > > +/* see "strong" declaration in tools/testing/nvdimm/dax-dev.c  */  
> > Bonus space before that */
> > Curiously that wasn't there in the original.  
> 
> Removed.
> 
> [ ... ]
> 
> Thanks,
> John


