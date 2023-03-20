Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8537F6C12DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 14:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjCTNP4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 09:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjCTNPz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:15:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44359234C8
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 06:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F/TTEgg3GkVaespoiM96CPCivVzyP5tcJdUcXD4VzT0=; b=3/Cd7tv53ft6K6Oi2VGC0tA4ZH
        N9wtxKXTWwSHxzaeKJpyR22dqA47ZwuJnm8qJpAtsrEmGFJ5bavj4FWjeEHY0CxnbzG4bx9tphrp5
        nMXjtD6TXEKUbmWXRcji0xJWOoyajfvJthZVbJqlfA5bVKa+JH/lBwO+tKGtY+TztO05bxrmZcOnp
        H+vaivPOgMOterR7KN2+u08zI9cM25jqH7DYDgUVhGm+040sK1NvCCPnTiFccqbU7e5NYAzwr9L/F
        08BYBkN9e+AaeLBvFQ+0mxERAxd0XDt9sqQdSUNRqntJJ3UOT9Mu9TggWP/9lNTJz9wjD4x9KHPPt
        Dh/bjcVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peFMg-0094nn-0e;
        Mon, 20 Mar 2023 13:15:54 +0000
Date:   Mon, 20 Mar 2023 06:15:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, lsf-pc@lists.linux-foundation.org
Subject: Re: [RFCv1][WIP] ext2: Move direct-io to use iomap
Message-ID: <ZBhcitlxolZbz4CV@infradead.org>
References: <87ttz889ns.fsf@doe.com>
 <eae9d2125de1887f55186668937df7475b0a33f4.1678977084.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eae9d2125de1887f55186668937df7475b0a33f4.1678977084.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 16, 2023 at 08:10:29PM +0530, Ritesh Harjani (IBM) wrote:
> +extern void ext2_write_failed(struct address_space *mapping, loff_t to);

Nit: please don't bother with extents for function prototypes.

> +static int ext2_dio_write_end_io(struct kiocb *iocb, ssize_t size,
> +				 int error, unsigned int flags)
> +{
> +	loff_t pos = iocb->ki_pos;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (error)
> +		return error;
> +
> +	pos += size;
> +	if (pos > i_size_read(inode))
> +		i_size_write(inode, pos);

Doesn't i_size_write need i_mutex protection?

> +	/*
> +	 * We pass IOMAP_DIO_NOSYNC because otherwise iomap_dio_rw()
> +	 * calls for generic_write_sync in iomap_dio_complete().
> +	 * Since ext2_fsync nmust be called w/o inode lock,
> +	 * hence we pass IOMAP_DIO_NOSYNC and handle generic_write_sync()
> +	 * ourselves.
> +	 */
> +	flags = IOMAP_DIO_NOSYNC;

So we added IOMAP_DIO_NOSYNC for btrfs initially, but even btrfs did
not manage to mak it work.  I suspect the right thing here as well
is to call __iomap_dio_rw and then separately after dropping the
lock.  Without that you for example can't take i_mutex in the
end_io handler, which I think we need to do.

We should then remove IOMAP_DIO_NOSYNC again.
