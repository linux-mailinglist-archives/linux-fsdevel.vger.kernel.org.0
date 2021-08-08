Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE7A3E37EF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 04:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhHHCII (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Aug 2021 22:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhHHCIH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Aug 2021 22:08:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AE3C061760
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Aug 2021 19:07:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mt6so22502588pjb.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Aug 2021 19:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMm/Odyk8MGDnKiGamL4nyRlCLtI3xfxJNTo+Yg9PlE=;
        b=EuDxBQf33n+JRr0xqbTGg4xkRIWSfJ70s9rmSi7wQGDsaOueK3rIJeDy3xmWbli+D6
         VtHnyLVlvGS1cysKLBJ12XBJQYUFhnyKejdqDXPQeQgmJRO8tlWhXjKmDh4mYhsC75k2
         FABvjEGyWU85TGM+FrMTM6CbxgKNnG5rS4pxXme3xLZBpSu0v0Mpt9sY5V6XkyPGxDw4
         uKl5G+456gzkBMkcZFDYMY+f3qmUeUhm4GvL/pJhGBj82zZNcW659iIXNlp7xVAQdxqh
         Bh42VdxZBGm/avJdK/s4/WLJY1ggy2qMokOBmF5U5EpOiO6C36Qg+donEit8FrYqmTP+
         dWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMm/Odyk8MGDnKiGamL4nyRlCLtI3xfxJNTo+Yg9PlE=;
        b=SGtpWeixlGwQFHNz/KAUronj1RD7WHWtY7I/z3ilfPGehVrh8A9/4jsAeMHP45Rro6
         eLG+0eYV+2sfnQOJ1asL4ONyOAK6PuFbT2WXpKDDtgH+L3dCuqHveS79qmvJWXP1C1EE
         VWaRaLdnRAfGZVDAs1jPlpZtCoXiSR0mXV0TBpmX7Tm/TPXNgRQKE/5kipi7Keg9vdq0
         AmPzaWSePJ0Rv8dTkNuedg0mrYx+Nx/v87vOo096qPNgKiG+Lg+E2i3KKT9m5GxOU/fG
         1KjedpMyR7tfTPYCrXSF3rsoBNSENSo/RpsXhMkOj18e3VF14eugXZ2iazRaL/vrS0oG
         FEDg==
X-Gm-Message-State: AOAM533od5NCzmr9B5FiLTy5iqLjaUNTa+vnpGAywTRXImcLJF8b2lR9
        eV/3n9JYPRDA0sGLwFL7Zq3DsnIa0BG2vw==
X-Google-Smtp-Source: ABdhPJzgr+BfBh1UqcqF4K/vxCfukmJeGKuNvZHod9NLrn5C6b07IB8Om8kcZJgFWYm7I4VBmSpqYA==
X-Received: by 2002:a63:120e:: with SMTP id h14mr220165pgl.215.1628388468489;
        Sat, 07 Aug 2021 19:07:48 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id o18sm3987432pjp.1.2021.08.07.19.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 19:07:47 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pavel Emelyanov <xemul@parallels.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Nadav Amit <namit@vmware.com>
Subject: [PATCH 0/3] userfaultfd: minor bug fixes
Date:   Sat,  7 Aug 2021 19:07:21 -0700
Message-Id: <20210808020724.1022515-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Three unrelated bug fixes. The first two addresses possible issues (not
too theoretical ones), but I did not encounter them in practice.

The third patch addresses a test bug that causes the test to fail on my
system. It has been sent before as part of a bigger RFC. 

Nadav Amit (3):
  userfaultfd: change mmap_changing to atomic
  userfaultfd: prevent concurrent API initialization
  selftests/vm/userfaultfd: wake after copy failure

 fs/userfaultfd.c                         | 116 +++++++++++------------
 include/linux/userfaultfd_k.h            |   8 +-
 mm/userfaultfd.c                         |  15 +--
 tools/testing/selftests/vm/userfaultfd.c |  13 +++
 4 files changed, 82 insertions(+), 70 deletions(-)

-- 
2.25.1

