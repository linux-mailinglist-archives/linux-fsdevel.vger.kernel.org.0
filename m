Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C491F597E27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 07:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243271AbiHRFki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 01:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242948AbiHRFkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:40:36 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE647331D
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 22:40:34 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id l5so435595qtv.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 22:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc;
        bh=c4YN6O08AaYBNToE2Um1itfC+MNp00Kd+ydM+T0W7ko=;
        b=IZg9hsqi4ssQ7fuSUIn7+iozROcN5MvemR4pWibTfFN+hfgd52YevwqpQv+32PXVtk
         tMKwa30Shd3IsjRcMLHYaAnJfl/UHy6ihTpMO5jxCGTVmCK8t9Q/fI2uh+GiuGiPBmQT
         hK2VF/OtxMLDbC/ytFlCkss/tfpwYlp5+ZwaMpzIEC+P6HlTmxeljMnHhkBQPeC4di9d
         T2u0GkCtVLOLm6jsVJ/3uxGfDAAj5JLx6gR6GsoWNUhw61Zp1rHlGIeQeHfYiVPTdajB
         O6i+/DSqdHmANKvtofbV85bdjkpgDV6mKg5DiLTieyv2rXLbetaIRb7kxG6T1BLHQnBp
         SkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=c4YN6O08AaYBNToE2Um1itfC+MNp00Kd+ydM+T0W7ko=;
        b=qdOq6RTAhuLwLX4x0YXiX+lhA0U78VmJtERW3g8gTb4wNkH5s2p2u86h3KBkiDoqZg
         iqnYbLKQd6uK4AtlJ6/CsYuXMEyoDrd/ogUhV2PnyCh18Y63u6YXUZDEHObkU/EcEbpg
         flNR/h1061UADgA9588PQofijht1F5FSQtkUaLFc6dhTT9aMqpJUENz9sl8N7JpDCnVj
         xYyHfViSHXBCpP9zD9LWCBgJsUQyo8PKyTdF0ya1e9aNdPXxjJ7udFKPhRFwhZb0Yatw
         X25Kbh9csMuppE2TKRyvn3wLkisJb//HwEgQsuXpe+WESpdw1O5eqjSoNKgQvYr9XBdX
         M3ZA==
X-Gm-Message-State: ACgBeo2UDkSNjRX8SDpOUFOiLjZQ5nmDtyz14SJ/I4TQRwxm3b77rKL6
        NE7Y9LEq52Vtr+gy4lZNcgUBSQ==
X-Google-Smtp-Source: AA6agR4Fw98jiMqwiSkyP6cz6JD/D6jUG7NFWUxowXwEedXtNOOsMzX1sD0rCuxeyRSGmm1fcXkVkw==
X-Received: by 2002:a05:622a:1745:b0:343:5e40:47b1 with SMTP id l5-20020a05622a174500b003435e4047b1mr1310585qtk.120.1660801233516;
        Wed, 17 Aug 2022 22:40:33 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m1-20020a05620a290100b006b95f832aebsm787055qkp.96.2022.08.17.22.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 22:40:33 -0700 (PDT)
Date:   Wed, 17 Aug 2022 22:40:12 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Chao Peng <chao.p.peng@linux.intel.com>
cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
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
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
In-Reply-To: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
Message-ID: <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
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

On Wed, 6 Jul 2022, Chao Peng wrote:
> This is the v7 of this series which tries to implement the fd-based KVM
> guest private memory.

Here at last are my reluctant thoughts on this patchset.

fd-based approach for supporting KVM guest private memory: fine.

Use or abuse of memfd and shmem.c: mistaken.

memfd_create() was an excellent way to put together the initial prototype.

But since then, TDX in particular has forced an effort into preventing
(by flags, seals, notifiers) almost everything that makes it shmem/tmpfs.

Are any of the shmem.c mods useful to existing users of shmem.c? No.
Is MFD_INACCESSIBLE useful or comprehensible to memfd_create() users? No.

What use do you have for a filesystem here?  Almost none.
IIUC, what you want is an fd through which QEMU can allocate kernel
memory, selectively free that memory, and communicate fd+offset+length
to KVM.  And perhaps an interface to initialize a little of that memory
from a template (presumably copied from a real file on disk somewhere).

You don't need shmem.c or a filesystem for that!

If your memory could be swapped, that would be enough of a good reason
to make use of shmem.c: but it cannot be swapped; and although there
are some references in the mailthreads to it perhaps being swappable
in future, I get the impression that will not happen soon if ever.

If your memory could be migrated, that would be some reason to use
filesystem page cache (because page migration happens to understand
that type of memory): but it cannot be migrated.

Some of these impressions may come from earlier iterations of the
patchset (v7 looks better in several ways than v5).  I am probably
underestimating the extent to which you have taken on board other
usages beyond TDX and SEV private memory, and rightly want to serve
them all with similar interfaces: perhaps there is enough justification
for shmem there, but I don't see it.  There was mention of userfaultfd
in one link: does that provide the justification for using shmem?

I'm afraid of the special demands you may make of memory allocation
later on - surprised that huge pages are not mentioned already;
gigantic contiguous extents? secretmem removed from direct map?

Here's what I would prefer, and imagine much easier for you to maintain;
but I'm no system designer, and may be misunderstanding throughout.

QEMU gets fd from opening /dev/kvm_something, uses ioctls (or perhaps
the fallocate syscall interface itself) to allocate and free the memory,
ioctl for initializing some of it too.  KVM in control of whether that
fd can be read or written or mmap'ed or whatever, no need to prevent it
in shmem.c, no need for flags, seals, notifications to and fro because
KVM is already in control and knows the history.  If shmem actually has
value, call into it underneath - somewhat like SysV SHM, and /dev/zero
mmap, and i915/gem make use of it underneath.  If shmem has nothing to
add, just allocate and free kernel memory directly, recorded in your
own xarray.

With that /dev/kvm_something subject to access controls and LSMs -
which I cannot find for memfd_create().  Full marks for including the
MFD_INACCESSIBLE manpage update, and for Cc'ing linux-api: but I'd
have expected some doubts from that direction already.

Hugh
