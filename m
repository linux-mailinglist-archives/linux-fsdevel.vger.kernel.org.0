Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049C267A771
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 01:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjAYAUi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 19:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjAYAUg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:20:36 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1555D4B4AF
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 16:20:31 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o13so16853489pjg.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 16:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vd0fuRLUDjU8rvXBur9NhqOrPTXVZKZJ4oN8G/lkhJI=;
        b=o+HXYRIxPxQ8KPpGLHKkZdPsJO5M09uHZapYHKFtwuihESZLkI6Zkm4ULLnmfHYxaN
         z6Bkf5/oL9w9YxifsJFcA+QqHXQpANCQz/OmWBa9Rlyll+JFY8LEgS0okBOrevjCF1S3
         zR7B+TPDrrG/OfCNb5TJIPizamziaqvNbn8/9CvRZxXi09FQ5URRCGE/FpZIYdJ6T4/N
         AY4adBiPMnMz+1wL4iuMS9jBXixwStGqund1wI/dbZkKpFhaJDOGRoji+PGQ7Xch442u
         xgwPTskywSS01/xVU1ilxRAsaLiYsitEfD5ZykZTycKtYgDSWCaIA6Ar69OkijI/Sgc/
         1/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vd0fuRLUDjU8rvXBur9NhqOrPTXVZKZJ4oN8G/lkhJI=;
        b=R2ITAVV8rv/fDNjPG/IzFDNpdH/ImpsEzQKGCDVutjtBjbY1RCkc8hHsDeGxKmuuko
         bLxMn+wcUZig5Lb6yoXsyqDhBD7K4HdzzSG2W7LvN8CAo2KCY/jgyjtNA9Tv1b56zF64
         bJmEcoOoITAmmHnPJMKI7+5dAwCbiWG/jgNoHZXdU3Pobbiai6jXQWPsLOMVKgBwI1MQ
         pgwimoWf077oCpvp2TBr3OdqTYZZ9z1/ESakIgzwe1f+vUTlSUbu5IWcTzYXlKCZJtC3
         8eYsuh6Nqwk+tGpKMIRgXSvzbUbbYaRnzrutlqlV6YBe22tfQ/TgEC1UKFLz2hsALOph
         1fpw==
X-Gm-Message-State: AO0yUKXpr0F/HtdQLGSWY6XDaSR+9z27HDdxECDn7J0XHCuVHOPfeDuk
        pbO7gu9MGKDmMMJEHqAmao0MzQ==
X-Google-Smtp-Source: AK7set8DMFuhHtJA8X11WSyZdq14F8cMlJuZ6jde92u/m6yVtA5WC0P8SrmivvZz4XbeH1VArDptDg==
X-Received: by 2002:a17:90a:690e:b0:22b:b82a:8b5f with SMTP id r14-20020a17090a690e00b0022bb82a8b5fmr436422pjj.2.1674606030366;
        Tue, 24 Jan 2023 16:20:30 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090a49c800b0022bae5c3e1esm148419pjm.9.2023.01.24.16.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 16:20:29 -0800 (PST)
Date:   Wed, 25 Jan 2023 00:20:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Liam Merwick <liam.merwick@oracle.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
Message-ID: <Y9B1yiRR8DpANAEo@google.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <Y8H5Z3e4hZkFxAVS@google.com>
 <48953bf2-cee9-f818-dc50-5fb5b9b410bf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48953bf2-cee9-f818-dc50-5fb5b9b410bf@oracle.com>
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

On Tue, Jan 24, 2023, Liam Merwick wrote:
> On 14/01/2023 00:37, Sean Christopherson wrote:
> > On Fri, Dec 02, 2022, Chao Peng wrote:
> > > This patch series implements KVM guest private memory for confidential
> > > computing scenarios like Intel TDX[1]. If a TDX host accesses
> > > TDX-protected guest memory, machine check can happen which can further
> > > crash the running host system, this is terrible for multi-tenant
> > > configurations. The host accesses include those from KVM userspace like
> > > QEMU. This series addresses KVM userspace induced crash by introducing
> > > new mm and KVM interfaces so KVM userspace can still manage guest memory
> > > via a fd-based approach, but it can never access the guest memory
> > > content.
> > > 
> > > The patch series touches both core mm and KVM code. I appreciate
> > > Andrew/Hugh and Paolo/Sean can review and pick these patches. Any other
> > > reviews are always welcome.
> > >    - 01: mm change, target for mm tree
> > >    - 02-09: KVM change, target for KVM tree
> > 
> > A version with all of my feedback, plus reworked versions of Vishal's selftest,
> > is available here:
> > 
> >    git@github.com:sean-jc/linux.git x86/upm_base_support
> > 
> > It compiles and passes the selftest, but it's otherwise barely tested.  There are
> > a few todos (2 I think?) and many of the commits need changelogs, i.e. it's still
> > a WIP.
> > 
> 
> When running LTP (https://github.com/linux-test-project/ltp) on the v10
> bits (and also with Sean's branch above) I encounter the following NULL
> pointer dereference with testcases/kernel/syscalls/madvise/madvise01
> (100% reproducible).
> 
> It appears that in restrictedmem_error_page() inode->i_mapping->private_data
> is NULL
> in the list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list)
> but I don't know why.

Kirill, can you take a look?  Or pass the buck to someone who can? :-)
