Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F27E655210
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 16:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbiLWPbg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 10:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbiLWPbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:31:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E485B2;
        Fri, 23 Dec 2022 07:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YI+GETaE07zfIF6gTr93yZkoaqmkXGRyTSkPLa22IzA=; b=RkLgtlP2zs+0grtCP2XKKuFJes
        6FHjSru80hSAyAYCWjR4giWwoV3DaU3XpMF7/3HZDUa+E/kozrd+x6VmAXg4TRMKJHW9b8wzSyfeD
        VokI0tlui9x8PQhh88Z82EqORo/ZAaFcoi8Gbx6S9ZrNjmqThuHWTTIRq3+YEjgq3IX5yINDVvjt+
        e0+/qxQDLcU/llLFjIUrhW0P/9m/nHcrhbkOptvrE3r4S9ZgmuFyMLR/rPv50gmRKgcXjautu9IC5
        U8MyiLTneJokeOtEKvUEFCZUMIUmLTbzJVU1SPbmDcoK0FIf2BAPGpTW1uoenfctyu+YHc+9jx57b
        guycEkxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8k0x-009SnO-0o; Fri, 23 Dec 2022 15:31:15 +0000
Date:   Fri, 23 Dec 2022 07:31:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
        linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>,
        linux-erofs@lists.ozlabs.org, linux-ext4@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] mm: Make filemap_release_folio() better inform
 shrink_folio_list()
Message-ID: <Y6XJwvjKyTgRIiI3@infradead.org>
References: <167172131368.2334525.8569808925687731937.stgit@warthog.procyon.org.uk>
 <167172134962.2334525.570622889806603086.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167172134962.2334525.570622889806603086.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 22, 2022 at 03:02:29PM +0000, David Howells wrote:
> Make filemap_release_folio() return one of three values:
> 
>  (0) FILEMAP_CANT_RELEASE_FOLIO
> 
>      Couldn't release the folio's private data, so the folio can't itself
>      be released.
> 
>  (1) FILEMAP_RELEASED_FOLIO
> 
>      The private data on the folio was released and the folio can be
>      released.
> 
>  (2) FILEMAP_FOLIO_HAD_NO_PRIVATE

These names read really odd, due to the different placementments
of FOLIO, the present vs past tense and the fact that 2 also released
the folio, and the reliance of callers that one value of an enum
must be 0, while no unprecedented, is a bit ugly.

But do we even need them?  What abut just open coding
filemap_release_folio (which is a mostly trivial function) in
shrink_folio_list, which is the only place that cares?

	if (folio_has_private(folio) && folio_needs_release(folio)) {
		if (folio_test_writeback(folio))
			goto activate_locked;

		if (mapping && mapping->a_ops->release_folio) {
			if (!mapping->a_ops->release_folio(folio, gfp))
				goto activate_locked;
		} else {
			if (!try_to_free_buffers(folio))
				goto activate_locked;
		}

		if (!mapping && folio_ref_count(folio) == 1) {
			...

alternatively just keep using filemap_release_folio and just add the
folio_needs_release in the first branch.  That duplicates the test,
but makes the change a one-liner.
