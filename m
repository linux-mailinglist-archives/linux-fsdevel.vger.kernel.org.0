Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3534124A184
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 16:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgHSORL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 10:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgHSORG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:17:06 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13227C061757
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2020 07:17:06 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id i10so5924305pgk.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2020 07:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+b+HgSL77X+21VijREb9V/UtZlFqeS2PZTUQKDVU+Fo=;
        b=DCMGHP7Osm+dJ0Bpj7dhChQIXeayREGue47/5N4hXZjG2r+DmCFkYIkfi6vC3hf9JH
         sZ1nLbExH8VLmFH8lGN9qFRep57SOlR8WcKZm9c1gDR5tB7n1TikVIPgYBwcqSyjg/7m
         0fBXlvdXjnK51AH2bXFqtpjfMZwAvqCbeEmHYhOgBs6YnCpjhQH7OBKwCJs4IIohCZQX
         bedjy3H0/X+0B1DLgSZHdqM1b4zDN5CvLg/5JJBbcwVmdwhrBak/CjdZxXsmV0yhKjeq
         kH+SVw3TfuZErQZtqekLXYbAQ4W34Nkaq8Xq+jrUaSCinycDd9nINRrj8CIm9VaJpMxf
         7GdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+b+HgSL77X+21VijREb9V/UtZlFqeS2PZTUQKDVU+Fo=;
        b=fGbng+O6lgSHe7aKAyvmci5/KrUUj+W3bmse5A5VPqo3GilpHGqN5uo7iBRmsY77iW
         jZ+OYOzuTDF3AYkxMRTQUPKEzXEWvijYCHkpbiTosFqnCQ8WqXShjLxC/z+d0PurR7QS
         kpGIF6e7PYdGYM3o5TQFJatKSM9Np1TWk+O6YfWe89dU/PYCuBsPlMwdhTahIIZkVcDP
         q5rKj1unKANECYUq3gYuDZUbAyS77pYuqTCoBOGSxlBMFxQ9nu/tSPZ6yRTby/RUgug4
         rRtQQoHRsUDDgTcIQBfxt4d1LeN2TTNIwzLwn5qdDP4Ug6ZIrLOTtmhrRvapiRP3hlf+
         zj8Q==
X-Gm-Message-State: AOAM5338+wd7M3Y1qgJv78noRq/u08SqPRGigdF6IxuETrSGEpI78LYX
        GLQogoKtabtoOzOrfbOrNcuW0A==
X-Google-Smtp-Source: ABdhPJw8qIH3SVIqTpbtrZweNKt8zINhfFh3upPPAKXhNelrIxnc3N98pRgun6QgKsN4b3kZoLA08w==
X-Received: by 2002:a63:541e:: with SMTP id i30mr14438592pgb.47.1597846625462;
        Wed, 19 Aug 2020 07:17:05 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id f43sm3285017pjg.35.2020.08.19.07.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 07:17:04 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Colin Cross <ccross@google.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michel Lespinasse <walken@google.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Song Liu <songliubraving@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        chenqiwu <chenqiwu@xiaomi.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Mike Christie <mchristi@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Adrian Reber <areber@redhat.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Cedeno <thomascedeno@google.com>,
        linux-fsdevel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v5 0/2] Anonymous VMA naming patches
Date:   Wed, 19 Aug 2020 19:46:48 +0530
Message-Id: <20200819141650.7462-1-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Last version v4 of these patches was sent by Colin Cross a long time ago [1]
and [2]. At the time, these patches were not merged, and it looks like they
just fell off the radar since.

In our efforts to run Android on mainline kernels, we realised that since past
some time, this patchset is needed for Android to boot, hence I am re-posting
it to try and get these discussed and hopefully merged.

I have rebased these for v5.9-rc1 and fixed minor updates as required.

[1]: https://lore.kernel.org/linux-mm/1383170047-21074-1-git-send-email-ccross@android.com/
[2]: https://lore.kernel.org/linux-mm/1383170047-21074-2-git-send-email-ccross@android.com/

Best,
Sumit.

Colin Cross (2):
  mm: rearrange madvise code to allow for reuse
  mm: add a field to store names for private anonymous memory

 Documentation/filesystems/proc.rst |   2 +
 fs/proc/task_mmu.c                 |  24 +-
 include/linux/mm.h                 |   5 +-
 include/linux/mm_types.h           |  23 +-
 include/uapi/linux/prctl.h         |   3 +
 kernel/sys.c                       |  32 +++
 mm/interval_tree.c                 |  34 +--
 mm/madvise.c                       | 356 +++++++++++++++++------------
 mm/mempolicy.c                     |   3 +-
 mm/mlock.c                         |   2 +-
 mm/mmap.c                          |  38 +--
 mm/mprotect.c                      |   2 +-
 12 files changed, 340 insertions(+), 184 deletions(-)

-- 
2.28.0

