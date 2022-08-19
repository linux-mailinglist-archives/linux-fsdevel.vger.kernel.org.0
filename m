Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBAD5993B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 05:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345673AbiHSDiz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 23:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344497AbiHSDiy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 23:38:54 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E105A3ED
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 20:38:52 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h21so2568463qta.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 20:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc;
        bh=7QWsk1dD79/0D4u0UWDr5UxzCpKhzJRpfIhKUpnpQ+k=;
        b=KuaCRRHm/qV9FFVeqlEN7JryKLX4RwfY1LZIY85W4Q5v1ZzNMZMPFdn7uo+ttUjCVT
         1HbFS5hSmTmVaadbykTq/foDTvZk+z2MPmSMfVSyEcM26pLHGI+FT1pagU3qA5YSv6Pe
         smiTX6ALd4jvtRg4FQeIZu/V5dtCvUlK9QqKG98uq9fHrU0wTxzhMXCNUViHzxNWqeDD
         tyUgxuRBDcr0kgwcKGkfVF51bYqzSNdXUE3NR9GsMHTj7CAWRw0dTXPSi1QBSeX/tIeL
         hFZWouaQyyw4UZ3LD6KHID3uW3OYyosgyH7ArN1AA5RlREyiZP0Lm0kDIaJaInosSy0j
         3rLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=7QWsk1dD79/0D4u0UWDr5UxzCpKhzJRpfIhKUpnpQ+k=;
        b=hSkp4bcMuGc5rVdRINdBQtBX767XtASRSxlb7pxYIjPSBaWAoCyKbYEbRox0yP9onW
         W0MF1K54SuLARgpNShtajUs8kr5x+yA40FWartMTh285Ibf3D5X2b0x5UWy2W6xeh9tN
         KKUJOlD1gHTP3VwFeNtN8nCeqY4Ycwj8zmQu0ahfnUq334sSV/TbSG1K2XrLCQcNqjxX
         /ffxWGLJSvXzp+z8nmabNIXFvA5bJHoi6NxftxALpyuJeAzmpx+Ag63R5KffMEVC9OX5
         i5oQBJaZ8cxjYiznD4DzdyreUVCOYcoB/hymMXb8oYWSjNjY0UvElRqzaFWcTVQAFK0h
         NNYw==
X-Gm-Message-State: ACgBeo1IXp8Q8G+HeMrXXTwTkayvhIubBxVJ2DKg4DkSwIKzAtmRSwhd
        CHT5G02ftylL8WP2k36D9tbqZQ==
X-Google-Smtp-Source: AA6agR40rfnrczgoKbXWMuIEA5UNdChmZMqcOy/mPNBBRihLY4ymgv1M+UCKRDg9gmCEuMhOuCh2xQ==
X-Received: by 2002:ac8:5ad4:0:b0:344:5e40:7824 with SMTP id d20-20020ac85ad4000000b003445e407824mr5218048qtd.482.1660880331003;
        Thu, 18 Aug 2022 20:38:51 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bm25-20020a05620a199900b006b949afa980sm2881193qkb.56.2022.08.18.20.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 20:38:50 -0700 (PDT)
Date:   Thu, 18 Aug 2022 20:38:35 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Sean Christopherson <seanjc@google.com>
cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
In-Reply-To: <Yv7XTON3MwuC1Q3U@google.com>
Message-ID: <226ab26d-9aa8-dce2-c7f0-9e3f5b65b63@google.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com> <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com> <20220818132421.6xmjqduempmxnnu2@box> <Yv7XTON3MwuC1Q3U@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 19 Aug 2022, Sean Christopherson wrote:
> On Thu, Aug 18, 2022, Kirill A . Shutemov wrote:
> > On Wed, Aug 17, 2022 at 10:40:12PM -0700, Hugh Dickins wrote:
> > > On Wed, 6 Jul 2022, Chao Peng wrote:
> > > But since then, TDX in particular has forced an effort into preventing
> > > (by flags, seals, notifiers) almost everything that makes it shmem/tmpfs.
> > > 
> > > Are any of the shmem.c mods useful to existing users of shmem.c? No.
> > > Is MFD_INACCESSIBLE useful or comprehensible to memfd_create() users? No.
> 
> But QEMU and other VMMs are users of shmem and memfd.  The new features certainly
> aren't useful for _all_ existing users, but I don't think it's fair to say that
> they're not useful for _any_ existing users.

Okay, I stand corrected: there exist some users of memfd_create()
who will also have use for "INACCESSIBLE" memory.

> 
> > > What use do you have for a filesystem here?  Almost none.
> > > IIUC, what you want is an fd through which QEMU can allocate kernel
> > > memory, selectively free that memory, and communicate fd+offset+length
> > > to KVM.  And perhaps an interface to initialize a little of that memory
> > > from a template (presumably copied from a real file on disk somewhere).
> > > 
> > > You don't need shmem.c or a filesystem for that!
> > > 
> > > If your memory could be swapped, that would be enough of a good reason
> > > to make use of shmem.c: but it cannot be swapped; and although there
> > > are some references in the mailthreads to it perhaps being swappable
> > > in future, I get the impression that will not happen soon if ever.
> > > 
> > > If your memory could be migrated, that would be some reason to use
> > > filesystem page cache (because page migration happens to understand
> > > that type of memory): but it cannot be migrated.
> > 
> > Migration support is in pipeline. It is part of TDX 1.5 [1]. 
> 
> And this isn't intended for just TDX (or SNP, or pKVM).  We're not _that_ far off
> from being able to use UPM for "regular" VMs as a way to provide defense-in-depth

UPM? That's an acronym from your side of the fence, I spy references to
it in the mail threads, but haven't tracked down a definition.  I'll
just take it to mean the fd-based memory we're discussing.

> without having to take on the overhead of confidential VMs.  At that point,
> migration and probably even swap are on the table.

Good, the more "flexible" that memory is, the better for competing users
of memory.  But an fd supplied by KVM gives you freedom to change to a
better implementation of allocation underneath, whenever it suits you.
Maybe shmem beneath is good from the start, maybe not.

Hugh
