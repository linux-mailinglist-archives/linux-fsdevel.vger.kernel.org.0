Return-Path: <linux-fsdevel+bounces-77479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN3xD0AKlWmTKQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 01:39:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D50AB1525B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 01:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B15653024C9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EB125A321;
	Wed, 18 Feb 2026 00:39:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1F13EBF22;
	Wed, 18 Feb 2026 00:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771375156; cv=none; b=bZf+e5VTAreSE1GC1Pw+Seuj4PLePo5liRATne4lJ2Z6gOwWjhqCSELNnMqxHXZLm9JK/bCz2/Zex/z6QQRc0odtFFPckxQJbsURuqknhSJsccl9PZpXQ8U7efDQshdClTNbeMYKXSMHTu+QKsuU7gWXkckP15PpH8S5R6tR6ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771375156; c=relaxed/simple;
	bh=N7Kt1rlSYfggHAi5kZ/FbucKlFPKkRRUWnHc7hvpR7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVMiCeLEqmmhDWzMpsFVF9bvnSN0ydu1V9Pll9/ZHdbVlckXpcOl7tm52pOsTBc0i16+ZD/YIV8YQuDmTtx0O1crYstvzG+XKz70iWqazm5KKNszxVb0jjBeR8CRkCz+mQyHKS1nT92RnKzYRAfMnpvmMlot0JNHriTTStszwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id A315813AB5F;
	Wed, 18 Feb 2026 00:39:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf16.hostedemail.com (Postfix) with ESMTPA id A77DA2000D;
	Wed, 18 Feb 2026 00:39:00 +0000 (UTC)
Date: Tue, 17 Feb 2026 18:38:59 -0600
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
Subject: Re: [PATCH V7 05/19] dax: Add dax_operations for use by fs-dax on
 fsdev dax
Message-ID: <aZUJxi5mzEd1Tojw@groves.net>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223147.92389-1-john@jagalactic.com>
 <0100019bd33c798b-b40d52e8-b393-4a54-9cc2-f30ee62b566f-000000@email.amazonses.com>
 <698f96436c715_bcb89100ea@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698f96436c715_bcb89100ea@iweiny-mobl.notmuch>
X-Stat-Signature: f4jo787zpakzf3y9zwtrhjdk1ybczeo8
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX1/8h3J39DJgkhqm4GBq3iPbDEOPKnf5irY=
X-HE-Tag: 1771375140-854600
X-HE-Meta: U2FsdGVkX19555SNH4TgDw+0D/5WySkCoz344yjmE1drTBd2BDahmB/atoWRuzxIEAC786D/K4NiAhiqTbKLSAqDxQvxqPxT8Od/9C2v//mKOXN/CHgE3gYP2dxH+37rDlBlriOFxFuYWE3Ixmv7MVw+ts4ERsZLsncB/MTDX+6GmAqyW9+I8vwwpCLRAFWZodzJv5dmnhx6GVCeysC4Rx0cTag39mxqDJgl1GAta2IIMiyqx+EkhhMqh6FHkiWZ5hGK7kh6kl3ykgfnBzG0q69IQsVtBVXUbV43PLJ2shR5M8nh1TYjRpc4YsugtX6/3g4uA71iG6zYeYfY7h/XIxfIX8k5d8j2uKXCIwiZ/nuHIqiavmkj+OlsWj4Vxfjb
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77479-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D50AB1525B0
X-Rspamd-Action: no action

On 26/02/13 03:23PM, Ira Weiny wrote:
> John Groves wrote:
> > From: John Groves <John@Groves.net>
> > 
> > fsdev: Add dax_operations for use by famfs
> > 
> > - These methods are based on pmem_dax_ops from drivers/nvdimm/pmem.c
> > - fsdev_dax_direct_access() returns the hpa, pfn and kva. The kva was
> >   newly stored as dev_dax->virt_addr by dev_dax_probe().
> > - The hpa/pfn are used for mmap (dax_iomap_fault()), and the kva is used
> >   for read/write (dax_iomap_rw())
> > - fsdev_dax_recovery_write() and dev_dax_zero_page_range() have not been
> >   tested yet. I'm looking for suggestions as to how to test those.
> > - dax-private.h: add dev_dax->cached_size, which fsdev needs to
> >   remember. The dev_dax size cannot change while a driver is bound
> >   (dev_dax_resize returns -EBUSY if dev->driver is set). Caching the size
> >   at probe time allows fsdev's direct_access path can use it without
> >   acquiring dax_dev_rwsem (which isn't exported anyway).
> > 
> > Signed-off-by: John Groves <john@groves.net>
> 
> [snip]
> 
> > +
> > +static long __fsdev_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> > +			long nr_pages, enum dax_access_mode mode, void **kaddr,
> > +			unsigned long *pfn)
> > +{
> > +	struct dev_dax *dev_dax = dax_get_private(dax_dev);
> > +	size_t size = nr_pages << PAGE_SHIFT;
> > +	size_t offset = pgoff << PAGE_SHIFT;
> > +	void *virt_addr = dev_dax->virt_addr + offset;
> > +	phys_addr_t phys;
> > +	unsigned long local_pfn;
> > +
> > +	WARN_ON(!dev_dax->virt_addr);
> 
> WARN_ON_ONCE.  But frankly I'm pretty sure this is impossible to hit given
> the probe call, so best remove it.  Also yall already used dev_dax->virt_addr
> above.  And will hand back a bad address to the caller.  So...

Good point - dropped it.

> 
> > +
> > +	phys = dax_pgoff_to_phys(dev_dax, pgoff, nr_pages << PAGE_SHIFT);
> > +	if (phys == -1) {
> > +		dev_dbg(&dev_dax->dev,
> > +			"pgoff (%#lx) out of range\n", pgoff);
> > +		return -ERANGE;
> 
> EFAULT?

This feels like a judgment call, but I'm fine with it.
Changed to -EFAULT

> 
> Ira
> 
> [snip]

Thanks Ira!
John


