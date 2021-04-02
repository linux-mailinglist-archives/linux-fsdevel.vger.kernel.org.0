Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDFD35270D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 09:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhDBHr0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 03:47:26 -0400
Received: from verein.lst.de ([213.95.11.211]:42814 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233901AbhDBHrZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 03:47:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 478DE68BEB; Fri,  2 Apr 2021 09:47:21 +0200 (CEST)
Date:   Fri, 2 Apr 2021 09:47:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
Subject: Re: [PATCH v3 02/10] fsdax: Factor helper: dax_fault_actor()
Message-ID: <20210402074720.GA7057@lst.de>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com> <20210319015237.993880-3-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319015237.993880-3-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +		if (!pmd)
> +			return dax_load_hole(xas, mapping, &entry, vmf);
> +		else
> +			return dax_pmd_load_hole(xas, vmf, iomap, &entry);

> +	if (pmd)
> +		return vmf_insert_pfn_pmd(vmf, pfn, write);
> +	if (write)
> +		return vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
> +	else
> +		return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
> +}

No need for else statements after returning.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
