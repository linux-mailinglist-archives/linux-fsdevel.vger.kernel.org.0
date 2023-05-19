Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212AC709C45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 18:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjESQVT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 12:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjESQVS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 12:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53104F4
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 09:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684513229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PhXJXT80hjlIVA8C9efdiNr9myekTSBO7D5CbfC3JCw=;
        b=IVXVk9u2A1sivGIu24gmKXniGfrefnhsKok5PlbFuo7BBSg3pMDuWR9f2e2Hyg6YdlO1ce
        jypmB/ct2SROQJNuidIh1eHbnZMT9XoS9RmTPUJjDPHXADqsW906jzsGV0JkIQ19hAnu2V
        LzvCjgGDk31Gu75AQOUs/3QpB33h1hk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-bg1qj79nN8mgsz7xRfgBwA-1; Fri, 19 May 2023 12:20:28 -0400
X-MC-Unique: bg1qj79nN8mgsz7xRfgBwA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7592c8fe630so8703385a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 09:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684513228; x=1687105228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhXJXT80hjlIVA8C9efdiNr9myekTSBO7D5CbfC3JCw=;
        b=NLMJgwvYLRUi7rLgNNA5fLFOpc6C1xHEE5RtU1woPSNfI5fGOCHOFa9INzto+wfbUQ
         SUlVPvhPYy7m6yUZmu2upiSg0TytfWPtcM/YqJ/Z8bxOp3gH9rX9+QiZOdN48g6Pl0eI
         hA91t/p8MkViyp9UerxCJvreGLVjV4E4LwMfdf0g+Y9wHVc/DIGrEOmA/jIuIBVLzDCa
         h/OuSF25Jm2gBYaBWQrJzPxRKoVQ76t62gLUX/ukXRxLDoSVFBcspQSGHbIB+uyQRrWo
         D4LyUBNUaFECne0zX7rha0dIxQ97AB9f3dS0+E5t1jlCbvG0cbRXPVKeDsoteif8PBw7
         vR2A==
X-Gm-Message-State: AC+VfDy6erb2nBATdh9Xe/8CjIg8cuQBXpQF7T/LGURpjY0k5GWMpBMf
        G6LxJyRAjxCRdj6wlvcsXno4jvGOPm/2nQ4MVylofWt7yYAM3uKkNpv7qbNS4TWh3X7rSk0r/K5
        YcO5bawrvN4BAc6ZwuLrA1CUmxw==
X-Received: by 2002:a05:6214:4009:b0:5ed:c96e:ca4a with SMTP id kd9-20020a056214400900b005edc96eca4amr5184439qvb.1.1684513227849;
        Fri, 19 May 2023 09:20:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6xd9iw24FUHoBv1Mr8oLJTlU6xLu6EjLFcB6cD+Gjyro3xcus5t+14yDAKr2/F83GAqVZi9A==
X-Received: by 2002:a05:6214:4009:b0:5ed:c96e:ca4a with SMTP id kd9-20020a056214400900b005edc96eca4amr5184405qvb.1.1684513227530;
        Fri, 19 May 2023 09:20:27 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id z24-20020a05620a101800b00751517fd46esm1211930qkj.26.2023.05.19.09.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 09:20:26 -0700 (PDT)
Date:   Fri, 19 May 2023 12:20:25 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huang Ying <ying.huang@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Anish Moorthy <amoorthy@google.com>
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
Message-ID: <ZGehyTCtAtTneiE8@x1n>
References: <20230511182426.1898675-1-axelrasmussen@google.com>
 <CADrL8HXFiTL-RDnETS2BUg_qH8CvcCMZiX-kutsrS1-8Uy25=w@mail.gmail.com>
 <ZGVRUeCWr8209m8d@x1n>
 <ZGVTMnVKNcQDM0x4@x1n>
 <CAJHvVcgXynHcuoS6eCfOAB2SgzqYy_zMGrRMR2kFuxOtSdUwvQ@mail.gmail.com>
 <CACw3F52MNOVv6KA5n7wRYDT2ujwYkco=aYngbo-zGA3zW1yq+w@mail.gmail.com>
 <ZGZMtK6PzoTuLZ1b@x1n>
 <CAJHvVcgcYPu-G3RDVrkrM_J48NUiUY0SH0G1sd+=X9BDgnQEuQ@mail.gmail.com>
 <32fdc2c8-b86b-92f3-1d5e-64db6be29126@redhat.com>
 <CACw3F50qvf13-fUx4XrL1jkhbo2mQ5sPV=E_i7_Gt2NaWXJfnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACw3F50qvf13-fUx4XrL1jkhbo2mQ5sPV=E_i7_Gt2NaWXJfnQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Jiaqi,

On Fri, May 19, 2023 at 08:04:09AM -0700, Jiaqi Yan wrote:
> I don't think CAP_ADMIN is something we can work around: a VMM must be
> a good citizen to avoid introducing any vulnerability to the host or
> guest.
> 
> On the other hand, "Userfaults allow the implementation of on-demand
> paging from userland and more generally they allow userland to take
> control of various memory page faults, something otherwise only the
> kernel code could do." [3]. I am not familiar with the UFFD internals,
> but our use case seems to match what UFFD wants to provide: without
> affecting the whole world, give a specific userspace (without
> CAP_ADMIN) the ability to handle page faults (indirectly emulate a
> HWPOISON page (in my mind I treat it as SetHWPOISON(page) +
> TestHWPOISON(page) operation in kernel's PF code)). So is it fair to
> say what Axel provided here is "provide !ADMIN somehow"?
> 
> [3]https://docs.kernel.org/admin-guide/mm/userfaultfd.html

Userfault keywords on "user", IMHO.  We don't strictly need userfault to
resolve anything regarding CAP_ADMIN problems.  MADV_DONTNEED also dosn't
need CAP_ADMIN, same to any new madvise() if we want to make it useful for
injecting poisoned ptes with !ADMIN and limit it within current->mm.

But I think you're right that userfaultfd always tried to avoid having
ADMIN and keep everything within its own scope of permissions.

So again, totally no objection on make it uffd specific for now if you guys
are all happy with it, but just to be clear that it's (to me) mostly for
avoiding another WAKE, and afaics that's not really for solving the ADMIN
issue here.

Thanks,

-- 
Peter Xu

