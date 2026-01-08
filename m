Return-Path: <linux-fsdevel+bounces-72831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B9FD04070
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A8253142C28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345F74F798E;
	Thu,  8 Jan 2026 12:36:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0051B4F7960;
	Thu,  8 Jan 2026 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875806; cv=none; b=nkCHHfStTrSMS282aWpRja25+5p9Be+9AOz6XF7kjXG0c7+nCV4XrryJZY53xf0XAt/grZamzGvZceZGHXDUX7KIAagdEmxxYM+VoKYnOR1yTP6IJ6mkM3NWpW970POfhrczNWh4ugy9zUwszzCl9CAPEE0pKqEQOcoHoi3hmuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875806; c=relaxed/simple;
	bh=z6+q860qTZZ4J4xm1/w1OkocGu91imgffXA3+CygH8c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CURtnB+ftkc/sOQ+7hQSozMZ3cv5L7xRrY+2ZU4vCVYG3x346Z23qBuvhQzoXLldwV3yE3huAYO5DqtzW2EGc4hIzlNFmrj+5+oNTmJJxXlQ7js2UAZ6gFBPpjPS6tksMdkJzqOuVN0E/+FFAH1f86pjyJPwQ1D8f8sV+7EWWTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn4CP55przHnGhV;
	Thu,  8 Jan 2026 20:36:33 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id C991440571;
	Thu,  8 Jan 2026 20:36:41 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 12:36:40 +0000
Date: Thu, 8 Jan 2026 12:36:38 +0000
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
Subject: Re: [PATCH V3 10/21] famfs_fuse: Kconfig
Message-ID: <20260108123638.0000442e@huawei.com>
In-Reply-To: <20260107153332.64727-11-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
	<20260107153332.64727-1-john@groves.net>
	<20260107153332.64727-11-john@groves.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed,  7 Jan 2026 09:33:19 -0600
John Groves <John@Groves.net> wrote:

> Add FUSE_FAMFS_DAX config parameter, to control compilation of famfs
> within fuse.
> 
> Signed-off-by: John Groves <john@groves.net>

A separate commit for this doesn't obviously add anything over combining
it with first place the CONFIG_xxx is used.

Maybe it's a convention for fs/fuse though. If it is ignore me.

> ---
>  fs/fuse/Kconfig | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index 3a4ae632c94a..3b6d3121fe40 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -76,3 +76,17 @@ config FUSE_IO_URING
>  
>  	  If you want to allow fuse server/client communication through io-uring,
>  	  answer Y
> +
> +config FUSE_FAMFS_DAX
> +	bool "FUSE support for fs-dax filesystems backed by devdax"
> +	depends on FUSE_FS
> +	depends on DEV_DAX
> +	default FUSE_FS
> +	select DEV_DAX_FS
> +	help
> +	  This enables the fabric-attached memory file system (famfs),
> +	  which enables formatting devdax memory as a file system. Famfs
> +	  is primarily intended for scale-out shared access to
> +	  disaggregated memory.
> +
> +	  To enable famfs or other fuse/fs-dax file systems, answer Y


