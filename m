Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DE062A3EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 22:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbiKOVVE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 16:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiKOVUk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:20:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93241F61D
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 13:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668547175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bTy3gKLCbAl+CtOq7+S/RLFhr2vBABevhnGQ4CWnwdE=;
        b=eYeiaEYz5W08/ARghTZRo3p61QUCbVMYsJ/OpACezymn4wX5xFWkPOrruNwz1mRXzWKbA6
        RchBWeZZ821LSivAib/tOEAfaqly0T1hb99zkl2dXC/9LDNrtBPIMK/tp1YxJchZZyAZda
        9qplA/ZKcCmj9kvvdmj1v/TQh8rQfTo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-iWGMazmjNtWTVqeLxnM2zw-1; Tue, 15 Nov 2022 16:19:32 -0500
X-MC-Unique: iWGMazmjNtWTVqeLxnM2zw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BD0A1C0BC62;
        Tue, 15 Nov 2022 21:19:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3A0A112131E;
        Tue, 15 Nov 2022 21:19:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, willy@infradead.org,
        Jeff Layton <jlayton@kernel.org>,
        JeffleXu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] netfs: Fix folio unmarking/unlocking loops
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1846965.1668547152.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From:   David Howells <dhowells@redhat.com>
Date:   Tue, 15 Nov 2022 21:19:29 +0000
Message-ID: <1846994.1668547169@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you pull these changes please?  There are two, affecting the
functions that iterates over the pagecache unmarking or unlocking pages
after an op is complete:

 (1) xas_for_each() loops must call xas_retry() first thing and immediatel=
y
     do a "continue" in the case that the extracted value is a special
     value that indicates that the walk raced with a modification.  Fix th=
e
     unlock and unmark loops to do this.

 (2) The maths in the unlock loop is dodgy as it could, theoretically, at
     some point in the future end up with a starting file pointer that is
     in the middle of a folio.  This will cause a subtraction to go
     negative - but the number is unsigned.  Fix the maths to use absolute
     file positions instead of relative page indices.

Thanks,
David

Link: https://lore.kernel.org/r/166749229733.107206.17482609105741691452.s=
tgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/166757987929.950645.12595273010425381286.s=
tgit@warthog.procyon.org.uk/ # v2
---
The following changes since commit f0c4d9fc9cc9462659728d168387191387e903c=
c:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/netfs-fixes-20221115

for you to fetch changes up to 5e51c627c5acbcf82bb552e17533a79d2a6a2600:

  netfs: Fix dodgy maths (2022-11-15 16:56:07 +0000)

----------------------------------------------------------------
netfslib fixes

----------------------------------------------------------------
David Howells (2):
      netfs: Fix missing xas_retry() calls in xarray iteration
      netfs: Fix dodgy maths

 fs/netfs/buffered_read.c | 20 +++++++++++++-------
 fs/netfs/io.c            |  3 +++
 2 files changed, 16 insertions(+), 7 deletions(-)

