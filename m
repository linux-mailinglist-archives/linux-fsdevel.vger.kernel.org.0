Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF6474B659
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 20:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjGGSd2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 14:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGGSd1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 14:33:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731F6212D;
        Fri,  7 Jul 2023 11:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EnPO7iYPqwnxTqwStZEfw5T07yWJQFIQid3g9b9XqJw=; b=hSZgYMr3UKHKYIY/VL4ipIs0vS
        61IBklPoCl4A108p1gsJG4vlTkCOJoen6cWDC43+6NTkr8YGNcmQcJs1O3p4OQtb1NXVR4LAls2Ng
        /p4TPNlO1XctYmGGMC+rkDVIiNqlriS/EFc8QPJBD4SL1Z2nsXdTYGKpye4UmT0WkXCONgtsxFIeV
        ZzegUWujwBx4r5ew4D2ZYlNPZ/o9jjAmGtG3ZcwrWDutua9YtWwESK4CTJ8bWQsA8XK+GJhZTgRVa
        CxK9+UPVL47g+ChIlgIr9kUvKuQXq0PFhjJDDTHlObVTxnMgijgaiIZJ6uLFDdPe7Ztq+0PZAnrFh
        +1A2zrEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHqGZ-00CFvk-6N; Fri, 07 Jul 2023 18:33:15 +0000
Date:   Fri, 7 Jul 2023 19:33:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>, linux-mm@kvack.org,
        Daire Byrne <daire.byrne@gmail.com>
Subject: Re: [BUG mm-unstable] BUG: KASAN: use-after-free in
 shrink_folio_list+0x9f4/0x1ae0
Message-ID: <ZKhaa7xn9aaZYicR@casper.infradead.org>
References: <20230628104852.3391651-1-dhowells@redhat.com>
 <20230628104852.3391651-3-dhowells@redhat.com>
 <ZKg/J3OG3kQ9ynSO@fedora>
 <CAB=+i9Qbi7+o90Cd_ecd1TeaAYnWPcO-gNp7kzc95Pxecy0XTw@mail.gmail.com>
 <CALF+zO=nGdoxcT-ya3aaUCBi-4iKPo3kZyzcWYCKMCf4n2wVbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALF+zO=nGdoxcT-ya3aaUCBi-4iKPo3kZyzcWYCKMCf4n2wVbA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 07, 2023 at 02:12:06PM -0400, David Wysochanski wrote:
> I think myself / Daire Byrne may have already tracked this down and I
> found a 1-liner that fixed a similar crash in his environment.
> 
> Can you try this patch on top and let me know if it still crashes?
> https://github.com/DaveWysochanskiRH/kernel/commit/902c990e311120179fa5de99d68364b2947b79ec

Said one-liner:
-	struct address_space *mapping = folio->mapping;
+	struct address_space *mapping = folio_mapping(folio);

This will definitely fix the problem.  shrink_folio_list() sees
anonymous folios as well as file folios.

I wonder if we want to go a step further and introduce ...

+static inline bool __folio_needs_release(struct address_space *mapping,
+               struct folio *folio)
+{
+       return folio_has_private(folio) ||
+               (mapping && mapping_release_always(mapping));
+}
+
 /*
  * Return true if a folio needs ->release_folio() calling upon it.
  */
 static inline bool folio_needs_release(struct folio *folio)
 {
-       struct address_space *mapping = folio->mapping;
-
-       return folio_has_private(folio) ||
-               (mapping && mapping_release_always(mapping));
+       return __folio_needs_release(folio_mapping(folio), folio);
 }

since two of the three callers already have done the necessary dance to
get the mapping (and they're the two which happen regularly; the third
is an unusual situation).

