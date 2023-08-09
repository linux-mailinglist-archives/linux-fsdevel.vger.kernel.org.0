Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBF07751EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 06:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjHIE2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 00:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjHIE2V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 00:28:21 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE5019A1
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 21:28:20 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d07c535377fso6836160276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 21:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691555299; x=1692160099;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LNX2gVTfjhVTAgrxowx/Ja6Ynr5BMCRl3aEeyLA/OyA=;
        b=Lp5IxKL3QYN8alsy4CzPCKT8uDmwrXUjy4IjlkWKHsQwI2AgxbPfVYMFJrLzg0eaLn
         2j7MUtFRjz6MVSIYk9zRHgl8UTP1ibj5IL+1MVpf3LVlJ9s9tCh1dF1wZxVgSge5tgR7
         XU4uI+BdhotRicWNYP31bFkaVUGeOWjscPGqH6+YqhnhBSWEFrOg3/ociku8hPyXejnq
         mEkQlFIJfiQ15uYTZNSjvWklnkDAeig9vP0CJ5DH5gFV7uyrlO++L0+wrqlhWPQ0QXM2
         mD45hj/KDLX8tDEXT9ULdh6oSgJklKLlmek2eEupUUOXBHX1dlP0YlUSsXvsO2FmKfkD
         afcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691555299; x=1692160099;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LNX2gVTfjhVTAgrxowx/Ja6Ynr5BMCRl3aEeyLA/OyA=;
        b=NJs9Q69ktRdsyTzA8T8MPcH5liLg5T4n993IWV0RilZW/aCeZHbAI6P8Itg98FsQtz
         eoEDm2ajBkUg5kVHknKqIPpd03psFejFA+u4QA46Vvi7CjCqHj597MloG05o63iQWVqC
         53Qemk5QIEVtP/5VtvdEkIEPLDCHsLdcDG9J9xJdxxUrSFvlkLJfDcHm6cChi7Qq4rEU
         h0LgBAILRVJAJDcOBCRCpuRzxLYoFl9bLamEpqobsd2ptd0ADdcowr7mqA8dTBuLXLYH
         2q7/Ac7sRiIYzsO0Tul01asmoz5k61lykI4+naKYT4vZnd7OTvB1MTK4o15aDV4xZTYu
         lzZg==
X-Gm-Message-State: AOJu0YxRDaWvglWXxVzLZibfZkbqkEDdDTeiDn0/BlWQa6CaU/FpM22B
        Gs1SXHwIrqSiW7wjy5X5i7JjSA==
X-Google-Smtp-Source: AGHT+IGdENtZZLPLv1rOUsSWfPNXi+awN4YQgBXL+LsGL+tZPvcj5kvheolqqxPSLvIXTwHMcHAsWQ==
X-Received: by 2002:a25:dfc1:0:b0:d47:d267:26d0 with SMTP id w184-20020a25dfc1000000b00d47d26726d0mr1531341ybg.38.1691555299507;
        Tue, 08 Aug 2023 21:28:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t5-20020a25c305000000b00c5ec980da48sm3192362ybf.9.2023.08.08.21.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 21:28:18 -0700 (PDT)
Date:   Tue, 8 Aug 2023 21:28:08 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Christian Brauner <brauner@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH vfs.tmpfs 0/5] tmpfs: user xattrs and direct IO
Message-ID: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series enables and limits user extended attributes on tmpfs,
and independently provides a trivial direct IO stub for tmpfs.

It is here based on the vfs.tmpfs branch in vfs.git in next-20230808
but with a cherry-pick of v6.5-rc4's commit
253e5df8b8f0 ("tmpfs: fix Documentation of noswap and huge mount options")
first: since the vfs.tmpfs branch is based on v6.5-rc1, but 3/5 in this
series updates tmpfs.rst in a way which depends on that commit.

IIUC the right thing to do would be to cherry-pick 253e5df8b8f0 into
vfs.tmpfs before applying this series.  I'm sorry that the series as
posted does not apply cleanly to any known tree! but I think posting
it against v6.5-rc5 or next-20230808 would be even less helpful.

There is one "conflict" between this series and the final next-20230808:
Jeff Layton's vfs.ctime mods update a line of shmem_xattr_handler_set(),
where neighbouring lines are modified by 1/5 and 3/5 here: easily
resolved in the merge commit, I hope.

1/5 xattr: simple_xattr_set() return old_xattr to be freed
2/5 tmpfs: track free_ispace instead of free_inodes
3/5 tmpfs,xattr: enable limited user extended attributes
4/5 tmpfs: trivial support for direct IO
5/5 mm: invalidation check mapping before folio_contains

 Documentation/filesystems/tmpfs.rst |   7 +-
 fs/Kconfig                          |   4 +-
 fs/kernfs/dir.c                     |   2 +-
 fs/kernfs/inode.c                   |  46 +++++++----
 fs/xattr.c                          |  79 +++++++++++-------
 include/linux/shmem_fs.h            |   2 +-
 include/linux/xattr.h               |  10 ++-
 mm/shmem.c                          | 130 +++++++++++++++++++++++-------
 mm/truncate.c                       |   4 +-
 9 files changed, 197 insertions(+), 87 deletions(-)

Hugh
