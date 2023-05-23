Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DD070E32C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 19:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbjEWR2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 13:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237923AbjEWR2H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 13:28:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87D01AD
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 10:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684862829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cImDjprrbyCagqgL7hx5cC+l1diu0Ysptat3mQQx7iI=;
        b=ALUHuU4tuOxCJfIJdheYXu73BxOkjGikFjHKh8HQYMwDCS9B0WiOLosdGPz8WwJQP+WqJO
        6s/y1NCqZxO/9pXISsIXBGHp/EGiGP63Cdl72nqn1hCkBoFsaTPAU58tmEcOMMIPpPvibg
        MNVzc6MKbtFcX+KjIQaQIuvZi52lQhg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-X53Ina4gO-CaJW1TCojS_Q-1; Tue, 23 May 2023 13:27:07 -0400
X-MC-Unique: X53Ina4gO-CaJW1TCojS_Q-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75b175cf0d1so2013385a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 10:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862827; x=1687454827;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cImDjprrbyCagqgL7hx5cC+l1diu0Ysptat3mQQx7iI=;
        b=LE5sTNsChdZ3KYgRjD77+9THUjVGOs13VxCS77N6cYw2rMJk50/fl4sMnlVmYOjSNJ
         t34im5wrSaPPNBoF0+fUpz51NqwA2wAU8NMSdwnLZ5W3hc/CxNU7dKALPWyJXyb+A/LS
         Em/8k7+fMj4nfCZY4fxjbVa2UtpYx1uu4eZDOoLGluSQPqtZgTn0FuOECO8UK8Dpq43p
         094oPEMA/GXK9ZS0qlnkxyPp6cU1xueK8zRHOhm459FonNg79UuHy+5ga63vmvwWuofw
         cjJQd9tLRxmuAzR6IDSTjT+spR4nb9GvU6Jp0WrzfLYTpftGpDPx7pI4dzoGtDQBUSE2
         ZfyQ==
X-Gm-Message-State: AC+VfDx6Kzifqefkju9DBRfAMDhcGqKJlOPpYfRRqvryMF7R2dc930R3
        Pja+9eiw0DsT4tl2FiNOzML1M/rDUngJjlg5EGDt8xQ7APoMppkZgz/jpeWVadalpXxa8m8tWpn
        rFVjkEh0rAvoFDZebY5lrnLSBCA==
X-Received: by 2002:a05:620a:2b0a:b0:75b:23a1:69ec with SMTP id do10-20020a05620a2b0a00b0075b23a169ecmr5378381qkb.3.1684862826880;
        Tue, 23 May 2023 10:27:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4M4RNfGC67mMFT70JEPLNT3I+5EAh4zo0m/jamb1QJmcX791dEziFSsudincKhZfjyQdFDIg==
X-Received: by 2002:a05:620a:2b0a:b0:75b:23a1:69ec with SMTP id do10-20020a05620a2b0a00b0075b23a169ecmr5378348qkb.3.1684862826591;
        Tue, 23 May 2023 10:27:06 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id fc10-20020ad44f2a000000b0062439f05b87sm2869456qvb.45.2023.05.23.10.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:27:05 -0700 (PDT)
Date:   Tue, 23 May 2023 13:27:04 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Jiaqi Yan <jiaqiyan@google.com>,
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
Message-ID: <ZGz3aNvcnP82b8L6@x1n>
References: <ZGVRUeCWr8209m8d@x1n>
 <ZGVTMnVKNcQDM0x4@x1n>
 <CAJHvVcgXynHcuoS6eCfOAB2SgzqYy_zMGrRMR2kFuxOtSdUwvQ@mail.gmail.com>
 <CACw3F52MNOVv6KA5n7wRYDT2ujwYkco=aYngbo-zGA3zW1yq+w@mail.gmail.com>
 <ZGZMtK6PzoTuLZ1b@x1n>
 <CAJHvVcgcYPu-G3RDVrkrM_J48NUiUY0SH0G1sd+=X9BDgnQEuQ@mail.gmail.com>
 <32fdc2c8-b86b-92f3-1d5e-64db6be29126@redhat.com>
 <CACw3F50qvf13-fUx4XrL1jkhbo2mQ5sPV=E_i7_Gt2NaWXJfnQ@mail.gmail.com>
 <ZGehyTCtAtTneiE8@x1n>
 <CAJHvVcgVcGigruVdCyOZ2gyrOMboHjuMBwyx9+9LFiv_xH2Q5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHvVcgVcGigruVdCyOZ2gyrOMboHjuMBwyx9+9LFiv_xH2Q5A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 10:32:13AM -0700, Axel Rasmussen wrote:
> On Fri, May 19, 2023 at 9:20 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > Hi, Jiaqi,
> >
> > On Fri, May 19, 2023 at 08:04:09AM -0700, Jiaqi Yan wrote:
> > > I don't think CAP_ADMIN is something we can work around: a VMM must be
> > > a good citizen to avoid introducing any vulnerability to the host or
> > > guest.
> > >
> > > On the other hand, "Userfaults allow the implementation of on-demand
> > > paging from userland and more generally they allow userland to take
> > > control of various memory page faults, something otherwise only the
> > > kernel code could do." [3]. I am not familiar with the UFFD internals,
> > > but our use case seems to match what UFFD wants to provide: without
> > > affecting the whole world, give a specific userspace (without
> > > CAP_ADMIN) the ability to handle page faults (indirectly emulate a
> > > HWPOISON page (in my mind I treat it as SetHWPOISON(page) +
> > > TestHWPOISON(page) operation in kernel's PF code)). So is it fair to
> > > say what Axel provided here is "provide !ADMIN somehow"?
> > >
> > > [3]https://docs.kernel.org/admin-guide/mm/userfaultfd.html
> >
> > Userfault keywords on "user", IMHO.  We don't strictly need userfault to
> > resolve anything regarding CAP_ADMIN problems.  MADV_DONTNEED also dosn't
> > need CAP_ADMIN, same to any new madvise() if we want to make it useful for
> > injecting poisoned ptes with !ADMIN and limit it within current->mm.
> >
> > But I think you're right that userfaultfd always tried to avoid having
> > ADMIN and keep everything within its own scope of permissions.
> >
> > So again, totally no objection on make it uffd specific for now if you guys
> > are all happy with it, but just to be clear that it's (to me) mostly for
> > avoiding another WAKE, and afaics that's not really for solving the ADMIN
> > issue here.
> 
> How about this plan:
> 
> Since the concrete use case we have (postcopy live migration) is
> UFFD-specific, let's leave it as a UFFDIO_* operation for now.
> 
> If in the future we come up with a non-UFFD use case, we can add a new
> MADV_* which does this operation at that point. From my perspective
> they could even share most of the same implementation code.
> 
> I don't think it's a big problem keeping the UFFDIO_* version too at
> that point, because it still provides some (perhaps small) value:
> 
> - Combines the operation + waking into one syscall
> - It allows us to support additional UFFD flags which modify / extend
> the operation in UFFD-specific ways, if we want to add those in the
> future
> 
> Seem reasonable?

Ok here.

> 
> If so, I'll send a v2 with documentation updates.

I've reviewed v1 in this case, please have a look, thanks.

-- 
Peter Xu

