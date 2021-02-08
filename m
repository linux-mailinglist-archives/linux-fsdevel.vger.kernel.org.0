Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12659313766
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 16:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhBHPYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 10:24:47 -0500
Received: from verein.lst.de ([213.95.11.211]:41777 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233681AbhBHPUF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:20:05 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B592868AFE; Mon,  8 Feb 2021 16:19:20 +0100 (CET)
Date:   Mon, 8 Feb 2021 16:19:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 5/7] fsdax: Dedup file range to use a compare function
Message-ID: <20210208151920.GE12872@lst.de>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com> <20210207170924.2933035-6-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207170924.2933035-6-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 08, 2021 at 01:09:22AM +0800, Shiyang Ruan wrote:
> With dax we cannot deal with readpage() etc. So, we create a
> funciton callback to perform the file data comparison and pass

s/funciton/function/g

> +#define MIN(a, b) (((a) < (b)) ? (a) : (b))

This should use the existing min or min_t helpers.


>  int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  				  struct file *file_out, loff_t pos_out,
> -				  loff_t *len, unsigned int remap_flags)
> +				  loff_t *len, unsigned int remap_flags,
> +				  compare_range_t compare_range_fn)

Can we keep generic_remap_file_range_prep as-is, and add a new
dax_remap_file_range_prep, both sharing a low-level
__generic_remap_file_range_prep implementation?  And for that
implementation I'd also go for classic if/else instead of the function
pointer.

> +extern int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> +					 struct inode *dest, loff_t destoff,
> +					 loff_t len, bool *is_same);

no need for the extern.
