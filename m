Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887207028B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 11:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbjEOJe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 05:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbjEOJes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 05:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1453DE4F
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 02:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684143236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oG9/8AaXZ7fe38ECDlGWs0TXmgwYuszu55qwePBG4cU=;
        b=fYgxC89r9xAkwlQn2gZs1EKWGbGOnDSA9wB33W3XcPfF84fuViNrzu9z/1IMnE8P1KWW/V
        /AexT6EjnxstWWgLM5muVZJ+prg/VtsMekoBFfIXEsJfhluU/Y9F4aO82E+9irJBGH0ocZ
        GsHiwJoSLhfBD+fT/j8cpM2GJ2eB8Wc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454--2Lx0N_jMj-PQMKm00WKTg-1; Mon, 15 May 2023 05:33:53 -0400
X-MC-Unique: -2Lx0N_jMj-PQMKm00WKTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49AD93C0CEFD;
        Mon, 15 May 2023 09:33:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3811440C6EC4;
        Mon, 15 May 2023 09:33:49 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH net-next v7 00/16] splice, net: Replace sendpage with sendmsg(MSG_SPLICE_PAGES), part 1
Date:   Mon, 15 May 2023 10:33:29 +0100
Message-Id: <20230515093345.396978-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's the first tranche of patches towards providing a MSG_SPLICE_PAGES
internal sendmsg flag that is intended to replace the ->sendpage() op with
calls to sendmsg().  MSG_SPLICE_PAGES is a hint that tells the protocol
that it should splice the pages supplied if it can and copy them if not.

This will allow splice to pass multiple pages in a single call and allow
certain parts of higher protocols (e.g. sunrpc, iwarp) to pass an entire
message in one go rather than having to send them piecemeal.  This should
also make it easier to handle the splicing of multipage folios.

A helper, skb_splice_from_iter() is provided to do the work of splicing or
copying data from an iterator.  If a page is determined to be unspliceable
(such as being in the slab), then the helper will give an error.

Note that this facility is not made available to userspace and does not
provide any sort of callback.

This set consists of the following parts:

 (1) Define the MSG_SPLICE_PAGES flag and prevent sys_sendmsg() from being
     able to set it.

 (2) Add an extra argument to skb_append_pagefrags() so that something
     other than MAX_SKB_FRAGS can be used (sysctl_max_skb_frags for
     example).

 (3) Add the skb_splice_from_iter() helper to handle splicing pages into
     skbuffs for MSG_SPLICE_PAGES that can be shared by TCP, IP/UDP and
     AF_UNIX.

 (4) Implement MSG_SPLICE_PAGES support in TCP.

 (5) Make do_tcp_sendpages() just wrap sendmsg() and then fold it in to its
     various callers.

 (6) Implement MSG_SPLICE_PAGES support in IP and make udp_sendpage() just
     a wrapper around sendmsg().

 (7) Implement MSG_SPLICE_PAGES support in IP6/UDP6.

 (8) Implement MSG_SPLICE_PAGES support in AF_UNIX.

 (9) Make AF_UNIX copy unspliceable pages.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=sendpage-1

The follow-on patches are on branch iov-sendpage on the same tree.

David

Changes
=======
ver #7)
 - Rebase after merge window.
 - In ____sys_sendmsg(), clear internal flags before setting msg_flags.
 - Clear internal flags in uring io_send{,_zc}().
 - Export skb_splice_from_iter().
 - Missed changing a "zc = 1" in tcp_sendmsg_locked().
 - Remove now-unused csum_page() from UDP.
 - Add a patch to make AF_UNIX sendpage() just a wrapper around sendmsg().
 - Return an error if !sendpage_ok() rather than copying for now.
 - Drop the page frag allocator patches for the moment.

ver #6)
 - Removed a couple of leftover page pointer declarations.
 - In TCP, set zc to 0/MSG_ZEROCOPY/MSG_SPLICE_PAGES rather than 0/1/2.
 - Add a max-frags argument to skb_append_pagefrags().
 - Extract the AF_UNIX helper out into a common helper and use it for
   IP/UDP and TCP too.
 - udp_sendpage() shouldn't lock the socket around udp_sendmsg().
 - udp_sendpage() should only set MSG_MORE if MSG_SENDPAGE_NOTLAST is set.
 - In siw, don't clear MSG_SPLICE_PAGES on the last page.

ver #5)
 - Dropped the samples patch as it causes lots of failures in the patchwork
   32-bit builds due to apparent libc userspace header issues.
 - Made the pagefrag alloc patches alter the Google gve driver too.
 - Rearranged the patches to put the support in IP before altering UDP.

ver #4)
 - Added some sample socket-I/O programs into samples/net/.
 - Fix a missing page-get in AF_KCM.
 - Init the sgtable and mark the end in AF_ALG when calling
   netfs_extract_iter_to_sg().
 - Add a destructor func for page frag caches prior to generalising it and
   making it per-cpu.

ver #3)
 - Dropped the iterator-of-iterators patch.
 - Only expunge MSG_SPLICE_PAGES in sys_send[m]msg, not sys_recv[m]msg.
 - Split MSG_SPLICE_PAGES code in __ip_append_data() out into helper
   functions.
 - Implement MSG_SPLICE_PAGES support in __ip6_append_data() using the
   above helper functions.
 - Rename 'xlength' to 'initial_length'.
 - Minimise the changes to sunrpc for the moment.
 - Don't give -EOPNOTSUPP if NETIF_F_SG not available, just copy instead.
 - Implemented MSG_SPLICE_PAGES support in the TLS, Chelsio-TLS and AF_KCM
   code.

ver #2)
 - Overhauled the page_frag_alloc() allocator: large folios and per-cpu.
   - Got rid of my own zerocopy allocator.
 - Use iov_iter_extract_pages() rather poking in iter->bvec.
 - Made page splicing fall back to page copying on a page-by-page basis.
 - Made splice_to_socket() pass 16 pipe buffers at a time.
 - Made AF_ALG/hash use finup/digest where possible in sendmsg.
 - Added an iterator-of-iterators, ITER_ITERLIST.
 - Made sunrpc use the iterator-of-iterators.
 - Converted more drivers.

Link: https://lore.kernel.org/r/20230316152618.711970-1-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20230329141354.516864-1-dhowells@redhat.com/ # v2
Link: https://lore.kernel.org/r/20230331160914.1608208-1-dhowells@redhat.com/ # v3
Link: https://lore.kernel.org/r/20230405165339.3468808-1-dhowells@redhat.com/ # v4

David Howells (16):
  net: Declare MSG_SPLICE_PAGES internal sendmsg() flag
  net: Pass max frags into skb_append_pagefrags()
  net: Add a function to splice pages into an skbuff for
    MSG_SPLICE_PAGES
  tcp: Support MSG_SPLICE_PAGES
  tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES
  tcp_bpf: Inline do_tcp_sendpages as it's now a wrapper around
    tcp_sendmsg
  espintcp: Inline do_tcp_sendpages()
  tls: Inline do_tcp_sendpages()
  siw: Inline do_tcp_sendpages()
  tcp: Fold do_tcp_sendpages() into tcp_sendpage_locked()
  ip, udp: Support MSG_SPLICE_PAGES
  ip6, udp6: Support MSG_SPLICE_PAGES
  udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES
  ip: Remove ip_append_page()
  af_unix: Support MSG_SPLICE_PAGES
  unix: Convert udp_sendpage() to use MSG_SPLICE_PAGES

 drivers/infiniband/sw/siw/siw_qp_tx.c |  17 +-
 include/linux/skbuff.h                |   5 +-
 include/linux/socket.h                |   3 +
 include/net/ip.h                      |   2 -
 include/net/tcp.h                     |   2 -
 include/net/tls.h                     |   2 +-
 io_uring/net.c                        |   2 +
 net/core/skbuff.c                     |  99 +++++++++++-
 net/ipv4/ip_output.c                  | 164 +++-----------------
 net/ipv4/tcp.c                        | 214 ++++++--------------------
 net/ipv4/tcp_bpf.c                    |  20 ++-
 net/ipv4/udp.c                        |  51 +-----
 net/ipv6/ip6_output.c                 |  17 ++
 net/socket.c                          |   2 +
 net/tls/tls_main.c                    |  24 +--
 net/unix/af_unix.c                    | 183 +++++-----------------
 net/xfrm/espintcp.c                   |  10 +-
 17 files changed, 285 insertions(+), 532 deletions(-)

