Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39766B14EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 23:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjCHWT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 17:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCHWTo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:19:44 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FECC960AC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 14:19:41 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bbaa701aso41567b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Mar 2023 14:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678313980;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=59KHgKYn5h2DxDze/0H+qYs+zSD2xpB8DwAJPLoezIY=;
        b=psy+2HbFD7rTKlv6i/9z9TMs7aO6Q9ADLGOAWDTg2WmJG1dRGgMgVUpX4efSJDUvCJ
         odAgnZkw0PHgqzrthaSvp+OztF9xLbC0yZdJ1GrTuiyfV6TFypRlA8Zo5qBHkw3RnAhq
         7dGto2fdIGm/53Ol9iQK8yQ5BJ9s4Ukg9THviV9xUtFMlUHcfO0c4dnCjiomTwYNWxTT
         0kWfgy/7vjGllkI79QC8UfGITDPQSesxh3c43ymmXYM3NQj4rpj+LQBQ8iiofjY13jzX
         +eep2agWxc1vFDSJYxP6BSgEc0uRyScjdwcFE0EYKuNQA/3yiX2YqhZKLUZ/V7CTvdgi
         xrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678313980;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=59KHgKYn5h2DxDze/0H+qYs+zSD2xpB8DwAJPLoezIY=;
        b=X3aObZ5Ntcn6/lFpL2/+GmlAb4IdScFQp67p4zQd9gzbG/ZQBKMsnQUJxTm/a/x6eq
         XI8Ga6mIH7DsI9QqjIUx4KMiAUI8D9O2VPdxBpV9710g117jZtoP9cqtgU5yTWk0m/r0
         7z7jsRvsOeBRyng1uybR+XsHyG9f77sg0hon5wWPbtY1vv7YHhHnk06oWUM6Mn5vHp3z
         Ds+TdIhbqhZJaJcaGkQLZZSKV7mrhbM6Nk92+Uel4t0MbCQ8qpV/nJKhFhg+o+R9m+0e
         tuDJHHZ+qSoQPuR7bgoUTax9PPjb13WuMoRA59TriOiSe2eGfRm2qA41AhxZWXfwlalL
         ddrQ==
X-Gm-Message-State: AO0yUKUj1SDh9e34wNHXi/6eLF/Oty52XOHgDfOxrA314fUm+tdx/kFZ
        WJY1K+e9JxFt9f3Zlu8L3h1GcXfNllKgyIem/w8Q
X-Google-Smtp-Source: AK7set9d9FE/NAlfpDGrZXYKb7zzCQ5a9t1j/rgnOnPFFtEbHAxYd1FA+v3qbCEOFEfsYlACC+nXD0T9KIOaxTuAUo5G
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:96cb:1c04:7322:78a4])
 (user=axelrasmussen job=sendgmr) by 2002:a5b:209:0:b0:aa9:bd2e:3746 with SMTP
 id z9-20020a5b0209000000b00aa9bd2e3746mr7058072ybl.4.1678313980346; Wed, 08
 Mar 2023 14:19:40 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:19:28 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230308221932.1548827-1-axelrasmussen@google.com>
Subject: [PATCH v4 0/4] mm: userfaultfd: refactor and add UFFDIO_CONTINUE_MODE_WP
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series, currently based on 6.3-rc1, is divided into two parts:

- Commits 1-3 refactor userfaultfd ioctl code without behavior changes, with the
  main goal of improving consistency and reducing the number of function args.
- Commit 4 adds UFFDIO_CONTINUE_MODE_WP.

The refactors are sorted by increasing controversial-ness, the idea being we
could drop some of the refactors if they are deemed not worth it.

Changelog:

v3->v4:
 - massage the uffd_flags_t implementation to eliminate all sparse warnings
 - add a couple inline helpers to make uffd_flags_t usage easier
 - drop the refactor passing `struct uffdio_range *` around (previously 4/5)
 - define a temporary `struct mm_struct *` in function with >=3 `vma->vm_mm`
 - consistent argument order between `flags` and `pagep`
 - expand on the use case in patch 4/4 message

v2->v3:
 - rebase onto 6.3-rc1
 - typedef a new type for mfill flags in patch 3/5 (suggested by Nadav)

v1->v2:
 - refactor before adding the new flag, to avoid perpetuating messiness

Axel Rasmussen (4):
  mm: userfaultfd: rename functions for clarity + consistency
  mm: userfaultfd: don't pass around both mm and vma
  mm: userfaultfd: combine 'mode' and 'wp_copy' arguments
  mm: userfaultfd: add UFFDIO_CONTINUE_MODE_WP to install WP PTEs

 fs/userfaultfd.c                         |  29 ++--
 include/linux/hugetlb.h                  |  27 ++--
 include/linux/shmem_fs.h                 |   9 +-
 include/linux/userfaultfd_k.h            |  68 +++++----
 include/uapi/linux/userfaultfd.h         |   7 +
 mm/hugetlb.c                             |  28 ++--
 mm/shmem.c                               |  14 +-
 mm/userfaultfd.c                         | 170 +++++++++++------------
 tools/testing/selftests/mm/userfaultfd.c |   4 +
 9 files changed, 187 insertions(+), 169 deletions(-)

--
2.40.0.rc1.284.g88254d51c5-goog

