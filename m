Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9B96A003C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Feb 2023 01:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjBWAzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Feb 2023 19:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjBWAzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:55:20 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417933772C
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 16:55:18 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536cad819c7so89487787b3.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 16:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3azLqXR2vSKV5L2PaJh+3T6s1vBztgHEFOD2woEyPYw=;
        b=ll/kgw4EhN1QBjkzhFZB0Ail1ORJy+AyUBj3Zon2zA6YZR6bvv6MRVw4xL88tq8Az8
         UNfJYuIlxPRqkMZxma4EfhQVLDz+WB3n7N3GgnS6/N71B9VGL9L1wJxicWIzPEsnhNbY
         jwqQtYqGUwQCJ7O/Ie7nc1bEP4GmGEJpB8DCFusadZrYSFRLnQZARIT1I0plRhGyCTgj
         klqga5wY1X/qhy0ohB1y16mctfilFHsYR3l8CX6UQd0Ok2HUyZRCt5JjEmEyFz3N4ySp
         AUxoMU/xS8Z5QEE7WS4WTYYb6USgkUVSpxiH8hOE9if2xvRinxF+p0VrjEGBhDPd5C7e
         03hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3azLqXR2vSKV5L2PaJh+3T6s1vBztgHEFOD2woEyPYw=;
        b=24DmZ2f1PzUVo2Ti2xRiL21KpPBMOUfg1djrwtAg9SrL7YVGw8Ynm5YHTIDuMJq5aU
         4ZVaFsjO0/xY/D+nHrHYs2h7BJpy1vDeOg5YzIqX2YxWzmQRoSp9gwpcmNJ5KS3RLBI2
         SoZcPl3SH3GpHYEjGXgrWsmZZOhq4CqlvfoPihkQDlhDCd8woxyVboLR0fJAs4MToT43
         aPP6WhOkvVKTn4y8fcAmXPixX5wz9Wq08dAfcCR2mEzQGokJWAoJnQzdnHr0MRZsRktU
         q74/+2eo/q9XkshOweoYo8fKysvJ3F5to63i88XuklwEgl88ed6GMOqHPGoGR4mFNFJg
         LglQ==
X-Gm-Message-State: AO0yUKWBXwjgw7z86xnKFdyRifdDmz+yfNALwN1tzPsiEdCBcRSnY5Di
        QckniFLelSunjVh50jRTraOXfxj8kLlBDNDQpg==
X-Google-Smtp-Source: AK7set/bRW8kyMySNfR/6zy0z0kR68DNc8Wiwl2R9ueq8c35MSB8zjbIqdtnOK6awXZtxDJCM5SBJnFOM9ODRuSA8Q==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:1028:b0:a27:3ecd:6 with SMTP
 id x8-20020a056902102800b00a273ecd0006mr761629ybt.1.1677113717462; Wed, 22
 Feb 2023 16:55:17 -0800 (PST)
Date:   Thu, 23 Feb 2023 00:55:16 +0000
In-Reply-To: <20230216100150.yv2ehwrdcfzbdhcq@box.shutemov.name> (kirill@shutemov.name)
Mime-Version: 1.0
Message-ID: <diqzsfex5hfv.fsf@ackerleytng-cloudtop.c.googlers.com>
Subject: Re: [RFC PATCH 1/2] mm: restrictedmem: Allow userspace to specify
 mount_path for memfd_restricted
From:   Ackerley Tng <ackerleytng@google.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org,
        chao.p.peng@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, akpm@linux-foundation.org, arnd@arndb.de,
        bfields@fieldses.org, bp@alien8.de, corbet@lwn.net,
        dave.hansen@intel.com, david@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, hpa@zytor.com, hughd@google.com,
        jlayton@kernel.org, jmattson@google.com, joro@8bytes.org,
        jun.nakajima@intel.com, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, luto@kernel.org, mail@maciej.szmigiero.name,
        mhocko@suse.com, michael.roth@amd.com, mingo@redhat.com,
        naoya.horiguchi@nec.com, pbonzini@redhat.com, qperret@google.com,
        rppt@kernel.org, seanjc@google.com, shuah@kernel.org,
        steven.price@arm.com, tabba@google.com, tglx@linutronix.de,
        vannapurve@google.com, vbabka@suse.cz, vkuznets@redhat.com,
        wanpengli@tencent.com, wei.w.wang@intel.com, x86@kernel.org,
        yu.c.zhang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


"Kirill A. Shutemov" <kirill@shutemov.name> writes:

> On Thu, Feb 16, 2023 at 12:41:16AM +0000, Ackerley Tng wrote:
>> By default, the backing shmem file for a restrictedmem fd is created
>> on shmem's kernel space mount.

>> With this patch, an optional tmpfs mount can be specified, which will
>> be used as the mountpoint for backing the shmem file associated with a
>> restrictedmem fd.

>> This change is modeled after how sys_open() can create an unnamed
>> temporary file in a given directory with O_TMPFILE.

>> This will help restrictedmem fds inherit the properties of the
>> provided tmpfs mounts, for example, hugepage allocation hints, NUMA
>> binding hints, etc.

>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>   include/linux/syscalls.h           |  2 +-
>>   include/uapi/linux/restrictedmem.h |  8 ++++
>>   mm/restrictedmem.c                 | 63 +++++++++++++++++++++++++++---
>>   3 files changed, 66 insertions(+), 7 deletions(-)
>>   create mode 100644 include/uapi/linux/restrictedmem.h

>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> index f9e9e0c820c5..4b8efe9a8680 100644
>> --- a/include/linux/syscalls.h
>> +++ b/include/linux/syscalls.h
>> @@ -1056,7 +1056,7 @@ asmlinkage long sys_memfd_secret(unsigned int  
>> flags);
>>   asmlinkage long sys_set_mempolicy_home_node(unsigned long start,  
>> unsigned long len,
>>   					    unsigned long home_node,
>>   					    unsigned long flags);
>> -asmlinkage long sys_memfd_restricted(unsigned int flags);
>> +asmlinkage long sys_memfd_restricted(unsigned int flags, const char  
>> __user *mount_path);

>>   /*
>>    * Architecture-specific system calls

> I'm not sure what the right practice now: do we provide string that
> contains mount path or fd that represents the filesystem (returned from
> fsmount(2) or open_tree(2)).

> fd seems more flexible: it allows to specify unbind mounts.

I tried out the suggestion of passing fds to memfd_restricted() instead
of strings.

One benefit I see of using fds is interface uniformity: it feels more
aligned with other syscalls like fsopen(), fsconfig(), and fsmount() in
terms of using and passing around fds.

Other than being able to use a mount without a path attached to the
mount, are there any other benefits of using fds over using the path string?

Should I post the patches that allows specifying a mount using fds?
Should I post them as a separate RFC, or as a new revision to this RFC?
