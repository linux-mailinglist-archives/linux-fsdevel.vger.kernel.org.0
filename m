Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C80C640BE3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 18:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiLBRRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 12:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiLBRRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:17:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A59D96BB
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Dec 2022 09:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670001379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yKke9EW2oGA8ByDm6GYJX6e3Hk5NSm64Il6UHZTRwa8=;
        b=GI4jiMDsiKqtnYp56JkWZQKWAibAl/YnZlSH0EUXq4/U22KgRoMAMa0UQfLFgqAsR7Vhg3
        EQ/NEP/vEvH1cKahtxkLSKu+0hPagOpzqchfRjqcMFNrfXf0AgQ1saZKcaWxiRgYJk0ml6
        eIeP7coww05K5ir+ETG1YjEQ7wPdH3M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-vjZ491oLOVi0QDHOSxrY_w-1; Fri, 02 Dec 2022 12:16:15 -0500
X-MC-Unique: vjZ491oLOVi0QDHOSxrY_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1DBE185A78F;
        Fri,  2 Dec 2022 17:16:14 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.8.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE2C740C947B;
        Fri,  2 Dec 2022 17:16:14 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ikent@redhat.com, onestero@redhat.com, willy@infradead.org,
        ebiederm@redhat.com
Subject: [PATCH v3 0/5] proc: improve root readdir latency with many threads
Date:   Fri,  2 Dec 2022 12:16:15 -0500
Message-Id: <20221202171620.509140-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

Here's v3 of the /proc readdir optimization patches. See v1 for the full
introductary cover letter.

Most of the feedback received to this point has been around switching
the pid code over to use the xarray api instead of the idr. Matt Wilcox
posted most of the code to do that. I cleaned it up a bit and posted a
standalone series for that here [1], but didn't receive any feedback.
Patches 1-3 of this series are essentially a repost of [1].

Patches 4-5 are otherwise mostly the same as v2 outside of switching
over to use the xarray bits instead of the idr/radix-tree.

Thoughts, reviews, flames appreciated.

Brian

[1] https://lore.kernel.org/linux-mm/20220715113349.831370-1-bfoster@redhat.com/

v3:
- Drop radix-tree fixups.
- Convert pid idr usage to xarray.
- Replace tgid radix-tree tag set/lookup to use xarray mark.
v2: https://lore.kernel.org/linux-fsdevel/20220711135237.173667-1-bfoster@redhat.com/
- Clean up idr helpers to be more generic.
- Use ->idr_base properly.
- Lift tgid iteration helper into pid.c to abstract tag logic from
  users.
v1: https://lore.kernel.org/linux-fsdevel/20220614180949.102914-1-bfoster@redhat.com/

Brian Foster (5):
  pid: replace pidmap_lock with xarray lock
  pid: split cyclic id allocation cursor from idr
  pid: switch pid_namespace from idr to xarray
  pid: mark pids associated with group leader tasks
  procfs: use efficient tgid pid search on root readdir

 arch/powerpc/platforms/cell/spufs/sched.c |   2 +-
 fs/proc/base.c                            |  17 +--
 fs/proc/loadavg.c                         |   2 +-
 include/linux/pid.h                       |   3 +-
 include/linux/pid_namespace.h             |   9 +-
 include/linux/threads.h                   |   2 +-
 init/main.c                               |   3 +-
 kernel/fork.c                             |   2 +-
 kernel/pid.c                              | 177 +++++++++++++---------
 kernel/pid_namespace.c                    |  23 ++-
 10 files changed, 132 insertions(+), 108 deletions(-)

-- 
2.37.3

