Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1786C35E778
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 22:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbhDMUQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 16:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232526AbhDMUQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618344942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z6jLMxHXDVRiXYyQcd5eAsrnA6ok/2H8Sdo63BFQ8u4=;
        b=Yzh3MhxzIK7sxOFXUbX5mlF3h6M8Q7haam0d50DM5YGOrJPGWtscD+3/VwGKiH4ZIl0zJs
        VDoFbZULK86eTgqpVx1NMbHSCh6eZjNTdPuo98dmZMCiGWjtQhKnQXxOMGYSXKQGZ7NaYo
        384/LqvbixdLwqksGVPaebeQZ5Um0oo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-eoYW9QQPMh2QL7kGaanW1w-1; Tue, 13 Apr 2021 16:15:38 -0400
X-MC-Unique: eoYW9QQPMh2QL7kGaanW1w-1
Received: by mail-qt1-f197.google.com with SMTP id i9-20020ac85e490000b02901b186fa5716so446990qtx.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Apr 2021 13:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z6jLMxHXDVRiXYyQcd5eAsrnA6ok/2H8Sdo63BFQ8u4=;
        b=rqLf2oXrVvudP21S15ur4uTybFTU/lzC1ydhsikh0DYbNzyOEyWQ04hpBgFqP46sbx
         UaW1ULJIrld1uwrMVKIpt84RriBuc7HlyZjSvpRszILKXePZEaggWSp5GH3wc6bSSz9V
         cYcK1JCT7W2zVS27oVWP5u51+7uQCnLaIOcMzLLMpXdgJtoWaMud9sVxxXIgg2phcfgl
         nMr5p4HgscRBsYcloid+Gnw2A6n0jdxwpKhgSKJ0ipV2dMK8yamuWgIoL1UCaIzDPOHv
         IUpRwZm1gAb3Qclh6FHpHZysGutsRXdbI0BxNauhNd+0xLojRpUvSIRzTxKL3DKiXUVN
         f30A==
X-Gm-Message-State: AOAM533fOMDBS6MRt9ZbcxE4B1tVi74LlAQQ3wGd5zRYp4cbDjZz/E+9
        ooQLzQaoZyVa+/Ix7v5RLG4FykQQyzAAiX9VC7AaWZ1xAk10rPEqPOyUyvEX/iGI/G9e9jI2rVg
        ksNmjI3YDtj+DOdYetv41Dd9EgQ==
X-Received: by 2002:ae9:f503:: with SMTP id o3mr32222744qkg.331.1618344938277;
        Tue, 13 Apr 2021 13:15:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzk0HNq0oDNyEr5ELMzeUTmw4uMriVRz0Eo5dEdf+xlarAnuXBL2LazN2KzuwaIREXFINZXmw==
X-Received: by 2002:ae9:f503:: with SMTP id o3mr32222721qkg.331.1618344937981;
        Tue, 13 Apr 2021 13:15:37 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id l16sm11024953qkg.91.2021.04.13.13.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 13:15:37 -0700 (PDT)
Date:   Tue, 13 Apr 2021 16:15:35 -0400
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
Subject: Re: [PATCH v2 7/9] userfaultfd/selftests: reinitialize test context
 in each test
Message-ID: <20210413201535.GD4440@xz-x1>
References: <20210413051721.2896915-1-axelrasmussen@google.com>
 <20210413051721.2896915-8-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210413051721.2896915-8-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:17:19PM -0700, Axel Rasmussen wrote:
> Currently, the context (fds, mmap-ed areas, etc.) are global. Each test
> mutates this state in some way, in some cases really "clobbering it"
> (e.g., the events test mremap-ing area_dst over the top of area_src, or
> the minor faults tests overwriting the count_verify values in the test
> areas). We run the tests in a particular order, each test is careful to
> make the right assumptions about its starting state, etc.
> 
> But, this is fragile. It's better for a test's success or failure to not
> depend on what some other prior test case did to the global state.
> 
> To that end, clear and reinitialize the test context at the start of
> each test case, so whatever prior test cases did doesn't affect future
> tests.
> 
> This is particularly relevant to this series because the events test's
> mremap of area_dst screws up assumptions the minor fault test was
> relying on. This wasn't a problem for hugetlb, as we don't mremap in
> that case.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 221 +++++++++++++----------
>  1 file changed, 127 insertions(+), 94 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 1f65c4ab7994..0ff01f437a39 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -89,7 +89,8 @@ static int shm_fd;
>  static int huge_fd;
>  static char *huge_fd_off0;
>  static unsigned long long *count_verify;
> -static int uffd, uffd_flags, finished, *pipefd;
> +static int uffd = -1;
> +static int uffd_flags, finished, *pipefd;
>  static char *area_src, *area_src_alias, *area_dst, *area_dst_alias;
>  static char *zeropage;
>  pthread_attr_t attr;
> @@ -342,6 +343,121 @@ static struct uffd_test_ops hugetlb_uffd_test_ops = {
>  
>  static struct uffd_test_ops *uffd_test_ops;
>  
> +static int userfaultfd_open(uint64_t *features)
> +{
> +	struct uffdio_api uffdio_api;
> +
> +	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);

Keep UFFD_USER_MODE_ONLY?

[...]

> @@ -961,10 +1045,9 @@ static int userfaultfd_zeropage_test(void)
>  	printf("testing UFFDIO_ZEROPAGE: ");
>  	fflush(stdout);
>  
> -	uffd_test_ops->release_pages(area_dst);
> -
> -	if (userfaultfd_open(0))
> +	if (uffd_test_ctx_clear() || uffd_test_ctx_init(0))
>  		return 1;

Would it look even nicer to init() at the entry of each test, and clear() after
finish one test?

> +
>  	uffdio_register.range.start = (unsigned long) area_dst;
>  	uffdio_register.range.len = nr_pages * page_size;
>  	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;

The rest looks good to me.  Thanks,

-- 
Peter Xu

