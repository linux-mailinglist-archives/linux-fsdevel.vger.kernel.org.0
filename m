Return-Path: <linux-fsdevel+bounces-73048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF2FD09DED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 13:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A7793049FED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 12:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A147E35BDAB;
	Fri,  9 Jan 2026 12:30:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D373E35B134;
	Fri,  9 Jan 2026 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961838; cv=none; b=q1H4tjWALW4ILAvbvJ4z0845fp8FZKc5ZMx6ONmMwpzM/3yd6GX5hiZCdWWyW9pv9BxtDaR46oXRLkS0TO0colhD4o+l273YnkrovSXc80AB6v7CiDfvjYVC4mFABIlVVI6cR/fxBEsNUYArAHFyQsbBu/7GbTxcgYP5ONEHQaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961838; c=relaxed/simple;
	bh=in5JvqRmDAdB6dX8FGI0EEgnQhCtsywKD5TDJBxjJjU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWnRPWl/bxzc3etC+D/hDMXVL629tsfTQoVOMiMHr4DXgk7pPNAhdQZEUneOc/w+kape6VZVYxiHCW05KMIS/DXjn5TcPcQvRZnq3uYsadgoSz0KFqyDJd3ziYR/+Q/KsO8k3hcZNfEBbcMg9f9FA6lIFqBpWd7JloZTbe8Sngo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dnh1h1cXTzHnH7w;
	Fri,  9 Jan 2026 20:30:16 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 48D4440572;
	Fri,  9 Jan 2026 20:30:26 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 9 Jan
 2026 12:30:24 +0000
Date: Thu, 8 Jan 2026 16:10:13 +0000
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
Subject: Re: [PATCH V3 04/21] dax: Add dax_operations for use by fs-dax on
 fsdev dax
Message-ID: <20260108161013.00001916@huawei.com>
In-Reply-To: <gqwlb6ept22edcuiwwzxkboeioin6l4afemn3lenbduuwbb357@tnkceo5764vf>
References: <20260107153244.64703-1-john@groves.net>
	<20260107153332.64727-1-john@groves.net>
	<20260107153332.64727-5-john@groves.net>
	<20260108115037.00003295@huawei.com>
	<gqwlb6ept22edcuiwwzxkboeioin6l4afemn3lenbduuwbb357@tnkceo5764vf>
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

On Thu, 8 Jan 2026 09:59:08 -0600
John Groves <John@groves.net> wrote:

> On 26/01/08 11:50AM, Jonathan Cameron wrote:
> > On Wed,  7 Jan 2026 09:33:13 -0600
> > John Groves <John@Groves.net> wrote:
> >   
> > > From: John Groves <John@Groves.net>
> > >   
> > Hi John
> > 
> > The description should generally make sense without the title.
> > Sometimes that means more or less repeating the title.
> > 
> > A few other things inline.  
> 
> Will do
> 
> >   
> > > * These methods are based on pmem_dax_ops from drivers/nvdimm/pmem.c
> > > * fsdev_dax_direct_access() returns the hpa, pfn and kva. The kva was
> > >   newly stored as dev_dax->virt_addr by dev_dax_probe().
> > > * The hpa/pfn are used for mmap (dax_iomap_fault()), and the kva is used
> > >   for read/write (dax_iomap_rw())
> > > * fsdev_dax_recovery_write() and dev_dax_zero_page_range() have not been
> > >   tested yet. I'm looking for suggestions as to how to test those.
> > > * dax-private.h: add dev_dax->cached_size, which fsdev needs to
> > >   remember. The dev_dax size cannot change while a driver is bound
> > >   (dev_dax_resize returns -EBUSY if dev->driver is set). Caching the size
> > >   at probe time allows fsdev's direct_access path can use it without
> > >   acquiring dax_dev_rwsem (which isn't exported anyway).
> > > 
> > > Signed-off-by: John Groves <john@groves.net>  
> >   
> > > diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> > > index c5c660b193e5..9e2f83aa2584 100644
> > > --- a/drivers/dax/fsdev.c
> > > +++ b/drivers/dax/fsdev.c
> > > @@ -27,6 +27,81 @@
> > >   * - No mmap support - all access is through fs-dax/iomap
> > >   */
> > >  
> > > +static void fsdev_write_dax(void *pmem_addr, struct page *page,
> > > +		unsigned int off, unsigned int len)
> > > +{
> > > +	while (len) {
> > > +		void *mem = kmap_local_page(page);  
> > 
> > I guess it's pretty simple, but do we care about HIGHMEM for this
> > new feature?  Maybe it's just easier to support it than argue about it however ;)  
> 
> I think this compiles to zero overhead, and is an established pattern -
> but I'm ok following a consensus elsewhere...

That's fair, probably just keep it.

> > > +static long __fsdev_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> > > +			long nr_pages, enum dax_access_mode mode, void **kaddr,
> > > +			unsigned long *pfn)
> > > +{
> > > +	struct dev_dax *dev_dax = dax_get_private(dax_dev);
> > > +	size_t size = nr_pages << PAGE_SHIFT;
> > > +	size_t offset = pgoff << PAGE_SHIFT;
> > > +	void *virt_addr = dev_dax->virt_addr + offset;
> > > +	phys_addr_t phys;
> > > +	unsigned long local_pfn;
> > > +
> > > +	WARN_ON(!dev_dax->virt_addr);
> > > +
> > > +	phys = dax_pgoff_to_phys(dev_dax, pgoff, nr_pages << PAGE_SHIFT);  
> > 
> > Use size given you already computed it.  
> 
> Not sure I follow. nr_pages is the size of the access or fault, not the size
> of the device. 

Just above:

size_t size = nr_pages << PAGE_SHIFT;

Jonathan


