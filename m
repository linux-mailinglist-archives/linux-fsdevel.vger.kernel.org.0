Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D54A36710D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 19:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242870AbhDURPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 13:15:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241487AbhDURP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619025292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7Ds+L1bCP6+6WbzB+/50dXw+9s8exJ7s0FvADavIhEQ=;
        b=dOkbUZuwwa+JHr98I+whTVf8YhdQDabch58v/qadwGLs75/3q6tmlnqllIZ6PpNfyBSM6v
        lMePNVT9D5Rw7SonrMGfGRbp9ExJ4zemwothY+caPoec0SAgxpmTW7yawKNZzXVUept5Sd
        YNANxGA27WECYGT6Z8LL/lTZObz2P2I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-o82-a8d9Nd2OkS3Psokf-w-1; Wed, 21 Apr 2021 13:14:50 -0400
X-MC-Unique: o82-a8d9Nd2OkS3Psokf-w-1
Received: by mail-ej1-f71.google.com with SMTP id n10-20020a1709061d0ab029037caa96b8c5so6190351ejh.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 10:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Ds+L1bCP6+6WbzB+/50dXw+9s8exJ7s0FvADavIhEQ=;
        b=mhi2gToYq7rCMUTFgcNlKw+WlSHPWyL8XyeD77M9Hl6qXsirHQmmOzb4d2JQn3lf0H
         Fd0+ubXfMkPK7wZMKKseZXqCCQo1Y9kNwSoeNOMUy6QWn/7IPxCG8YH68hkduh0CdN42
         kqfEkMBJu3eLZZvBbpRVX2+CuS3KqnJfqBl0YNTK2oFD25kF+YJry2PDjcI9BCnQ31dW
         O//+qUyJlQ5pUfJgHZTOZRy5F6jqdOY8mpTLGRl9Reo8+NZ9QGsiXCYyiiTbrbEsaLfH
         AL5yJ32ZkjpOuDqmuqTiYEW58uaLUBaknwe+Zt/Wb+MKC0Qo6y1aJsGd+5eEoDNsL8yZ
         ebDg==
X-Gm-Message-State: AOAM532rcxJXEC6+adRE0EbcHmkelsddA/S7+XRbdh8kopKgrUVCUbKs
        eaWE7aacuFoBNFSlKq2aJXX+U+vZ4dhUGFIvgwAqDAkBbUlnSBzdyW8TkzgcZAwCfHClh0iqxO6
        mROtb6pAR7BX07kQ7gNlpATotCA==
X-Received: by 2002:a05:6402:290:: with SMTP id l16mr29082599edv.337.1619025289507;
        Wed, 21 Apr 2021 10:14:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmoKETRUuKqjG2OlKoFygbPK3HDWwNtdSKU+JS0tzwEYE4lpqCN0fHqQM+w+zccUEMLCoX8w==
X-Received: by 2002:a05:6402:290:: with SMTP id l16mr29082582edv.337.1619025289299;
        Wed, 21 Apr 2021 10:14:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id i1sm22905edt.33.2021.04.21.10.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 10:14:48 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lokesh Gidra <lokeshgidra@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 0/2] selinux,anon_inodes: Use a separate SELinux class for each type of anon inode
Date:   Wed, 21 Apr 2021 19:14:44 +0200
Message-Id: <20210421171446.785507-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series aims to correct a design flaw in the original anon_inode
SELinux support that would make it hard to write policies for anonymous
inodes once more types of them are supported (currently only userfaultfd
inodes are). A more detailed rationale is provided in the second patch.

The first patch extends the anon_inode_getfd_secure() function to accept
an additional numeric identifier that represents the type of the
anonymous inode being created, which is passed to the LSMs via
security_inode_init_security_anon().

The second patch then introduces a new SELinux policy capability that
allow policies to opt-in to have a separate class used for each type of
anon inode. That means that the "old way" will still 

I wish I had realized the practical consequences earlier, while the
patches were still under review, but it only started to sink in after
the authors themselves later raised the issue in an off-list
conversation. Even then, I still hoped it wouldn't be that bad, but the
more I thought about how to apply this in an actual policy, the more I
realized how much pain it would be to work with the current design, so
I decided to propose these changes.

I hope this will be an acceptable solution.

A selinux-testsuite patch that adapts the userfaultfd test to work also
with the new policy capability enabled will follow.

Ondrej Mosnacek (2):
  LSM,anon_inodes: explicitly distinguish anon inode types
  selinux: add capability to map anon inode types to separate classes

 fs/anon_inodes.c                           | 42 +++++++++++++---------
 fs/userfaultfd.c                           |  6 ++--
 include/linux/anon_inodes.h                |  4 ++-
 include/linux/lsm_hook_defs.h              |  3 +-
 include/linux/security.h                   | 19 ++++++++++
 security/security.c                        |  3 +-
 security/selinux/hooks.c                   | 28 ++++++++++++++-
 security/selinux/include/classmap.h        |  2 ++
 security/selinux/include/policycap.h       |  1 +
 security/selinux/include/policycap_names.h |  3 +-
 security/selinux/include/security.h        |  7 ++++
 11 files changed, 95 insertions(+), 23 deletions(-)

-- 
2.30.2

