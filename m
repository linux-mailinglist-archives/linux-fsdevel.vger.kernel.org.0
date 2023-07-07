Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6461E74B673
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 20:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjGGSk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 14:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjGGSk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 14:40:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803872682;
        Fri,  7 Jul 2023 11:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+PlsjkygUy/NaxzRVXPs1XdCvvqCmcP1CuzrF3FYi78=; b=N9zitiD9uhOT4xbkk5LyzIKHYX
        oMrbk08jA82Cz40fcP3zliWq/SUVTzVrGkNTbfI64T5Pq/aGZg83/qJ31NjmTNPAQbW9ihmPy+4Bz
        NDHN7KsjjXDoZXpNlaTDsw0Ng6OxNfS6riYufmFDduqttjy1zl4EUtSjenPwizBzCgiZ4scKn3AvY
        RDaCdpBbV5FKlXZRJICebIvzPv59Ij8Y3A1iB2yXsA/gwIxEiD136/HwOCEFl/Y0dlnzG4D6J47XA
        bVwW12r4UqbiAs7v/ppdzBM31FENe0bllXM8Oze0HAKyWzwax1MzW5QFef3oJozoBS6poHHz1PNcd
        f5aQg21g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHqNQ-00CGGh-H0; Fri, 07 Jul 2023 18:40:20 +0000
Date:   Fri, 7 Jul 2023 19:40:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     David Wysochanski <dwysocha@redhat.com>,
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
Message-ID: <ZKhcFE1JpT6F2ez3@casper.infradead.org>
References: <20230628104852.3391651-1-dhowells@redhat.com>
 <20230628104852.3391651-3-dhowells@redhat.com>
 <ZKg/J3OG3kQ9ynSO@fedora>
 <CAB=+i9Qbi7+o90Cd_ecd1TeaAYnWPcO-gNp7kzc95Pxecy0XTw@mail.gmail.com>
 <CALF+zO=nGdoxcT-ya3aaUCBi-4iKPo3kZyzcWYCKMCf4n2wVbA@mail.gmail.com>
 <ZKhZHg6LSGnvryIe@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKhZHg6LSGnvryIe@fedora>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 08, 2023 at 03:27:42AM +0900, Hyeonggon Yoo wrote:
> Hmm, was it UAF because it references wrong field ->mapping,
> instead of swapper address space?

Ooh, I know this one!

When a folio is in use as an anonymous page, ->mapping has the bottom
two bits set to 01b.  The rest of the pointer is actually a pointer
to an anon_vma.  It's entirely plausible that an anon page might have
had its anon_vma freed by the time the folio is on the inactive list,
and on its way to being recycled (eg it was unmapped).  I'm not
terribly familiar with the lifetime rules of the anon_vma, but I doubt
that a folio still being in RAM would pin it if it has been unmapped.
