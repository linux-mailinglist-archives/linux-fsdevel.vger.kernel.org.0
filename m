Return-Path: <linux-fsdevel+bounces-77378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHB/D+KrlGl7GQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 18:56:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D55D014ECA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 18:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DD67300F119
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 17:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15651372B36;
	Tue, 17 Feb 2026 17:56:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D211336E46B;
	Tue, 17 Feb 2026 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351006; cv=none; b=aqr8XNUVmWpqURQmmXkNRqTSPLk9f/YIHtGBOmASEibkps70m00mKr9iTzvskW8J8Rl7fVV4EvrR4BnddLm0jWHTCZ5jQezmGCTCXaakxJXDIQJDk8+9Q98ZgONq/52usEF0sIXJd7DCg80F6OSloiyNwR2eGCqyxcs/s5C7iuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351006; c=relaxed/simple;
	bh=oj2/4OTzqpu0dYyA//lam3A5PTpYqozj74Gq+2HyEdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqKtvOA/T5Z2Hqa0PEgMI/4+2SvjluGt8TTsKKK20UOXLeFcqAZ6yJPqiFwmai55N9pnFtKZFe4780mt3I8GtAA9nO2zuDu0paWS5EdJgGzSqTf31BpO8yD5nx3V2B4NI5xtIKHzdY13HhbVojp1YlqkNEIglMeuShnan3ICNVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id B15B6B7426;
	Tue, 17 Feb 2026 17:56:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf09.hostedemail.com (Postfix) with ESMTPA id 8AE9E20024;
	Tue, 17 Feb 2026 17:56:21 +0000 (UTC)
Date: Tue, 17 Feb 2026 11:56:20 -0600
From: John Groves <John@groves.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: John Groves <john@jagalactic.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	John Groves <jgroves@fastmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V7 03/19] dax: add fsdev.c driver for fs-dax on character
 dax
Message-ID: <aZSoCIjbxKIqRZF4@groves.net>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223123.92341-1-john@jagalactic.com>
 <0100019bd33c310f-1b4a8555-bc81-4ec3-b45f-27abc01dff05-000000@email.amazonses.com>
 <698f922296bd0_bcb8910059@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698f922296bd0_bcb8910059@iweiny-mobl.notmuch>
X-Stat-Signature: y6j1pqxhf17j6byg7y66gfxz3ig3zwgp
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX1/KkrEKzlLziUMYd4+VFywKH6Bzhu5nkwM=
X-HE-Tag: 1771350981-821509
X-HE-Meta: U2FsdGVkX1+iyhLS3pUUNxA1XVBPX3+vwzhA7OjHfQD0G3oVZg2OugZtFlF9F5Ynwqfza3MI3vz/3yGnR1mjsIZfPuTUrOcYa0N5OU8m4UrZpR/OF3w1e4bjsvIUIJ3gGXNtYvM14Uc+ue4DKvwGtH51uE60CUe7kPlMMT95rV+a3EuwmtcK4mHTrDrONhWduNAsPhbKqTEmjSmJwyIjc9fX/AOUEp7o0TfFllgvRrkGtMvqUV2mDV0evbHFxz/qRxleBIrWcXcw/2qAhAGykC/4Oh4Y6uCFVjfs1cZU8YagQXQQm8x7KLDosNZxM62wf+rbT19o5pM44Hkyi7lN/GeaJI5zBGFljmRQDlRTYQLc11Eg2tBv8DzOGl7gnAiTm97L5sebthT+fNo8ajA2y8D23J4/YUJBLIiJ/biie7IDjL8eBIPz9Srd9bxRrjiNZzN6E0Yl+XDycYtSr9iHGw==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77378-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[jagalactic.com,szeredi.hu,intel.com,ddn.com,micron.com,fastmail.com,lwn.net,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[groves.net];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[John@groves.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D55D014ECA3
X-Rspamd-Action: no action

On 26/02/13 03:05PM, Ira Weiny wrote:
> John Groves wrote:
> > From: John Groves <john@groves.net>
> > 
> > The new fsdev driver provides pages/folios initialized compatibly with
> > fsdax - normal rather than devdax-style refcounting, and starting out
> > with order-0 folios.
> > 
> > When fsdev binds to a daxdev, it is usually (always?) switching from the
> > devdax mode (device.c), which pre-initializes compound folios according
> > to its alignment. Fsdev uses fsdev_clear_folio_state() to switch the
> > folios into a fsdax-compatible state.
> > 
> > A side effect of this is that raw mmap doesn't (can't?) work on an fsdev
> > dax instance. Accordingly, The fsdev driver does not provide raw mmap -
> > devices must be put in 'devdax' mode (drivers/dax/device.c) to get raw
> > mmap capability.
> > 
> > In this commit is just the framework, which remaps pages/folios compatibly
> > with fsdax.
> > 
> > Enabling dax changes:
> > 
> > - bus.h: add DAXDRV_FSDEV_TYPE driver type
> > - bus.c: allow DAXDRV_FSDEV_TYPE drivers to bind to daxdevs
> > - dax.h: prototype inode_dax(), which fsdev needs
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Suggested-by: Gregory Price <gourry@gourry.net>
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  MAINTAINERS          |   8 ++
> >  drivers/dax/Makefile |   6 ++
> >  drivers/dax/bus.c    |   4 +
> >  drivers/dax/bus.h    |   1 +
> >  drivers/dax/fsdev.c  | 242 +++++++++++++++++++++++++++++++++++++++++++
> >  fs/dax.c             |   1 +
> >  include/linux/dax.h  |   5 +
> >  7 files changed, 267 insertions(+)
> >  create mode 100644 drivers/dax/fsdev.c
> > 
> 
> [snip]
> 
> > +
> > +static int fsdev_dax_probe(struct dev_dax *dev_dax)
> > +{
> > +	struct dax_device *dax_dev = dev_dax->dax_dev;
> > +	struct device *dev = &dev_dax->dev;
> > +	struct dev_pagemap *pgmap;
> > +	u64 data_offset = 0;
> > +	struct inode *inode;
> > +	struct cdev *cdev;
> > +	void *addr;
> > +	int rc, i;
> > +
> > +	if (static_dev_dax(dev_dax))  {
> > +		if (dev_dax->nr_range > 1) {
> > +			dev_warn(dev, "static pgmap / multi-range device conflict\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		pgmap = dev_dax->pgmap;
> > +	} else {
> > +		size_t pgmap_size;
> > +
> > +		if (dev_dax->pgmap) {
> > +			dev_warn(dev, "dynamic-dax with pre-populated page map\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		pgmap_size = struct_size(pgmap, ranges, dev_dax->nr_range - 1);
> > +		pgmap = devm_kzalloc(dev, pgmap_size,  GFP_KERNEL);
> > +		if (!pgmap)
> > +			return -ENOMEM;
> > +
> > +		pgmap->nr_range = dev_dax->nr_range;
> > +		dev_dax->pgmap = pgmap;
> > +
> > +		for (i = 0; i < dev_dax->nr_range; i++) {
> > +			struct range *range = &dev_dax->ranges[i].range;
> > +
> > +			pgmap->ranges[i] = *range;
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < dev_dax->nr_range; i++) {
> > +		struct range *range = &dev_dax->ranges[i].range;
> > +
> > +		if (!devm_request_mem_region(dev, range->start,
> > +					range_len(range), dev_name(dev))) {
> > +			dev_warn(dev, "mapping%d: %#llx-%#llx could not reserve range\n",
> > +				 i, range->start, range->end);
> > +			return -EBUSY;
> > +		}
> > +	}
> 
> All of the above code is AFAICT exactly the same as the dev_dax driver.
> Isn't there a way to make this common?
> 
> The rest of the common code is simple enough.

dev_dax_probe() and fsdev_dax_probe() do indeed have some "same code" - 
range validity checking and pgmap setup, from the top of probe through 
the for loop above. After that they're different. Also, I just did a scan 
and the probe function seems like the only remaining common code between 
device.c and fsdev.c.

These are separate kmods; that code could certainly be factored out and 
shared, but it would need to go somewhere common (maybe bus.c)?

So both device.c and fsdev.c would call bus.c:dax_prepare_pgmap() or
some such.

I feel like this might not be worth factoring out, but I'm happy to do it
if you and/or the dax team prefer it factored out and shared.

> 
> > +
> > +	/*
> > +	 * FS-DAX compatible mode: Use MEMORY_DEVICE_FS_DAX type and
> > +	 * do NOT set vmemmap_shift. This leaves folios at order-0,
> > +	 * allowing fs-dax to dynamically create compound folios as needed
> > +	 * (similar to pmem behavior).
> > +	 */
> > +	pgmap->type = MEMORY_DEVICE_FS_DAX;
> > +	pgmap->ops = &fsdev_pagemap_ops;
> > +	pgmap->owner = dev_dax;
> > +
> > +	/*
> > +	 * CRITICAL DIFFERENCE from device.c:
> > +	 * We do NOT set vmemmap_shift here, even if align > PAGE_SIZE.
> > +	 * This ensures folios remain order-0 and are compatible with
> > +	 * fs-dax's folio management.
> > +	 */
> > +
> > +	addr = devm_memremap_pages(dev, pgmap);
> > +	if (IS_ERR(addr))
> > +		return PTR_ERR(addr);
> > +
> > +	/*
> > +	 * Clear any stale compound folio state left over from a previous
> > +	 * driver (e.g., device_dax with vmemmap_shift).
> > +	 */
> > +	fsdev_clear_folio_state(dev_dax);
> > +
> > +	/* Detect whether the data is at a non-zero offset into the memory */
> > +	if (pgmap->range.start != dev_dax->ranges[0].range.start) {
> > +		u64 phys = dev_dax->ranges[0].range.start;
> > +		u64 pgmap_phys = dev_dax->pgmap[0].range.start;
> > +
> > +		if (!WARN_ON(pgmap_phys > phys))
> > +			data_offset = phys - pgmap_phys;
> > +
> > +		pr_debug("%s: offset detected phys=%llx pgmap_phys=%llx offset=%llx\n",
> > +		       __func__, phys, pgmap_phys, data_offset);
> > +	}
> > +
> > +	inode = dax_inode(dax_dev);
> > +	cdev = inode->i_cdev;
> > +	cdev_init(cdev, &fsdev_fops);
> > +	cdev->owner = dev->driver->owner;
> > +	cdev_set_parent(cdev, &dev->kobj);
> > +	rc = cdev_add(cdev, dev->devt, 1);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = devm_add_action_or_reset(dev, fsdev_cdev_del, cdev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	run_dax(dax_dev);
> > +	return devm_add_action_or_reset(dev, fsdev_kill, dev_dax);
> > +}
> > +
> 
> [snip]
> 
> > diff --git a/include/linux/dax.h b/include/linux/dax.h
> > index 9d624f4d9df6..fe1315135fdd 100644
> > --- a/include/linux/dax.h
> > +++ b/include/linux/dax.h
> > @@ -51,6 +51,10 @@ struct dax_holder_operations {
> >  
> >  #if IS_ENABLED(CONFIG_DAX)
> >  struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
> > +
> > +#if IS_ENABLED(CONFIG_DEV_DAX_FS)
> > +struct dax_device *inode_dax(struct inode *inode);
> > +#endif
> 
> I don't understand why this hunk is added here but then removed in a later
> patch?  Why can't this be placed below? ...
> 
> >  void *dax_holder(struct dax_device *dax_dev);
> >  void put_dax(struct dax_device *dax_dev);
> >  void kill_dax(struct dax_device *dax_dev);
> > @@ -153,6 +157,7 @@ static inline void fs_put_dax(struct dax_device *dax_dev, void *holder)
> >  #if IS_ENABLED(CONFIG_FS_DAX)
> >  int dax_writeback_mapping_range(struct address_space *mapping,
> >  		struct dax_device *dax_dev, struct writeback_control *wbc);
> > +int dax_folio_reset_order(struct folio *folio);
> 
> ... Here?

Done, thanks - good catch. That was just sloppy factoring into a series on
my part.

> 
> Ira
> 
> [snip]

Thanks for the reviewing Ira!

Regards,
John


