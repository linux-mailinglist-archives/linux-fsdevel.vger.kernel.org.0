Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C334FFD1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 19:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbiDMRyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 13:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbiDMRye (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:54:34 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD446D3BE
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 10:52:11 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id o18so1913426qtk.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 10:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AOcfAyqGgzTsDLYWZNFvb/pt3FEBh03V8FeUjVfINLs=;
        b=Bossa6GEY7VuCphnLPZuOzJUtcvFY0Xkwv27PVSBfCC/FdX4k2U/R/8tc3e6/TDG9b
         w/9uAgh8u82TWvzqs9/oqezRfVKYTJcg88jPsDyVpjn5i6qVesFEQ/DApakc869u+5lk
         GwUeq/iRHuUUSbU5VPjF+x+Nxyo3LcL64cerGvihnoxpTS7x163MByH0tjIdn6VLh7j0
         ORezJT/JFq5so7GsIh61VtI+O3VpLisBAYp/sU9dzGHFPjvZ0UPJeFpJ9W27eu7ET5GJ
         cvhFhPAZ1ZOsHSur//jxKwQ6gDdtJtdM7gcJ7fyJKGc6kOw1FZQe9pd2KDaJak2ceHpG
         PJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AOcfAyqGgzTsDLYWZNFvb/pt3FEBh03V8FeUjVfINLs=;
        b=c8E+QT0Cy2RYkuyF2sL6MHUdiQ8aMiENlRt5jKAIOZhDpEhpM3IxgcRzyGfG6GkqZ7
         cgJPYTvLoSPeRf1E0zvKhBKV1uQD2JJiFGTTOHRWPnSo4BQHtlOFbQC1Wdm8aGurtzr7
         NLAqDwi/cfVtEPdr5kPA3oqaYcY/sxjL6xew+YqFFyMjH+bL5p+kfzFC0QhzN/RQE8Ii
         H480/qsbb29IXIDiNpJEm/UaPCds5JhQzp8TnfpJpYgb+jqfBAYeNfDJS0vyfIGgHgDS
         u/tZ9jAB0gp5WFGSN3kwRDH5WtzGIk3EN1j9FaPDpJxL8SHptse9jj0Tl3YtwboFxm+P
         FD2Q==
X-Gm-Message-State: AOAM530k8BXqhEArZUCqFrAu2GCqCqlaq47w/7fM1uiKAXe7uCQL3/hS
        A07m9w/9FTetZHxR5oleSIcUFA==
X-Google-Smtp-Source: ABdhPJyFh5b43Bp+tYjO2fJUecpGRbFTQokPtotFsAvgNZxKoFX6OH3MdddD7y2rpYU6hDl31dtUUQ==
X-Received: by 2002:a05:622a:1392:b0:2e1:e7b9:3ce4 with SMTP id o18-20020a05622a139200b002e1e7b93ce4mr7976945qtk.153.1649872330523;
        Wed, 13 Apr 2022 10:52:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a424a00b00680c0c0312dsm23050212qko.30.2022.04.13.10.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 10:52:09 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nehA0-001kWp-5D; Wed, 13 Apr 2022 14:52:08 -0300
Date:   Wed, 13 Apr 2022 14:52:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Hildenbrand <david@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 04/13] mm/shmem: Restrict MFD_INACCESSIBLE memory
 against RLIMIT_MEMLOCK
Message-ID: <20220413175208.GI64706@ziepe.ca>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-5-chao.p.peng@linux.intel.com>
 <Yk8L0CwKpTrv3Rg3@google.com>
 <02e18c90-196e-409e-b2ac-822aceea8891@www.fastmail.com>
 <YlB3Z8fqJ+67a2Ck@google.com>
 <7ab689e7-e04d-5693-f899-d2d785b09892@redhat.com>
 <20220412143636.GG64706@ziepe.ca>
 <1686fd2d-d9c3-ec12-32df-8c4c5ae26b08@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686fd2d-d9c3-ec12-32df-8c4c5ae26b08@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 13, 2022 at 06:24:56PM +0200, David Hildenbrand wrote:
> On 12.04.22 16:36, Jason Gunthorpe wrote:
> > On Fri, Apr 08, 2022 at 08:54:02PM +0200, David Hildenbrand wrote:
> > 
> >> RLIMIT_MEMLOCK was the obvious candidate, but as we discovered int he
> >> past already with secretmem, it's not 100% that good of a fit (unmovable
> >> is worth than mlocked). But it gets the job done for now at least.
> > 
> > No, it doesn't. There are too many different interpretations how
> > MELOCK is supposed to work
> > 
> > eg VFIO accounts per-process so hostile users can just fork to go past
> > it.
> > 
> > RDMA is per-process but uses a different counter, so you can double up
> > 
> > iouring is per-user and users a 3rd counter, so it can triple up on
> > the above two
> 
> Thanks for that summary, very helpful.

I kicked off a big discussion when I suggested to change vfio to use
the same as io_uring

We may still end up trying it, but the major concern is that libvirt
sets the RLIMIT_MEMLOCK and if we touch anything here - including
fixing RDMA, or anything really, it becomes a uAPI break for libvirt..

> >> So I'm open for alternative to limit the amount of unmovable memory we
> >> might allocate for user space, and then we could convert seretmem as well.
> > 
> > I think it has to be cgroup based considering where we are now :\
> 
> Most probably. I think the important lessons we learned are that
> 
> * mlocked != unmovable.
> * RLIMIT_MEMLOCK should most probably never have been abused for
>   unmovable memory (especially, long-term pinning)

The trouble is I'm not sure how anything can correctly/meaningfully
set a limit.

Consider qemu where we might have 3 different things all pinning the
same page (rdma, iouring, vfio) - should the cgroup give 3x the limit?
What use is that really?

IMHO there are only two meaningful scenarios - either you are unpriv
and limited to a very small number for your user/cgroup - or you are
priv and you can do whatever you want.

The idea we can fine tune this to exactly the right amount for a
workload does not seem realistic and ends up exporting internal kernel
decisions into a uAPI..

Jason
