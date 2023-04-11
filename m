Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAE26DD1FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 07:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjDKFqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 01:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDKFqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:46:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD14131;
        Mon, 10 Apr 2023 22:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nvM8pxlJ1Talzo7VMGNpTDLLNruDc+YtSG3z16ERgm0=; b=G82AJC/Oflgo3gckIbFm9SimSb
        f7YVW22exExmG83ZxkZ6mojVaNLSrH5mi/H4JhtqlYcEEy8PiHmCs5r6rOocgZCD/foZDMtc0tTyu
        SPK0dVCHM1wKBDJTCycUZfwuSikd+YSlmS+6/rFm2DszSYu6ssNkhTJQ039SSqGCLZA+vPFDzjFH8
        6n/abYJ9TVgO+S0erkwSzqIjxTayhnogluLWnNA0CXOZgvJaRzBr7gAl7BxbA2OelGzf7/m2EK6mX
        SDLpIwp014Ypq1+44YXuomXq8TYIlFOiwiuglGVGrFTQLxUszBpcHNo0HQIW+eh140DkPrNpqjY+c
        U5PyNa1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pm6pY-00GUhW-08;
        Tue, 11 Apr 2023 05:46:12 +0000
Date:   Mon, 10 Apr 2023 22:46:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 5/8] ext2: Move direct-io to use iomap
Message-ID: <ZDT0JFmwg/9ijdcv@infradead.org>
References: <cover.1681188927.git.ritesh.list@gmail.com>
 <e51f9a43f976d1b70d163fed791d960b88f044e2.1681188927.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e51f9a43f976d1b70d163fed791d960b88f044e2.1681188927.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 11, 2023 at 10:51:53AM +0530, Ritesh Harjani (IBM) wrote:
> +extern void ext2_write_failed(struct address_space *mapping, loff_t to);

No need for the extern.

> +	/* handle case for partial write and for fallback to buffered write */
> +	if (ret >= 0 && iov_iter_count(from)) {
> +		loff_t pos, endbyte;
> +		ssize_t status;
> +		int ret2;
> +
> +		iocb->ki_flags &= ~IOCB_DIRECT;
> +		pos = iocb->ki_pos;
> +		status = generic_perform_write(iocb, from);
> +		if (unlikely(status < 0)) {
> +			ret = status;
> +			goto out_unlock;
> +		}
> +
> +		iocb->ki_pos += status;
> +		ret += status;
> +		endbyte = pos + status - 1;
> +		ret2 = filemap_write_and_wait_range(inode->i_mapping, pos,
> +						    endbyte);
> +		if (!ret2)
> +			invalidate_mapping_pages(inode->i_mapping,
> +						 pos >> PAGE_SHIFT,
> +						 endbyte >> PAGE_SHIFT);
> +		if (ret > 0)
> +			generic_write_sync(iocb, ret);
> +	}

Nit, but to me it would seem cleaner if all the fallback handling
was moved into a separate helper function.  Or in fact by not
using generic_file_write_iter even for buffered I/O and at doing
the pre-I/O checks and the final generic_write_sync in common code in
ext2 for direct and buffered I/O.

> +	/*
> +	 * For writes that could fill holes inside i_size on a
> +	 * DIO_SKIP_HOLES filesystem we forbid block creations: only
> +	 * overwrites are permitted.
> +	 */
> +	if ((flags & IOMAP_DIRECT) && (first_block << blkbits < i_size_read(inode)))
> +		create = 0;

No need for braes around the < operation, but I think you might need
them around the shift.

Also an overly long line here.

> +	if ((flags & IOMAP_WRITE) && (offset + length > i_size_read(inode)))

No need for the second set of inner braces here either.
