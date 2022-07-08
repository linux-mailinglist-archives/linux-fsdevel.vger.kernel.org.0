Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF60656C227
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jul 2022 01:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbiGHVcm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 17:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240509AbiGHVcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BC52A026A
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657315957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cLD6V0BQa36edMLgHMFHkOTrNlZhNZjBOzy1qNyvvuU=;
        b=BEzVlBeNQHFnQF768mBbQyC3jeTfX5DTMmrOJ73qgLfabDRDRQtgQDXxJh7HKnfGwJcxBx
        8H05t2gN3uvMQ7bt87+1wRM6a7ZKfZxMAsdWfU/lZDGC6mdVniNz5417sH0NwFbVzmKjGt
        7f3GlV/GDHm4R9CLH94C3ZcsVNMLWxw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-L1s-bVZRNh23PIdMI0BY5w-1; Fri, 08 Jul 2022 17:32:36 -0400
X-MC-Unique: L1s-bVZRNh23PIdMI0BY5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CECC1C05132;
        Fri,  8 Jul 2022 21:32:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E1C540D282E;
        Fri,  8 Jul 2022 21:32:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, jlayton@kernel.org,
        Yue Hu <huyue2@coolpad.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Jia Zhu <zhujia.zj@bytedance.com>,
        Max Kellermann <mk@cm4all.com>, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] fscache: Miscellaneous fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3753786.1657315951.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 08 Jul 2022 22:32:31 +0100
Message-ID: <3753787.1657315951@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you pull these fscache/cachefiles fixes please?

 (1) Fix a check in fscache_wait_on_volume_collision() in which the
     polarity is reversed.  It should complain if a volume is still marked
     acquisition-pending after 20s, but instead complains if the mark has
     been cleared (ie. the condition has cleared).

     Also switch an open-coded test of the ACQUIRE_PENDING volume flag to
     use the helper function for consistency.

 (2) Not a fix per se, but neaten the code by using a helper to check for
     the DROPPED state.

 (3) Fix cachefiles's support for erofs to only flush requests associated
     with a released control file, not all requests.

 (4) Fix a race between one process invalidating an object in the cache an=
d
     another process trying to look it up.

Thanks,
David
---
The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9=
a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/fscache-fixes-20220708

for you to fetch changes up to 85e4ea1049c70fb99de5c6057e835d151fb647da:

  fscache: Fix invalidation/lookup race (2022-07-05 16:12:55 +0100)

----------------------------------------------------------------
fscache fixes

----------------------------------------------------------------
David Howells (1):
      fscache: Fix invalidation/lookup race

Jia Zhu (1):
      cachefiles: narrow the scope of flushed requests when releasing fd

Yue Hu (2):
      fscache: Fix if condition in fscache_wait_on_volume_collision()
      fscache: Introduce fscache_cookie_is_dropped()

 fs/cachefiles/ondemand.c |  3 ++-
 fs/fscache/cookie.c      | 26 ++++++++++++++++++++++----
 fs/fscache/volume.c      |  4 ++--
 include/linux/fscache.h  |  1 +
 4 files changed, 27 insertions(+), 7 deletions(-)

