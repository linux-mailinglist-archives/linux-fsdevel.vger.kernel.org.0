Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58C08EFF1F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 14:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389264AbfKEN7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 08:59:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:41568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388209AbfKEN7e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:59:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E376FAC44;
        Tue,  5 Nov 2019 13:59:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3C9EC1E47E5; Tue,  5 Nov 2019 14:59:32 +0100 (CET)
Date:   Tue, 5 Nov 2019 14:59:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: Re: [PATCH v7 11/11] ext4: introduce direct I/O write using iomap
 infrastructure
Message-ID: <20191105135932.GN22379@quack2.suse.cz>
References: <cover.1572949325.git.mbobrowski@mbobrowski.org>
 <e55db6f12ae6ff017f36774135e79f3e7b0333da.1572949325.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e55db6f12ae6ff017f36774135e79f3e7b0333da.1572949325.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 05-11-19 23:02:39, Matthew Bobrowski wrote:
> +	if (ret >= 0 && iov_iter_count(from)) {
> +		ssize_t err;
> +		loff_t endbyte;
> +
> +		offset = iocb->ki_pos;
> +		err = ext4_buffered_write_iter(iocb, from);
> +		if (err < 0)
> +			return err;
> +
> +		/*
> +		 * We need to ensure that the pages within the page cache for
> +		 * the range covered by this I/O are written to disk and
> +		 * invalidated. This is in attempt to preserve the expected
> +		 * direct I/O semantics in the case we fallback to buffered I/O
> +		 * to complete off the I/O request.
> +		 */
> +		ret += err;
> +		endbyte = offset + ret - 1;
				   ^^ err here?

Otherwise you would write out and invalidate too much AFAICT - the 'offset'
is position just before we fall back to buffered IO. Otherwise this hunk
looks good to me.

> +		err = filemap_write_and_wait_range(iocb->ki_filp->f_mapping,
> +						   offset, endbyte);
> +		if (!err)
> +			invalidate_mapping_pages(iocb->ki_filp->f_mapping,
> +						 offset >> PAGE_SHIFT,
> +						 endbyte >> PAGE_SHIFT);
> +	}
> +
> +	return ret;
> +}
> +

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
