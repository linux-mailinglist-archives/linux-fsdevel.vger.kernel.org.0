Return-Path: <linux-fsdevel+bounces-57062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9107B1E7FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B665418871A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 12:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DF3275B1B;
	Fri,  8 Aug 2025 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xkfiswvk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F52274B26
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754654836; cv=none; b=VKGJDGvnOHN/I2nmXz3A2RtAcBdiCeymhQ3i82S+ONCF1vEAxKkNqQlaMIg53ATqY61WettKdJJzElLvbCD7mb1KrulOY7TMI6ZiGH9eEjzhugPtcFItjN1cZZn678MjTyl6sKdwaJffRorA+4lh4/FCiRMBwl+zIyIH72obWoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754654836; c=relaxed/simple;
	bh=n187WERgZLnx7Vx9aAgLQhNmo5y1zk/cDjvboaWvF3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TjvsiBjtkHtfq2awZ3DNYMHAsJN+iasBnfSb97yP2NZfsYJBba2+SQzOE2ldmGTVffAEmyxGWh1cK13tga1GiqQEr2z8NAmpPRLUWmZdGPKMZyHF5PfBu+JvtUI8WXGy0nIkqyVruD/oNN1k2ErTTo7+tOzjP78ecqVLR/KKvR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xkfiswvk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754654833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K7PR6T97DOesrUgpBgIw/sUP2uRXqCEaIUlSEoZ9FG0=;
	b=Xkfiswvk/8AoN2HhcZVephyCsQPVddD4nRnonab9JVMLVZeWbfqE5q6I+XN7dHcbK75Qft
	opobyfA6ZakgWkAH3VrhNzj8j9AT0jAvLyqBiQ7Q42y+SuClP5Xj+xtuVPhvk3MLzmpUoA
	LwOkq1sdnQvJFEMtHezXIQfxJPftMuY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-wpYLr9hLP4ewLlc2CHkF_Q-1; Fri, 08 Aug 2025 08:07:12 -0400
X-MC-Unique: wpYLr9hLP4ewLlc2CHkF_Q-1
X-Mimecast-MFC-AGG-ID: wpYLr9hLP4ewLlc2CHkF_Q_1754654831
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b79ad7b8a5so1253714f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 05:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754654831; x=1755259631;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7PR6T97DOesrUgpBgIw/sUP2uRXqCEaIUlSEoZ9FG0=;
        b=WByHjafIL+ykyxyUj9w5hDodFtjVN2XI3+TwgNA1tmqbjJaoOMfyRrcLdB8GqcZoRc
         qeJyQ6HpO8KeGAanzB4kFBvTGNSzjoi8kpli8/thyfHjW48dXsoGtplOTqrWTI9SVon+
         9ZbKIw9xcb9Uh78T2o/u2k1p1GiYp3F12FLve5P9Qhxtgy0ADq4fIyBwy439u7zj8SWC
         d6ptf3PJVl8cogLJBi+LNcR+fiumdPqA23Wfb//kSQRLo373g9g4h1nAnodVacQ7+itS
         YATDGV5zemGyWA57HyVNDDLozDykEg9Gl9afR9bYxOW5cmlg323YlhJfZpN01qIi2jca
         Na7g==
X-Forwarded-Encrypted: i=1; AJvYcCUcTnlt6c6IF0cha6SraOzOqLIlljwtr1ehbzYkc7IwFE5G1i62L1xHoOLHLDBS+82a43ydI2bg9vYJvgLW@vger.kernel.org
X-Gm-Message-State: AOJu0YyIAT0R+Ie7SK7dTPh0fkBGqGFMulE912jLQE2Ki3+sGRAiD0gI
	JNWizJ4u/XJYl+Ow4wJCKuVKJzpcHsBm249ouMwCnqlDYAQV5G/Rtjj0ou3rsE2LdpxU07R+uXp
	Ig8u2Q+K0LsdlYLqWsxq76SahKbtf2+7ikgnhzKaxpS4lFJ22mcrJL0yBwxYTltEJjpE=
X-Gm-Gg: ASbGncsP5c/8uzEwmHAnazPd7bUTyi4Cbn5Ivjyt0V+Wpt2krELfCAUcRzMFfbwCQXq
	5WSEQkU1UvOhjVvhdmCUJIUBp3Dz8rMGOnoC27z78jZMzICjVCkPQYaMZiQIkR08rQw8O6X7H99
	Ce8Fer4o9BGLC5cR8DeXuVA3+LPzDwMw1BAG96qNOCGgnpAqwSf1zokr0HPYn+z7MfVboVSVY7Y
	c+vOK83mB+/QwomVBLqdB9duLgLtM/r64emsE7103KrPRxm+NDKIrCMoQ4ORfQwuqsd+b8VAR2b
	DclN0jJwoIg5TuWos5kL6WNg24ygYKlpvYT1N/2Lewo1BKyjfhxVttO8fySPR2FFuK28e6MTsLc
	sUqZ0jp+ZrUZ0ikvsyuqQ2aVhPQ6yZJ8+/Gtvx/RDRp5/x2rFrXLEyO5HHb7TNrJ3
X-Received: by 2002:a05:6000:2484:b0:3b8:d337:cc12 with SMTP id ffacd0b85a97d-3b900b4d924mr2273661f8f.22.1754654830708;
        Fri, 08 Aug 2025 05:07:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH14f3A03P48yToZyIcUNv01ynSHfX3vD/oHZeYFhlLUXHLzUbXXwmKjcQ9PjsfRXvFv0UdEw==
X-Received: by 2002:a05:6000:2484:b0:3b8:d337:cc12 with SMTP id ffacd0b85a97d-3b900b4d924mr2273586f8f.22.1754654830032;
        Fri, 08 Aug 2025 05:07:10 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:900:2e1e:d717:2543:c4d6? (p200300d82f2509002e1ed7172543c4d6.dip0.t-ipconnect.de. [2003:d8:2f25:900:2e1e:d717:2543:c4d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47c516sm30387111f8f.62.2025.08.08.05.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 05:07:09 -0700 (PDT)
Message-ID: <b227482a-31ec-4c92-a856-bd19f72217b7@redhat.com>
Date: Fri, 8 Aug 2025 14:07:06 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/30] Live Update Orchestrator
To: Pasha Tatashin <pasha.tatashin@soleen.com>, pratyush@kernel.org,
 jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
 rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
 kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
 masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
 yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
 chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
 jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
 dan.j.williams@intel.com, joel.granados@kernel.org, rostedt@goodmis.org,
 anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
 linux@weissschuh.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org,
 cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com,
 Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
 aleksander.lobakin@intel.com, ira.weiny@intel.com,
 andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
 bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
 stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
 brauner@kernel.org, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, ajayachandra@nvidia.com,
 jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.25 03:44, Pasha Tatashin wrote:
> This series introduces the LUO, a kernel subsystem designed to
> facilitate live kernel updates with minimal downtime,
> particularly in cloud delplyoments aiming to update without fully
> disrupting running virtual machines.
> 
> This series builds upon KHO framework by adding programmatic
> control over KHO's lifecycle and leveraging KHO for persisting LUO's
> own metadata across the kexec boundary. The git branch for this series
> can be found at:
> 
> https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v3
> 
> Changelog from v2:
> - Addressed comments from Mike Rapoport and Jason Gunthorpe
> - Only one user agent (LiveupdateD) can open /dev/liveupdate
> - Release all preserved resources if /dev/liveupdate closes
>    before reboot.
> - With the above changes, sessions are not needed, and should be
>    maintained by the user-agent itself, so removed support for
>    sessions.
> - Added support for changing per-FD state (i.e. some FDs can be
>    prepared or finished before the global transition.
> - All IOCTLs now follow iommufd/fwctl extendable design.
> - Replaced locks with guards
> - Added a callback for registered subsystems to be notified
>    during boot: ops->boot().
> - Removed args from callbacks, instead use container_of() to
>    carry context specific data (see luo_selftests.c for example).
> - removed patches for luolib, they are going to be introduced in
>    a separate repository.
> 
> What is Live Update?
> Live Update is a kexec based reboot process where selected kernel
> resources (memory, file descriptors, and eventually devices) are kept
> operational or their state preserved across a kernel transition. For
> certain resources, DMA and interrupt activity might continue with
> minimal interruption during the kernel reboot.
> 
> LUO provides a framework for coordinating live updates. It features:
> State Machine: Manages the live update process through states:
> NORMAL, PREPARED, FROZEN, UPDATED.
> 
> KHO Integration:
> 
> LUO programmatically drives KHO's finalization and abort sequences.
> KHO's debugfs interface is now optional configured via
> CONFIG_KEXEC_HANDOVER_DEBUG.
> 
> LUO preserves its own metadata via KHO's kho_add_subtree and
> kho_preserve_phys() mechanisms.
> 
> Subsystem Participation: A callback API liveupdate_register_subsystem()
> allows kernel subsystems (e.g., KVM, IOMMU, VFIO, PCI) to register
> handlers for LUO events (PREPARE, FREEZE, FINISH, CANCEL) and persist a
> u64 payload via the LUO FDT.
> 
> File Descriptor Preservation: Infrastructure
> liveupdate_register_filesystem, luo_register_file, luo_retrieve_file to
> allow specific types of file descriptors (e.g., memfd, vfio) to be
> preserved and restored.
> 
> Handlers for specific file types can be registered to manage their
> preservation and restoration, storing a u64 payload in the LUO FDT.
> 
> User-space Interface:
> 
> ioctl (/dev/liveupdate): The primary control interface for
> triggering LUO state transitions (prepare, freeze, finish, cancel)
> and managing the preservation/restoration of file descriptors.
> Access requires CAP_SYS_ADMIN.
> 
> sysfs (/sys/kernel/liveupdate/state): A read-only interface for
> monitoring the current LUO state. This allows userspace services to
> track progress and coordinate actions.
> 
> Selftests: Includes kernel-side hooks and userspace selftests to
> verify core LUO functionality, particularly subsystem registration and
> basic state transitions.
> 
> LUO State Machine and Events:
> 
> NORMAL:   Default operational state.
> PREPARED: Initial preparation complete after LIVEUPDATE_PREPARE
>            event. Subsystems have saved initial state.
> FROZEN:   Final "blackout window" state after LIVEUPDATE_FREEZE
>            event, just before kexec. Workloads must be suspended.
> UPDATED:  Next kernel has booted via live update. Awaiting restoration
>            and LIVEUPDATE_FINISH.
> 
> Events:
> LIVEUPDATE_PREPARE: Prepare for reboot, serialize state.
> LIVEUPDATE_FREEZE:  Final opportunity to save state before kexec.
> LIVEUPDATE_FINISH:  Post-reboot cleanup in the next kernel.
> LIVEUPDATE_CANCEL:  Abort prepare or freeze, revert changes.
> 
> v2: https://lore.kernel.org/all/20250723144649.1696299-1-pasha.tatashin@soleen.com
> v1: https://lore.kernel.org/all/20250625231838.1897085-1-pasha.tatashin@soleen.com
> RFC v2: https://lore.kernel.org/all/20250515182322.117840-1-pasha.tatashin@soleen.com
> RFC v1: https://lore.kernel.org/all/20250320024011.2995837-1-pasha.tatashin@soleen.com
> 
> Changyuan Lyu (1):
>    kho: add interfaces to unpreserve folios and physical memory ranges
> 
> Mike Rapoport (Microsoft) (1):
>    kho: drop notifiers
> 
> Pasha Tatashin (23):
>    kho: init new_physxa->phys_bits to fix lockdep
>    kho: mm: Don't allow deferred struct page with KHO
>    kho: warn if KHO is disabled due to an error
>    kho: allow to drive kho from within kernel
>    kho: make debugfs interface optional
>    kho: don't unpreserve memory during abort
>    liveupdate: kho: move to kernel/liveupdate
>    liveupdate: luo_core: luo_ioctl: Live Update Orchestrator
>    liveupdate: luo_core: integrate with KHO
>    liveupdate: luo_subsystems: add subsystem registration
>    liveupdate: luo_subsystems: implement subsystem callbacks
>    liveupdate: luo_files: add infrastructure for FDs
>    liveupdate: luo_files: implement file systems callbacks
>    liveupdate: luo_ioctl: add userpsace interface
>    liveupdate: luo_files: luo_ioctl: Unregister all FDs on device close
>    liveupdate: luo_files: luo_ioctl: Add ioctls for per-file state
>      management
>    liveupdate: luo_sysfs: add sysfs state monitoring
>    reboot: call liveupdate_reboot() before kexec
>    kho: move kho debugfs directory to liveupdate
>    liveupdate: add selftests for subsystems un/registration
>    selftests/liveupdate: add subsystem/state tests
>    docs: add luo documentation
>    MAINTAINERS: add liveupdate entry
> 
> Pratyush Yadav (5):
>    mm: shmem: use SHMEM_F_* flags instead of VM_* flags
>    mm: shmem: allow freezing inode mapping
>    mm: shmem: export some functions to internal.h
>    luo: allow preserving memfd
>    docs: add documentation for memfd preservation via LUO

It's not clear from the description why these mm shmem changes are 
buried in this patch set. It's not even described above in the patch 
description.

I suggest sending that part out separately, so Hugh actually spots this.
(is he even CC'ed?)

-- 
Cheers,

David / dhildenb


