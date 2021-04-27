Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6E336BD42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 04:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbhD0CYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 22:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbhD0CYp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 22:24:45 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335B6C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 19:24:02 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id d19so22959656qkk.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 19:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=aBj4f1ka2nJ/gpsa6TStMHZaqIrVKG/e6xHVPE7SPEE=;
        b=E+NwonMupVGezKMvjZ7hJwuZQ7V76KMT7a8ypVkX65/bszqV5hRAaSxib3pmK+eJfD
         tllgqMWe4sbOvxMl7aM71A2JNBTaV6C4u83GRHWJqFYRE+VJcoLkL7QAEEBwq7WiVHci
         mu8D0PyYgzY4sbwCSW2vC8nYPq0r6pbav55Ns7BukgH1UbnMxFMMxgilLzeSqlIlSofA
         3UlLDdRyR+qwsj8qMAj7iuK0XWKe4Kx+CdfPJfaJCYsTqCzkbIHOIzVefh0TzQ5jTOs1
         AwC2bB4Nfm5aVbPV4Fja3J0XyP69U0AMxou0bN2hbN9ScZn/sFvBlmLvq/CUoguRbXC8
         Mh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=aBj4f1ka2nJ/gpsa6TStMHZaqIrVKG/e6xHVPE7SPEE=;
        b=iAEpSew9qwrFHfYU3Rhuoy4Mqc8yGv1woUZePyk7ob2TMIUsVKE2xkiy/Jdb7SK3BI
         SgrlqXtx2+pVht6RmHlmyozhClEwNeXYy1DLCv0xZm8vTZ9Opj8bAb+jqvzPKpe5dkIP
         wjf5mKH1IsdNqFi9eNHt2sf2QFQ4FY+3s3qklagOSDowxOuksF6WUGCk2+CmEMmxQHVA
         iN8L2mpxqZYWJsPVZPsa0IgisM8AvZWPHX2CiFNg+Y3zZ3nqgOZxuqZ4EnbhHNKe6NH9
         Gs6MRevbeY0NhXKhTsQWP1M+CfxT4K9ft2b9uhgGbuWy1hBKYKpgM3yejx0cRxn7irWH
         T4Rg==
X-Gm-Message-State: AOAM533b+cCTeRhstVy4pq1zTdV+mih/DZupCt/kqf7aIpETX92Fwxs3
        dqSG+7e1rswzSRnn3Vszw0YxOg==
X-Google-Smtp-Source: ABdhPJwLO4HFCK9suHur0GwSkoyOuSg6kDjsLGyUYf2tfkko0tHuU3kIyVhh7klL0KlXz4P9U6ePlg==
X-Received: by 2002:a37:5b84:: with SMTP id p126mr21326713qkb.142.1619490241227;
        Mon, 26 Apr 2021 19:24:01 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i2sm13728602qtg.0.2021.04.26.19.23.58
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 26 Apr 2021 19:24:00 -0700 (PDT)
Date:   Mon, 26 Apr 2021 19:23:57 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 04/10] userfaultfd/shmem: support minor fault registration
 for shmem
In-Reply-To: <20210420220804.486803-5-axelrasmussen@google.com>
Message-ID: <alpine.LSU.2.11.2104261920110.2998@eggly.anvils>
References: <20210420220804.486803-1-axelrasmussen@google.com> <20210420220804.486803-5-axelrasmussen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 20 Apr 2021, Axel Rasmussen wrote:

> This patch allows shmem-backed VMAs to be registered for minor faults.
> Minor faults are appropriately relayed to userspace in the fault path,
> for VMAs with the relevant flag.
> 
> This commit doesn't hook up the UFFDIO_CONTINUE ioctl for shmem-backed
> minor faults, though, so userspace doesn't yet have a way to resolve
> such faults.
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

And if this "04/10" had been numbered 03/10, I would have said
Acked-by: Hugh Dickins <hughd@google.com>

Just read the comment above: "so userspace doesn't yet have a way to
resolve such faults" - if it doesn't by this stage, we're in trouble.

> ---
>  fs/userfaultfd.c                 |  6 +++---
>  include/uapi/linux/userfaultfd.h |  7 ++++++-
>  mm/memory.c                      |  8 +++++---
>  mm/shmem.c                       | 12 +++++++++++-
>  4 files changed, 25 insertions(+), 8 deletions(-)
