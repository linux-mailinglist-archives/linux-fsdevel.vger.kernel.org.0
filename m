Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1E76D2BF0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Apr 2023 01:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjCaX5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 19:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjCaX4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 19:56:47 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7F91EFF0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 16:56:16 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id e14-20020a056a00162e00b0062804a7a79bso11244028pfc.23
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 16:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680306972;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sG6q4pkZb1PQl0aPgzbGY4ON8LGmvMRz4r7etWkMq4s=;
        b=WIuiZiUmBrkp2YhuCurDCgSkBZEc7Z5OqkyPiskiC1yk+Wn7xr3OVMZ6bTJT2jChGU
         gYB3NqXz1dSf2AK0Vo7H04PmxQ2u6f2sPigBZplbEjbqCCL6kOJu6i9T+PAkceBzrlJK
         WdiA7iiJbAefAXUQlwEUCSWtlz4NyYo/TCW/dIFBgPN/OjRvLI9C9dzcKG2rYvPRaJgR
         eledUJCSJqGBcVI+cf/4W7IKSTdWIRYbNu9Q8zMLaAw28LCuE9DmDJwYjnijOfTNWhW2
         /dZLVFsSEyDqcwzoQeov9nRjWgfWRhWwoN1voUhGP/RLTxMxylIl+dFWMDFWmYA60zlX
         wzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680306972;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sG6q4pkZb1PQl0aPgzbGY4ON8LGmvMRz4r7etWkMq4s=;
        b=ZfIRA17FC/O53S17FnylBbfkooZByMLKVNFwIupcZQ0JVnMATsVBYI6Dk3h9Sw4kb7
         fY0zAYmbpTSxz0t+43KjsPpgnODeqE0e3FC2gAqVCXf8o0qN8mwZ5PVmfvR9VvP2MpoW
         8BH5FqkXQl2xVX8Ui7HKB6osgvMZLxzB6iOKYZXpL2h27a9I7RabMBoUolEuAD52BNSZ
         XkaO/JUUiPlS+wmoX2DyH+NyJ3Cj/VbAIzgWMliVbQhtRGJS8aHpFu9YcRz/mUm3EVGA
         1TGryV/vTva/E/4VOv5guoC7yy62Xzco5tbkVKOxRXHy+tJquYs1tymfg7pUOPhpb8Zd
         9Jlw==
X-Gm-Message-State: AAQBX9duKObiycUtEjvE3FkLZY5v392goqXO2u3MbwN8uhUiEndqiFPQ
        mIhhy+tuqxQI76O6/6cw2euD6/crHtp3EGBoxw==
X-Google-Smtp-Source: AKy350bwo4gDmt6qvVmklscGtMe+0GABAuLYyXXB8b22LaSZK6d4xB1fPVTRAuoUYPissJnWP1PA7ngfyjHOn7h8gg==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a63:c042:0:b0:513:1281:2796 with SMTP
 id z2-20020a63c042000000b0051312812796mr8266653pgi.11.1680306971953; Fri, 31
 Mar 2023 16:56:11 -0700 (PDT)
Date:   Fri, 31 Mar 2023 23:56:10 +0000
In-Reply-To: <20230322111951.vfrm2xf4o5kmtte6@wittgenstein> (message from
 Christian Brauner on Wed, 22 Mar 2023 12:19:51 +0100)
Mime-Version: 1.0
Message-ID: <diqzmt3sqxut.fsf@ackerleytng-cloudtop.c.googlers.com>
Subject: Re: [RFC PATCH v2 1/2] mm: restrictedmem: Allow userspace to specify
 mount for memfd_restricted
From:   Ackerley Tng <ackerleytng@google.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org, aarcange@redhat.com,
        ak@linux.intel.com, akpm@linux-foundation.org, arnd@arndb.de,
        bfields@fieldses.org, bp@alien8.de, chao.p.peng@linux.intel.com,
        corbet@lwn.net, dave.hansen@intel.com, david@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com, hpa@zytor.com,
        hughd@google.com, jlayton@kernel.org, jmattson@google.com,
        joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:

> On Tue, Mar 21, 2023 at 08:15:32PM +0000, Ackerley Tng wrote:
>> By default, the backing shmem file for a restrictedmem fd is created
>> on shmem's kernel space mount.

>> ...

Thanks for reviewing this patch!


> This looks like you can just pass in some tmpfs fd and you just use it
> to identify the mnt and then you create a restricted memfd area in that
> instance. So if I did:

> mount -t tmpfs tmpfs /mnt
> mknod /mnt/bla c 0 0
> fd = open("/mnt/bla")
> memfd_restricted(fd)

> then it would create a memfd restricted entry in the tmpfs instance
> using the arbitrary dummy device node to infer the tmpfs instance.

> Looking at the older thread briefly and the cover letter. Afaict, the
> new mount api shouldn't figure into the design of this. fsopen() returns
> fds referencing a VFS-internal fs_context object. They can't be used to
> create or lookup files or identify mounts. The mount doesn't exist at
> that time. Not even a superblock might exist at the time before
> fsconfig(FSCONFIG_CMD_CREATE).

> When fsmount() is called after superblock setup then it's similar to any
> other fd from open() or open_tree() or whatever (glossing over some
> details that are irrelevant here). Difference is that open_tree() and
> fsmount() would refer to the root of a mount.

This is correct, memfd_restricted() needs an fd returned from fsmount()
and not fsopen(). Usage examples of this new parameter in
memfd_restricted() are available in selftests.


> At first I wondered why this doesn't just use standard *at() semantics
> but I guess the restricted memfd is unlinked and doesn't show up in the
> tmpfs instance.

> So if you go down that route then I would suggest to enforce that the
> provided fd refer to the root of a tmpfs mount. IOW, it can't just be an
> arbitrary file descriptor in a tmpfs instance. That seems cleaner to me:

> sb = f_path->mnt->mnt_sb;
> sb->s_magic == TMPFS_MAGIC && f_path->mnt->mnt_root == sb->s_root

> and has much tigher semantics than just allowing any kind of fd.

Thanks for your suggestion, I've tightened the semantics as you
suggested. memfd_restricted() now only accepts fds representing the root
of the mount.


> Another wrinkly I find odd but that's for you to judge is that this
> bypasses the permission model of the tmpfs instance. IOW, as long as you
> have a handle to the root of a tmpfs mount you can just create
> restricted memfds in there. So if I provided a completely sandboxed
> service - running in a user namespace or whatever - with an fd to the
> host's tmpfs instance they can just create restricted memfds in there no
> questions asked.

> Maybe that's fine but it's certainly something to spell out and think
> about the implications.

Thanks for pointing this out! I added a permissions check in RFC v3, and
clarified the permissions model (please see patch 1 of 2):
https://lore.kernel.org/lkml/cover.1680306489.git.ackerleytng@google.com/
