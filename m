Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA51E693F97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 09:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBMI2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 03:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBMI22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:28:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E919A93EE;
        Mon, 13 Feb 2023 00:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wxlJQMevKqE2XAdU0egXxg4nlul2OuANdQckNSG1zd4=; b=yNP7CW38zlbi1rHHEcCfMou0KT
        pBdi8juRpMvwvwsEnP/Vq/QjAnZo10E1WpG1u3TH7OSoKL7pzU2oVLEHQM3CSA3zt9Feeenmh3lAi
        iFfsju82cjg5khya8v2Lfszhk4v7UCJG+LLjjOo+AKw/LwLf1DWVfay/EP55rh1FTTrcOK6QTRjgn
        RFtVVbLyeVK5Rap9dFg2+X5Br058dC8Yic3ksaaE3Q1dO5rIzAwHcVqK/sZsRa79HQAJZVCIBxRp3
        2Fa9GMSUf/i4TNMahqlxJmbm+PiQ5er+7uIK+08KaTkUMgQ0vuWb760ZEXkSx4RdsVMsA0vFJMHPo
        ts/Z9qPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRUC7-00DazA-3L; Mon, 13 Feb 2023 08:28:15 +0000
Date:   Mon, 13 Feb 2023 00:28:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v13 03/12] splice: Do splice read from a buffered file
 without using ITER_PIPE
Message-ID: <Y+n0n2UE8BQa/OwW@infradead.org>
References: <20230209102954.528942-1-dhowells@redhat.com>
 <20230209102954.528942-4-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209102954.528942-4-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> The code is loosely based on filemap_read() and might belong in
> mm/filemap.c with that as it needs to use filemap_get_pages().

Yes, I thunk it should go into filemap.c

> +	while (spliced < size &&
> +	       !pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
> +		struct pipe_buffer *buf = &pipe->bufs[pipe->head & (pipe->ring_size - 1)];

Can you please facto this calculation, that is also duplicated in patch
one into a helper?

static inline struct pipe_buffer *pipe_head_buf(struct pipe_inode_info *pipe)
{
	return &pipe->bufs[pipe->head & (pipe->ring_size - 1)];
}

> +	struct folio_batch fbatch;
> +	size_t total_spliced = 0, used, npages;
> +	loff_t isize, end_offset;
> +	bool writably_mapped;
> +	int i, error = 0;
> +
> +	struct kiocb iocb = {

Why the empty line before this declaration?

> +		.ki_filp	= in,
> +		.ki_pos		= *ppos,
> +	};

Also why doesn't this use init_sync_kiocb?

>  	if (in->f_flags & O_DIRECT)
>  		return generic_file_direct_splice_read(in, ppos, pipe, len, flags);
> +	return generic_file_buffered_splice_read(in, ppos, pipe, len, flags);

Btw, can we drop the verbose generic_file_ prefix here?

generic_file_buffered_splice_read really should be filemap_splice_read
and be in filemap.c.  generic_file_direct_splice_read I'd just name
direct_splice_read.
