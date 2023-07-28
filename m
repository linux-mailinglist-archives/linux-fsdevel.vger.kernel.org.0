Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C321D766D48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 14:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbjG1Mck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 08:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjG1Mcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:32:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F26410FC;
        Fri, 28 Jul 2023 05:32:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 000FC6211C;
        Fri, 28 Jul 2023 12:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8C1C433C8;
        Fri, 28 Jul 2023 12:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690547557;
        bh=5+IB+ctY7aSwJzgoHEiHuMClfV6yZJmKN9IgrfrAyvQ=;
        h=Subject:From:Cc:Date:From;
        b=P3WiCF1UYQWWIAnOTPxtAyCawIacJu2MOEAFrnl1+2E+hKa6G4LjFOVGnWg7MImqK
         6FIMvXgzND14/EyoTerASk2ymrcjMAXQbagk2jYRVMkrpUVy9OkXVNKOztvx/NY/29
         GqqN20SZl4m5ly2CnUqm162H+TNKcf4cj6eBRiKtOdQnUjQGolwKG2xyDOPCevjWhs
         ZYgh73uCB0n1/OW9soeoq2rYOSRAyESzTpnJZMPajQdjQgO31dgu7nGCJWZgiO2nsq
         LLKGU5uD8lBNGGB/EiM07/m57Tr/XA6b+0BVjqzXk41HsEd/rUnLbXdPa4m3hjZkP6
         nRElSuklB2zSw==
Subject: [PATCH] nfsd: Fix reading via splice
From:   Chuck Lever <cel@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Hugh Dickins <hughd@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Chuck Lever <chuck.lever@oracle.com>,
        hughd@google.com, axboe@kernel.dk, willy@infradead.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Fri, 28 Jul 2023 08:32:35 -0400
Message-ID: <169054754615.3783.11682801287165281930.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

nfsd_splice_actor() has a clause in its loop that chops up a compound page
into individual pages such that if the same page is seen twice in a row, it
is discarded the second time.  This is a problem with the advent of
shmem_splice_read() as that inserts zero_pages into the pipe in lieu of
pages that aren't present in the pagecache.

Fix this by assuming that the last page is being extended only if the
currently stored length + starting offset is not currently on a page
boundary.

This can be tested by NFS-exporting a tmpfs filesystem on the test machine
and truncating it to more than a page in size (eg. truncate -s 8192) and
then reading it by NFS.  The first page will be all zeros, but thereafter
garbage will be read.

Note: I wonder if we can ever get a situation now where we get a splice
that gives us contiguous parts of a page in separate actor calls.  As NFSD
can only be splicing from a file (I think), there are only three sources of
the page: copy_splice_read(), shmem_splice_read() and file_splice_read().
The first allocates pages for the data it reads, so the problem cannot
occur; the second should never see a partial page; and the third waits for
each page to become available before we're allowed to read from it.

Fixes: bd194b187115 ("shmem: Implement splice-read")
Reported-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: Hugh Dickins <hughd@google.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-nfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 59b7d60ae33e..ee3bbaa79478 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -956,10 +956,13 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 	last_page = page + (offset + sd->len - 1) / PAGE_SIZE;
 	for (page += offset / PAGE_SIZE; page <= last_page; page++) {
 		/*
-		 * Skip page replacement when extending the contents
-		 * of the current page.
+		 * Skip page replacement when extending the contents of the
+		 * current page.  But note that we may get two zero_pages in a
+		 * row from shmem.
 		 */
-		if (page == *(rqstp->rq_next_page - 1))
+		if (page == *(rqstp->rq_next_page - 1) &&
+		    offset_in_page(rqstp->rq_res.page_base +
+				   rqstp->rq_res.page_len))
 			continue;
 		if (unlikely(!svc_rqst_replace_page(rqstp, page)))
 			return -EIO;


