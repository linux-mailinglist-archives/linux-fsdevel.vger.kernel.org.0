Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26B86EA19A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 04:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjDUCZx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 22:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjDUCZv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:25:51 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2033C34;
        Thu, 20 Apr 2023 19:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y1bbQJ7Lqx3xWtWj+CoARcsmEeD4ylMi8y4fbkOFWk8=; b=DeFQt246yzDgknT7FPn5/XxNHH
        GbHy6KiFEA5Tpu+HGgzHFmYW6agusVPC+Emv9k35KuYlk5KaiTns4veWfFAMpD02EDxICWXt7Lb3P
        mOgDGDx7nXcayyFH1e4C79FDwu6xJ7chrQsyQWIr+ZQVvfAyNxzqS8P6Hd4CxEU9k7XIY7l1BriHu
        kL0LJluVR6A8lXvQWSoZI3TJAEZJcr0ySA7Y0mSYO+KpSzZYiUXKVg39tQa7RV7W6URmB51nn/SCp
        2WvIch7hLU6utswkEYV/li0kV+NUdjYJSP/EsUGZL660FCkOw55v6kmA5GxGStfVseujlNodizJbk
        gki8B+Mw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppgSj-00B37o-1L;
        Fri, 21 Apr 2023 02:25:25 +0000
Date:   Fri, 21 Apr 2023 03:25:25 +0100
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
Message-ID: <20230421022525.GX3390869@ZenIV>
References: <20230314220757.3827941-1-dhowells@redhat.com>
 <20230314220757.3827941-10-dhowells@redhat.com>
 <20230420222231.GT3390869@ZenIV>
 <20230420223657.GV3390869@ZenIV>
 <20230421011145.GW3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421011145.GW3390869@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 02:11:45AM +0100, Al Viro wrote:
> On Thu, Apr 20, 2023 at 11:36:57PM +0100, Al Viro wrote:
> 
> > Don't get me wrong - I'd love to kill ITER_PIPE off; it's just that tons
> > of ->splice_read() duplicating the corresponding ->read_iter() up to the
> > point where it would call generic_file_read_iter(), modulo ignoring
> > O_DIRECT case and then calling filemap_splice_read() instead...  Painful
> > and asking for trouble down the road.
> 
> FWIW, broken in this series:
> 	* a bunch of 9p variants (those could probably switch to direct)
> 	* afs
> 	* ceph (very likely)
> 	* ecryptfs (atime propagation)
> 	* dax on various filesystems (probably)
> 	* f2fs
> 	* gfs2
> 	* nfs
> 	* ocfs2
> 	* orangefs
> 	* xfs
> 	* zonefs (probably)
> 	* splice from UDP sockets, unless I'm misreading something.
> Your sock_splice_read() still falls back to generic_file_splice_read(),
> rather than to direct_splice_read() and sockets don't have O_DIRECT
> in flags.  Neither do they have associated page cache ;-)
> 
> Sure, we could provide a bunch of ->splice_read(), but then we'd have to make
> sure that all subsequent changes to matching ->read_iter() get duplicated -
> unless they are on O_DIRECT-only paths, that is...

OK, how about the following modification of ITER_PIPE?
	* buffers might extend past the current position
	* buffers (as now) are either data or zero-copy ones.
	* advance past the end of data => allocate data-type buffers
and fill with zeroes.
	* copying data to area prior to the end of buffers => each
zero-copy-type buffer is converted to a data one; data is copied,
but WTF else can you do?  If there's a page borrowed from page
cache, we can't change its contents anyway.
	* zero-copy of a page into an area overlapping the existing
buffers => treat as data copy for the overlapping part and zero-copy
the rest (if any) in normal fashion.
	* iov_iter_get_pages(): convert everything involved into
data-type buffers first, then give caller references to that.
Zero-fill new pages (if any).
	* iov_iter_revert() does *NOT* truncate anything
	* truncation of stuff past the current position is done by
generic_file_splice_read() not only in error case, but on success
as well - starting at the end of actually read data, of course.

That would make for seekable ITER_PIPE, with zero-copy working for
normal cases.  I agree that O_DIRECT would probably be better off
with ITER_BVEC.

Comments?
