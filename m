Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4D340D316
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 08:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbhIPGSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 02:18:17 -0400
Received: from verein.lst.de ([213.95.11.211]:38674 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234395AbhIPGSQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:18:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F53568AFE; Thu, 16 Sep 2021 08:16:54 +0200 (CEST)
Date:   Thu, 16 Sep 2021 08:16:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     djwong@kernel.org, hch@lst.de, linux-xfs@vger.kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, rgoldwyn@suse.de, viro@zeniv.linux.org.uk,
        willy@infradead.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH v9 5/8] fsdax: Add dax_iomap_cow_copy() for
 dax_iomap_zero
Message-ID: <20210916061654.GB13306@lst.de>
References: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com> <20210915104501.4146910-6-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915104501.4146910-6-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 06:44:58PM +0800, Shiyang Ruan wrote:
> +	rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
> +	if (rc < 0)
> +		goto out;
> +	memset(kaddr + offset, 0, size);
> +	if (srcmap->addr != IOMAP_HOLE && srcmap->addr != iomap->addr) {

Should we also check that ->dax_dev for iomap and srcmap are different
first to deal with case of file system with multiple devices?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
