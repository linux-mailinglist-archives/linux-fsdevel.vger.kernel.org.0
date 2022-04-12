Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4854FE3F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 16:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356585AbiDLOi5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 10:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241823AbiDLOi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:38:56 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588F95F262
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 07:36:38 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id j6so13847561qkp.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 07:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=evNj2CNMoMsw5e7L6RfPQYGJFzo3TZYC7FsieHWZ5Ls=;
        b=P4KDTA4ChNl8eFo5TaRAl/5FnI/hVHjJzJBo1xbfO6E6tcQCaqBfnBN1z5fv3DfE1u
         iQILgHtSz7DDusNSlvJP3Z1yMP4+yKAQ2Eyz628hQVcLvQ+BxsdlwhsUbE6fvWB/Q2is
         KJFMZcpNQuQ1kXRm/7dZww/aXDBDg6Qg87XJBXqMNal9QHP5YcfHOuo4039oAPwifclm
         Ni6jxAqEXJAsTg1vDWd5O4322/PPXZOhWqI7cTTZAicevA8+5AkWYEBaFSAdm27ELa3S
         niv0qlWzCgCFeZ31VkUUBPNxRCHtURSjk4RK/eF6eqwh/psh+4pwILguC3l2W1BosUlI
         tCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=evNj2CNMoMsw5e7L6RfPQYGJFzo3TZYC7FsieHWZ5Ls=;
        b=xr9yws1sXRip8XVFtXBUVXJ/ZbPHrWqnTtLUc8tH3dJQuIdcdZEBJ6HiXbR8RGlwNv
         Zv5gmmgDq016d+FrHmRcgtn8rggEXaN/EBY5saz0KvOM/kR+sCc7bg0DyAbiNXLU40li
         ILnPUGp2KdJQsDjEoHY/dojDn7NZoJTFNoasoMrmroRCvp8rOkP8iMwO8No2SRcVAk99
         r/RyT8DrbcB1bYsyyiM2z+Mx23AiBYCwBXVK47qBEDwSq687FSz1HUZwUGlNwUzARZkb
         oOYmMSjHLtpmcWn9tTyV3noiEiHEc6iGmyD0QczjdiPwrUaqDE6mScKmL5TbB5FIziw5
         ISzg==
X-Gm-Message-State: AOAM533nLebGQAn4I1HdovGJjeq3BEk7qIs88sh7PerNo+RojcZY0uxd
        Nl1mKP10EpWvlFzKfBTT89T89g==
X-Google-Smtp-Source: ABdhPJySHPHmQqifS2wea+F5V8gixdYIV//Jv7wOTevmOQGVNlVLMxWAFhJpJjukoZ7Xd9/fbgNIYA==
X-Received: by 2002:a37:990:0:b0:69a:976:be4e with SMTP id 138-20020a370990000000b0069a0976be4emr3264529qkj.321.1649774197434;
        Tue, 12 Apr 2022 07:36:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id n7-20020ac85a07000000b002f1421dac8csm324215qta.80.2022.04.12.07.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 07:36:36 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1neHdE-000uGn-C6; Tue, 12 Apr 2022 11:36:36 -0300
Date:   Tue, 12 Apr 2022 11:36:36 -0300
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
Message-ID: <20220412143636.GG64706@ziepe.ca>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-5-chao.p.peng@linux.intel.com>
 <Yk8L0CwKpTrv3Rg3@google.com>
 <02e18c90-196e-409e-b2ac-822aceea8891@www.fastmail.com>
 <YlB3Z8fqJ+67a2Ck@google.com>
 <7ab689e7-e04d-5693-f899-d2d785b09892@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ab689e7-e04d-5693-f899-d2d785b09892@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 08, 2022 at 08:54:02PM +0200, David Hildenbrand wrote:

> RLIMIT_MEMLOCK was the obvious candidate, but as we discovered int he
> past already with secretmem, it's not 100% that good of a fit (unmovable
> is worth than mlocked). But it gets the job done for now at least.

No, it doesn't. There are too many different interpretations how
MELOCK is supposed to work

eg VFIO accounts per-process so hostile users can just fork to go past
it.

RDMA is per-process but uses a different counter, so you can double up

iouring is per-user and users a 3rd counter, so it can triple up on
the above two

> So I'm open for alternative to limit the amount of unmovable memory we
> might allocate for user space, and then we could convert seretmem as well.

I think it has to be cgroup based considering where we are now :\

Jason
