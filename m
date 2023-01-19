Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5192C673164
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 06:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjASFwI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 00:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjASFwH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:52:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F83BA;
        Wed, 18 Jan 2023 21:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HV20o5DJoYejH4ZxhgolHlvJcr34R1PSBryHehLovgc=; b=OA+Vp86krsp9Bm3bY8YID9wbtz
        l4r1JaKf6WSW/XCx1VilImlA4K2In6L3j7JmCCVGvg+qj1gx3MZK/WnznqYdCdsKLjdNi6CZWMN+9
        q0KGasFax4jUaAIRwi2w9dJD1Y5JTab2CAxJBfjuNqZ/P+8332Fqou7UGYPI1sOsI+5/ne9a99vmI
        r2tIXLg70iTdrz7UCbdrvAY8plHIWklrKAtfcd8F3u+tXq1sIRBdyd6vbTKo966UriXiRa4vCdVtb
        7C8G/1chYtTsrdA9pvz1yWo+shpaKpcJbwVDMwDrBkfR+Dh0albhuyWyoF/evf6xafPeT9M6PUYTg
        zFvO+imQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pINq9-003hee-Da; Thu, 19 Jan 2023 05:51:57 +0000
Date:   Wed, 18 Jan 2023 21:51:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 18/34] dio: Pin pages rather than ref'ing if
 appropriate
Message-ID: <Y8jafackRu7t2Jf4@infradead.org>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391061117.2311931.16807283804788007499.stgit@warthog.procyon.org.uk>
 <Y8jPVLewUaaiuplq@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8jPVLewUaaiuplq@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 19, 2023 at 05:04:20AM +0000, Al Viro wrote:
> 1) fs/direct-io.c is ancient, grotty and has few remaining users.
> The case of block devices got split off first; these days it's in
> block/fops.c.  Then iomap-using filesystems went to fs/iomap/direct-io.c,
> leaving this sucker used only by affs, ext2, fat, exfat, hfs, hfsplus, jfs,
> nilfs2, ntfs3, reiserfs, udf and ocfs2.  And frankly, the sooner it dies
> the better off we are.  IOW, you've picked an uninteresting part and left
> the important ones untouched.

Agreed.  That being said if we want file systems (including those not
using this legacy version) to be able to rely on correct page dirtying
eventually everything needs to pin pages it writes to.  So we need to
either actually fix or remove this code in the forseeable future.  It's
by far not the most interesting and highest priority, though.   And as
I said this series is already too large too review anyway, I'd really
prefer to get a core set done ASAP and then iterate on the callers and
additional bits.

> Unless I misunderstand something fundamental about the whole thing,
> this crap should become useless with that conversion.

It should - mostly.  But we need to be very careful about that, so
I'd prefer a separate small series for it to be honest.

> BTW, where do we dirty the pages on IO_URING_OP_READ_FIXED with
> O_DIRECT file?  AFAICS, bio_set_pages_dirty() won't be called
> (ITER_BVEC iter) and neither will bio_release_pages() do anything
> (BIO_NO_PAGE_REF set on the bio by bio_iov_bvec_set() called
> due to the same ITER_BVEC iter).  Am I missing something trivial
> here?  Jens?

I don't think we do that all right now.
