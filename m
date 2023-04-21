Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81426EA0CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 03:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjDUBMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 21:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjDUBMH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 21:12:07 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C52D2108;
        Thu, 20 Apr 2023 18:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dnj+MwCbtv8NOzvIf0pmIsPDMO0RM2xq9qIHLD7iX50=; b=CPHwR0igmjjSKRMhIU5CVABr3L
        RHq9WCCAqi4m5UCt2vC7XJSeG8JnOkQet7uVZUngpAaKWXFx+5pFKYKJBSfhCYo3yAQNXNHw5rgLG
        FWZA/tfrftfflE9xd3redguLME3UR69V2eBvI55VD9KpYcxqcxoNOGDdDse5lMvIZnbw06FpNsMkT
        PwrmaLqmPHRIKfGi/j2ol1hbGra+C3hUFICY9D7elfvypvHe9KF2TrNn8RQqmGcm4QgViKj6jNG38
        gyHy7f8m1WiCKigzm2GfHG24I6DKi/g8IhlvoNIk/YyQlr1NclnTDFE7jg+tNPVFIPm0ypj3jj54l
        mD42JdcQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppfJR-00B1x8-0S;
        Fri, 21 Apr 2023 01:11:45 +0000
Date:   Fri, 21 Apr 2023 02:11:45 +0100
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
Message-ID: <20230421011145.GW3390869@ZenIV>
References: <20230314220757.3827941-1-dhowells@redhat.com>
 <20230314220757.3827941-10-dhowells@redhat.com>
 <20230420222231.GT3390869@ZenIV>
 <20230420223657.GV3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420223657.GV3390869@ZenIV>
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

On Thu, Apr 20, 2023 at 11:36:57PM +0100, Al Viro wrote:

> Don't get me wrong - I'd love to kill ITER_PIPE off; it's just that tons
> of ->splice_read() duplicating the corresponding ->read_iter() up to the
> point where it would call generic_file_read_iter(), modulo ignoring
> O_DIRECT case and then calling filemap_splice_read() instead...  Painful
> and asking for trouble down the road.

FWIW, broken in this series:
	* a bunch of 9p variants (those could probably switch to direct)
	* afs
	* ceph (very likely)
	* ecryptfs (atime propagation)
	* dax on various filesystems (probably)
	* f2fs
	* gfs2
	* nfs
	* ocfs2
	* orangefs
	* xfs
	* zonefs (probably)
	* splice from UDP sockets, unless I'm misreading something.
Your sock_splice_read() still falls back to generic_file_splice_read(),
rather than to direct_splice_read() and sockets don't have O_DIRECT
in flags.  Neither do they have associated page cache ;-)

Sure, we could provide a bunch of ->splice_read(), but then we'd have to make
sure that all subsequent changes to matching ->read_iter() get duplicated -
unless they are on O_DIRECT-only paths, that is...
