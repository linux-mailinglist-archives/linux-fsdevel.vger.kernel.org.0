Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55060680E76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 14:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbjA3NFq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 08:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236569AbjA3NFm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:05:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AF6125B0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 05:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675083890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uBCujYj2Veetu7QK57xU7G/CWr3+t3ZM1ReUnbevAXw=;
        b=FsTmxfO+S+Onkd3o+T4mL6JgjMWmPoeI3D95j4re85b5tr8mhIRynnYmki6KMvIvZSLLm3
        ULL1eYWCbhBo09hpLSO+imgPdUioWu0s93gvR/014Fpyo6v318+/EQ07j2WxjNX5WD96i+
        CVKcoNNK+RRr1v/SNaj6w1zwz/3B0Zw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-TGlHHuprOdK2blxvl6wn1A-1; Mon, 30 Jan 2023 08:04:46 -0500
X-MC-Unique: TGlHHuprOdK2blxvl6wn1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46E1285A588;
        Mon, 30 Jan 2023 13:04:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D3742166B29;
        Mon, 30 Jan 2023 13:04:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     David Howells <dhowells@redhat.com>,
        Hou Tao <houtao@huaweicloud.com>,
        Jeff Layton <jlayton@kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>, houtao1@huawei.com,
        linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fscache: Fix incorrect mixing of wake/wait and missing barriers
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3425803.1675083883.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 30 Jan 2023 13:04:43 +0000
Message-ID: <3425804.1675083883@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

Could you pull these fixes from Hou Tao please?  There are two problems
fixed in fscache volume handling:

 (1) wake_up_bit() is incorrectly paired with wait_var_event().  The latte=
r
     selects the waitqueue to use differently.

 (2) Missing barriers ordering between state bit and task state.

Thanks,
David

To quote Hou Tao:

    The patchset includes two fixes for fscache volume operations: patch 1
    fixes the hang problem during volume acquisition when the volume
    acquisition process waits for the freeing of relinquished volume, patc=
h
    2 adds the missing memory barrier in fscache_create_volume_work() and =
it
    is spotted through code review when checking whether or not these is
    missing smp_mb() before invoking wake_up_bit().

    Change Log:
    v3:
     * Use clear_and_wake_up_bit() helper (Suggested by Jingbo Xu)
     * Tidy up commit message and add Reviewed-by tag

    v2: https://listman.redhat.com/archives/linux-cachefs/2022-December/00=
7402.html
     * rebased on v6.1-rc1
     * Patch 1: use wait_on_bit() instead (Suggested by David)
     * Patch 2: add the missing smp_mb() in fscache_create_volume_work()

    v1: https://listman.redhat.com/archives/linux-cachefs/2022-December/00=
7384.html

Link: https://lore.kernel.org/r/20230113115211.2895845-1-houtao@huaweiclou=
d.com
---
The following changes since commit 6d796c50f84ca79f1722bb131799e5a5710c470=
0:

  Linux 6.2-rc6 (2023-01-29 13:59:43 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/fscache-fixes-20230130

for you to fetch changes up to 3288666c72568fe1cc7f5c5ae33dfd3ab18004c8:

  fscache: Use clear_and_wake_up_bit() in fscache_create_volume_work() (20=
23-01-30 12:51:54 +0000)

----------------------------------------------------------------
fscache fixes

----------------------------------------------------------------
Hou Tao (2):
      fscache: Use wait_on_bit() to wait for the freeing of relinquished v=
olume
      fscache: Use clear_and_wake_up_bit() in fscache_create_volume_work()

 fs/fscache/volume.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

