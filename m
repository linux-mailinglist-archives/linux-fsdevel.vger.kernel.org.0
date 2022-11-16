Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C5C62B6F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 10:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiKPJx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 04:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiKPJxz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:53:55 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C00D10B56
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 01:53:52 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso2735850wmb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 01:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zze9Wsxt3ysTHHvg5WBu0SQosVjbcwx2aPdUf6crt3Y=;
        b=I2T59KEQLxIXM2pHNfvD9YeKkkSHE4ZyMd/bqV2bIhQhCd4r7G3BFqEMlifLl2/V3U
         Ltzz2PryU6B8uAKFDvsVQ1vtZoIrK9vgSISfVLVmvC111IWlhiu150wSuOeQnJ6nS591
         EbyyF/lv+oHj3JMgx+8zk0gz81qJBc38w/3AY8cHqHQDXz76GRaAPK34tu5ONO4yvzJi
         2AZTRHZQV9qWmZROHiHvF+90nX6/MmF+WWmcZMOj7hNAIEiOmXfJs2/gtzUTPmnerT3Y
         SDwEvPH6Zu2ekiEIvkl//9IDw/jJhHIejKcAMlZV7e7jFfc0EIr02UqMzf+azaJwFDJT
         h21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zze9Wsxt3ysTHHvg5WBu0SQosVjbcwx2aPdUf6crt3Y=;
        b=IYv5GCIE3rnMMvlG9X2Zz2X2HMQ3Gp/yrVqp9M18kJ9SOLcoSCm9iIBk5CaC+5aMbz
         Heebz9zef6h3et7fx1SeCPjdwZERGGYyk7wKKiK4kbBw1taGEDDwgS5F42l3iqmfMcPr
         g4mxOSjKunsaLpt3MFSoj8c4eBLtz0qCy48J8J7EKA2s7/I9tGJAeot4RlImkcd1uiG9
         wub8ykiL2NZA7XlN0+Xlt58iAja+vuSM6AtyvcgNYydEdKIz13N2YA6teYwOSGTuF1kb
         RZUcrZMEJrFN1ICWuADgw4InMN0TjJ8Ng8EQQRrL82n+sjVCZbpwOWUP6zB835yZ6OAC
         IZ9g==
X-Gm-Message-State: ANoB5pmqyS/ncmUN3Q5N/WGbNG1KV0HZGZO1mnkJ7GYTPoPgMxQf00Kf
        BD7cjcMPYZygjqrCiat6MQSRHw==
X-Google-Smtp-Source: AA0mqf450k4KT3b612+SvZbSE765F/0XKp3AXD24C9sDIk/4dxF+lDjo+r4A3/pJpT3ovdAyPzm4jg==
X-Received: by 2002:a7b:ca43:0:b0:3cf:ade4:d529 with SMTP id m3-20020a7bca43000000b003cfade4d529mr1563443wml.193.1668592431026;
        Wed, 16 Nov 2022 01:53:51 -0800 (PST)
Received: from zen.linaroharston ([185.81.254.11])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003cf4eac8e80sm2160083wms.23.2022.11.16.01.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 01:53:50 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id B067B1FFB7;
        Wed, 16 Nov 2022 09:53:49 +0000 (GMT)
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <87k03xbvkt.fsf@linaro.org> <20221116050022.GC364614@chaop.bj.intel.com>
User-agent: mu4e 1.9.2; emacs 28.2.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
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
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v9 0/8] KVM: mm: fd-based approach for supporting KVM
Date:   Wed, 16 Nov 2022 09:40:23 +0000
In-reply-to: <20221116050022.GC364614@chaop.bj.intel.com>
Message-ID: <87v8nf8bte.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Chao Peng <chao.p.peng@linux.intel.com> writes:

> On Mon, Nov 14, 2022 at 11:43:37AM +0000, Alex Benn=C3=A9e wrote:
>>=20
>> Chao Peng <chao.p.peng@linux.intel.com> writes:
>>=20
>> <snip>
>> > Introduction
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > KVM userspace being able to crash the host is horrible. Under current
>> > KVM architecture, all guest memory is inherently accessible from KVM
>> > userspace and is exposed to the mentioned crash issue. The goal of this
>> > series is to provide a solution to align mm and KVM, on a userspace
>> > inaccessible approach of exposing guest memory.=20
>> >
>> > Normally, KVM populates secondary page table (e.g. EPT) by using a host
>> > virtual address (hva) from core mm page table (e.g. x86 userspace page
>> > table). This requires guest memory being mmaped into KVM userspace, but
>> > this is also the source where the mentioned crash issue can happen. In
>> > theory, apart from those 'shared' memory for device emulation etc, gue=
st
>> > memory doesn't have to be mmaped into KVM userspace.
>> >
>> > This series introduces fd-based guest memory which will not be mmaped
>> > into KVM userspace. KVM populates secondary page table by using a
>> > fd/offset pair backed by a memory file system. The fd can be created
>> > from a supported memory filesystem like tmpfs/hugetlbfs and KVM can
>> > directly interact with them with newly introduced in-kernel interface,
>> > therefore remove the KVM userspace from the path of accessing/mmaping
>> > the guest memory.=20
>> >
>> > Kirill had a patch [2] to address the same issue in a different way. It
>> > tracks guest encrypted memory at the 'struct page' level and relies on
>> > HWPOISON to reject the userspace access. The patch has been discussed =
in
>> > several online and offline threads and resulted in a design document [=
3]
>> > which is also the original proposal for this series. Later this patch
>> > series evolved as more comments received in community but the major
>> > concepts in [3] still hold true so recommend reading.
>> >
>> > The patch series may also be useful for other usages, for example, pure
>> > software approach may use it to harden itself against unintentional
>> > access to guest memory. This series is designed with these usages in
>> > mind but doesn't have code directly support them and extension might be
>> > needed.
>>=20
>> There are a couple of additional use cases where having a consistent
>> memory interface with the kernel would be useful.
>
> Thanks very much for the info. But I'm not so confident that the current
> memfd_restricted() implementation can be useful for all these usages.=20
>
>>=20
>>   - Xen DomU guests providing other domains with VirtIO backends
>>=20
>>   Xen by default doesn't give other domains special access to a domains
>>   memory. The guest can grant access to regions of its memory to other
>>   domains for this purpose.=20
>
> I'm trying to form my understanding on how this could work and what's
> the benefit for a DomU guest to provide memory through memfd_restricted().
> AFAICS, memfd_restricted() can help to hide the memory from DomU userspac=
e,
> but I assume VirtIO backends are still in DomU uerspace and need access
> that memory, right?

They need access to parts of the memory. At the moment you run your
VirtIO domains in the Dom0 and give them access to the whole of a DomU's
address space - however the Xen model is by default the guests memory is
inaccessible to other domains on the system. The DomU guest uses the Xen
grant model to expose portions of its address space to other domains -
namely for the VirtIO queues themselves and any pages containing buffers
involved in the VirtIO transaction. My thought was that looks like a
guest memory interface which is mostly inaccessible (private) with some
holes in it where memory is being explicitly shared with other domains.

What I want to achieve is a common userspace API with defined semantics
for what happens when private and shared regions are accessed. Because
having each hypervisor/confidential computing architecture define its
own special API for accessing this memory is just a recipe for
fragmentation and makes sharing common VirtIO backends impossible.

>
>>=20
>>   - pKVM on ARM
>>=20
>>   Similar to Xen, pKVM moves the management of the page tables into the
>>   hypervisor and again doesn't allow those domains to share memory by
>>   default.
>
> Right, we already had some discussions on this in the past versions.
>
>>=20
>>   - VirtIO loopback
>>=20
>>   This allows for VirtIO devices for the host kernel to be serviced by
>>   backends running in userspace. Obviously the memory userspace is
>>   allowed to access is strictly limited to the buffers and queues
>>   because giving userspace unrestricted access to the host kernel would
>>   have consequences.
>
> Okay, but normal memfd_create() should work for it, right? And
> memfd_restricted() instead may not work as it unmaps the memory from
> userspace.
>
>>=20
>> All of these VirtIO backends work with vhost-user which uses memfds to
>> pass references to guest memory from the VMM to the backend
>> implementation.
>
> Sounds to me these are the places where normal memfd_create() can act on.
> VirtIO backends work on the mmap-ed memory which currently is not the
> case for memfd_restricted(). memfd_restricted() has different design
> purpose that unmaps the memory from userspace and employs some kernel
> callbacks so other kernel modules can make use of the memory with these
> callbacks instead of userspace virtual address.

Maybe my understanding is backwards then. Are you saying a guest starts
with all its memory exposed and then selectively unmaps the private
regions? Is this driven by the VMM or the guest itself?

--=20
Alex Benn=C3=A9e
