Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D44F70F9BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 17:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbjEXPGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 11:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjEXPGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 11:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D590E9
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684940749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C1IKq4W7kXMUcZYad8O4aYshE6tNJx+8XRtusGP3BwA=;
        b=BAyw3H2/ocVKgwVIV7n89FUoU3gfpbEEoPObPGMI4HmsNQiQItDhdp1tfiDhTQZ6YV+0n1
        AOobINnCEBkQ1HgbIoriv4Jmi+2ReFQxYNGcEHwhEZJxIgRvwIp6ZqZapX7VUwvdGcbsCz
        GFS9AH9hrzDyO9/qByEhpf+SEX/CDb8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-p1LhHvFDOE6RDOIifwE3kQ-1; Wed, 24 May 2023 11:05:48 -0400
X-MC-Unique: p1LhHvFDOE6RDOIifwE3kQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-623b86d929dso1403906d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 08:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684940746; x=1687532746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1IKq4W7kXMUcZYad8O4aYshE6tNJx+8XRtusGP3BwA=;
        b=ZT0VmzoeDCHQITh54F4QpafKnwOtFJ7QtuFfbx4emwU1UT3abSFxAlu6cy+dx52nvc
         qxMJoEmF+QnDYAkipigtLkd0S7Uo3125xNp0eu0Pg0cttwVP6NaU0ZtPh+1ZCAn6Q1zi
         ctkXuDrKjv0Eb/hY9BPb7KxZqHtDlDDabspjYuumzJKu1Csbw0OtWg6eLr6nLa4JD9kH
         PBgQeCSYb1xAaT0Rbz7NpP0ZsjVBSN8NAdxu96Zqcxb+L+NdUK7ptGEAMhWq4c9oA79c
         c3yANEN3wa1clpSDarJTu8f1uCOGrl/2bEncyUDyhUQ2J+TXsreC19uU5DoBAkgKLPQS
         9Z+Q==
X-Gm-Message-State: AC+VfDy8RNSSAfIM9oR//CO2hwwGAfdR0pXNLrSgGRj31YKoJFPoSi8T
        Z4k5ThpYlRLkmQMKv+xSIn7kR+QY42ZCpNGGrdo4wFSZ6rW24JRizAhCPOdGXfwYWXdS5veyDiE
        3SEs4FGLS+EoJeqeXr/1PzIBdYw==
X-Received: by 2002:ad4:5961:0:b0:625:aa49:a48b with SMTP id eq1-20020ad45961000000b00625aa49a48bmr2106793qvb.6.1684940746120;
        Wed, 24 May 2023 08:05:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5u2JsTk1mmNXoqf84VPpm8+rDS0A+qmShWJLS/640lXVGHgY6BmYlqoYyLv6ghI1O3C3OnlA==
X-Received: by 2002:ad4:5961:0:b0:625:aa49:a48b with SMTP id eq1-20020ad45961000000b00625aa49a48bmr2106736qvb.6.1684940745557;
        Wed, 24 May 2023 08:05:45 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id v10-20020a0cf90a000000b0062136626e09sm3625337qvn.57.2023.05.24.08.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:05:44 -0700 (PDT)
Date:   Wed, 24 May 2023 11:05:43 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huang Ying <ying.huang@intel.com>,
        James Houghton <jthoughton@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
Message-ID: <ZG4nxwdbWzhtR4pP@x1n>
References: <20230511182426.1898675-1-axelrasmussen@google.com>
 <ZGz3LeRyghnv4wwZ@x1n>
 <CAJHvVcjh6hOrZyr1t92v07+PVNVJH-BnPDs+ZSUWsLVjpLEuHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcjh6hOrZyr1t92v07+PVNVJH-BnPDs+ZSUWsLVjpLEuHA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 10:59:05AM -0700, Axel Rasmussen wrote:
> > Actually.. I think maybe we should have 1 patch changing SWAPIN_ERROR from
> > VM_FAULT_SIGBUS to VM_FAULT_HWPOISON.
> >
> > Let's imagine a VM having anonymous page backing and got a swapin error
> > when faulted on one of the guest page.  Instead of crashing the hypervisor
> > with sigbus we should probably make it a MCE injected into the guest too,
> > because there's no page corrupt in bare metal in this specific case,
> > however to the guest it's the same as having one page corrupted just like a
> > real MCE.
> 
> This is a great idea, you're right that injecting an MCE into the
> guest is exactly the end goal, and it seems like VM_FAULT_HWPOISON
> will "just work". Also the name UFFDIO_POISON resolves any confusion
> with UFFD_FEATURE_SIGBUS, so that's a nice side benefit.

Hopefully!  Please double check it with KVM running altogether to make sure
the patch works exactly as expected.

[...]

> We'll want hugetlbfs support for this operation too, but it's only
> really useful (at least for our use case) after HGM is merged. But,
> there's no strong reason not to just implement both all at once - I'll
> extend v2 to also work properly with hugetlbfs. Probably it isn't too
> hard, I just need to do a bit more reading of how swap markers are
> handled in hugetlbfs.

Sure.  We have too many flags separating different types of memory, so I
think it'll be nice if when it can still trivially work for everything.

For this specific case, since your goal is definitely having hugetlb hgm
supported so it'll be even more trickier if only hgm will be supported but
not !hgm hugetlbs, so we'd better target it initially with all mem types.

Thanks,

-- 
Peter Xu

