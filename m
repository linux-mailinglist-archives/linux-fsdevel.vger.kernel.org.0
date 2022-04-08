Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD4D4F9159
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 11:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiDHJI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 05:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiDHJIz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:08:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB4B3100764
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Apr 2022 02:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649408808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UIJ8W4kbN7C/kjzP9MVB+P9ZEFTMhxLK2LQH7IyF0lI=;
        b=A96IW47wEXhm0wE6TweuGE6RJdye1WfiKSXRlk7YOy+z6vrKE/wqidyCxXDZrmr36vB4hd
        URlsarWs7/0eR3jJ51hWiS+Xk3TbIluhT8/W1Xt+5J6jlRLg2DOcj9dmvhFo+mHytHaMmT
        pF+GRCzv3j9JwdYzEcBzvzF3XeysNgE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-4iiUBieZMQ2BkXETTv797A-1; Fri, 08 Apr 2022 05:06:45 -0400
X-MC-Unique: 4iiUBieZMQ2BkXETTv797A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6539811E75;
        Fri,  8 Apr 2022 09:06:44 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-202.pek2.redhat.com [10.72.12.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E945640E80E0;
        Fri,  8 Apr 2022 09:06:39 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        hch@lst.de, yangtiezhu@loongson.cn, amit.kachhap@arm.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        bhe@redhat.com
Subject: [PATCH v5 RESEND 0/3] Convert vmcore to use an iov_iter
Date:   Fri,  8 Apr 2022 17:06:33 +0800
Message-Id: <20220408090636.560886-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Copy the description of v3 cover letter from Willy:
===
For some reason several people have been sending bad patches to fix
compiler warnings in vmcore recently.  Here's how it should be done.
Compile-tested only on x86.  As noted in the first patch, s390 should
take this conversion a bit further, but I'm not inclined to do that
work myself.

V4:
[PATCH v4 0/3] Convert vmcore to use an iov_iter
https://lore.kernel.org/all/20220318093706.161534-1-bhe@redhat.com/T/#u

v3:
[PATCH v3 0/3] Convert vmcore to use an iov_iter
https://lore.kernel.org/all/20211213143927.3069508-1-willy@infradead.org/T/#u


Changelog:
===
v5 RESEND:
 - Add my own Signed-off-by, no code or log change related in this round.

v5:
 - Rebased on Linus's latest master branch.
 - Merge the patch 4 of v4 into patch 2.
v4:
 - Append one patch to replace the open code with iov_iter_count().
   This is suggested by Al.
 - Fix a indentation error by replacing space with tab in
   arch/sh/kernel/crash_dump.c of patch 1 reported by checkpatch. The
   rest of patch 1~3 are untouched.
 - Add Christopy's Reviewed-by and my Acked-by for patch 1~3.
v3:
 - Send the correct patches this time
v2:
 - Removed unnecessary kernel-doc
 - Included uio.h to fix compilation problems
 - Made read_from_oldmem_iter static to avoid compile warnings during the
   conversion
 - Use iov_iter_truncate() (Christoph)


Matthew Wilcox (Oracle) (3):
  vmcore: Convert copy_oldmem_page() to take an iov_iter
  vmcore: Convert __read_vmcore to use an iov_iter
  vmcore: Convert read_from_oldmem() to take an iov_iter

 arch/arm/kernel/crash_dump.c     |  27 +------
 arch/arm64/kernel/crash_dump.c   |  29 +------
 arch/ia64/kernel/crash_dump.c    |  32 +-------
 arch/mips/kernel/crash_dump.c    |  27 +------
 arch/powerpc/kernel/crash_dump.c |  35 ++-------
 arch/riscv/kernel/crash_dump.c   |  26 +------
 arch/s390/kernel/crash_dump.c    |  13 ++--
 arch/sh/kernel/crash_dump.c      |  29 ++-----
 arch/x86/kernel/crash_dump_32.c  |  29 +------
 arch/x86/kernel/crash_dump_64.c  |  48 ++++--------
 fs/proc/vmcore.c                 | 130 +++++++++++++------------------
 include/linux/crash_dump.h       |  19 ++---
 12 files changed, 123 insertions(+), 321 deletions(-)

-- 
2.34.1

