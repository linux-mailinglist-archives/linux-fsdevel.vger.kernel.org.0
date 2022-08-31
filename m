Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F68F5A82D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 18:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiHaQO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 12:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiHaQOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3038F114B
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661962488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ohhxUg4+7/8HPSeKqNusAxfeg1kSR1cM5jiTTCPKRpM=;
        b=W+PFkpjgSMHC1Gst4CTqR96zaP0/ihl8up5pj/nCIVFpZ2tf65S7It/tw2H6YBGnEOCjtu
        ACamg2TfLN5mT9mWERxcgp/fMZ/jZ06N45wrC32O21gr0ZjU/c/ucjL2RcY15wDiHdQYZ1
        59IcxKtF15MGJCWTr9rCMF0o8vVdG6g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-Q-eZkHgUNKmsL4Z_r1Ec6Q-1; Wed, 31 Aug 2022 12:14:43 -0400
X-MC-Unique: Q-eZkHgUNKmsL4Z_r1Ec6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BCEE294EDDC;
        Wed, 31 Aug 2022 16:14:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C28A2026D4C;
        Wed, 31 Aug 2022 16:14:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, jlayton@kernel.org,
        Khalid Masum <khalid.masum.92@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sun Ke <sunke32@huawei.com>, Xin Yin <yinxin.x@bytedance.com>,
        Yongqing Li <liyongqing@bytedance.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fscache, cachefiles: Miscellaneous fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1867370.1661962479.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 31 Aug 2022 17:14:39 +0100
Message-ID: <1867371.1661962479@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Here's a collection of fixes for fscache and cachefiles, if you could pull
them:

 (1) Fix kdoc on fscache_use/unuse_cookie().

 (2) Fix the error returned by cachefiles_ondemand_copen() from an upcall
     result.

 (3) Fix the distribution of requests in on-demand mode in cachefiles to b=
e
     fairer by cycling through them rather than picking the one with the
     lowest ID each time (IDs being reused).

David
---
The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c=
5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/fscache-fixes-20220831

for you to fetch changes up to 1122f40072731525c06b1371cfa30112b9b54d27:

  cachefiles: make on-demand request distribution fairer (2022-08-31 16:41=
:10 +0100)

----------------------------------------------------------------
fscache/cachefiles fixes

----------------------------------------------------------------
Khalid Masum (1):
      fscache: fix misdocumented parameter

Sun Ke (1):
      cachefiles: fix error return code in cachefiles_ondemand_copen()

Xin Yin (1):
      cachefiles: make on-demand request distribution fairer

 fs/cachefiles/internal.h |  1 +
 fs/cachefiles/ondemand.c | 22 ++++++++++++++++------
 include/linux/fscache.h  |  4 ++--
 3 files changed, 19 insertions(+), 8 deletions(-)

