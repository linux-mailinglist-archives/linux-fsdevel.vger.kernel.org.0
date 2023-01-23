Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A86678C18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 00:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjAWXiS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 18:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjAWXiP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:38:15 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455471207B
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 15:38:12 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id lp10so9752615pjb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 15:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PDHB0ODlMstmhFdpIes6JLYo5+ikO8l0oYaAPmmlt1c=;
        b=VkzHwRGnuLzzOCe+jd2+aXAC1B0Pi316N1RkmUx4r6ANqJcx0x+5Q72Z8UUWxTdy1r
         pG5SCyLEjYuMfqhsFLdkkFHinHiEydOUFzX+r5WNej9OPd87nM0d7yREV+Rq8DkVOrGV
         NNXVLr+T0ZRr5iz2mMx1Z0IHdQwR/sXaSDOinZlAX/u9O36ljHgPvbEvKqpZSoiKL/Ql
         2n5bBmNgSGwr5j9NkL7X+hI5ejHfVg7U5tPdlMMUlM5A7mUt0EJEbSqS9aevYAkYpR2i
         P7CyNcMiBR5cvRjvE+wd+fhWDFEx7SAIHLLtgqKHLWXCd78gvhmYm3A32QaiqopBK3SZ
         eGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDHB0ODlMstmhFdpIes6JLYo5+ikO8l0oYaAPmmlt1c=;
        b=ogp13hAwpWvjYBnEbYgFrzGWFVDQMsuAaxY6XnfxeHngE4JdKxRFlmZrxS+LWSuAaW
         EKekby+wGT4kMHtwy87LV0G/5tse007vfJnQUbrTdzXXyGITP5mBr5o2fTFa0Uu3Va3k
         7AFz9yBSwCcftmHeMnQmd85LrcrrCEM6mqr2FRzz4/PspaXUPyxj4Igr30/6BVOprNtO
         02eYDevMkiJFzREQDpcTQAtBo4L0/Ce6ax9lOz/X5mM4yOSNWJlII/0NzY6k1XDJkGej
         Iz0NOtcqSo79w8ArP20qg1vZZAASlGNdxY5rB8ys/qkdgcH/cXk9xGNyXQ5c3yY5DsAU
         eofQ==
X-Gm-Message-State: AFqh2kppVSV5dBXkGCPaZyKPOl6EYBC8kStSCDSQrGu0a/Hs18xWFhwU
        VoriU/oB37LWTWvaf3ZRMwhEzA==
X-Google-Smtp-Source: AMrXdXtrvJkyeLq8anFSJnOID4b9C3AaKf59uOM0fvrdASPfrf/mhyTzO8Q2iNKbj2o8vaNJGqEopA==
X-Received: by 2002:a05:6a20:3ca7:b0:b8:c646:b0e2 with SMTP id b39-20020a056a203ca700b000b8c646b0e2mr1004683pzj.3.1674517091557;
        Mon, 23 Jan 2023 15:38:11 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b00499a90cce5bsm102181pgo.50.2023.01.23.15.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 15:38:10 -0800 (PST)
Date:   Mon, 23 Jan 2023 23:38:07 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "jmattson@google.com" <jmattson@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "tabba@google.com" <tabba@google.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "david@redhat.com" <david@redhat.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "qperret@google.com" <qperret@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Annapurve, Vishal" <vannapurve@google.com>,
        "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "hughd@google.com" <hughd@google.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <Y88aX+MIZeteDQju@google.com>
References: <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
 <5c6e2e516f19b0a030eae9bf073d555c57ca1f21.camel@intel.com>
 <20221219075313.GB1691829@chaop.bj.intel.com>
 <deba096c85e41c3a15d122f2159986a74b16770f.camel@intel.com>
 <20221220072228.GA1724933@chaop.bj.intel.com>
 <126046ce506df070d57e6fe5ab9c92cdaf4cf9b7.camel@intel.com>
 <20221221133905.GA1766136@chaop.bj.intel.com>
 <b898e28d7fd7182e5d069646f84b650c748d9ca2.camel@intel.com>
 <010a330c-a4d5-9c1a-3212-f9107d1c5f4e@suse.cz>
 <0959c72ec635688f4b6c1b516815f79f52543b31.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0959c72ec635688f4b6c1b516815f79f52543b31.camel@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023, Huang, Kai wrote:
> On Mon, 2023-01-23 at 15:03 +0100, Vlastimil Babka wrote:
> > On 12/22/22 01:37, Huang, Kai wrote:
> > > > > I argue that this page pinning (or page migration prevention) is not
> > > > > tied to where the page comes from, instead related to how the page will
> > > > > be used. Whether the page is restrictedmem backed or GUP() backed, once
> > > > > it's used by current version of TDX then the page pinning is needed. So
> > > > > such page migration prevention is really TDX thing, even not KVM generic
> > > > > thing (that's why I think we don't need change the existing logic of
> > > > > kvm_release_pfn_clean()). 
> > > > > 
> > > This essentially boils down to who "owns" page migration handling, and sadly,
> > > page migration is kinda "owned" by the core-kernel, i.e. KVM cannot handle page
> > > migration by itself -- it's just a passive receiver.
> > > 
> > > For normal pages, page migration is totally done by the core-kernel (i.e. it
> > > unmaps page from VMA, allocates a new page, and uses migrate_pape() or a_ops-
> > > > migrate_page() to actually migrate the page).
> > > In the sense of TDX, conceptually it should be done in the same way. The more
> > > important thing is: yes KVM can use get_page() to prevent page migration, but
> > > when KVM wants to support it, KVM cannot just remove get_page(), as the core-
> > > kernel will still just do migrate_page() which won't work for TDX (given
> > > restricted_memfd doesn't have a_ops->migrate_page() implemented).
> > > 
> > > So I think the restricted_memfd filesystem should own page migration handling,
> > > (i.e. by implementing a_ops->migrate_page() to either just reject page migration
> > > or somehow support it).
> > 
> > While this thread seems to be settled on refcounts already, 
> > 
> 
> I am not sure but will let Sean/Paolo to decide.

My preference is whatever is most performant without being hideous :-)

> > just wanted
> > to point out that it wouldn't be ideal to prevent migrations by
> > a_ops->migrate_page() rejecting them. It would mean cputime wasted (i.e.
> > by memory compaction) by isolating the pages for migration and then
> > releasing them after the callback rejects it (at least we wouldn't waste
> > time creating and undoing migration entries in the userspace page tables
> > as there's no mmap). Elevated refcount on the other hand is detected
> > very early in compaction so no isolation is attempted, so from that
> > aspect it's optimal.
> 
> I am probably missing something,

Heh, me too, I could have sworn that using refcounts was the least efficient way
to block migration.

> but IIUC the checking of refcount happens at very last stage of page migration too 
