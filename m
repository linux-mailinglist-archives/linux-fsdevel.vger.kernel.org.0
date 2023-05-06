Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB646F9367
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 19:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjEFRl1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 13:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFRlZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 13:41:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7584156B2
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 May 2023 10:41:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47FFF60BA6
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 May 2023 17:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CAFC433EF;
        Sat,  6 May 2023 17:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683394883;
        bh=uCjhesLcsunAx7s5aod9XiUZ78Nv1oXq2yenr1NvgEE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wsLd1C5HlxgIIVmt4ASrhpcTtCrMHOWkZ7A5kZGgmXequPskUYr5NMOdrSKTiQiXs
         j0Tt+d8KgWhYrFW5L7vt4X6YlrppLBG00FWLvx+DG3AZr6N8Em6rAgx7edTgnKz9Mp
         x79j6kLny7YolS9/hayAtU9joGsetEU+1u4BwI8E=
Date:   Sat, 6 May 2023 10:41:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] filemap: Handle error return from __filemap_get_folio()
Message-Id: <20230506104122.e9ab27f59fd3d8294cb1356d@linux-foundation.org>
In-Reply-To: <CAHk-=wjzs7jHyp_SmT6h1Hnwu39Vuc0DuUxndwf2kL3zhyiCcw@mail.gmail.com>
References: <20230506160415.2992089-1-willy@infradead.org>
        <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com>
        <CAHk-=winai-5i6E1oMk7hXPfbP+SCssk5+TOLCJ3koaDrn7Bzg@mail.gmail.com>
        <CAHk-=wiZ0GaAdqyke-egjBRaqP-QdLcX=8gNk7m6Hx7rXjcXVQ@mail.gmail.com>
        <CAHk-=whfNqsZVjy1EWAA=h7D0K2o4D8MSdnK8Qytj2BBhhFrSQ@mail.gmail.com>
        <CAHk-=wjzs7jHyp_SmT6h1Hnwu39Vuc0DuUxndwf2kL3zhyiCcw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 6 May 2023 10:34:31 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, May 6, 2023 at 10:10 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > .. in the meantime, I did end up applying your patch.
> 
> Final (?) note on this: I not only applied your patch, but went
> looking for any other missed cases.
> 
> And found one in fs/nfs/dir.c, which like ext4 had grown a new use of
> __filemap_get_folio().
> 
> But unlike ext4 it hadn't been caught in linux-next (or I had just
> missed it) and so I hadn't caught it in my merge either.
> 
> I hope that's the last one.
> 
> I grepped for all these __filemap_get_folio() cases when I did the MM
> merge that brought in that change (and did the ext4 merge fixup), but
> then the nfs pull happened later and I didn't think to check for new
> cases...
> 
> A current grep seems to say that it's all good. But we had all missed
> the second check in filemap_fault(), so...
> 

We have a related afs fix which I plan to send over later today:

From: Christoph Hellwig <hch@lst.de>
Subject: afs: fix the afs_dir_get_folio return value
Date: Wed, 3 May 2023 17:45:26 +0200

Keep returning NULL on failure instead of letting an ERR_PTR escape to
callers that don't expect it.

Link: https://lkml.kernel.org/r/20230503154526.1223095-2-hch@lst.de
Fixes: 66dabbb65d67 ("mm: return an ERR_PTR from __filemap_get_folio")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: David Howells <dhowells@redhat.com>
Tested-by: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/afs/dir_edit.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/fs/afs/dir_edit.c~afs-fix-the-afs_dir_get_folio-return-value
+++ a/fs/afs/dir_edit.c
@@ -115,11 +115,12 @@ static struct folio *afs_dir_get_folio(s
 	folio = __filemap_get_folio(mapping, index,
 				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
 				    mapping->gfp_mask);
-	if (IS_ERR(folio))
+	if (IS_ERR(folio)) {
 		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
-	else if (folio && !folio_test_private(folio))
+		return NULL;
+	}
+	if (!folio_test_private(folio))
 		folio_attach_private(folio, (void *)1);
-
 	return folio;
 }
 
_

