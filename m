Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEE476778D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 23:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbjG1VWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 17:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjG1VWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:22:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55042723
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 14:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690579270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ac7QCjU27us9pWCzIU7wIhVCfe0T3FQhf/CkOGsKAAQ=;
        b=LYhSe/6OtEFll5aplWdy4d8CrHxzCAQ8zW2bCaN7e3SauRBnQ7L5ETkDUEGg1tBAJy8OGM
        Rde9tAHap2nU/doxLLjyPZAyxbineQooQNttMMSc6jJ9r5SeJJuTA3NXk385ozQ50OOLZc
        FxcsIDYdl9O6/fRL2IzmAzWvflSvksI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-HNwaPd5pPxCr8EpKxnRZGg-1; Fri, 28 Jul 2023 17:21:08 -0400
X-MC-Unique: HNwaPd5pPxCr8EpKxnRZGg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-637948b24bdso5467126d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 14:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690579268; x=1691184068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ac7QCjU27us9pWCzIU7wIhVCfe0T3FQhf/CkOGsKAAQ=;
        b=ZV9AXGUqFZd04FsbH3y1R3gvX2vdfyPTZWvpnj0p6wY2iDjthiAop0pHGP5S5GgvLO
         mDY5xtyLMKmx4Ek+n9jIJFcE2SMncn9WTEEcB2owATBV8HsLTG0ovVegvZxW8SQs8g/O
         qxoLWb2d1qc0lEE0w7noLkj2+OICY5td+hFL1nseuEiTuZ1+wS06h6mAT/UD7GNMHz6B
         8sG3jlblsDsz0SocTeCll6eSZpB6CE07Z40M+povoGfxRUDS84xTyDNOf7NdK34qndyX
         D2IiyrLxeOxTuVYetO6/ERBBn7iQtMS4vUSSLt12ZWak5gWBPjOBsjF030WWpRpat+Fi
         S0RA==
X-Gm-Message-State: ABy/qLYr9LcNBJ/76fFWbGdKfxV0ig4nJMHziARNj5Weq/teO0xbtq5/
        E8nsgGJpngtXtboywrXwIRC2A9MlKdcvcnloNOF4dbGNn54kT+eDqfxj6r0ua3jlxK/HHkI43gW
        13XRoNIOY8Nkt33vw1d0MAdHT4w==
X-Received: by 2002:a05:6214:5190:b0:635:fa38:5216 with SMTP id kl16-20020a056214519000b00635fa385216mr571664qvb.0.1690579268033;
        Fri, 28 Jul 2023 14:21:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG+YMOCBtzBXkVZi5qKTKhmwdfdvIXgbKwZ5wE8cXxoJVGwXu7gH3KYSZRnh2FZGnuM3gaciQ==
X-Received: by 2002:a05:6214:5190:b0:635:fa38:5216 with SMTP id kl16-20020a056214519000b00635fa385216mr571651qvb.0.1690579267641;
        Fri, 28 Jul 2023 14:21:07 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id h13-20020a0cab0d000000b00635eeb8a4fcsm1538086qvb.114.2023.07.28.14.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 14:21:07 -0700 (PDT)
Date:   Fri, 28 Jul 2023 17:20:55 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
Message-ID: <ZMQxNzDcYTQRjWNh@x1n>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <ZMQZfn/hUURmfqWN@x1n>
 <CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com>
 <e74b735e-56c8-8e62-976f-f448f7d4370c@redhat.com>
 <CAHk-=wgG1kfPR6vtA2W8DMFOSSVMOhKz1_w5bwUn4_QxyYHnTA@mail.gmail.com>
 <69a5f457-63b6-2d4f-e5c0-4b3de1e6c9f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69a5f457-63b6-2d4f-e5c0-4b3de1e6c9f1@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 28, 2023 at 11:02:46PM +0200, David Hildenbrand wrote:
> Can we get a simple revert in first (without that FOLL_FORCE special casing
> and ideally with a better name) to handle stable backports, and I'll
> follow-up with more documentation and letting GUP callers pass in that flag
> instead?
> 
> That would help a lot. Then we also have more time to let that "move it to
> GUP callers" mature a bit in -next, to see if we find any surprises?

As I raised my concern over the other thread, I still worry numa users can
be affected by this change. After all, numa isn't so uncommon to me, at
least fedora / rhel as CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y. I highly
suspect that's also true to major distros.  Meanwhile all kernel modules
use gup..

I'd say we can go ahead and try if we want, but I really don't know why
that helps in any form to move it to the callers.. with the risk of
breaking someone.

Logically it should also be always better to migrate earlier than later,
not only because the page will be local earlier, but also per I discussed
also in the other thread (that the gup can hold a ref to the page, and it
could potentially stop numa balancing to succeed later).

Thanks,

-- 
Peter Xu

