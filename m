Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B90373397
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 03:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhEEBdG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 21:33:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230127AbhEEBdF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 21:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620178329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cPRVInBsTWC+0BUGJOB5FIDSOa450b+bMYREaXrrpp0=;
        b=OlYvEWSTM0YyKkoXTzEv61TTW5NH29xkBb25yX96IdN3aG9PrrU2hvknfbG6XXm+bQOf2c
        Ydgxw90FsbUxZw22G0if2eT97Ki9tbZA1X9pAGTsT7fMc7Ngv9HgTVQI2w+2QZPJ5qCsq5
        xwP45KTF153RAvYc5VGcsGm8xQ1bxQM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-ic8DAF_GM4q_wuVavJCw_w-1; Tue, 04 May 2021 21:32:08 -0400
X-MC-Unique: ic8DAF_GM4q_wuVavJCw_w-1
Received: by mail-io1-f70.google.com with SMTP id r2-20020a5e95020000b0290435b891bacbso172840ioj.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 May 2021 18:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cPRVInBsTWC+0BUGJOB5FIDSOa450b+bMYREaXrrpp0=;
        b=MRP2S0dceRbTYJanzHzqvkIWqA3PHCzFTqyiAhyCbuRpM9x+w9OrjKZKjIJvhXQicG
         MaZZEgPpIvIJElF9D9bsmdaOvYtTLEYUZFZwWMS+WIwSVTNYs+wjzYhvRjMrEEjv9q8Z
         hCHoOgiu9tIKF4sHkNV7tMi1oIffY9ftflWYsJF7Tw4CvGlr6yGAn2eBePiKbm4Y/IuD
         aJm71SbpydJcUY0qJogHhtEE0p190qWB5lQEYyoUH2Cl56CWJq9LWxeDXNLulSzdJf1A
         +lNMzJxcHGf9lomyZWkT1GD+xTNHU7uZc4qs9v3eEl99WtGJIvG1mcRkGHlm1ubUMD0V
         BaOQ==
X-Gm-Message-State: AOAM53008cOVlTSedmvnHX1twx/HN9fxvbBBCY3OU7TCboTbGFc2Z7xt
        bP+RqigCO50c2f56+nwfJjijMEG8bIMPgk2Asei3BunvRfIAwJcWewKXK4jbhhO6cfx6+bFzl1y
        2mMGOnWRqHHmWwWHdN3euaxNSSg==
X-Received: by 2002:a92:8e03:: with SMTP id c3mr2036554ild.167.1620178327564;
        Tue, 04 May 2021 18:32:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNg9jcG4O9OkPZqQlTS7aeMFQ7/soHNplo9cjmrJ2Ghe+p949bqg4pbzePUCrb/19N4cHmHg==
X-Received: by 2002:a92:8e03:: with SMTP id c3mr2036544ild.167.1620178327359;
        Tue, 04 May 2021 18:32:07 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id u9sm1842495ior.8.2021.05.04.18.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 18:32:06 -0700 (PDT)
Date:   Tue, 4 May 2021 21:32:04 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v6 06/10] userfaultfd/shmem: modify
 shmem_mfill_atomic_pte to use install_pte()
Message-ID: <YJH1lCx9IGqHG+yq@t490s>
References: <20210503180737.2487560-1-axelrasmussen@google.com>
 <20210503180737.2487560-7-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210503180737.2487560-7-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Axel,

On Mon, May 03, 2021 at 11:07:33AM -0700, Axel Rasmussen wrote:
> In a previous commit, we added the mfill_atomic_install_pte() helper.
> This helper does the job of setting up PTEs for an existing page, to map
> it into a given VMA. It deals with both the anon and shmem cases, as
> well as the shared and private cases.
> 
> In other words, shmem_mfill_atomic_pte() duplicates a case it already
> handles. So, expose it, and let shmem_mfill_atomic_pte() use it
> directly, to reduce code duplication.
> 
> This requires that we refactor shmem_mfill_atomic_pte() a bit:
> 
> Instead of doing accounting (shmem_recalc_inode() et al) part-way
> through the PTE setup, do it afterward. This frees up
> mfill_atomic_install_pte() from having to care about this accounting,
> and means we don't need to e.g. shmem_uncharge() in the error path.
> 
> A side effect is this switches shmem_mfill_atomic_pte() to use
> lru_cache_add_inactive_or_unevictable() instead of just lru_cache_add().
> This wrapper does some extra accounting in an exceptional case, if
> appropriate, so it's actually the more correct thing to use.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

(The moving of "ret = -ENOMEM" seems unnecessary, but not a big deal I think)

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

