Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD896322005
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 20:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhBVTVb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 14:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhBVTSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:18:45 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD54C06178A
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Feb 2021 11:17:52 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id e13so27895127ejl.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Feb 2021 11:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mL0bjhfITdu5839ghM56EtmuJ0mV3o1IEyaUJSuFMFs=;
        b=0VKXgI+d4N8/TsZjQE/E5fkYxDFeC7KFxegFQ1tUDUQWXj1P6cXOsiH5slGqxqrmbb
         dBx4HcRD8Hzu5KRTHX5N1ybYz5yC5e7kYtwfTlsuU2esXKkYljaX8VDDRS1DaE/uHUin
         QAGppPvDyByXQFp+iE9GKGPwF3A2dB1mFytnHdtGJw+XJLGP5r33xK45enAbysyTaEHa
         57tTo6DZyOE+uYzDNdPTZAL71cYVMSUiSI5K7sek4p2eMAFj1YmFFfuyLNvbSLKSE5kW
         D+y3PQVbEo19hoNoanDSrLywkZqhcPGuG5KVCRRj/oMJKHnyCwkRLTAD6EZO4JnoconN
         aV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mL0bjhfITdu5839ghM56EtmuJ0mV3o1IEyaUJSuFMFs=;
        b=ZNOJoyC/6vLUjYFul3GYdbSO6IkuwHe4NS/+PbftCVi5YlN+vAzzt99uQyPaaS7VU4
         hNVnisfyU5pmhLP+B9NPMkKzti7wEk4ANJSdtIOmVUMGJNjyOiyt2b9BarIn59/NpN3V
         F720fVhyX5x/HTpV7F5RTxeBRW6wtwV6CZ/iy/QQklyEbwZKG4SsefoxQT3Z+jhgT024
         ExYHeb+G0hsdGOZHoUSjmJ7k/ZCeewanzMWX2LVegeVGVMy4EfZqpZm0Iucm9gveBHHy
         X5wMJLuwb0f0yRiDI8TBLDYSwuPxh5UQvURf2gkBSHkMnz4XtDbM6ig5rSqGmdRBWdVG
         W1jQ==
X-Gm-Message-State: AOAM532jO7uc/JI0nXpgyFgerQbAG5f76GVDyY6Xo2ZQhwN6IbkWLPGC
        a/a81b6gPFZi9lmkfT76rn1sXQzACdFFuBPxVg5WAg==
X-Google-Smtp-Source: ABdhPJwkiWshDLTsz8a3A7EzLjYNcKqX6Z1F01E3QE0NjkocZdW4txgaDcjEXqIRRI2IV4obwnL12Zk+rIG7YnuhZ4g=
X-Received: by 2002:a17:906:8692:: with SMTP id g18mr22575502ejx.418.1614021471495;
 Mon, 22 Feb 2021 11:17:51 -0800 (PST)
MIME-Version: 1.0
References: <20210208084920.2884-1-rppt@kernel.org> <20210208084920.2884-9-rppt@kernel.org>
 <20210222073452.GA30403@codon.org.uk> <20210222102359.GE1447004@kernel.org>
In-Reply-To: <20210222102359.GE1447004@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Feb 2021 11:17:46 -0800
Message-ID: <CAPcyv4hCXZFmeMkKxN54Yw3ZbvoYQ3Z9y9Ayv42i6u+24Bkmqg@mail.gmail.com>
Subject: Re: [PATCH v17 08/10] PM: hibernate: disable when there are active
 secretmem users
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-riscv@lists.infradead.org, X86 ML <x86@kernel.org>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 22, 2021 at 2:24 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Feb 22, 2021 at 07:34:52AM +0000, Matthew Garrett wrote:
> > On Mon, Feb 08, 2021 at 10:49:18AM +0200, Mike Rapoport wrote:
> >
> > > It is unsafe to allow saving of secretmem areas to the hibernation
> > > snapshot as they would be visible after the resume and this essentially
> > > will defeat the purpose of secret memory mappings.
> >
> > Sorry for being a bit late to this - from the point of view of running
> > processes (and even the kernel once resume is complete), hibernation is
> > effectively equivalent to suspend to RAM. Why do they need to be handled
> > differently here?
>
> Hibernation leaves a copy of the data on the disk which we want to prevent.

Why not document that users should use data at rest protection
mechanisms for their hibernation device? Just because secretmem can't
assert its disclosure guarantee does not mean the hibernation device
is untrustworthy.
