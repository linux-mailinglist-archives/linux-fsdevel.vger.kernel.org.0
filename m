Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6374D6A8CD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 00:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjCBXSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 18:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjCBXSF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:18:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696245942E
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 15:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677799008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LAJJhudeXwtcWIsgOSeQzqHZOSp/kZ+Tsq3aTHJfVgw=;
        b=O2pgfdftPeK50yEzVS7qdqaP+YCLQFgIJia//lOEGC1Fy9rBWX4xkaZf0Lobjsq9YVpvax
        WPL2ny/IDY3S0c1gfktrhFYVIS3h2aSEBA7SyantKYM9wtkNlxhDZXVrEALzqRLr82HIFF
        qm27ghCKGjfjAFBrqEQF9wahKpstGlc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-L88jf00AM7usTIYZwG25HA-1; Thu, 02 Mar 2023 18:16:44 -0500
X-MC-Unique: L88jf00AM7usTIYZwG25HA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9C151C05ABE;
        Thu,  2 Mar 2023 23:16:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C38BC2026D76;
        Thu,  2 Mar 2023 23:16:41 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Paulo Alcantara <pc@cjr.nz>, Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] smb3, afs: Revert changes to {cifs,afs}_writepages_region()
Date:   Thu,  2 Mar 2023 23:16:35 +0000
Message-Id: <20230302231638.521280-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus, Steve,

Could you consider applying these please?

I've split the patch that I proposed[1] to revert Vishal's patch to afs and
Linus's changes to cifs back to the point where find_get_pages_range_tag()
was being used to get a single folio and then replace that with a function,
filemap_get_folio_tag() that just gets a single folio and done some
benchmarking against this and some conversions to use write_cache_pages()
in various ways.

This is using the following to do testing of the write paths:

	fio --ioengine=libaio --direct=0 --gtod_reduce=1 --name=readtest \
	    --filename=/xfstest.test/foo --iodepth=128 --time_based \
	    --runtime=120 --readwrite=randread --iodepth_low=96 \
	    --iodepth_batch=16 --numjobs=4 --size=16M --bs=4k

The base for comparison, the upstream kernel at commit:

	d2980d8d826554fa6981d621e569a453787472f8
	"Merge tag 'mm-nonmm-stable-2023-02-20-15-29' of git://git./linux/kernel/git/akpm/mm"

plus the accumulated fixes on Steve's cifs for-next branch.

AFS firstly.  The code that's upstream keeps track of the dirtied region of
a folio in page->private, so I tried removing that to see what difference
it makes, in addition to trying conversions to use write_cache_pages().  I
also tried giving afs it's own copy of write_cache_pages() in order to
eliminate the function pointer - in case that had a signifcant effect due
to spectre mitigations.

  Base:
	WRITE: bw=302MiB/s (316MB/s), 71.9MiB/s-78.9MiB/s (75.3MB/s-82.8MB/s)
	WRITE: bw=303MiB/s (318MB/s), 65.9MiB/s-84.0MiB/s (69.1MB/s-88.1MB/s)
	WRITE: bw=310MiB/s (325MB/s), 73.6MiB/s-87.3MiB/s (77.1MB/s-91.5MB/s)

  Base + Partial revert (these patches):
	WRITE: bw=348MiB/s (365MB/s), 86.4MiB/s-87.5MiB/s (90.6MB/s-91.8MB/s)
	WRITE: bw=350MiB/s (367MB/s), 86.6MiB/s-88.4MiB/s (90.8MB/s-92.7MB/s)
	WRITE: bw=387MiB/s (406MB/s), 96.8MiB/s-97.0MiB/s (101MB/s-102MB/s)

  Base + write_cache_pages():
	WRITE: bw=280MiB/s (294MB/s), 69.7MiB/s-70.5MiB/s (73.0MB/s-73.9MB/s)
	WRITE: bw=285MiB/s (299MB/s), 70.9MiB/s-71.5MiB/s (74.4MB/s-74.9MB/s)
	WRITE: bw=290MiB/s (304MB/s), 71.6MiB/s-73.2MiB/s (75.1MB/s-76.8MB/s)

  Base + Page-dirty-region removed:
	WRITE: bw=301MiB/s (315MB/s), 70.4MiB/s-80.2MiB/s (73.8MB/s-84.1MB/s)
	WRITE: bw=325MiB/s (341MB/s), 78.5MiB/s-87.1MiB/s (82.3MB/s-91.3MB/s)
	WRITE: bw=320MiB/s (335MB/s), 71.6MiB/s-88.6MiB/s (75.0MB/s-92.9MB/s)

  Base + Page-dirty-region tracking removed +  write_cache_pages():
	WRITE: bw=288MiB/s (302MB/s), 71.9MiB/s-72.3MiB/s (75.4MB/s-75.8MB/s)
	WRITE: bw=284MiB/s (297MB/s), 70.7MiB/s-71.3MiB/s (74.1MB/s-74.8MB/s)
	WRITE: bw=287MiB/s (301MB/s), 71.2MiB/s-72.6MiB/s (74.7MB/s-76.1MB/s)

  Base + Page-dirty-region tracking removed + Own write_cache_pages()
	WRITE: bw=302MiB/s (316MB/s), 75.1MiB/s-76.1MiB/s (78.7MB/s-79.8MB/s)
	WRITE: bw=302MiB/s (316MB/s), 74.5MiB/s-76.1MiB/s (78.1MB/s-79.8MB/s)
	WRITE: bw=301MiB/s (316MB/s), 75.2MiB/s-75.5MiB/s (78.9MB/s-79.1MB/s)

So the partially reverted code appears significantly faster than code based
on write_cache_pages().  Removing the page-dirty-region tracking also slows
things down - I have a suspicion that this may be due to multipage folios
enlarging the apparently dirty regions of a file.

And then CIFS.  There's no dirtied region tracking here, so just the
partial reversion, a conversion to write_cache_pages() and its own version
of write_cache_pages() to eliminate the function pointer.

  Base:
	WRITE: bw=464MiB/s (487MB/s), 116MiB/s-116MiB/s (122MB/s-122MB/s)
	WRITE: bw=463MiB/s (486MB/s), 116MiB/s-116MiB/s (121MB/s-122MB/s)
	WRITE: bw=465MiB/s (488MB/s), 116MiB/s-116MiB/s (122MB/s-122MB/s)

  Base + Partial revert (these patches):
	WRITE: bw=470MiB/s (493MB/s), 117MiB/s-118MiB/s (123MB/s-123MB/s)
	WRITE: bw=467MiB/s (489MB/s), 117MiB/s-117MiB/s (122MB/s-122MB/s)
	WRITE: bw=464MiB/s (486MB/s), 116MiB/s-116MiB/s (121MB/s-122MB/s)

  Base + write_cache_pages():
	WRITE: bw=457MiB/s (479MB/s), 114MiB/s-114MiB/s (120MB/s-120MB/s)
	WRITE: bw=449MiB/s (471MB/s), 112MiB/s-113MiB/s (118MB/s-118MB/s)
	WRITE: bw=459MiB/s (482MB/s), 115MiB/s-115MiB/s (120MB/s-121MB/s)

  Base + Own write_cache_pages():
	WRITE: bw=451MiB/s (473MB/s), 113MiB/s-113MiB/s (118MB/s-118MB/s)
	WRITE: bw=455MiB/s (478MB/s), 114MiB/s-114MiB/s (119MB/s-120MB/s)
	WRITE: bw=453MiB/s (475MB/s), 113MiB/s-113MiB/s (119MB/s-119MB/s)
	WRITE: bw=459MiB/s (481MB/s), 115MiB/s-115MiB/s (120MB/s-120MB/s)

Here the partially reverted code appears slightly better - but the results
are very close so I'm not sure if it's statistically significant.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-cifs

David

Link: https://lore.kernel.org/r/2214157.1677250083@warthog.procyon.org.uk/ [1]

David Howells (3):
  mm: Add a function to get a single tagged folio from a file
  afs: Partially revert and use filemap_get_folio_tag()
  cifs: Partially revert and use filemap_get_folio_tag()

 fs/afs/write.c          | 118 +++++++++++++++++++---------------------
 fs/cifs/file.c          | 115 +++++++++++++++++----------------------
 include/linux/pagemap.h |   2 +
 mm/filemap.c            |  58 ++++++++++++++++++++
 4 files changed, 166 insertions(+), 127 deletions(-)

