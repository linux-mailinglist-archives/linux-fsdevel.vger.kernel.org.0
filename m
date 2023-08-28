Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ACF78B25E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 15:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjH1N5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 09:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjH1N4l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:56:41 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B73EBA;
        Mon, 28 Aug 2023 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PJ90BdA+8s3qX5y6y0ylNyYbaZuzc0FQ7tGvCVtNYPo=; b=AIKhRmdLChvBh1g3+s6EW46CKf
        MEbR4fH1pD3IzHz8haDpscNiqgIT1MwygtaGsg0/mJ22nTUE6hhMTmMaXMPK2UFki637fwtT5IR5e
        NpCkU9lVELANCdo3c4h02AUyKpTFJGcO2Yf8AdjY5H7ThMDg0k1adrBbq/dNvtWwWnE3JjBJPdXc+
        ZymQQTBtlnb8KZghvPVKQ32cCYcqGFspsFg4ARKclGMJ6roXU/fBsxC40PaksuQ+i2Lrun7tK4Cxw
        NodllbY3kB+LQ2ImYXlQY7RelX2cS+RJORhfHJhRq6XyXuEQGqfPM8/oHIO2kXnO0q6TWo/qN/Di3
        04k9P7lQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qacj1-001ZTg-1Q;
        Mon, 28 Aug 2023 13:56:15 +0000
Date:   Mon, 28 Aug 2023 14:56:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 03/12] filemap: update ki_pos in generic_perform_write
Message-ID: <20230828135615.GW3390869@ZenIV>
References: <20230601145904.1385409-1-hch@lst.de>
 <20230601145904.1385409-4-hch@lst.de>
 <20230827194122.GA325446@ZenIV>
 <20230827214518.GU3390869@ZenIV>
 <20230828123259.GB11084@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828123259.GB11084@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 28, 2023 at 02:32:59PM +0200, Christoph Hellwig wrote:
> On Sun, Aug 27, 2023 at 10:45:18PM +0100, Al Viro wrote:
> > IOW, I suspect that the right thing to do would be something along the lines
> > of
> 
> The idea looks sensible to me, but we'll also need to do it for the
> filemap_write_and_wait_range failure case.

Huh?  That's precisely where this patch is doing that...  That function
in mainline is
        if (unlikely(buffered_written < 0)) {
                if (direct_written)
                        return direct_written;
                return buffered_written;
        }

        /*
         * We need to ensure that the page cache pages are written to disk and
         * invalidated to preserve the expected O_DIRECT semantics.
         */
        err = filemap_write_and_wait_range(mapping, pos, end);
        if (err < 0) {
                /*
                 * We don't know how much we wrote, so just return the number of
                 * bytes which were direct-written
                 */
                if (direct_written)
                        return direct_written;
                return err;
        }
        invalidate_mapping_pages(mapping, pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
        return direct_written + buffered_written;

The first failure exit does not need any work - the caller had not bumped
->ki_pos; the second one (after that 'if (err < 0) {' line) does and that's
where the patch upthread adds iocb->ki_pos -= buffered_written.

Or am I completely misparsing what you've written?
