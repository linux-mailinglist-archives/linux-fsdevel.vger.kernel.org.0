Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BDE6E9F1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 00:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjDTWhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 18:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDTWhO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:37:14 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8A1E5E;
        Thu, 20 Apr 2023 15:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IjH8cEEb4Pdaq+7y2hXqBIVsGh4DsrKvkp8dCInMI9s=; b=UtAWwKWDyPwNKRQjh0mJk8KLwu
        z7QZ0MyjHoQxBAJlCJk6n/arszZ/jTfN1kVnlyn2tdXQogoqENYh5Ra+B4MJ03q1ZAtXMZkC71FbN
        xjO7kzrxT+RaqjXTwlw4wb478rm9BxBGUE77KbyOzH0Ae0t0xey94s8c9oj8dO+WQ1/Iyvj57oSgf
        L1zRVWcWxnRLkNZeBOJlMfuyZEaLmMdbRpUiVrMrv2vxX2mPaqcUXZRaAmzJngz5FmE+BELi2ongi
        rdArNeY8oylbrtGpYZLm/cFRlrv/KKSSOm4TyRtzBJ+RrEsgiju/CudreBNiOpXSow5Mw6W9xLlgn
        OhyGsuvw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppctd-00Az06-1Y;
        Thu, 20 Apr 2023 22:36:57 +0000
Date:   Thu, 20 Apr 2023 23:36:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v18 09/15] iov_iter: Kill ITER_PIPE
Message-ID: <20230420223657.GV3390869@ZenIV>
References: <20230314220757.3827941-1-dhowells@redhat.com>
 <20230314220757.3827941-10-dhowells@redhat.com>
 <20230420222231.GT3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420222231.GT3390869@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 20, 2023 at 11:22:31PM +0100, Al Viro wrote:
> On Tue, Mar 14, 2023 at 10:07:51PM +0000, David Howells wrote:
> > The ITER_PIPE-type iterator was only used for generic_file_splice_read(),
> > but that has now been switched to either pull pages directly from the
> > pagecache for buffered file splice-reads or to use ITER_BVEC instead for
> > O_DIRECT file splice-reads.  This leaves ITER_PIPE unused - so remove it.
> 
> Wonderful, except that now you've got duplicates of ->read_iter() for
> everyone who wants zero-copy on ->splice_read() ;-/
> 
> I understand the attraction of arbitrary seeks on those suckers; ITER_PIPE
> is a massive headache in that respect.  But I really don't like what your
> approach trades it for.
> 
> And you are nowhere near done - consider e.g. NFS.  Mainline has it
> feed ITER_PIPE to nfs_file_read(), which does call generic_file_read_iter() -
> after
>         result = nfs_revalidate_mapping(inode, iocb->ki_filp->f_mapping);
> 
> Sure, you can add nfs_file_splice_read() that would do what nfs_file_read()
> does, calling filemap_spice_read() instead of generic_file_read_iter().
> 
> Repeat the same for ocfs2 (locking of its own).  And orangefs.  And
> XFS (locking, again).  And your own AFS, while we are at it.  Et sodding
> cetera - *everything* that uses generic_file_splice_read() with
> ->read_iter other than generic_file_read_iter() needs review and,
> quite likely, a ->splice_read() instance of its own.

Don't get me wrong - I'd love to kill ITER_PIPE off; it's just that tons
of ->splice_read() duplicating the corresponding ->read_iter() up to the
point where it would call generic_file_read_iter(), modulo ignoring
O_DIRECT case and then calling filemap_splice_read() instead...  Painful
and asking for trouble down the road.
