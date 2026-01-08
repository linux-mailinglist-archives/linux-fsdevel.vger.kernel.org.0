Return-Path: <linux-fsdevel+bounces-72821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D25D03C05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 595173255635
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 14:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF73E3FB208;
	Thu,  8 Jan 2026 11:33:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B34D3ED633;
	Thu,  8 Jan 2026 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871982; cv=none; b=ud9yRoysxY0vhGCiV6mV78m0u7JdSMyhc/MCGEVJPJKxeoER7Znyoz3PFjyzCjfkaHSguZQe84Sa5mvvxeyoQKDM9NOvX7CRpJ7/7sAML5LDJ1kl/aMjeix73MmLO9/PgErpWP6MXxWKFFm4QPldtZjfgax4jiv2PET0jBqfQTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871982; c=relaxed/simple;
	bh=19yj1ippT+lFgZqkEqVduhYtECDl/VwUE/AFC+VPjZg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOBDGX9E7fFnttw+CItBU+/Bw4PTiCvMQgDbTCYs70FfnzPTTN8ObiIjFonc5NpKWWv57PqzF9p6cqJ5LBapHhRRv8z1jRhLNuo3R0mJj9PBH9NmFEina2+zR94NHgQb4za6qjOSDJ3xTbxFVuayz1MoC4ccVv98Oj6+IiYffiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn2nt0fn9zJ46db;
	Thu,  8 Jan 2026 19:32:50 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id D070540086;
	Thu,  8 Jan 2026 19:32:54 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 11:32:53 +0000
Date: Thu, 8 Jan 2026 11:32:51 +0000
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
Subject: Re: [PATCH V3 03/21] dax: Save the kva from memremap
Message-ID: <20260108113251.00004f1c@huawei.com>
In-Reply-To: <20260107153332.64727-4-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
	<20260107153332.64727-1-john@groves.net>
	<20260107153332.64727-4-john@groves.net>
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

On Wed,  7 Jan 2026 09:33:12 -0600
John Groves <John@Groves.net> wrote:

> Save the kva from memremap because we need it for iomap rw support.
> 
> Prior to famfs, there were no iomap users of /dev/dax - so the virtual
> address from memremap was not needed.
> 
> (also fill in missing kerneldoc comment fields for struct dev_dax)

Do that as a precursor that can be picked up ahead of the rest of the series.

> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  drivers/dax/dax-private.h | 4 ++++
>  drivers/dax/fsdev.c       | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index 0867115aeef2..1bb1631af485 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -69,18 +69,22 @@ struct dev_dax_range {
>   * data while the device is activated in the driver.
>   * @region - parent region
>   * @dax_dev - core dax functionality
> + * @virt_addr - kva from memremap; used by fsdev_dax
> + * @align - alignment of this instance
>   * @target_node: effective numa node if dev_dax memory range is onlined
>   * @dyn_id: is this a dynamic or statically created instance
>   * @id: ida allocated id when the dax_region is not static
>   * @ida: mapping id allocator
>   * @dev - device core
>   * @pgmap - pgmap for memmap setup / lifetime (driver owned)
> + * @memmap_on_memory - allow kmem to put the memmap in the memory
>   * @nr_range: size of @ranges
>   * @ranges: range tuples of memory used
>   */
>  struct dev_dax {
>  	struct dax_region *region;
>  	struct dax_device *dax_dev;
> +	void *virt_addr;
>  	unsigned int align;
>  	int target_node;
>  	bool dyn_id;
> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> index 2a3249d1529c..c5c660b193e5 100644
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
> @@ -235,6 +235,7 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
>  		pr_debug("%s: offset detected phys=%llx pgmap_phys=%llx offset=%llx\n",
>  		       __func__, phys, pgmap_phys, data_offset);
>  	}
> +	dev_dax->virt_addr = addr + data_offset;
>  
>  	inode = dax_inode(dax_dev);
>  	cdev = inode->i_cdev;


