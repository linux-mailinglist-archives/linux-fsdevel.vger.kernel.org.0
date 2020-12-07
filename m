Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADAC2D19A5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 20:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgLGTc7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 14:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgLGTc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:32:59 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBA3C061793
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Dec 2020 11:32:18 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id b9so10844904ejy.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Dec 2020 11:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEesS3OI54HKVDbciJY01YZ/Otnyn7nILQ7ygAOmgxw=;
        b=S7HQZhJ9qSfgRFeBQ/VI28rCEZ0AfT+LagJrORVZEpyQI+IsauFJPZPKcstnNe9KqP
         E9dEdOhjnbRu4qdedgy7a/2Lk+8UBtZYusjrNtGz8GfGYXbaSGsQ+ZBsNFTS1KXCRiM5
         DFmCco1qg0r2qOoW++FPNbTfOc5F/059ESmISx/fN4YY75Bfn7371RU2sGUPYCt4m19W
         G0RG1fS35aU8JbtHZL2Z6a5xmnb5OyXlDCHm1gABi6S93ZMK1cROG+DC2DjFpBmHhsD1
         vUJqCZIB16ZvME9K3ZeQOzqjJOqPlVeyukGq6E4dcYt6HgsPCUv44Ievc2j8VflP2Mu2
         MjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEesS3OI54HKVDbciJY01YZ/Otnyn7nILQ7ygAOmgxw=;
        b=JIwwtrcB6R7+GuJpF+Tu4HrejE5TIZKSaImGkHlm5DZoZ/qew31tbEN+3Ldpn3On88
         ZSTq7sVs5IxFL0yaJE+2Xkw1IrJP3zV3B5erDrMcpdBAhAIfySdqPMx1a8nVX+eXyLp8
         73X+3kw7DKdPF2sbzkZhGNPb0r2GErdccCqQhAA7lLaxDZviciapGrztz/AKjVRuQg/B
         IQEWUhteBTkNqz6Gk9el8Ev6frRoddhmd6blcCzfdX8BWPDIHkAgrywfvQOcLGv0CV3I
         isg+TzmO+/leB60fMUuJGZ8Tv7e9rYgaXHTcnfXhrYSlTJtj9Myswo5Kj5lmuNBqDWw8
         dAmA==
X-Gm-Message-State: AOAM533azJsBiLv13NpTkZwpxZccbsmqklqqblz16ZR8y3kQL+1mV47m
        EdI09InQvaf3z/9FLBcelN5zIjF5KcTfJXYGed0MWA==
X-Google-Smtp-Source: ABdhPJx5TeZNSqN3ip9Hy7T4c21kaCHiRPLpQlPgDb6J2CMXhw6hKQwEMBJ3WgD8dM5pAXawaTU2xRXz3vPlPxQJP7g=
X-Received: by 2002:a17:906:2707:: with SMTP id z7mr14807988ejc.418.1607369537299;
 Mon, 07 Dec 2020 11:32:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1607332046.git.yuleixzhang@tencent.com> <33a1c4ca-9f78-96ca-a774-3adea64aaed3@redhat.com>
In-Reply-To: <33a1c4ca-9f78-96ca-a774-3adea64aaed3@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 7 Dec 2020 11:32:15 -0800
Message-ID: <CAPcyv4jRcT4ySx4DDnyGjM9t+C1y7yR+tVcKahsgGN8jGJB44A@mail.gmail.com>
Subject: Re: [RFC V2 00/37] Enhance memory utilization with DMEMFS
To:     David Hildenbrand <david@redhat.com>
Cc:     yulei zhang <yulei.kernel@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sean J Christopherson <sean.j.christopherson@intel.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Haiwei Li <lihaiwei.kernel@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 7, 2020 at 4:03 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 07.12.20 12:30, yulei.kernel@gmail.com wrote:
> > From: Yulei Zhang <yuleixzhang@tencent.com>
> >
> > In current system each physical memory page is assocaited with
> > a page structure which is used to track the usage of this page.
> > But due to the memory usage rapidly growing in cloud environment,
> > we find the resource consuming for page structure storage becomes
> > more and more remarkable. So is it possible that we could reclaim
> > such memory and make it reusable?
> >
> > This patchset introduces an idea about how to save the extra
> > memory through a new virtual filesystem -- dmemfs.
> >
> > Dmemfs (Direct Memory filesystem) is device memory or reserved
> > memory based filesystem. This kind of memory is special as it
> > is not managed by kernel and most important it is without 'struct page'.
> > Therefore we can leverage the extra memory from the host system
> > to support more tenants in our cloud service.
>
> "is not managed by kernel" well, it's obviously is managed by the
> kernel. It's not managed by the buddy ;)
>
> How is this different to using "mem=X" and mapping the relevant memory
> directly into applications? Is this "simply" a control instance on top
> that makes sure unprivileged process can access it and not step onto
> each others feet? Is that the reason why it's called  a "file system"?
> (an example would have helped here, showing how it's used)
>
> It's worth noting that memory hotunplug, memory poisoning and probably
> more is currently fundamentally incompatible with this approach - which
> should better be pointed out in the cover letter.
>
> Also, I think something similar can be obtained by using dax/hmat
> infrastructure with "memmap=", at least I remember a talk where this was
> discussed (but not sure if they modified the firmware to expose selected
> memory as soft-reserved - we would only need a cmdline parameter to
> achieve the same - Dan might know more).

There is currently the efi_fake_mem parameter that can add the
"EFI_MEMORY_SP" attribute on EFI platforms:

    efi_fake_mem=4G@9G:0x40000

...this results in a /dev/dax instance that can be further partitioned
via the device-dax sub-division facility merged for 5.10. That could
be generalized to something else for non-EFI platforms, but there has
not been a justification to go that route yet.

Joao pointed this out in a previous posting of DMEMFS, and I have yet
to see an explanation of incremental benefit the kernel gains from
having yet another parallel memory management interface.
