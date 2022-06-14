Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF2A54BA99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 21:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiFNTgq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 15:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiFNTgp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A139219F8D
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 12:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655235403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ox4dj78XDeONpCY/I2byHRWGGL1bbVgG7Ngg4aNtSc=;
        b=ImviVn7b+BH6uuWLzXxeNnfKPLpYbDtcKLjEsJouyM++5Yx7AyMhRqmQ0OkKy1P3bSOlyk
        LJA+AdsPCMRyQqc5J1YPoLMpYbhH2J2bKwL0K7fnxu4ks0PlYaVmmGy8WtCNkne4FiGRxG
        0G1QkwBZZhoHclf52ujfc6XQXK8+JfY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-Zg5XWhxYNzW40CHDTP9uZQ-1; Tue, 14 Jun 2022 15:36:41 -0400
X-MC-Unique: Zg5XWhxYNzW40CHDTP9uZQ-1
Received: by mail-io1-f72.google.com with SMTP id w16-20020a5d8450000000b00669877b9ce2so4809235ior.20
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 12:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ox4dj78XDeONpCY/I2byHRWGGL1bbVgG7Ngg4aNtSc=;
        b=00aCknxZvJm3EDGpysl1kT/cPFAzDsDiFrfSEkb7x0ULryI4C48mamQqxpvQotoiWd
         eOr5/3aub1jR7UPHqHQ3Ud0FgutUSDIHlLADCDvJmmyH0BbPPQmUOKcPibcI4gCGpj4L
         qRr9Dr1hRvM4GjhXQfkgHHESoMVwJbrfPq7wqcxD+KDIyTvcM7ciwr+kW7eTjjbRyjD1
         I9vpi0EuZbCEfuWFOQk8ItWaO7OoAuJsf++FnLOLtxevlzOOT9rSbq8cO2+BcnzNFxQG
         u/W64Rqz+2FZr7Q1r8Zfbqm095F34z/Gp7Db3HLLUrnzBCC85Ote8z5s+9F/qb052Ry9
         uS4Q==
X-Gm-Message-State: AOAM5310i71CagazTP4pBfG0WGTXMCh7zmnWW3EJMlO69+eGuLGiF5bY
        3IIvAqAzQ0uFxHcse54VLL3/Az57mj4TCE7gYK7xh0GHgwbdQQ9i4adEW2KuluzPum0M2WXlnvE
        emmjGSNuSk5V238hHIebUOTHnfA==
X-Received: by 2002:a05:6638:2722:b0:331:f878:e38b with SMTP id m34-20020a056638272200b00331f878e38bmr3844030jav.272.1655235400377;
        Tue, 14 Jun 2022 12:36:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy46UsOGrOa9qzN3/0xyOD3Pu8920BAJfUTIRIZ+b23+ZLnb0uaumApmJV1QyQxC2J6j9msQQ==
X-Received: by 2002:a05:6638:2722:b0:331:f878:e38b with SMTP id m34-20020a056638272200b00331f878e38bmr3844002jav.272.1655235400064;
        Tue, 14 Jun 2022 12:36:40 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id r2-20020a6bd902000000b00669c107e289sm5783020ioc.29.2022.06.14.12.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:36:39 -0700 (PDT)
Date:   Tue, 14 Jun 2022 15:36:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 4/6] userfaultfd: update documentation to describe
 /dev/userfaultfd
Message-ID: <YqjjRKcnrmMGuw5n@xz-m1.local>
References: <20220601210951.3916598-1-axelrasmussen@google.com>
 <20220601210951.3916598-5-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220601210951.3916598-5-axelrasmussen@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 01, 2022 at 02:09:49PM -0700, Axel Rasmussen wrote:
> Explain the different ways to create a new userfaultfd, and how access
> control works for each way.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  Documentation/admin-guide/mm/userfaultfd.rst | 40 ++++++++++++++++++--
>  Documentation/admin-guide/sysctl/vm.rst      |  3 ++
>  2 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
> index 6528036093e1..9bae1acd431f 100644
> --- a/Documentation/admin-guide/mm/userfaultfd.rst
> +++ b/Documentation/admin-guide/mm/userfaultfd.rst
> @@ -17,7 +17,10 @@ of the ``PROT_NONE+SIGSEGV`` trick.
>  Design
>  ======
>  
> -Userfaults are delivered and resolved through the ``userfaultfd`` syscall.
> +Userspace creates a new userfaultfd, initializes it, and registers one or more
> +regions of virtual memory with it. Then, any page faults which occur within the
> +region(s) result in a message being delivered to the userfaultfd, notifying
> +userspace of the fault.
>  
>  The ``userfaultfd`` (aside from registering and unregistering virtual
>  memory ranges) provides two primary functionalities:
> @@ -34,12 +37,11 @@ The real advantage of userfaults if compared to regular virtual memory
>  management of mremap/mprotect is that the userfaults in all their
>  operations never involve heavyweight structures like vmas (in fact the
>  ``userfaultfd`` runtime load never takes the mmap_lock for writing).
> -
>  Vmas are not suitable for page- (or hugepage) granular fault tracking
>  when dealing with virtual address spaces that could span
>  Terabytes. Too many vmas would be needed for that.
>  
> -The ``userfaultfd`` once opened by invoking the syscall, can also be
> +The ``userfaultfd``, once created, can also be
>  passed using unix domain sockets to a manager process, so the same
>  manager process could handle the userfaults of a multitude of
>  different processes without them being aware about what is going on
> @@ -50,6 +52,38 @@ is a corner case that would currently return ``-EBUSY``).
>  API
>  ===
>  
> +Creating a userfaultfd
> +----------------------
> +
> +There are two ways to create a new userfaultfd, each of which provide ways to
> +restrict access to this functionality (since historically userfaultfds which
> +handle kernel page faults have been a useful tool for exploiting the kernel).
> +
> +The first way, supported by older kernels, is the userfaultfd(2) syscall.

How about "supported since userfaultfd was introduced"?  Otherwise the
reader can get a feeling that the syscall won't work on new kernels but
it will.

> +Access to this is controlled in several ways:
> +
> +- By default, the userfaultfd will be able to handle kernel page faults. This

s/kernel/both user and kernel/?

> +  can be disabled by passing in UFFD_USER_MODE_ONLY.
> +
> +- If vm.unprivileged_userfaultfd is 0, then the caller must *either* have
> +  CAP_SYS_PTRACE, or pass in UFFD_USER_MODE_ONLY.
> +
> +- If vm.unprivileged_userfaultfd is 1, then no particular privilege is needed to
> +  use this syscall, even if UFFD_USER_MODE_ONLY is *not* set.

The separation of above three paragraphs do not feel very clear to me to
understand these flags.. Entry 1) was trying to define UFFD_USER_MODE_ONLY,
but entry 2) was also referring to it in another context.

How about using two paragraphs to explain these two flags one by one?  My
try..

  The user can always creates an userfaultfd that only traps userspace page
  faults only.  To achieve it, one can create the userfaultfd object using
  the syscall userfaultfd() with flag UFFD_USER_MODE_ONLY passed in.

  If the user would like to also trap kernel page faults for the address
  space, then either the process needs to have CAP_SYS_PTRACE capability,
  or the system must have vm.unprivileged_userfaultfd set to 1.  By
  default, vm.unprivileged_userfaultfd is set to 0.

> +
> +The second way, added to the kernel more recently, is by opening and issuing a
> +USERFAULTFD_IOC_NEW ioctl to /dev/userfaultfd. This method yields equivalent
> +userfaultfds to the userfaultfd(2) syscall; its benefit is in how access to
> +creating userfaultfds is controlled.

Since the benefit is immediately mentioned next, how about dropping "its
benefit is in how ... is controlled" and just connect these two paragraphs?

Again, please take it with a grain of salt on my English-related comments
(it means all comment above :).

Thanks,

> +
> +Access to /dev/userfaultfd is controlled via normal filesystem permissions
> +(user/group/mode for example), which gives fine grained access to userfaultfd
> +specifically, without also granting other unrelated privileges at the same time
> +(as e.g. granting CAP_SYS_PTRACE would do).
> +
> +Initializing up a userfaultfd
> +-----------------------------
> +
>  When first opened the ``userfaultfd`` must be enabled invoking the
>  ``UFFDIO_API`` ioctl specifying a ``uffdio_api.api`` value set to ``UFFD_API`` (or
>  a later API version) which will specify the ``read/POLLIN`` protocol
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index d7374a1e8ac9..e3a952d1fd35 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -927,6 +927,9 @@ calls without any restrictions.
>  
>  The default value is 0.
>  
> +An alternative to this sysctl / the userfaultfd(2) syscall is to create
> +userfaultfds via /dev/userfaultfd. See
> +Documentation/admin-guide/mm/userfaultfd.rst.
>  
>  user_reserve_kbytes
>  ===================
> -- 
> 2.36.1.255.ge46751e96f-goog
> 

-- 
Peter Xu

