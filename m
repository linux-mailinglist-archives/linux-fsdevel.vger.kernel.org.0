Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E236D54BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 00:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjDCW2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 18:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjDCW2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:28:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6A130C1;
        Mon,  3 Apr 2023 15:28:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so1024484wmb.3;
        Mon, 03 Apr 2023 15:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680560921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OioxhUaBsoagdWKYjA8WltvG/ViKSROcFBG3zkltOsQ=;
        b=ZB4YtgtHuGTtxSQnDSNuKDwOX9f/ubCsGGjYYgGbHGMjD1/Zm2nfVmEfT8lpOKa63S
         zidEBr3cA8hPgiuN1gO+MV4hCsXk+UryUgsmsijFfo1OUioR68BEpJw0WuohlJ+WYFci
         CdE8ppoSRZXkRrVURkVZwR+TcWTgMEvbwmWgrg6NOwO3qtWQZyZRQb+drrDJ6oBAl+yv
         d/xuKm8vT4TnfRGHbKFjI5BR16g58gwN9CkSaZ0mcy7gqKt8/nmv6viJk2rKtAJ8/x7/
         ZRFVLjTSv7C2iMkatIyuJdevtZqzCWM8ma9hDw92/D/2tlOEdZkU0/cYmDpgeWLeVNfi
         sS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680560921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OioxhUaBsoagdWKYjA8WltvG/ViKSROcFBG3zkltOsQ=;
        b=IWzo2N245vyFoFLOwIeP9oRJJT7Zw3ssb8Ucf4144v2FlOU4AyQpeDxQhSI7YapFfN
         wIWkz2rDvCR6dExmXTsGJCJWrdFAWQ0sMVRsohGqR4Jzkgr7QFnJiJwtFY6HuZOngW+K
         ea1l/nHh3+1l384hIKVk7EF4KbNHPE+xfot5pVkUJ7An4q3LKi/IakP1FFkQfhJOXtpU
         G/y1sEvgunVoQeGy0+MjNW18ZFlcmmvCtiLC2KzVICFNWSjrFiJUkbpwfEmM9uN2wGYJ
         +wZZX0BICUG/IgxZwZmgTekJNb1+a/a1RIkKJt+JHpWCowbs+AxaXhIxVbyVEhh7BwJu
         HeHg==
X-Gm-Message-State: AAQBX9dRMbjJ1gjeC5LQ4fKgW17pwYB8CSRFO50glEygMpB/tfx47IMb
        Ak1g4KyzdHbQo5cdUghQVrw=
X-Google-Smtp-Source: AKy350ZkH1dPvYtp77wPws1P2clzBLOW5//H6DXVOew0yN/++Jz7DRIMoyCO9kjYsKhgv8orz7HDpg==
X-Received: by 2002:a7b:c4c6:0:b0:3ed:5a12:5641 with SMTP id g6-20020a7bc4c6000000b003ed5a125641mr585231wmk.36.1680560921186;
        Mon, 03 Apr 2023 15:28:41 -0700 (PDT)
Received: from lucifer.home (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.googlemail.com with ESMTPSA id u17-20020a05600c19d100b003dd1bd0b915sm20731309wmq.22.2023.04.03.15.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 15:28:40 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [RFC PATCH 0/3] permit write-sealed memfd read-only shared mappings
Date:   Mon,  3 Apr 2023 23:28:29 +0100
Message-Id: <cover.1680560277.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series is in two parts:-

1. Currently there are a number of places in the kernel where we assume
   VM_SHARED implies that a mapping is writable. Let's be slightly less
   strict and relax this restriction in the case that VM_MAYWRITE is not
   set.

   This should have no noticeable impact as the lack of VM_MAYWRITE implies
   that the mapping can not be made writable via mprotect() or any other
   means.

2. Align the behaviour of F_SEAL_WRITE and F_SEAL_FUTURE_WRITE on mmap().
   The latter already clears the VM_MAYWRITE flag for a sealed read-only
   mapping, we simply extend this to F_SEAL_WRITE too.

   For this to have effect, we must also invoke call_mmap() before
   mapping_map_writable().

As this is quite a fundamental change on the assumptions around VM_SHARED
and since this causes a visible change to userland (in permitting read-only
shared mappings on F_SEAL_WRITE mappings), I am putting forward as an RFC
to see if there is anything terribly wrong with it.

I suspect even if the patch series as a whole is unpalatable, there are
probably things we can salvage from it in any case.

Thanks to Andy Lutomirski who inspired the series!

Lorenzo Stoakes (3):
  mm: drop the assumption that VM_SHARED always implies writable
  mm: update seal_check_[future_]write() to include F_SEAL_WRITE as well
  mm: perform the mapping_map_writable() check after call_mmap()

 fs/hugetlbfs/inode.c |  2 +-
 include/linux/fs.h   |  4 ++--
 include/linux/mm.h   | 24 ++++++++++++++++++------
 kernel/fork.c        |  2 +-
 mm/filemap.c         |  2 +-
 mm/madvise.c         |  2 +-
 mm/mmap.c            | 22 +++++++++++-----------
 mm/shmem.c           |  2 +-
 8 files changed, 36 insertions(+), 24 deletions(-)

--
2.40.0
