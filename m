Return-Path: <linux-fsdevel+bounces-72824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C9AD045BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D39A33F0875
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A37350D41;
	Thu,  8 Jan 2026 12:06:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00C4A4D6D;
	Thu,  8 Jan 2026 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873994; cv=none; b=rqRVjkry3txK1nf1k7SKkxCo6SoGBdGADwTPXAU0ZRUsptL9n0rad5jbTRnpavsJuQG1iZ9ZxVbz4rcNLdYMbstRuM3nYa0h11TPS5GT+9LiSULASHLFi219lDk8W2YUpM5RebUPyy6mY7w3kJaGIcAdiymC58MRmtiqCWJx0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873994; c=relaxed/simple;
	bh=g/sYTBwp403O7eXxXi6S3ShzWIZlQJYz6EEeBkbibL4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Row3UplLZ6J0pl/zAfghC77lwVCwq2pX74KqrzjIKifGOznFJ+bi2qfFPhx+wLN+vblmljYQ3CdfxWU18vo3e422tRZl7Msaq9leotT86gR1LIT+eW1tpYDgB+O7OV7eUTxePbQkgY8FRzGMIQe/G7uC7In8b6/CF4yzaqZMFSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn3XQ2fQHzHnGd7;
	Thu,  8 Jan 2026 20:06:14 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C8B540086;
	Thu,  8 Jan 2026 20:06:22 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 12:06:20 +0000
Date: Thu, 8 Jan 2026 12:06:19 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: John Groves <John@Groves.net>
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
Subject: Re: [PATCH V3 05/21] dax: Add dax_set_ops() for setting
 dax_operations at bind time
Message-ID: <20260108120619.00001bc5@huawei.com>
In-Reply-To: <20260107153332.64727-6-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
	<20260107153332.64727-1-john@groves.net>
	<20260107153332.64727-6-john@groves.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed,  7 Jan 2026 09:33:14 -0600
John Groves <John@Groves.net> wrote:

> From: John Groves <John@Groves.net>
> 
> The dax_device is created (in the non-pmem case) at hmem probe time via
> devm_create_dev_dax(), before we know which driver (device_dax,
> fsdev_dax, or kmem) will bind - by calling alloc_dax() with NULL ops,
> drivers (i.e. fsdev_dax) that need specific dax_operations must set
> them later.
> 
> Add dax_set_ops() exported function so fsdev_dax can set its ops at
> probe time and clear them on remove. device_dax doesn't need ops since
> it uses the mmap fault path directly.
> 
> Use cmpxchg() to atomically set ops only if currently NULL, returning
> -EBUSY if ops are already set. This prevents accidental double-binding.
> Clearing ops (NULL) always succeeds.
> 
> Signed-off-by: John Groves <john@groves.net>
Hi John

This one runs into the fun mess of mixing devm and other calls.
I'd advise you just don't do it because it makes code much harder
to review and hits the 'smells bad' button.

Jonathan

> ---
>  drivers/dax/fsdev.c | 12 ++++++++++++
>  drivers/dax/super.c | 38 +++++++++++++++++++++++++++++++++++++-
>  include/linux/dax.h |  1 +
>  3 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> index 9e2f83aa2584..3f4f593896e3 100644
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
> @@ -330,12 +330,24 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
>  	if (rc)
>  		return rc;
>  
> +	/* Set the dax operations for fs-dax access path */
> +	rc = dax_set_ops(dax_dev, &dev_dax_ops);
> +	if (rc)
> +		return rc;
> +
>  	run_dax(dax_dev);
>  	return devm_add_action_or_reset(dev, fsdev_kill, dev_dax);
>  }
>  
> +static void fsdev_dax_remove(struct dev_dax *dev_dax)
> +{
> +	/* Clear ops on unbind so they aren't used with a different driver */
> +	dax_set_ops(dev_dax->dax_dev, NULL);

Generally orderings of calls that mix devm and stuff done manually in remove are
a bad idea.  They can be safe (and this one probably is) but it adds a review
burden that is best avoided.

Once you stop using devm_ you need to stop it for everything.  So either
use a devm_add_action_or_reset for this or drop the one for fsdev_kill and
call that code here instead.

> +}
> +
>  static struct dax_device_driver fsdev_dax_driver = {
>  	.probe = fsdev_dax_probe,
> +	.remove = fsdev_dax_remove,
>  	.type = DAXDRV_FSDEV_TYPE,
>  };



