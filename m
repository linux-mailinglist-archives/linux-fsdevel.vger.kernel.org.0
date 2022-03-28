Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1634EA143
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 22:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbiC1USp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 16:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244198AbiC1USo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:18:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27B36623F
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Mar 2022 13:17:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D84B61474
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Mar 2022 20:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF80C34115
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Mar 2022 20:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648498622;
        bh=F88P3EjB8xr5i+2/B7u8QJbACQEAp4uoybtn389DnK4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MbUyJVBBtcRiSqPMHyR5eTY53fRuRdbMY7WKUQUsWXQwbwdNFdMe++QlbME3I4aU5
         k3luwth9XutktPcZBag3IYt3MRDRVYipv+ZzpOr7tGe+3ve7q6cUGAJ7CxEMMj3/aW
         Hn9ibm5hfHZrw6B5z8MboqK7NPTNAU7quqrhjeNASOVNcUCE0o0AsnUU3OwsZO4HnJ
         90zbcgiajFjUNlPdgUK1jhw6+zfiJd1YWeZix/64m2xxjMvS8gbUzOOW44PxtF/0aF
         JrbiOj4D48tJXtEhCKjFeD5xeHKQ1BXX5i0o4k4HE4lMRy4HAZr/gvPFhsTu4t9kdC
         xmPOKxGci3a9Q==
Received: by mail-ej1-f43.google.com with SMTP id r13so30992225ejd.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Mar 2022 13:17:01 -0700 (PDT)
X-Gm-Message-State: AOAM531TNEzNGVYWhD5UJgL9gvWNZSxDThOTL9Z2ANW7bSyLCS5sZzOo
        Y/rBoVAIqNzeSoVAb9SmkEffq1s5jvYufZrH8ZgyHg==
X-Google-Smtp-Source: ABdhPJyUCfqNMjY4j/zDrp5thzUNKGPE9xMYQkN6ReIG1dPzUmJOgX3w9dDbnVfGV3lDWzlxjIqdp/oS80009PSifH0=
X-Received: by 2002:a17:906:c10d:b0:6e0:dc2a:338d with SMTP id
 do13-20020a170906c10d00b006e0dc2a338dmr14671860ejc.538.1648498620006; Mon, 28
 Mar 2022 13:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
In-Reply-To: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 28 Mar 2022 13:16:48 -0700
X-Gmail-Original-Message-ID: <CALCETrWk1Y47JQC=V028A7Tmc9776Oo4AjgwqRtd9K=XDh6=TA@mail.gmail.com>
Message-ID: <CALCETrWk1Y47JQC=V028A7Tmc9776Oo4AjgwqRtd9K=XDh6=TA@mail.gmail.com>
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022 at 6:09 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> This is the v5 of this series which tries to implement the fd-based KVM
> guest private memory. The patches are based on latest kvm/queue branch
> commit:
>
>   d5089416b7fb KVM: x86: Introduce KVM_CAP_DISABLE_QUIRKS2

Can this series be run and a VM booted without TDX?  A feature like
that might help push it forward.

--Andy
