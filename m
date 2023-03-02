Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8496A8D16
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 00:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCBXdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 18:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCBXdp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:33:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D6CE053
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 15:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677799983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5AKnwm11CuV/ZxP8F1kL9kNO/YucYb6B9hOTf3x61Ss=;
        b=UqAjHDXgSqxDoTsVjZvruge/C9mYnrsHWPr1V0DiNRge2X9FA2aeUEddkE+uGZSmiO/xMb
        9wEgG6+mUQ2XcVxERo1TVwPVXlTs0j14lpU3XR50CKJVa+84zgSI0hpLtiL8H4of2irm5B
        mhANl91g4WwR4ehrPJhVVaBuPcnvPDs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-E7TjwiinNbuZZv7n31dibw-1; Thu, 02 Mar 2023 18:32:59 -0500
X-MC-Unique: E7TjwiinNbuZZv7n31dibw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E640380450A;
        Thu,  2 Mar 2023 23:32:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6C12492C3E;
        Thu,  2 Mar 2023 23:32:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <521914.1677799750@warthog.procyon.org.uk>
References: <521914.1677799750@warthog.procyon.org.uk> <521671.1677799421@warthog.procyon.org.uk> <20230302231638.521280-1-dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, Vishal Moola <vishal.moola@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Paulo Alcantara <pc@cjr.nz>, Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Test patch to make afs use its own version of write_cache_pages()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <522121.1677799976.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 02 Mar 2023 23:32:56 +0000
Message-ID: <522122.1677799976@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> AFS firstly. ...
> =

>   Base + Page-dirty-region tracking removed + Own write_cache_pages()
> 	WRITE: bw=3D302MiB/s (316MB/s), 75.1MiB/s-76.1MiB/s (78.7MB/s-79.8MB/s)
> 	WRITE: bw=3D302MiB/s (316MB/s), 74.5MiB/s-76.1MiB/s (78.1MB/s-79.8MB/s)
> 	WRITE: bw=3D301MiB/s (316MB/s), 75.2MiB/s-75.5MiB/s (78.9MB/s-79.1MB/s)


This goes on top of "Test patch to remove per-page dirty region tracking f=
rom
afs" and "Test patch to make afs use write_cache_pages()"

David
---
 write.c |  141 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
 1 file changed, 138 insertions(+), 3 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 86b6e7cbe17c..d66c05acda8c 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -463,9 +463,9 @@ static int afs_writepages_submit(struct address_space =
*mapping,
  * Add a page to the set and flush when large enough.
  */
 static int afs_writepages_add_folio(struct folio *folio,
-				    struct writeback_control *wbc, void *data)
+				    struct writeback_control *wbc,
+				    struct afs_writepages_context *ctx)
 {
-	struct afs_writepages_context *ctx =3D data;
 	struct afs_vnode *vnode =3D AFS_FS_I(folio->mapping->host);
 	int ret;
 =

@@ -499,6 +499,141 @@ static int afs_writepages_add_folio(struct folio *fo=
lio,
 	}
 	return 0;
 }
+static int afs_write_cache_pages(struct address_space *mapping,
+				 struct writeback_control *wbc,
+				 struct afs_writepages_context *ctx)
+{
+	int ret =3D 0;
+	int done =3D 0;
+	int error;
+	struct folio_batch fbatch;
+	int nr_folios;
+	pgoff_t index;
+	pgoff_t end;		/* Inclusive */
+	pgoff_t done_index;
+	int range_whole =3D 0;
+	xa_mark_t tag;
+
+	folio_batch_init(&fbatch);
+	if (wbc->range_cyclic) {
+		index =3D mapping->writeback_index; /* prev offset */
+		end =3D -1;
+	} else {
+		index =3D wbc->range_start >> PAGE_SHIFT;
+		end =3D wbc->range_end >> PAGE_SHIFT;
+		if (wbc->range_start =3D=3D 0 && wbc->range_end =3D=3D LLONG_MAX)
+			range_whole =3D 1;
+	}
+	if (wbc->sync_mode =3D=3D WB_SYNC_ALL || wbc->tagged_writepages) {
+		tag_pages_for_writeback(mapping, index, end);
+		tag =3D PAGECACHE_TAG_TOWRITE;
+	} else {
+		tag =3D PAGECACHE_TAG_DIRTY;
+	}
+	done_index =3D index;
+	while (!done && (index <=3D end)) {
+		int i;
+
+		nr_folios =3D filemap_get_folios_tag(mapping, &index, end,
+				tag, &fbatch);
+
+		if (nr_folios =3D=3D 0)
+			break;
+
+		for (i =3D 0; i < nr_folios; i++) {
+			struct folio *folio =3D fbatch.folios[i];
+
+			done_index =3D folio->index;
+
+			folio_lock(folio);
+
+			/*
+			 * Page truncated or invalidated. We can freely skip it
+			 * then, even for data integrity operations: the page
+			 * has disappeared concurrently, so there could be no
+			 * real expectation of this data integrity operation
+			 * even if there is now a new, dirty page at the same
+			 * pagecache address.
+			 */
+			if (unlikely(folio->mapping !=3D mapping)) {
+continue_unlock:
+				folio_unlock(folio);
+				continue;
+			}
+
+			if (!folio_test_dirty(folio)) {
+				/* someone wrote it for us */
+				goto continue_unlock;
+			}
+
+			if (folio_test_writeback(folio)) {
+				if (wbc->sync_mode !=3D WB_SYNC_NONE)
+					folio_wait_writeback(folio);
+				else
+					goto continue_unlock;
+			}
+
+			BUG_ON(folio_test_writeback(folio));
+			if (!folio_clear_dirty_for_io(folio))
+				goto continue_unlock;
+
+			//trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
+			error =3D afs_writepages_add_folio(folio, wbc, ctx);
+			if (unlikely(error)) {
+				/*
+				 * Handle errors according to the type of
+				 * writeback. There's no need to continue for
+				 * background writeback. Just push done_index
+				 * past this page so media errors won't choke
+				 * writeout for the entire file. For integrity
+				 * writeback, we must process the entire dirty
+				 * set regardless of errors because the fs may
+				 * still have state to clear for each page. In
+				 * that case we continue processing and return
+				 * the first error.
+				 */
+				if (error =3D=3D AOP_WRITEPAGE_ACTIVATE) {
+					folio_unlock(folio);
+					error =3D 0;
+				} else if (wbc->sync_mode !=3D WB_SYNC_ALL) {
+					ret =3D error;
+					done_index =3D folio->index +
+						folio_nr_pages(folio);
+					done =3D 1;
+					break;
+				}
+				if (!ret)
+					ret =3D error;
+			}
+
+			/*
+			 * We stop writing back only if we are not doing
+			 * integrity sync. In case of integrity sync we have to
+			 * keep going until we have written all the pages
+			 * we tagged for writeback prior to entering this loop.
+			 */
+			if (--wbc->nr_to_write <=3D 0 &&
+			    wbc->sync_mode =3D=3D WB_SYNC_NONE) {
+				done =3D 1;
+				break;
+			}
+		}
+		folio_batch_release(&fbatch);
+		cond_resched();
+	}
+
+	/*
+	 * If we hit the last page and there is more work to be done: wrap
+	 * back the index back to the start of the file for the next
+	 * time we are called.
+	 */
+	if (wbc->range_cyclic && !done)
+		done_index =3D 0;
+	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
+		mapping->writeback_index =3D done_index;
+
+	return ret;
+}
 =

 /*
  * write some of the pending data back to the server
@@ -523,7 +658,7 @@ int afs_writepages(struct address_space *mapping,
 	else if (!down_read_trylock(&vnode->validate_lock))
 		return 0;
 =

-	ret =3D write_cache_pages(mapping, wbc, afs_writepages_add_folio, &ctx);
+	ret =3D afs_write_cache_pages(mapping, wbc, &ctx);
 	if (ret >=3D 0 && ctx.begun)
 		ret =3D afs_writepages_submit(mapping, wbc, &ctx);
 =

