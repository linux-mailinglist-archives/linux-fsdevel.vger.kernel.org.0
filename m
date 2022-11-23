Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB58636A7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 21:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbiKWUE5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 15:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiKWUEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:04:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1760F61BB2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 12:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669233792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FyF91lZbMxrHn5anVwrCryKb88DRm4Sm24TF8WqfMn8=;
        b=XEw1gBSxh1L4AYQJn4VsrqkpqQHl45vLr7kViDs6mJy8ZnersJybW/GejFUN5zvALFfNjZ
        wDiTYDyJCec+RO4UjyC3qX7CqkB4hUYPz3vbALZw7rQDwNpAQyOGZu1D+W1bqlIBHZI3VO
        W5teeO5V2JxxD2mcYLWOoBsL90BmJS0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-WfiQ4PvGNeam6muHEfvymg-1; Wed, 23 Nov 2022 15:03:09 -0500
X-MC-Unique: WfiQ4PvGNeam6muHEfvymg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB7E087B2A1;
        Wed, 23 Nov 2022 20:03:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B49AF40C83C5;
        Wed, 23 Nov 2022 20:03:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wghJtq-952e_8jd=vtV68y_HsDJ8=e0=C3-AsU2WL-8YA@mail.gmail.com>
References: <CAHk-=wghJtq-952e_8jd=vtV68y_HsDJ8=e0=C3-AsU2WL-8YA@mail.gmail.com> <1459152.1669208550@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, willy@infradead.org, dwysocha@redhat.com,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
        linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm, netfs, fscache: Stop read optimisation when folio removed from pagecache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1619342.1669233783.1@warthog.procyon.org.uk>
Date:   Wed, 23 Nov 2022 20:03:03 +0000
Message-ID: <1619343.1669233783@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> But I also think it's strange in another way, with that odd placement of
> 
>         mapping_clear_release_always(inode->i_mapping);
> 
> at inode eviction time. That just feels very random.

I was under the impression that a warning got splashed if unexpected
address_space flags were set when ->evict_inode() returned.  I may be thinking
of page flags.  If it doesn't, fine, this isn't required.

> Similarly, that change to shrink_folio_list() looks strange, with the
> nasty folio_needs_release() helper. It seems entirely pointless, with
> the use then being
> 
>                 if (folio_needs_release(folio)) {
>                         if (!filemap_release_folio(folio, sc->gfp_mask))
>                                 goto activate_locked;

Unfortunately, that can't be simply folded down.  It actually does something
extra if folio_has_private() was set, filemap_release_folio() succeeds but
there was no mapping:

		 * Rarely, folios can have buffers and no ->mapping.
		 * These are the folios which were not successfully
		 * invalidated in truncate_cleanup_folio().  We try to
		 * drop those buffers here and if that worked, and the
		 * folio is no longer mapped into process address space
		 * (refcount == 1) it can be freed.  Otherwise, leave
		 * the folio on the LRU so it is swappable.

Possibly I could split the if-statement and make it two separate cases:

		/*
		 * If the folio has buffers, try to free the buffer
		 * mappings associated with this folio. If we succeed
		 * we try to free the folio as well.
		 *
		 * We do this even if the folio is dirty.
		 * filemap_release_folio() does not perform I/O, but it
		 * is possible for a folio to have the dirty flag set,
		 * but it is actually clean (all its buffers are clean).
		 * This happens if the buffers were written out directly,
		 * with submit_bh(). ext3 will do this, as well as
		 * the blockdev mapping.  filemap_release_folio() will
		 * discover that cleanness and will drop the buffers
		 * and mark the folio clean - it can be freed.
		 */
		if (!filemap_release_folio(folio, sc->gfp_mask))
			goto activate_locked;

filemap_release_folio() will return true if folio_has_private() is false,
which would allow us to reach the next part, which we would then skip.

		/*
		 * Rarely, folios can have buffers and no ->mapping.
		 * These are the folios which were not successfully
		 * invalidated in truncate_cleanup_folio().  We try to
		 * drop those buffers here and if that worked, and the
		 * folio is no longer mapped into process address space
		 * (refcount == 1) it can be freed.  Otherwise, leave
		 * the folio on the LRU so it is swappable.
		 */
		if (!mapping && folio_has_private(folio) &&
		    folio_ref_count(folio) == 1) {
			folio_unlock(folio);
			if (folio_put_testzero(folio))
				goto free_it;
			 /*
			  * rare race with speculative reference.
			  * the speculative reference will free
			  * this folio shortly, so we may
			  * increment nr_reclaimed here (and
			  * leave it off the LRU).
			  */
			nr_reclaimed += nr_pages;
			continue;
		}

But that will malfunction if try_to_free_buffers(), as called from
folio_has_private(), manages to clear the private bits.  I wonder if it might
be possible to fold this bit into filemap_release_folio() somehow.

I really need a three-state return from filemap_release_folio() - maybe:

	0	couldn't release
	1	released
	2	there was no private

The ordinary "if (filemap_release_folio()) { ... }" would work as expected.
shrink_folio_list() could do something different between case 1 and case 2.

> And the change to mm/filemap.c is completely unacceptable in all
> forms, and this added test
> 
> +       if ((!mapping || !mapping_release_always(mapping)) &&
> +           !folio_test_private(folio) &&
> +           !folio_test_private_2(folio))
> +               return true;
> 
> will not be accepted even during the merge window. That code makes no
> sense what-so-ever, and is in no way acceptable.
>
> That code makes no sense what-so-ever. Why isn't it using
> "folio_has_private()"?

It should be, yes.

> Why is this done as an open-coded - and *badly* so - version of
> !folio_needs_release() that you for some reason made private to mm/vmscan.c?

Yeah, in retrospect, I should have put that in mm/internal.h.

David

