Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5848A4F9FF2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Apr 2022 01:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbiDHXIS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 19:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239980AbiDHXIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 19:08:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BB711D41A1
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Apr 2022 16:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649459170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fFnzWGKk077SHJjN1dvWjxWxYOAqXtEPrfH68KIxBjo=;
        b=NYKo/SJFzyYTWN4WSXnPB7b1ZypSqIR6RfOEQ1mTHKa+BzQb3TufDec6GqlTolElCRfz1W
        FpXG80xWxrjlAw5heXySokCAxwccbCijW8XOGKvbeOaEqL/nRRUYWHvCrGKW4eAL/QdjtK
        8mkz7eOJcvoCfgAdW7CA48fxZvcL6u4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343--IZuAnm4PHa3XJB99oFPcw-1; Fri, 08 Apr 2022 19:06:05 -0400
X-MC-Unique: -IZuAnm4PHa3XJB99oFPcw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5B4E380409B;
        Fri,  8 Apr 2022 23:06:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BA3B2167D60;
        Fri,  8 Apr 2022 23:05:57 +0000 (UTC)
Subject: [RFC][PATCH 0/8] fscache, cachefiles: Fixes
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Dave Wysochanski <dwysocha@redhat.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>, dhowells@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Sat, 09 Apr 2022 00:05:56 +0100
Message-ID: <164945915630.773423.14655306154231712324.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a collection of fscache and cachefiles fixes and misc small
cleanups.  The two main fixes are:

 (1) Add a missing unmark of the inode in-use mark in an error path.

 (2) Fix a KASAN slab-out-of-bounds error when setting the xattr on a
     cachefiles volume due to the wrong length being given to memcpy().

In addition, there's the removal of an unused parameter, removal of an
unused Kconfig option, conditionalising a bit of procfs-related stuff and
some doc fixes.

The patches are on a branch here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-fixes

David

---
Dave Wysochanski (1):
      cachefiles: Fix KASAN slab-out-of-bounds in cachefiles_set_volume_xattr

Jeffle Xu (1):
      cachefiles: unmark inode in use in error path

Yue Hu (6):
      docs: filesystems: caching/backend-api.rst: correct two relinquish APIs use
      docs: filesystems: caching/backend-api.rst: fix an object withdrawn API
      fscache: Remove the cookie parameter from fscache_clear_page_bits()
      fscache: Move fscache_cookies_seq_ops specific code under CONFIG_PROC_FS
      fscache: Use wrapper fscache_set_cache_state() directly when relinquishing
      fscache: remove FSCACHE_OLD_API Kconfig option


 .../filesystems/caching/backend-api.rst       |  8 ++---
 .../filesystems/caching/netfs-api.rst         | 25 +++++++-------
 fs/afs/write.c                                |  3 +-
 fs/cachefiles/namei.c                         | 33 ++++++++++++++-----
 fs/cachefiles/xattr.c                         |  2 +-
 fs/fscache/Kconfig                            |  3 --
 fs/fscache/cache.c                            |  2 +-
 fs/fscache/cookie.c                           |  4 ++-
 fs/fscache/internal.h                         |  4 +++
 fs/fscache/io.c                               |  5 ++-
 include/linux/fscache.h                       |  4 +--
 11 files changed, 53 insertions(+), 40 deletions(-)


