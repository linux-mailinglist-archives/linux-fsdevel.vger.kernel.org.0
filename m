Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D736A8D23
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 00:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCBXmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 18:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCBXmf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:42:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32624616A
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 15:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677800508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PlH4fJFKppxY+A07JXfq9y7Xnf4IHpCsyJL9AJzCkgg=;
        b=YfaOPaqpXvFM/fmKL26sYDIiTuZaB1ZBfVkZZX+iQmQUCyRuP1cUh5QRjdcxUCcMpWTnYa
        LlINPZAFYu3ZfbGxQ7tqfbf3bsl296g2ugPCicAGwzuAijOaUvHG0BAzqAMIEy+zPq/uOd
        cSvc5XDFOk4j22AT8ewF3AbTJ8NYZEM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-AwPjlJZLO6-m9tqSQdYfyw-1; Thu, 02 Mar 2023 18:41:42 -0500
X-MC-Unique: AwPjlJZLO6-m9tqSQdYfyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B90D31C05AEE;
        Thu,  2 Mar 2023 23:41:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F275F440D9;
        Thu,  2 Mar 2023 23:41:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <522331.1677800209@warthog.procyon.org.uk>
References: <522331.1677800209@warthog.procyon.org.uk> <20230302231638.521280-1-dhowells@redhat.com>
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
Subject: cifs test patch to make cifs use its own version of write_cache_pages()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <522531.1677800499.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 02 Mar 2023 23:41:39 +0000
Message-ID: <522532.1677800499@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

> And then CIFS. ...
> =

>   Base + Own write_cache_pages():
> 	WRITE: bw=3D451MiB/s (473MB/s), 113MiB/s-113MiB/s (118MB/s-118MB/s)
> 	WRITE: bw=3D455MiB/s (478MB/s), 114MiB/s-114MiB/s (119MB/s-120MB/s)
> 	WRITE: bw=3D453MiB/s (475MB/s), 113MiB/s-113MiB/s (119MB/s-119MB/s)
> 	WRITE: bw=3D459MiB/s (481MB/s), 115MiB/s-115MiB/s (120MB/s-120MB/s)

Here's my patch to give cifs its own copy of write_cache_pages() so that t=
he
function pointer can be eliminated in case some sort of spectre thing is
causing a slowdown.

This goes on top of "cifs test patch to convert to using write_cache_pages=
()".

David
---
 fs/cifs/file.c |  137 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
 1 file changed, 136 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 04e2466609d9..c33c7db729c7 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2802,6 +2802,141 @@ static int cifs_writepages_add_folio(struct folio =
*folio,
 	return 0;
 }
 =

+static int cifs_write_cache_pages(struct address_space *mapping,
+				  struct writeback_control *wbc,
+				  struct cifs_writepages_context *ctx)
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
+			error =3D cifs_writepages_add_folio(folio, wbc, ctx);
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
+
 /*
  * Write some of the pending data back to the server
  */
@@ -2816,7 +2951,7 @@ static int cifs_writepages(struct address_space *map=
ping,
 	 * to prevent it.
 	 */
 =

-	ret =3D write_cache_pages(mapping, wbc, cifs_writepages_add_folio, &ctx)=
;
+	ret =3D cifs_write_cache_pages(mapping, wbc, &ctx);
 	if (ret >=3D 0 && ctx.begun) {
 		ret =3D cifs_writepages_submit(mapping, wbc, &ctx);
 		if (ret < 0)

