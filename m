Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8BD660FD4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jan 2023 16:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjAGPLv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Jan 2023 10:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjAGPLt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Jan 2023 10:11:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA3365AD6;
        Sat,  7 Jan 2023 07:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cq3Tcm7OLVA1me+kKR9zka8dfFlwNGfvdQ54sCCOFy0=; b=ZNxGrxfYZ18g+iYGTFB+S1ko54
        lj1sxWXhAn78Z3mSPVR2VNhutJKCAxFaz7EvlYN14xY1q6+NBT5BmqFVf/nJJRXx3rkyJLyzNsotg
        p2AncToaCGxm00OtMsKBilhhcwdZaLAT92+SGg+aiYltEWGvShClAy8z/ZR/bi7VI7vE5J+bt26Am
        gl2QLP2YD9kfgP/iz1ffl1HiLzGCokiMepgI+S3Woob+xpPYF/t/jYpqc9CydIc1SEn5K9QJfINJB
        3kqKLKrmueMObbikddZ9gvcsiGZattD6U4HvI2cIcSbuPAQJI15Mvcrjjs0mZKc3oACChoxW3lSC/
        5B9rSMTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEArM-000dly-Pt; Sat, 07 Jan 2023 15:11:48 +0000
Date:   Sat, 7 Jan 2023 15:11:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Rohith Surabattula <rohiths.msft@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Jeff Layton <jlayton@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-ext4@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] mm: Merge
 folio_has_private()/filemap_release_folio() call pairs
Message-ID: <Y7mLtPpRz8boODVX@casper.infradead.org>
References: <167172131368.2334525.8569808925687731937.stgit@warthog.procyon.org.uk>
 <167172132272.2334525.13617516784050484518.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167172132272.2334525.13617516784050484518.stgit@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 22, 2022 at 03:02:02PM +0000, David Howells wrote:
> Make filemap_release_folio() check folio_has_private().  Then, in most
> cases, where a call to folio_has_private() is immediately followed by a
> call to filemap_release_folio(), we can get rid of the test in the pair.
> 
> The same is done to page_has_private()/try_to_release_page() call pairs.

This line is now obsolete.

> There are a couple of sites in mm/vscan.c that this can't so easily be
> done.  In shrink_folio_list(), there are actually three cases (something
> different is done for incompletely invalidated buffers), but
> filemap_release_folio() elides two of them.
> 
> In shrink_active_list(), we don't have have the folio lock yet, so the
> check allows us to avoid locking the page unnecessarily.
> 
> A wrapper function to check if a folio needs release is provided for those
> places that still need to do it in the mm/ directory.  This will acquire
> additional parts to the condition in a future patch.
> 
> After this, the only remaining caller of folio_has_private() outside of mm/
> is a check in fuse.

But there are a few remaining places which check page_has_private().
I think they're all wrong and should be PagePrivate(), but I'll look
at them more next week.

