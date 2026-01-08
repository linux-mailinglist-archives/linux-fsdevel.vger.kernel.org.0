Return-Path: <linux-fsdevel+bounces-72868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD43D040A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB31C31A450B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDE333DEDD;
	Thu,  8 Jan 2026 15:17:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E870C33A71E;
	Thu,  8 Jan 2026 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885461; cv=none; b=nwLI927D1RzRg3Tk6jjyjewN7WyJV6S/Dy6PNILntEl2+vYj4ChAVIFknQAlwia2oPxPQ772c0aKrAVYQO/TTURI6rgveAZMjFCRB2adbpfiFC5kMCfuyLK12wnOxh7ponoRFquk3hdeeZg4rjFKZNICYENPK8CPpHNUhymgKOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885461; c=relaxed/simple;
	bh=JAMdqyvoBlEJDXg82/7KOufjpCqCeM/HByi3F8wEtLs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6rHwWFgn4ft7uA7xrbCy6q26zAedTjksraIJhA37yJwIKTPc/bjkc/DkVV7KfWDeCZJi9YMrAb4TGMf3LaK1fsncnEK79LZ8ZNnpG3iJzZK9ggxaWmQYHEgPSnku88wbCLkPXvaf8v3tfn/7bqiaW6pYkdBWEb7Eh2jsOBKqgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn7n90W89zJ46C2;
	Thu,  8 Jan 2026 23:17:33 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1555040571;
	Thu,  8 Jan 2026 23:17:38 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 15:17:35 +0000
Date: Thu, 8 Jan 2026 15:17:33 +0000
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
Subject: Re: [PATCH V3 18/21] famfs_fuse: Add holder_operations for dax
 notify_failure()
Message-ID: <20260108151733.00005f6e@huawei.com>
In-Reply-To: <20260107153332.64727-19-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
	<20260107153332.64727-1-john@groves.net>
	<20260107153332.64727-19-john@groves.net>
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

On Wed,  7 Jan 2026 09:33:27 -0600
John Groves <John@Groves.net> wrote:

> Memory errors are at least somewhat more likely on disaggregated memory
> than on-board memory. This commit registers to be notified by fsdev_dax
> in the event that a memory failure is detected.
> 
> When a file access resolves to a daxdev with memory errors, it will fail
> with an appropriate error.
> 
> If a daxdev failed fs_dax_get(), we set dd->dax_err. If a daxdev called
> our notify_failure(), set dd->error. When any of the above happens, set
> (file)->error and stop allowing access.
> 
> In general, the recovery from memory errors is to unmount the file
> system and re-initialize the memory, but there may be usable degraded
> modes of operation - particularly in the future when famfs supports
> file systems backed by more than one daxdev. In those cases,
> accessing data that is on a working daxdev can still work.
> 
> For now, return errors for any file that has encountered a memory or dax
> error.
> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/fuse/famfs.c       | 115 +++++++++++++++++++++++++++++++++++++++---
>  fs/fuse/famfs_kfmap.h |   3 +-
>  2 files changed, 109 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> index c02b14789c6e..4eb87c5c628e 100644
> --- a/fs/fuse/famfs.c
> +++ b/fs/fuse/famfs.c

> @@ -254,6 +288,38 @@ famfs_update_daxdev_table(
>  	return 0;
>  }
>  
> +static void
> +famfs_set_daxdev_err(
> +	struct fuse_conn *fc,
> +	struct dax_device *dax_devp)
> +{
> +	int i;
> +
> +	/* Gotta search the list by dax_devp;
> +	 * read lock because we're not adding or removing daxdev entries
> +	 */
> +	down_read(&fc->famfs_devlist_sem);

Use a guard()

> +	for (i = 0; i < fc->dax_devlist->nslots; i++) {
> +		if (fc->dax_devlist->devlist[i].valid) {
> +			struct famfs_daxdev *dd = &fc->dax_devlist->devlist[i];
> +
> +			if (dd->devp != dax_devp)
> +				continue;
> +
> +			dd->error = true;
> +			up_read(&fc->famfs_devlist_sem);
> +
> +			pr_err("%s: memory error on daxdev %s (%d)\n",
> +			       __func__, dd->name, i);
> +			goto done;
> +		}
> +	}
> +	up_read(&fc->famfs_devlist_sem);
> +	pr_err("%s: memory err on unrecognized daxdev\n", __func__);
> +
> +done:

If this isn't getting more interesting, just return above.

> +}
> +
>  /***************************************************************************/
>  
>  void
> @@ -611,6 +677,26 @@ famfs_file_init_dax(
>  
>  static ssize_t famfs_file_bad(struct inode *inode);
>  
> +static int famfs_dax_err(struct famfs_daxdev *dd)

I'd introduce this earlier in the series to reduce need
to refactor below.

> +{
> +	if (!dd->valid) {
> +		pr_err("%s: daxdev=%s invalid\n",
> +		       __func__, dd->name);
> +		return -EIO;
> +	}
> +	if (dd->dax_err) {
> +		pr_err("%s: daxdev=%s dax_err\n",
> +		       __func__, dd->name);
> +		return -EIO;
> +	}
> +	if (dd->error) {
> +		pr_err("%s: daxdev=%s memory error\n",
> +		       __func__, dd->name);
> +		return -EHWPOISON;
> +	}
> +	return 0;
> +}

...

> @@ -966,7 +1064,8 @@ famfs_file_bad(struct inode *inode)
>  		return -EIO;
>  	}
>  	if (meta->error) {
> -		pr_debug("%s: previously detected metadata errors\n", __func__);
> +		pr_debug("%s: previously detected metadata errors\n",
> +			 __func__);

Spurious change.

>  		return -EIO;
>  	}



