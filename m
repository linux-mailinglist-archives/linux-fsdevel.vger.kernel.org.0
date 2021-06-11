Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1AC3A47D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 19:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFKRZK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 13:25:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:4063 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFKRZI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:25:08 -0400
IronPort-SDR: hO+R290UXHoAaSJSuME/ndDQO5/wgyIgNS6AstbgjIth/eLM6gyE2TcoEFrDSjTkRWT/HI5xvx
 ypGB9R+6juNA==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="203736303"
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="203736303"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 10:23:02 -0700
IronPort-SDR: 4i+fT2T1As8HkdjpSkkPnDzx3VtZbWksMoCKSu7s9TAtGFU6y5K4ELwo+Gx8S4tbuW+OBexGOg
 jrbJDfsXs29w==
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="483339389"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 10:23:02 -0700
Date:   Fri, 11 Jun 2021 10:23:01 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs/fuse: Remove unneeded kaddr parameter
Message-ID: <20210611172301.GA1600546@iweiny-DESK2.sc.intel.com>
References: <20210525172428.3634316-1-ira.weiny@intel.com>
 <20210525172428.3634316-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525172428.3634316-2-ira.weiny@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 10:24:26AM -0700, 'Ira Weiny' wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> fuse_dax_mem_range_init() does not need the address or the pfn of the
> memory requested in dax_direct_access().  It is only calling direct
> access to get the number of pages.

In looking for feedback on this small series I realize that I failed to email
Miklos for the fs/fuse patch.

I'm adding Miklos to the To line...

For the rest of the series is there any feedback?

Ira

> 
> Remove the unused variables and stop requesting the kaddr and pfn from
> dax_direct_access().
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  fs/fuse/dax.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index ff99ab2a3c43..34f8a5635c7f 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -1234,8 +1234,6 @@ void fuse_dax_conn_free(struct fuse_conn *fc)
>  static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
>  {
>  	long nr_pages, nr_ranges;
> -	void *kaddr;
> -	pfn_t pfn;
>  	struct fuse_dax_mapping *range;
>  	int ret, id;
>  	size_t dax_size = -1;
> @@ -1247,8 +1245,8 @@ static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
>  	INIT_DELAYED_WORK(&fcd->free_work, fuse_dax_free_mem_worker);
>  
>  	id = dax_read_lock();
> -	nr_pages = dax_direct_access(fcd->dev, 0, PHYS_PFN(dax_size), &kaddr,
> -				     &pfn);
> +	nr_pages = dax_direct_access(fcd->dev, 0, PHYS_PFN(dax_size), NULL,
> +				     NULL);
>  	dax_read_unlock(id);
>  	if (nr_pages < 0) {
>  		pr_debug("dax_direct_access() returned %ld\n", nr_pages);
> -- 
> 2.28.0.rc0.12.gb6a658bd00c9
> 
