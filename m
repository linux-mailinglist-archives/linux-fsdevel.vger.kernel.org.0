Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976BA52564C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 22:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358325AbiELUTk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 16:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357297AbiELUTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 16:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7029B24B58E
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 13:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652386777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pZ5QLEdjgefViyTCBuEWdUf/IkKqswKu0EJ2CtblATU=;
        b=Gwbhjx4+0nSdZUrfVUBsO4ojKE8dMToMyAFxcyYcmoY3i4DYjzevulPjIRn3hiz2PSL31E
        kurnfEoW+VX+Y1dySWpYpAa0qRld07VXIkjr9gZBKQYRokjZ8zolSNzzLoL+lloOEeRDP7
        L3jUe5+l6vJhohmYHNTg6UG6/FeDfQM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-fR4JHJ-jO6--GTa4SwQNFA-1; Thu, 12 May 2022 16:19:36 -0400
X-MC-Unique: fR4JHJ-jO6--GTa4SwQNFA-1
Received: by mail-qv1-f71.google.com with SMTP id d13-20020a05621421cd00b0045a99874ae5so5363250qvh.14
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 13:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=pZ5QLEdjgefViyTCBuEWdUf/IkKqswKu0EJ2CtblATU=;
        b=RkcMXMZS8PM2mlkBUU4EufrRP9mWdyq6eWRnqou7SZZjQH+0/ic97uQ0mlGcwO+KIK
         MAAaY6L1zPmCwPMZo/Vh71fkEAs7ePz1d/eBETeiw+WmCtPtb08mP5WwuFDoQO1j/Ck2
         pM5ON+Ag8943T+hYzMswbUEgKZvLfF19ViDsSts4eqs1c+2be2b/HgeLitVZjMZzIgzP
         djsLDFJKej/JNrxM9tY9zOv7GHH4gAqDB1kSdE2xOOFbevn5yKwNIydV3+9emgE688fN
         mE2tYlqu7OzwwsDsyyIZtU4vVvTw17MmGOgJ5iD1QvHNyIs4J23DaEJXutWWeEEbRFZS
         In+Q==
X-Gm-Message-State: AOAM5315e48FuHZGAiWuy/Q9fGGrV4VJE2Uvx7TAzD0dMMhp596aGa9x
        28uQlKQzIJJOK70DHv/vpt+gM6FgSEyt/g+RlOXJEGVsF3fZhKUtnMGF48Zt+FHDh7CxIwsvVtP
        EBRXQc9L0U+VmXV4aFQEgQ45kBQ==
X-Received: by 2002:ac8:110a:0:b0:2f1:ea84:b84 with SMTP id c10-20020ac8110a000000b002f1ea840b84mr1509882qtj.463.1652386775510;
        Thu, 12 May 2022 13:19:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg2ZAI2R8zScZa7Q5eTIHoEvTg4kfFO3r0Qno6sLBY8IpJByY63nfRHleqBmmR0uDa8qfENA==
X-Received: by 2002:ac8:110a:0:b0:2f1:ea84:b84 with SMTP id c10-20020ac8110a000000b002f1ea840b84mr1509861qtj.463.1652386775206;
        Thu, 12 May 2022 13:19:35 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i2-20020a37b802000000b0069fc13ce1eesm261431qkf.31.2022.05.12.13.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 13:19:34 -0700 (PDT)
Date:   Fri, 13 May 2022 04:19:29 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] rename & split tests
Message-ID: <20220512201929.5egujgnf66fn5yh4@zlang-mailbox>
Mail-Followup-To: Christian Brauner <brauner@kernel.org>,
        fstests <fstests@vger.kernel.org>, linux-fsdevel@vger.kernel.org
References: <20220512165250.450989-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512165250.450989-1-brauner@kernel.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 06:52:37PM +0200, Christian Brauner wrote:
> From: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> 
> Hey everyone,
> 
> Please note that this patch series contains patches that will be
> rejected by the fstests mailing list because of the amount of changes
> they contain. So tools like b4 will not be able to find the whole patch
> series on a mailing list. In case it's helpful I've added the
> "fstests.vfstest.for-next" tag which can be pulled. Otherwise it's
> possible to simply use the patch series as it appears in your inbox.

Thanks Christian! I've merged this patchset to my local testing branch, and
haven't found regressions for now. That's good to me.

Due to it *blocks* all other idmapped related patches, so if VFS (idmapped)
forks don't have objections, and if no big regressions either, I'd like to merge
this patchset at first, to free this *blocking*, then we can fix small issues
bit by bit. If anyone has review points, please point out ASAP :)

Thanks,
Zorro

> 
> All vfstests pass:
> 
> #### btrfs ####
> ubuntu@imp1-vm:~/src/git/xfstests$ sudo ./check -g idmapped
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 imp1-vm 5.18.0-rc4-fs-mnt-hold-writers-8a2e2350494f #107 SMP PREEMPT_DYNAMIC Mon May 9 12:12:34 UTC 2022
> MKFS_OPTIONS  -- /dev/sda4
> MOUNT_OPTIONS -- /dev/sda4 /mnt/scratch
> 
> btrfs/245 52s ...  54s
> generic/633 58s ...  51s
> generic/644 60s ...  49s
> generic/645 161s ...  143s
> generic/656 63s ...  55s
> Ran: btrfs/245 generic/633 generic/644 generic/645 generic/656
> Passed all 5 tests
> 
> #### ext4 ####
> ubuntu@imp1-vm:~/src/git/xfstests$ sudo ./check -g idmapped
> FSTYP         -- ext4
> PLATFORM      -- Linux/x86_64 imp1-vm 5.18.0-rc4-fs-mnt-hold-writers-8a2e2350494f #107 SMP PREEMPT_DYNAMIC Mon May 9 12:12:34 UTC 2022
> MKFS_OPTIONS  -- /dev/sda4
> MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /mnt/scratch
> 
> generic/633 47s ...  50s
> generic/644 46s ...  49s
> generic/645 135s ...  139s
> generic/656 53s ...  54s
> Ran: generic/633 generic/644 generic/645 generic/656
> Passed all 4 tests
> 
> #### xfs ####
> ubuntu@imp1-vm:~/src/git/xfstests$ sudo ./check -g idmapped
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/x86_64 imp1-vm 5.18.0-rc4-fs-mnt-hold-writers-8a2e2350494f #107 SMP PREEMPT_DYNAMIC Mon May 9 12:12:34 UTC 2022
> MKFS_OPTIONS  -- -f /dev/sda4
> MOUNT_OPTIONS -- /dev/sda4 /mnt/scratch
> 
> generic/633 58s ...  58s
> generic/644 62s ...  60s
> generic/645 161s ...  161s
> generic/656 62s ...  63s
> xfs/152 133s ...  133s
> xfs/153 94s ...  92s
> Ran: generic/633 generic/644 generic/645 generic/656 xfs/152 xfs/153
> Passed all 6 tests
> 
> /* v2 */
> * This rebases the patchset on top the for-next branch.
> * Last week we merged 858a19c5e9b0 ("idmapped_mounts: Prepare for
>   support for more features"). The patch switched feature checking from
>   a boolean to a flag. It failed convert all tests. This adds a patch to
>   fix this in patch 01/13.
> * A patch has been added to remove an invalid test. The semantics for a
>   specific corner-case where we allowed a mount's idmapping to change
>   while there were active writers will be altered.
> 
> /* v1 */
> As announced multiple times already we need to rename and split the
> idmapped mount testsuite into separate source files and also give it a
> better name to reflect the fact that it covers a lot more than just
> idmapped mounts.
> 
> I have decided against compiling different binaries for now. Instead we
> compile a single vfstest binary that can be called with various command
> line switches to run the various test suites. This is not different than
> what we did for the idmapped-mounts binary. Of course, nothing prevents
> us from using multiple binaries in the future.
> 
> Thanks!
> Christian
> 
> Christian Brauner (13):
>   idmapped-mounts: make all tests set their required feature flags
>   src: rename idmapped-mounts folder
>   src/vfs: rename idmapped-mounts.c file
>   vfstest: rename struct t_idmapped_mounts
>   utils: add missing global.h include
>   utils: add struct vfstest_info
>   utils: move helpers into utils
>   missing: move sys_execveat() to missing.h
>   utils: add struct test_suite
>   vfstests: split idmapped mount tests into separate suite
>   vfstest: split out btrfs idmapped mounts test
>   vfstest: split out remaining idmapped mount tests
>   vfs/idmapped-mounts: remove invalid test
> 
>  .gitignore                                    |     4 +-
>  common/rc                                     |    32 +-
>  src/Makefile                                  |     2 +-
>  src/detached_mounts_propagation.c             |     2 +-
>  src/feature.c                                 |     2 +-
>  src/idmapped-mounts/idmapped-mounts.c         | 14625 ----------------
>  src/idmapped-mounts/utils.c                   |   425 -
>  src/idmapped-mounts/utils.h                   |   130 -
>  src/{idmapped-mounts => vfs}/Makefile         |    14 +-
>  src/vfs/btrfs-idmapped-mounts.c               |  3854 ++++
>  src/vfs/btrfs-idmapped-mounts.h               |    15 +
>  src/vfs/idmapped-mounts.c                     |  7747 ++++++++
>  src/vfs/idmapped-mounts.h                     |    18 +
>  src/{idmapped-mounts => vfs}/missing.h        |    11 +
>  src/{idmapped-mounts => vfs}/mount-idmapped.c |     0
>  src/vfs/utils.c                               |  1050 ++
>  src/vfs/utils.h                               |   373 +
>  src/vfs/vfstest.c                             |  2073 +++
>  tests/btrfs/245                               |     2 +-
>  tests/generic/633                             |     2 +-
>  tests/generic/644                             |     2 +-
>  tests/generic/645                             |     2 +-
>  tests/generic/656                             |     2 +-
>  tests/xfs/152                                 |     4 +-
>  tests/xfs/153                                 |     2 +-
>  25 files changed, 15177 insertions(+), 15216 deletions(-)
>  delete mode 100644 src/idmapped-mounts/idmapped-mounts.c
>  delete mode 100644 src/idmapped-mounts/utils.c
>  delete mode 100644 src/idmapped-mounts/utils.h
>  rename src/{idmapped-mounts => vfs}/Makefile (59%)
>  create mode 100644 src/vfs/btrfs-idmapped-mounts.c
>  create mode 100644 src/vfs/btrfs-idmapped-mounts.h
>  create mode 100644 src/vfs/idmapped-mounts.c
>  create mode 100644 src/vfs/idmapped-mounts.h
>  rename src/{idmapped-mounts => vfs}/missing.h (93%)
>  rename src/{idmapped-mounts => vfs}/mount-idmapped.c (100%)
>  create mode 100644 src/vfs/utils.c
>  create mode 100644 src/vfs/utils.h
>  create mode 100644 src/vfs/vfstest.c
> 
> 
> base-commit: 87cf32ad3fa234e3d5ec501e0f86516bef91d805
> -- 
> 2.34.1
> 

