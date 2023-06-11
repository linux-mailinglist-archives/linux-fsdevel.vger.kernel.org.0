Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC672B245
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 16:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjFKOQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 10:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjFKOQD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:16:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF2CD7;
        Sun, 11 Jun 2023 07:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fDLmQabXCTXwFAPTqybFPxD8zjt2Tccvqs7T+QWFUGI=; b=h3tqF5j57PCYLSG6yCWfbEfr32
        CO4Bz3Z4WqNMAc9oJyokcDxBXOKCP1aZzD1iVbbft4MJyTuKqOt6NOaUDPtKzn5AGyfUEzbAY3Hb9
        2QsfVfs1n1rZ304XGiwefNmWKudg0g08CmPkrIV3tQ0l7AED2DYDAFwZHemjsPonI7CqfSuTIZk8V
        Dz4A19AqgsvjcuIamqN6a0X2Ene3C74V2tHCTiqk8+rUmDi7LAA8UPJSiAz5pmvd8hG8bC7OLFC8L
        gkEn6q0c/9cwh6moplb+NrTk+T94O8YBgTkp8otJFSUSxd/Ha0JCFQGO5ZITHm1gkppFYcrJnPVLl
        C40WwV4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8LrG-001RLt-8u; Sun, 11 Jun 2023 14:15:54 +0000
Date:   Sun, 11 Jun 2023 15:15:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv2 2/5] ext4: Remove PAGE_SIZE assumption of folio from
 mpage_submit_folio
Message-ID: <ZIXXGhvfJEaKDIXC@casper.infradead.org>
References: <cover.1684122756.git.ritesh.list@gmail.com>
 <74182f5607ccfc3b1e7f08737fcb3442b42a2124.1684122756.git.ritesh.list@gmail.com>
 <20230611055831.GF1436857@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230611055831.GF1436857@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 11, 2023 at 01:58:31AM -0400, Theodore Ts'o wrote:
> On Mon, May 15, 2023 at 04:10:41PM +0530, Ritesh Harjani (IBM) wrote:
> > mpage_submit_folio() was converted to take folio. Even though
> > folio_size() in ext4 as of now is PAGE_SIZE, but it's better to
> > remove that assumption which I am assuming is a missed left over from
> > patch[1].
> > 
> > [1]: https://lore.kernel.org/linux-ext4/20230324180129.1220691-7-willy@infradead.org/
> > 
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> I didn't notice this right away, because the failure is not 100%
> reliable, but this commit will sometimes cause "kvm-xfstests -c
> ext4/encrypt generic/068" to crash.  Reverting the patch fixes the
> problem, so I plan to drop this patch from my tree.

Hrm.  Well, let's think about how this can go wrong:

@@ -1885,7 +1885,7 @@ static int mpage_submit_folio(struct mpage_da_data *mpd,
+struct folio *folio)
        len = folio_size(folio);
        if (folio_pos(folio) + len > size &&
            !ext4_verity_in_progress(mpd->inode))
-               len = size & ~PAGE_MASK;
+        	len = size - folio_pos(folio);
        err = ext4_bio_write_folio(&mpd->io_submit, folio, len);
        if (!err)
                mpd->wbc->nr_to_write--;

Just off-camera is:

        size = i_size_read(mpd->inode);

Now, nothing is preventing i_size to be truncated to far below this
folio, right?  So if that happened before this patch, we'd write some
randomly sized fragment of the page.  Now we'll get a negative result
... which is assigned to size_t, so is exabytes in size.

So do we care if we write a random fragment of a page after a truncate?
If so, we should add:

	if (folio_pos(folio) >= size)
		return 0; /* Do we need to account nr_to_write? */

If we simply don't care that we're doing a spurious write, then we can
do something like:

-		len = size & ~PAGE_MASK;
+		len = size & (len - 1);

