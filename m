Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091513B327F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 17:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhFXP1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 11:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38083 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232005AbhFXP1j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624548320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yv7m1AvCn7O6dTH1q9vdjmlX/RhwF6AeGVa6Oa4+0Qw=;
        b=hc+MkdR+M9lbcshIxpzaf8acpDNrC3LOd3ZS/LDdnwPvYfmIph+6vLEcnbwcbXiZSVuN3v
        xNVLSgIBA4ZdwKfH2jPuaMqVYgxsBlBCYNyA8tXNPcloVtUkP4MeGqHnl1wR5AWtUzmt1E
        2JmQ9+Ta0OrtY0ORPj/lscgUfZzl8Ac=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-pxrp5rh7P0Ogm5PrSfFsBg-1; Thu, 24 Jun 2021 11:25:18 -0400
X-MC-Unique: pxrp5rh7P0Ogm5PrSfFsBg-1
Received: by mail-ej1-f70.google.com with SMTP id ho42-20020a1709070eaab02904a77ea3380eso2151690ejc.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jun 2021 08:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yv7m1AvCn7O6dTH1q9vdjmlX/RhwF6AeGVa6Oa4+0Qw=;
        b=oXvYTDY+tZPvTIJcbD18kuRkk9/v0a0+6mHhEBY5apgNO4NTFQ0Y7b2+cedZ0hbk8N
         jcQDnBW9Fin3vxN5LQsV8STmxngaJgEgvLOmrNbJYzUVGg1LorgSIRooencFux4d3iu4
         wgCIFLdnvN+J/jFdwB0LDBoXVg3w9dPzenhcqT6BXJ2a+pBlznZoYV9K7GxYcsO54Qo7
         IUjo0xr/Uog2dPyhiTPC75y5C6mQz40cldNIdsk5XiTc8NT33I+4kAXbH6Kakzp8uFwU
         37DtpnED4XEWTFkISSz2VCygDWkLfT+4GnKQD6OHAsS+t/rcwyfM8ftYOYWN4QCnaPTt
         jlqg==
X-Gm-Message-State: AOAM533Kibfdg5CBf/4Swnqnyq5Kvq6nheYXowziS63xNAK7u31cgNHi
        GqM2CwAcXpIdoPofLLpUF6EOCSfW71heD8nFTtcGbP96hewQK2zwVmvQS4Z8iYfN2lxNVff4kqn
        E6rQuvxM95H1e3SVFhx85ZRQlHA==
X-Received: by 2002:a17:906:22c6:: with SMTP id q6mr5836123eja.275.1624548317666;
        Thu, 24 Jun 2021 08:25:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDFvu9eksuXynDzV/xksZCJe2btC6g1NOCWnVD/di1wd6CsF0Z7byzAfEPlhofKBrJp+8MwA==
X-Received: by 2002:a17:906:22c6:: with SMTP id q6mr5836107eja.275.1624548317485;
        Thu, 24 Jun 2021 08:25:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:d067:83f0:d612:b70f])
        by smtp.gmail.com with ESMTPSA id a2sm1399830ejp.1.2021.06.24.08.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 08:25:17 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert O'Callahan <roc@ocallahan.org>
Subject: [RFC PATCH] userfaultfd: open userfaultfds with O_RDONLY
Date:   Thu, 24 Jun 2021 17:25:15 +0200
Message-Id: <20210624152515.1844133-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since userfaultfd doesn't implement a write operation, it is more
appropriate to open it read-only.

When userfaultfds are opened read-write like it is now, and such fd is
passed from one process to another, SELinux will check both read and
write permissions for the target process, even though it can't actually
do any write operation on the fd later.

Inspired by the following bug report, which has hit the SELinux scenario
described above:
https://bugzilla.redhat.com/show_bug.cgi?id=1974559

Reported-by: Robert O'Callahan <roc@ocallahan.org>
Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

I marked this as RFC, because I'm not sure if this has any unwanted side
effects. I only ran this patch through selinux-testsuite, which has a
simple userfaultfd subtest, and a reproducer from the Bugzilla report.

Please tell me whether this makes sense and/or if it passes any
userfaultfd tests you guys might have.

 fs/userfaultfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 14f92285d04f..24e14c36068f 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -986,7 +986,7 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *new,
 	int fd;
 
 	fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, new,
-			O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
+			O_RDONLY | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
 	if (fd < 0)
 		return fd;
 
@@ -2088,7 +2088,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	mmgrab(ctx->mm);
 
 	fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, ctx,
-			O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
+			O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
 	if (fd < 0) {
 		mmdrop(ctx->mm);
 		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-- 
2.31.1

