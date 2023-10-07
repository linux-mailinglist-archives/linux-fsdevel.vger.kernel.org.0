Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4697BC9DB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 22:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344164AbjJGUvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 16:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344151AbjJGUvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 16:51:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DDB93;
        Sat,  7 Oct 2023 13:51:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3226cc3e324so3189205f8f.3;
        Sat, 07 Oct 2023 13:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696711868; x=1697316668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iSZI04FWJw/xnla7C54t9PaSWTWuiAAC0wOD66SHSbo=;
        b=iAA7+t9YKwkEB5L/UEEEw8ulSLl07k1fRvtVLRFS1rAFYJqLtr1TYsmD+tBNMa266R
         Pxx8ia/pTkdaKkvD9I6Xof8xMMw6Yfn2JZY1pvLkbFdhxAaLjZHy2vygHDa96KCX27fW
         +BTR3R4832rnkXlWmEF4S4Qn83t6CYMnK4x1yp3C0dUnOBJIGCAlKrL+oO0a1MIbFMwN
         4da/ToKR+nWxEFLOWkD6L5E4Ig7tQ0eoiJF+1vQ7P+6aFMVn5+if5Fle6hixkNfhgjhT
         uaxXIuXciG9+Cc2FwQF9++sYxGycBTwAe0ZxKdBiW3nFdGQ1J1ljnIQxL0TZ80LggiQE
         nNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696711868; x=1697316668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSZI04FWJw/xnla7C54t9PaSWTWuiAAC0wOD66SHSbo=;
        b=bx9n5ITJOiiBWQ1kaBQXCN6SrcP0nd/K4zC0sr7bBGLhJTGZaq9EG4LtmkPk57Qzc3
         qZgUjumLU6nXfk2wXKlS+VMSFdACYQkRI6ByxShBjq10HiIySXNU0FQY62xljy/4BqSK
         p1R9zkuTJiZuaaCmEbeQ6ND31ica4jHpN18/1DJ28Vlzh2jkFT9WvAdZB6If35v5SnIw
         12nuCatZMcWvT5/18vL+umscHxffIHCRKuwUbZKhxomqMlerTy3HkESFusK8XhAeJwaU
         UkLzFrbdCOEaTMDCNyycchoLeqDz+qBoSc8eYZ403UybuIRQjjcVTuZQggVmyVmo+DeU
         5j5w==
X-Gm-Message-State: AOJu0Yy7fUHSZ8S3lNXESBuW3BuhgXCO+P1LXRCGY1hUnfR2wHNILiJ9
        RJmO//ozQ/0qbS/3JWkaXOVMVcXHGJc=
X-Google-Smtp-Source: AGHT+IGK0lDCEFA1hjFIW4LoHD2dcefcZKMoSA33EZr0Wxrn11nHo2JrireSCmV9YVJAnWlKMXQ1Ug==
X-Received: by 2002:a5d:494f:0:b0:31a:d266:3d62 with SMTP id r15-20020a5d494f000000b0031ad2663d62mr10817205wrs.54.1696711868048;
        Sat, 07 Oct 2023 13:51:08 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id g7-20020adfe407000000b003232d122dbfsm5120550wrm.66.2023.10.07.13.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 13:51:07 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Andy Lutomirski <luto@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 0/3] permit write-sealed memfd read-only shared mappings
Date:   Sat,  7 Oct 2023 21:50:58 +0100
Message-ID: <cover.1696709413.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The man page for fcntl() describing memfd file seals states the following
about F_SEAL_WRITE:-

    Furthermore, trying to create new shared, writable memory-mappings via
    mmap(2) will also fail with EPERM.

With emphasis on 'writable'. In turns out in fact that currently the kernel
simply disallows all new shared memory mappings for a memfd with
F_SEAL_WRITE applied, rendering this documentation inaccurate.

This matters because users are therefore unable to obtain a shared mapping
to a memfd after write sealing altogether, which limits their
usefulness. This was reported in the discussion thread [1] originating from
a bug report [2].

This is a product of both using the struct address_space->i_mmap_writable
atomic counter to determine whether writing may be permitted, and the
kernel adjusting this counter when any VM_SHARED mapping is performed and
more generally implicitly assuming VM_SHARED implies writable.

It seems sensible that we should only update this mapping if VM_MAYWRITE is
specified, i.e. whether it is possible that this mapping could at any point
be written to.

If we do so then all we need to do to permit write seals to function as
documented is to clear VM_MAYWRITE when mapping read-only. It turns out
this functionality already exists for F_SEAL_FUTURE_WRITE - we can
therefore simply adapt this logic to do the same for F_SEAL_WRITE.

We then hit a chicken and egg situation in mmap_region() where the check
for VM_MAYWRITE occurs before we are able to clear this flag. To work
around this, separate the check and its enforcement across call_mmap() -
allowing for this function to clear VM_MAYWRITE.

Thanks to Andy Lutomirski for the suggestion!

[1]:https://lore.kernel.org/all/20230324133646.16101dfa666f253c4715d965@linux-foundation.org/
[2]:https://bugzilla.kernel.org/show_bug.cgi?id=217238

v3:
- Don't defer the writable check until after call_mmap() in case this
  breaks f_ops->mmap() callbacks which assume this has been done
  first. Instead, separate the check and enforcement of it across the call,
  allowing for it to change vma->vm_flags in the meanwhile.
- Improve/correct commit messages and comments throughout.

v2:
- Removed RFC tag.
- Correct incorrect goto pointed out by Jan.
- Reworded cover letter as suggested by Jan.
https://lore.kernel.org/all/cover.1682890156.git.lstoakes@gmail.com/

v1:
https://lore.kernel.org/all/cover.1680560277.git.lstoakes@gmail.com/

Lorenzo Stoakes (3):
  mm: drop the assumption that VM_SHARED always implies writable
  mm: update memfd seal write check to include F_SEAL_WRITE
  mm: perform the mapping_map_writable() check after call_mmap()

 fs/hugetlbfs/inode.c |  2 +-
 include/linux/fs.h   |  4 ++--
 include/linux/mm.h   | 26 +++++++++++++++++++-------
 kernel/fork.c        |  2 +-
 mm/filemap.c         |  2 +-
 mm/madvise.c         |  2 +-
 mm/mmap.c            | 28 ++++++++++++++++++----------
 mm/shmem.c           |  2 +-
 8 files changed, 44 insertions(+), 24 deletions(-)

-- 
2.42.0

