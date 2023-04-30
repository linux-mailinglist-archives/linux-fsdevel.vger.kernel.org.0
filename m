Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418276F2B55
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 00:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjD3W0p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Apr 2023 18:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjD3W0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Apr 2023 18:26:44 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390FB199;
        Sun, 30 Apr 2023 15:26:43 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-2fa0ce30ac2so1732962f8f.3;
        Sun, 30 Apr 2023 15:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682893601; x=1685485601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=okwsBHwtVho9RM+LIvD/U8UT1JGc7W3WT4T39OwkLBE=;
        b=UUJ/NDbbfOsxeA/Q0SOBghVYDteCo9FAjpu2BQuXtF0TZJfU2YQ86MmGpfrHqy6tjp
         T8+O+Xc74+kvmTbFHtADMkXyeTwapRaBYM3A+cSw/gROkda4aTTmyNNWpEHUsYj/sALL
         CZsY1WHTwx2Q7YXY+95VXHGq16udXRuUE+5WOpdHjcLO1uP3wfIsRmJVD9elvMj1ePK+
         ceGn6AvjANPQIbaEaBoWW/I2UHKK/pUH7YoGqlTPYq+9MgWqxqTn7WGyvY7eeKkGKFJN
         VV+Krys6lbg97MpHHNsv8Qg5Ktbv6emSyQzgqqkF1M3oge+YH+DV4k5F/9F/+X9dqOQ3
         LNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682893601; x=1685485601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okwsBHwtVho9RM+LIvD/U8UT1JGc7W3WT4T39OwkLBE=;
        b=bVoQ2dkKdsgiNLgW7L2U37GCYoS2ILO5sN8kwSkjbSYfT//AUXDmgD0m+v7LoHiCp+
         sevfaskaPE4jX/esEfz1MNGeFSiFdoEohWZlDQ+UoFlG6VVv4BCGBSeNZoDIOEDNO8Fk
         pL5FpOfCvP9ICc5N1wsBx3GcwQacxs7+smB4XVJ56KOvB8OzhJFdqMAUdnEYeDSYZ+vF
         0uHsjPIroZ9fSLgY3FTgD3P8rHfNY48LIx1PA2XUxq5lLcbbDQ1zdByXpDQ/3Rt9RL4i
         vUXCrIorEO00w7ZvJ7NroUIq9mMijR0p8GqeuAJ3Thr66XGn/yF9z2ojhych5g83gXv0
         YOWA==
X-Gm-Message-State: AC+VfDz32WQWIm4lijYjsaT64VzIb+iLDC6QkK4oBIyyqEpKD2131jGy
        N8wOtCbALkmcRelcu8VjWg8=
X-Google-Smtp-Source: ACHHUZ7y1xuoHHoFogOgEwzy3Gl+4P31trS1M5DtpRjSebq/LaRrngoPfxSiZSLenWWrvGC1U/Py0w==
X-Received: by 2002:a05:6000:84:b0:306:2c43:7afc with SMTP id m4-20020a056000008400b003062c437afcmr1386799wrx.34.1682893600876;
        Sun, 30 Apr 2023 15:26:40 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id g2-20020a5d5402000000b002da75c5e143sm26699865wrv.29.2023.04.30.15.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 15:26:40 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 0/3] permit write-sealed memfd read-only shared mappings
Date:   Sun, 30 Apr 2023 23:26:04 +0100
Message-Id: <cover.1682890156.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The man page for fcntl() describing memfd file seals states the following
about F_SEAL_WRITE:-

    Furthermore, trying to create new shared, writable memory-mappings via
    mmap(2) will also fail with EPERM.

With emphasis on _writable_. In turns out in fact that currently the kernel
simply disallows _all_ new shared memory mappings for a memfd with
F_SEAL_WRITE applied, rendering this documentation inaccurate.

This matters because users are therefore unable to obtain a shared mapping
to a memfd after write sealing altogether, which limits their
usefulness. This was reported in the discussion thread [1] originating from
a bug report [2].

This is a product of both using the struct address_space->i_mmap_writable
atomic counter to determine whether writing may be permitted, and the
kernel adjusting this counter when _any_ VM_SHARED mapping is performed.

It seems sensible that we should only update this mapping if VM_MAYWRITE is
specified, i.e. whether it is possible that this mapping could at any point
be written to.

If we do so then all we need to do to permit write seals to function as
documented is to clear VM_MAYWRITE when mapping read-only. It turns out
this functionality already exists for F_SEAL_FUTURE_WRITE - we can
therefore simply adapt this logic to do the same for F_SEAL_WRITE.

The final change required is to invoke call_mmap() before
mapping_map_writable() - doing so ensures that the memfd-relevant
shmem_mmap() or hugetlbfs_file_mmap() custom mmap handlers will be called
before the writable test, enabling us to clear VM_MAYWRITE first.

Thanks to Andy Lutomirski for the suggestion!

[1]:https://lore.kernel.org/all/20230324133646.16101dfa666f253c4715d965@linux-foundation.org/
[2]:https://bugzilla.kernel.org/show_bug.cgi?id=217238

v2:
- Removed RFC tag.
- Correct incorrect goto pointed out by Jan.
- Reworded cover letter as suggested by Jan.

v1:
https://lore.kernel.org/all/cover.1680560277.git.lstoakes@gmail.com/

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
2.40.1
