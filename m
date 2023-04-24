Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD7B6EC623
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 08:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjDXGWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 02:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDXGWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 02:22:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D65010C8;
        Sun, 23 Apr 2023 23:22:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 50A3B68B05; Mon, 24 Apr 2023 08:22:20 +0200 (CEST)
Date:   Mon, 24 Apr 2023 08:22:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] iomap: assign current->backing_dev_info in
 iomap_file_buffered_write
Message-ID: <20230424062220.GA10368@lst.de>
References: <20230424054926.26927-1-hch@lst.de> <20230424054926.26927-12-hch@lst.de> <20230424061825.GO360889@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424061825.GO360889@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 23, 2023 at 11:18:25PM -0700, Darrick J. Wong wrote:
> > @@ -876,8 +877,11 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
> >  	if (iocb->ki_flags & IOCB_NOWAIT)
> >  		iter.flags |= IOMAP_NOWAIT;
> >  
> > +	current->backing_dev_info = inode_to_bdi(iter.inode);
> 
> Dumb question from me late on a Sunday night, but does the iomap_unshare
> code need to set this too?  Since it works by dirtying pagecache folios
> without actually changing the contents?

A very good question that I have no answer for.  The
current->backing_dev_info mechanism confuses the heck out of me and
appears basically undocumented.
