Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908C7767866
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jul 2023 00:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjG1WOc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 18:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjG1WOb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 18:14:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181E5448A
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 15:14:30 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686f1240a22so2300113b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 15:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690582469; x=1691187269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j23ImFvrdRCadrPSwwknJnJ5y4yBBTyt7l0nVVVM2Yc=;
        b=ZtiNC4ej7OZeywn8wHEAqgDTQCL96l3JSg/+ffzCXaHNuNTx//E5tRxv+/5LyUCmzy
         wJU7VJ1iIxDjSGiYmpFU6nsZJLAX9pZspnX9lclWTUB+5LrMVyrOHTTcH7n9g0ri1s6/
         jxQOuM+oNZ2mdhzAwawrFQ9KDOH6pNdZsBMXiJbfKH2lCh7pATaIgYWj96/7at6d67Va
         mRmHHE1OyMNNCbopzrhaqGthSM5xveatfXj9L6soKQqTrUS+/DH4oq1w4/EnW2qpPV1M
         Jdy66HRsCu5/ykHeyesJo9rLKHxuC2ZI1slvAXgyW67g1fPexWbnVuxbXMH7GbD4QMwG
         mmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690582469; x=1691187269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j23ImFvrdRCadrPSwwknJnJ5y4yBBTyt7l0nVVVM2Yc=;
        b=ZZbTbT0izX0mtZExBmXu0iG+ybIbrymdGELO0cc/qc7gYfnVHsEEoPxH4vXImBhr8W
         OlAQR0DWEkDtx6Xm++1LKOKT3l1I18bVC3WPcTNexdzHRmK9bJB9suvOM+PXjbfeErVG
         LI7VK0phZOOfnMTw+/2bbaiXjVo0KybypJeiJ+/5nZkpxA+60g42u+FLo2sJSI6Pw5EP
         t14WZPnCh4ipbiURX4sen9K1y9G4xuYuoEfGlFFloKUH3fmi38uxYegOz2AaHqKSInqx
         RonnIBCmkFosCf7HojdSNZ7oCbMzFoaa3wDhOyRG++fbV+DY1hDFxhlJZvv5RQDSi3Dz
         Jk4A==
X-Gm-Message-State: ABy/qLY/JO84ovXWSe4Qq3vc+oaAAm4FYq9jFWGHqc7Y8wnTHeBwml+X
        ATsi/V+QB2F512PgelH3oule5g==
X-Google-Smtp-Source: APBJJlF0fafCFeexldp3nrIcTl/TKK4y9sr2ROkSLVlVpnM5bPmorNZnR4SuXn5KRsO7VBS9InuRKQ==
X-Received: by 2002:a17:902:988e:b0:1b2:1a79:147d with SMTP id s14-20020a170902988e00b001b21a79147dmr3058566plp.2.1690582469499;
        Fri, 28 Jul 2023 15:14:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id jl21-20020a170903135500b001b531e8a000sm4056368plb.157.2023.07.28.15.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 15:14:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qPVj8-001vv5-5d;
        Fri, 28 Jul 2023 19:14:26 -0300
Date:   Fri, 28 Jul 2023 19:14:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
Message-ID: <ZMQ9wuSa3Sp3sVvE@ziepe.ca>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <ZMQZfn/hUURmfqWN@x1n>
 <CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com>
 <e74b735e-56c8-8e62-976f-f448f7d4370c@redhat.com>
 <CAHk-=wgG1kfPR6vtA2W8DMFOSSVMOhKz1_w5bwUn4_QxyYHnTA@mail.gmail.com>
 <69a5f457-63b6-2d4f-e5c0-4b3de1e6c9f1@redhat.com>
 <ZMQxNzDcYTQRjWNh@x1n>
 <22262495-c92c-20fa-dddf-eee4ce635b12@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22262495-c92c-20fa-dddf-eee4ce635b12@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 28, 2023 at 11:31:49PM +0200, David Hildenbrand wrote:
> * vfio triggers FOLL_PIN|FOLL_LONGTERM from a random QEMU thread.
>   Where should we migrate that page to? Would it actually be counter-
>   productive to migrate it to the NUMA node of the setup thread? The
>   longterm pin will turn the page unmovable, yes, but where to migrate
>   it to?

For VFIO & KVM you actively don't get any kind of numa balancing or
awareness. In this case qemu should probably strive to put the memory
on the numa node of the majorty of CPUs early on because it doesn't
get another shot at it.

In other cases it depends quite alot. Eg DPDK might want its VFIO
buffers to NUMA'd to the node that is close to the device, not the
CPU. Or vice versa. There is alot of micro sensitivity here at high
data rates. I think people today manually tune this by deliberately
allocating the memory to specific numas and then GUP should just leave
it alone.

FWIW, I'm reading this thread and I have no idea what the special
semantic is KVM needs from GUP, so I'm all for better documentation on
the GUP flag :)

Jason
