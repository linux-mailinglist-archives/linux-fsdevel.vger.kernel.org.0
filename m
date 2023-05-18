Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE44708ABF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 23:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjERVv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 17:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjERVv4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 17:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86B010DD
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 14:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684446661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3PTxJzjUCnDeLKGxq08Q4RltGGG7TNyuXuOM81PDsCQ=;
        b=ehJ6/tQpER+6utwgWlzS7qx0XKYsMLHum2jfb6OCoi2KcVdz08yS0GXVhN1uFElpFf27gY
        FXDuJovjQrSjK+oo41jcyuwcFEu9isSFOiJ+qEnV8KHEqbkw9eYtb9WY4UoIVKq/H+MI93
        NpnsoDkFT893j4dWAvbYeUYV6LczMDA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-UkfEhRqQOUyEz35PLb-uAQ-1; Thu, 18 May 2023 17:51:00 -0400
X-MC-Unique: UkfEhRqQOUyEz35PLb-uAQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-621189941cdso3246566d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 14:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684446660; x=1687038660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PTxJzjUCnDeLKGxq08Q4RltGGG7TNyuXuOM81PDsCQ=;
        b=SXqbfnB/dsPCn43D1jQdqeG88Ldl2r6gINhduPox3NlqfsS2+0PKXTCAfm45O54u2w
         9JMMJYE49Iy8QP1np+4SyOO23HlkjBaekYZzJFIHsPQX9av94sd7bsfAUnWU674tHAeL
         kN9UQDY0pV4BdC75RzD0vOoRvDRcKi36mGN3duC6ayop1eRbR1vepV8kU+THwPQUJ1Aj
         01mODToFYrA4vsqbaQI3zbL4CtNPN8MoWENq2hnGeB2fpaZBogOXL9xTKgng229IevMP
         UTIZilZn8d1PxWa7rhcy5wtpa2BPGwRy6ZhceTV+GyBdzw8e/WK53vVyRFHarWIczqYT
         ugzA==
X-Gm-Message-State: AC+VfDxT2R0TLQRE07k59M510zS9mpKcPdxFfIhANZsCm/biVyHYsEV3
        OMFD7WZbBBuFk0GSNVq4TEZyZTQynnjoCNaDpr70W+ieHxsmnrzVdl0NvMznlBCoSOUuB1dopvu
        aCwIeGaoMEWbQEAUoHI3EXciw5Mbkc2y+5Q==
X-Received: by 2002:a05:6214:519a:b0:621:7d4:e05b with SMTP id kl26-20020a056214519a00b0062107d4e05bmr1024262qvb.0.1684446659896;
        Thu, 18 May 2023 14:50:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6hwLLJfjckQ3qXnTQ5Jvs59iaTcg3CL+DRiXVyjoA2RxvwVhuDUKynLqHROugZ/mgJauTrRA==
X-Received: by 2002:a05:6214:519a:b0:621:7d4:e05b with SMTP id kl26-20020a056214519a00b0062107d4e05bmr1024242qvb.0.1684446659694;
        Thu, 18 May 2023 14:50:59 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id c30-20020a0ca9de000000b0061f7cf8207asm818958qvb.133.2023.05.18.14.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 14:50:58 -0700 (PDT)
Date:   Thu, 18 May 2023 17:50:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Jiaqi Yan <jiaqiyan@google.com>,
        James Houghton <jthoughton@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
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
Message-ID: <ZGadwEDlsvIxnsvq@x1n>
References: <20230511182426.1898675-1-axelrasmussen@google.com>
 <CADrL8HXFiTL-RDnETS2BUg_qH8CvcCMZiX-kutsrS1-8Uy25=w@mail.gmail.com>
 <ZGVRUeCWr8209m8d@x1n>
 <ZGVTMnVKNcQDM0x4@x1n>
 <CAJHvVcgXynHcuoS6eCfOAB2SgzqYy_zMGrRMR2kFuxOtSdUwvQ@mail.gmail.com>
 <CACw3F52MNOVv6KA5n7wRYDT2ujwYkco=aYngbo-zGA3zW1yq+w@mail.gmail.com>
 <ZGZMtK6PzoTuLZ1b@x1n>
 <CAJHvVcgcYPu-G3RDVrkrM_J48NUiUY0SH0G1sd+=X9BDgnQEuQ@mail.gmail.com>
 <ZGaaxjS4jWUio+f6@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZGaaxjS4jWUio+f6@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 05:38:14PM -0400, Peter Xu wrote:
> If with uffd, perhaps avoid calling it sigbus? As we have FEATURE_SIGBUS
> and I'm afraid it'll cause confusion.  UFFDIO_HWPOISON may sound more
> suitable?

Or UFFDIO_POISON (to identify it from real hw poisons)..

-- 
Peter Xu

