Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429AA7924EF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjIEQAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354776AbjIEOQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:16:14 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D7B197;
        Tue,  5 Sep 2023 07:16:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9D9CC6732A; Tue,  5 Sep 2023 16:16:04 +0200 (CEST)
Date:   Tue, 5 Sep 2023 16:16:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>
Cc:     Lei Huang <lei.huang@linux.intel.com>, miklos@szeredi.hu,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Boris Pismenny <borisp@nvidia.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-mm@kvack.org, v9fs@lists.linux.dev, netdev@vger.kernel.org
Subject: getting rid of the last memory modifitions through gup(FOLL_GET)
Message-ID: <20230905141604.GA27370@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

we've made some nice progress on converting code that modifies user
memory to the pin_user_pages interface, especially though the work
from David Howells on iov_iter_extract_pages.  This thread tries to
coordinate on how to finish off this work.

The obvious next step is the remaining users of iov_iter_get_pages2
and iov_iter_get_pages_alloc2.  We have three file system direct I/O
users of those left: ceph, fuse and nfs.  Lei Huang has sent patches
to convert fuse to iov_iter_extract_pages which I'd love to see merged,
and we'd need equivalent work for ceph and nfs.

The non-file system uses are in the vmsplice code, which only reads
from the pages (but would still benefit from an iov_iter_extract_pages
conversion), and in net.  Out of the users in net, all but the 9p code
appear to be for reads from memory, so they don't pin even if a
conversion would be nice to retire iov_iter_get_pages* APIs.

After that we might have to do an audit of the raw get_user_pages APIs,
but there probably aren't many that modify file backed memory.

I'm also wondering what a good debug aid would be for detecting
writes to file backed memory without a previous reservation, but
everything either involves a page flag or file system code.  But if
someone has an idea I'm all ear as something mechanical to catch these
uses would be quite helpful.
