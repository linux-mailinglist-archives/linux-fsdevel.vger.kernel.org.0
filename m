Return-Path: <linux-fsdevel+bounces-6055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B774812FA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 13:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD7C1C2198F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 12:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA33F41227;
	Thu, 14 Dec 2023 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7l7NPQe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7A0B9;
	Thu, 14 Dec 2023 04:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702555379; x=1734091379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=563D9nECUGI/og8VRk92+ujEBSTYRs1beJ3uhY8y7zs=;
  b=d7l7NPQe3CJulGImA8XbKtmYRe2a6xvH+/WlIKvc08uYBQWnzI1uPCXO
   eOEuTtH9oWv7jBU/xYw2r17Rnxn6NWjFhDBi6eYCSrZrJ5oU0aLzDPLnP
   Pd3NaH2ccd3uYySJbzrWxtsjQLblEx7GEu1DEtB0o15sNjiTERT8bNk+3
   WHDk2EWF5484p0PxOUt1VRX5BhqHnLfv8WPbHh1/2DTbtYByiEfm1yh72
   KcGJR1F4/ye44WY1HvSExG2A/S1EA69vnO5Rt7TF8h+kd7yc/oWNjlGIg
   z7ziyc9G7RF0Ew1VTMJF0s30Ax/ZBTKW+zVqOCcP6QvFIMRU89gXYveqB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="397892475"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="397892475"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 04:02:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="808560608"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="808560608"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.7.207])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 04:02:57 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 3/4] minixfs: Use dir_put_page() in minix_unlink() and
 minix_rename()
Date: Thu, 14 Dec 2023 13:02:54 +0100
Message-ID: <4082441.irdbgypaU6@fdefranc-mobl3>
Organization: intel
In-Reply-To: <20231213000849.2748576-3-viro@zeniv.linux.org.uk>
References:
 <20231213000656.GI1674809@ZenIV>
 <20231213000849.2748576-1-viro@zeniv.linux.org.uk>
 <20231213000849.2748576-3-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 13 December 2023 01:08:48 CET Al Viro wrote:
> ... rather than open-coding it there.  Counterpart of the
> corresponding fs/sysv commit from Fabio's series...

Yes, I can still remember this code ;)

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/minix/dir.c   |  6 ------
>  fs/minix/minix.h |  5 +++++
>  fs/minix/namei.c | 12 ++++--------
>  3 files changed, 9 insertions(+), 14 deletions(-)

Reviewed-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>

> diff --git a/fs/minix/dir.c b/fs/minix/dir.c
> index 4e5483adea40..ccb6c47fd7fe 100644
> --- a/fs/minix/dir.c
> +++ b/fs/minix/dir.c
> @@ -26,12 +26,6 @@ const struct file_operations minix_dir_operations = {
>  	.fsync		= generic_file_fsync,
>  };
> 
> -static inline void dir_put_page(struct page *page)
> -{
> -	kunmap(page);
> -	put_page(page);
> -}
> -
>  /*
>   * Return the offset into page `page_nr' of the last valid
>   * byte in that page, plus one.
> diff --git a/fs/minix/minix.h b/fs/minix/minix.h
> index d493507c064f..cb42b6cf7909 100644
> --- a/fs/minix/minix.h
> +++ b/fs/minix/minix.h
> @@ -64,6 +64,11 @@ extern int V2_minix_get_block(struct inode *, long,
> struct buffer_head *, int); extern unsigned V1_minix_blocks(loff_t, struct
> super_block *);
>  extern unsigned V2_minix_blocks(loff_t, struct super_block *);
> 
> +static inline void dir_put_page(struct page *page)
> +{
> +	kunmap(page);
> +	put_page(page);
> +}
>  extern struct minix_dir_entry *minix_find_entry(struct dentry*, struct
> page**); extern int minix_add_link(struct dentry*, struct inode*);
>  extern int minix_delete_entry(struct minix_dir_entry*, struct page*);
> diff --git a/fs/minix/namei.c b/fs/minix/namei.c
> index 114084d5636a..20923a15e30a 100644
> --- a/fs/minix/namei.c
> +++ b/fs/minix/namei.c
> @@ -149,8 +149,7 @@ static int minix_unlink(struct inode * dir, struct
> dentry *dentry) if (!de)
>  		return -ENOENT;
>  	err = minix_delete_entry(de, page);
> -	kunmap(page);
> -	put_page(page);
> +	dir_put_page(page);
> 
>  	if (err)
>  		return err;
> @@ -242,13 +241,10 @@ static int minix_rename(struct mnt_idmap *idmap,
>  			inode_dec_link_count(old_dir);
>  	}
>  out_dir:
> -	if (dir_de) {
> -		kunmap(dir_page);
> -		put_page(dir_page);
> -	}
> +	if (dir_de)
> +		dir_put_page(dir_page);
>  out_old:
> -	kunmap(old_page);
> -	put_page(old_page);
> +	dir_put_page(old_page);
>  out:
>  	return err;
>  }





