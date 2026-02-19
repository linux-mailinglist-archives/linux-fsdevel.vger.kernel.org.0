Return-Path: <linux-fsdevel+bounces-77725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNkGIRhBl2lXwAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 17:58:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD8C160DB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 17:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AEB0230028C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 16:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E10434D90D;
	Thu, 19 Feb 2026 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TaGDbfVt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEA534BA49;
	Thu, 19 Feb 2026 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520268; cv=none; b=NmdXUe40/8n0L67GIhSgX5yMVnPHZlfmV84/CuIQPQdpNcgJ5W6KLEL/ymWlHlgVu8xvlxl7BwLhNlI4OXCbmnxIX9B8sLAcdH3MroQ5sY6LPwJlFWBEr2YK7A0lqU5DGiToRqFYI7w3in+zDyUcc/yzJQWfZnqFto7IR+vZdPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520268; c=relaxed/simple;
	bh=keGxv0XW9uGTEDwJr6o3ruRqzxs29dY4le2+vnuYBmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hoQ8I1F6CzAOCuywK+1V78GFVIKY30wWyZ9S/Ab6A6tQyMdbQMIYK5yCRNQ02+VSnWQwCUIc0jtcbvTtk7z2nhtwzcSzbQ+shaYSsGBk1yqUcgkZ/AT3UTHw4AIlfSvn6d7xPHa3rKbHU50sw9qYNHTy0X669id3Z57bk0o54lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TaGDbfVt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771520268; x=1803056268;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=keGxv0XW9uGTEDwJr6o3ruRqzxs29dY4le2+vnuYBmc=;
  b=TaGDbfVtzNifoVeqkzBffyt7LVA4kYjFo2CraoWxg4cFtxdZhuDYvSwj
   qnkBIi882f+oyt8QBE89uqdDfRTZOelyi7s6OOZ6sf5ndoUIRnEBzoB0C
   0kpKVl56c9RRY+Kz8Z78kcEUAYiItTgVBgy7esOoNqujt1VhXcm8FUzwI
   0eO+IknnbkXudzTN/H3H1n3HClr8tP+El4/l+ERoMZYcWTgSIcimzXrbT
   AFlquZm9tk9xGUKfNRCOjCVXbK31HRIadykrpU5yQ2aOMaspaOzWtSrHU
   riztf7SxY5ugCgMgGpYm+AW2buFDkcUx4JDr1XrhPT0uaeFL6XO8v+Dxc
   Q==;
X-CSE-ConnectionGUID: FyslofPgRladKVeR3L9xzw==
X-CSE-MsgGUID: QVp4Rv1dSdipKiKrbYMKPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72673339"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="72673339"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 08:57:47 -0800
X-CSE-ConnectionGUID: ykm5XSKSSde0hbYU1GXsFQ==
X-CSE-MsgGUID: AE6JY0wCRuKWlSheAE0Ngw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="218721860"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.20]) ([10.125.110.20])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 08:57:44 -0800
Message-ID: <512b96fc-c5b0-4388-b640-1a6afd022d80@intel.com>
Date: Thu, 19 Feb 2026 09:57:43 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 11/19] famfs_fuse: Basic fuse kernel ABI enablement for
 famfs
To: John Groves <john@jagalactic.com>, John Groves <John@Groves.net>,
 Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>,
 Bernd Schubert <bschubert@ddn.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 David Hildenbrand <david@kernel.org>, Christian Brauner
 <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong
 <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>,
 Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>,
 Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
 Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>,
 Ajay Joshi <ajayjoshi@micron.com>,
 "venkataravis@micron.com" <venkataravis@micron.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223247.92522-1-john@jagalactic.com>
 <0100019bd33d6668-75812abd-cb8a-487e-90b9-0fd2b9ad9e89-000000@email.amazonses.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0100019bd33d6668-75812abd-cb8a-487e-90b9-0fd2b9ad9e89-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-77725-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email,groves.net:email]
X-Rspamd-Queue-Id: BDD8C160DB2
X-Rspamd-Action: no action



On 1/18/26 3:32 PM, John Groves wrote:
> From: John Groves <john@groves.net>
> 
> This patch starts the kernel ABI enablement of famfs in fuse.
> 
> - Kconfig: Add FUSE_FAMFS_DAX config parameter, to control
>   compilation of famfs within fuse.
> - FUSE_DAX_FMAP flag in INIT request/reply
> - fuse_conn->famfs_iomap (enable famfs-mapped files) to denote a
>   famfs-enabled connection
> 
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: John Groves <john@groves.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  fs/fuse/Kconfig           | 14 ++++++++++++++
>  fs/fuse/fuse_i.h          |  3 +++
>  fs/fuse/inode.c           |  6 ++++++
>  include/uapi/linux/fuse.h |  5 +++++
>  4 files changed, 28 insertions(+)
> 
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index 3a4ae632c94a..5ca9fae62c7b 100644
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
> +	depends on FS_DAX
> +	default FUSE_FS
> +	help
> +	  This enables the fabric-attached memory file system (famfs),
> +	  which enables formatting devdax memory as a file system. Famfs
> +	  is primarily intended for scale-out shared access to
> +	  disaggregated memory.
> +
> +	  To enable famfs or other fuse/fs-dax file systems, answer Y
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 45e108dec771..2839efb219a9 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -921,6 +921,9 @@ struct fuse_conn {
>  	/* Is synchronous FUSE_INIT allowed? */
>  	unsigned int sync_init:1;
>  
> +	/* dev_dax_iomap support for famfs */
> +	unsigned int famfs_iomap:1;
> +
>  	/* Use io_uring for communication */
>  	unsigned int io_uring;
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index ed667920997f..acabf92a11f8 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1456,6 +1456,10 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  
>  			if (flags & FUSE_REQUEST_TIMEOUT)
>  				timeout = arg->request_timeout;
> +
> +			if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&
> +			    flags & FUSE_DAX_FMAP)
> +				fc->famfs_iomap = 1;
>  		} else {
>  			ra_pages = fc->max_read / PAGE_SIZE;
>  			fc->no_lock = 1;
> @@ -1517,6 +1521,8 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
>  		flags |= FUSE_SUBMOUNTS;
>  	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>  		flags |= FUSE_PASSTHROUGH;
> +	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
> +		flags |= FUSE_DAX_FMAP;
>  
>  	/*
>  	 * This is just an information flag for fuse server. No need to check
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index c13e1f9a2f12..25686f088e6a 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -240,6 +240,9 @@
>   *  - add FUSE_COPY_FILE_RANGE_64
>   *  - add struct fuse_copy_file_range_out
>   *  - add FUSE_NOTIFY_PRUNE
> + *
> + *  7.46
> + *  - Add FUSE_DAX_FMAP capability - ability to handle in-kernel fsdax maps
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -448,6 +451,7 @@ struct fuse_file_lock {
>   * FUSE_OVER_IO_URING: Indicate that client supports io-uring
>   * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
>   *			 init_out.request_timeout contains the timeout (in secs)
> + * FUSE_DAX_FMAP: kernel supports dev_dax_iomap (aka famfs) fmaps
>   */
>  #define FUSE_ASYNC_READ		(1 << 0)
>  #define FUSE_POSIX_LOCKS	(1 << 1)
> @@ -495,6 +499,7 @@ struct fuse_file_lock {
>  #define FUSE_ALLOW_IDMAP	(1ULL << 40)
>  #define FUSE_OVER_IO_URING	(1ULL << 41)
>  #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
> +#define FUSE_DAX_FMAP		(1ULL << 43)
>  
>  /**
>   * CUSE INIT request/reply flags


