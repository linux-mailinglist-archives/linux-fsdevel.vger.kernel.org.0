Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E246F4DE5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 01:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjEBX4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 19:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEBX4I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 19:56:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B15F1704
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 16:56:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a25f6aa0eso8264702276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 16:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683071765; x=1685663765;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rm6kQ1RPOx/wKEQB/Wr7FhtY/sYHUQli9SfLyNwvoqI=;
        b=uld2PwCrMn+4Zi5vIkxMBtu7gCaRSzRQfkoghLE434QzitskKqtSqPR4P7SDJjYTWT
         YDaTn99Hu63b5Q3sBMCMhh5S0Dl5gK5yHH6bxjmGPf/XmEUG1oqp19/fO/4zeyF1W+r5
         t5AjPjQRwn55Oe+h09+nxyP3KkDlqI0mzpA/difTAhShjIsfmWQGH9A2h60vzrFn6Ybs
         ozXNeb3UpB5kggiT5mEQhrFgxpNfa37n4ydUSFU0WPewwjhmldheAk5wezK37UBLv/qB
         a88RjweKfn6lynAg/tWRRIW76S7u9xQvheBv38LXWdv07U5IMEo7aJRQUx28g9h7UAmu
         wdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683071765; x=1685663765;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rm6kQ1RPOx/wKEQB/Wr7FhtY/sYHUQli9SfLyNwvoqI=;
        b=QdqN706g/Rs3w2MGImodcYWaeYbGtVQhlnpAu8pdM5KpfaHj6VUprtoafB2exRv9kH
         0MLmheeDyf5o+gUc4rhIwJq1rctJ5TUvNiX3iqeetU9Q6JJWI52fKN85UroUpX2EH1+5
         RRYtdVeDgT+7len45hMclUVPzRFygsLL0Y9VFFWeB2KVnTbVabbs1t3wN/gySQzY6daM
         javvOJ7cg+Jqqze2cvtRZDQq2oa4d7CqLIFLE2Is16+ZpRqhBuBrEmo/Weq1WD/+Ym5Z
         Y/63HIZrDsClL9U4Is3GnKmUVoSYjyyU+3bFlvqj7Nnc5Il1vIq32MTgPQHaqBtkfqty
         23rQ==
X-Gm-Message-State: AC+VfDx4OHbm7CgGn8iZMfJj0Gwj8VmfAk7WyzflWBG4UHdpYrUavHs/
        dRgTV6xqkvJk2x2LLQ99324CWD7pQnXZhL9Ejg==
X-Google-Smtp-Source: ACHHUZ7l2Zyul066g8u0v9VFJHFuMm0nrivTqlRpLBeSkQrDswmmTDc47Xoso9TMDtxKFKBZC3JCAlwv721Bc0rhqQ==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:3794:0:b0:b9e:6d41:54c4 with SMTP
 id e142-20020a253794000000b00b9e6d4154c4mr1685511yba.8.1683071765688; Tue, 02
 May 2023 16:56:05 -0700 (PDT)
Date:   Tue,  2 May 2023 23:56:01 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <cover.1683069252.git.ackerleytng@google.com>
Subject: [PATCH 0/2] Fix fallocate error in hugetlbfs when fallocating again
From:   Ackerley Tng <ackerleytng@google.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, sidhartha.kumar@oracle.com,
        jhubbard@nvidia.com
Cc:     vannapurve@google.com, erdemaktas@google.com,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When fallocate() is used twice on the same offset, it should succeed
and return 0 to userspace. The second fallocate() in
test_multiple_fallocates() in the following code will return -EEXIST
for hugetlbfs, but not tmpfs/shmem.

#define _GNU_SOURCE
#include <fcntl.h>
#include <linux/falloc.h>
#include <linux/memfd.h>
#include <sys/mman.h>
#include <stdio.h>
#include <unistd.h>

void test_multiple_fallocates(unsigned int flags)
{
	int fd = memfd_create("foo", flags);

	if (fallocate(fd, 0, 0, 0x1000))
		printf("error with fallocate %m\n");

	if (fallocate(fd, 0, 0, 0x1000))
		printf("error with second fallocate %m\n");
}

int main(void) {

	printf("Testing tmpfs:\n");
	test_multiple_fallocates(0);

	printf("Testing hugetlbfs:\n");
	test_multiple_fallocates(MFD_HUGETLB | MFD_HUGE_2MB);

}

This patch series replaces page_cache_next_miss(), used to determine a
page cache hit, with a more direct filemap_has_folio() (a new
function).

I hope that this is also the desired refactoring as mentioned in [1].

[1] https://lore.kernel.org/all/Y8oqEOICcNV762IA@casper.infradead.org/

---

Ackerley Tng (2):
  mm: filemap: Add filemap_has_folio function
  fs: hugetlbfs: Fix logic to skip allocation on hit in page cache

 fs/hugetlbfs/inode.c    |  6 +-----
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 17 +++++++++++++++++
 3 files changed, 19 insertions(+), 5 deletions(-)

--
2.40.1.495.gc816e09b53d-goog
