Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972CE780B56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 13:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376594AbjHRLoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 07:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376788AbjHRLoI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:44:08 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EEA421B
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 04:44:00 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so58685e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 04:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692359039; x=1692963839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIXjbiz6TK1LqDn6EHee8zioCV1ywwUJqzx0qrSWlC4=;
        b=iAgEvAVFBHQmlvfmKejtJd+tUsRv5Q9HsK1z1MMUT8NTKv+Xizhh2LRqQKLgcS6CvP
         q9n4l3qH+G3TBjQOyWSlbL2WqhenVfqETZVvzYzlL13E4O6ell/BiLzm3EOI8GxeO9st
         GIcpSvzBKsbnIVQytGOawEW0dmtHcqFqSuaNsa0HMVnp0lDpXkrUy+NVZlSnQ5UR4JrH
         j3CxKUeH/3ofKgSNls3PkLkvz7tSMFSVhQaXONFdEcLtycUAlp2uVlZMaTDbOE4vd3GZ
         ZQVGT81i1x4w/vaLKZ00Lyj94a8s1zJN2Kr4zA10d1iLrZNWKpj0mqpTJL1+Bzn9A7qJ
         /p8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692359039; x=1692963839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIXjbiz6TK1LqDn6EHee8zioCV1ywwUJqzx0qrSWlC4=;
        b=YaLANVWqwj4eWfc87a5wMvkh3jvSvGiQYR9yRTdnHV7KlrB6yHHwzJMlFMD5SOyGGL
         gtWq6swMO7AAnXvQTSGh0NTq4L9NltF1irhITIB42hRKr1BVddfbN8oqEGFax16O4vy5
         Ks4rr0tl3gP28ImGnH7dqbqLTHOcgJFgRgifzFcreUkDzwDAto5CiGkI2jfgOfGsFH85
         KEWG9n4bHHUiyCI2RDYRgfS5wKRGDNvxpGlPKZV4SjHo3Ie4BrHl4JqLriRO0CoQsAYm
         fX/PiXv8P9ZnW22cn8iBPANLujFHU7s8hmYxuqka8CgdKNZ1+tMHKVCQWsEtFJ0yYPx4
         CNKQ==
X-Gm-Message-State: AOJu0Yx+QjbsvFHD2vHeZl/JtynoUKHqx1YaLqUjS8S0XMf12NBMsMRP
        RQssTk8Mq30M+0M4LO6VXLKDMt6l39j3HDMaPJXEUA==
X-Google-Smtp-Source: AGHT+IGvpCUj333BWxhvbZecJ7Q1XwDtFX6G7nOkCGTQf/F8EMz3zoGP8dovzTUAoHcPtkSAUWXb/iozmJw80waQMYM=
X-Received: by 2002:a05:600c:3b0c:b0:3fd:e47:39c7 with SMTP id
 m12-20020a05600c3b0c00b003fd0e4739c7mr89946wms.4.1692359038988; Fri, 18 Aug
 2023 04:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000530e0d060312199e@google.com> <20230817142103.GA2247938@mit.edu>
 <CANp29Y7jbcOw_rS5vbfWNo7Y+ySYhYS-AWC356QN=JRVOm9B8w@mail.gmail.com> <20230817144505.GB2247938@mit.edu>
In-Reply-To: <20230817144505.GB2247938@mit.edu>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 18 Aug 2023 13:43:45 +0200
Message-ID: <CANp29Y4HGnp6LJ7jw2hrXNFd7S4+MKfjdpjOGZALUuGK1L3wPA@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] kernel panic: EXT4-fs (device loop0): panic
 forced after error (3)
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     syzbot <syzbot+27eece6916b914a49ce7@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've taken a closer look at the issue.

Documentation/filesystems/ext4.txt says that the "errors=3D" mount
parameter "override the errors behavior specified in the superblock".
So syzbot can prevent it by passing "errors=3Dcontinue" as a mount
argument and there's no need to filter out such reports.

Syzkaller actually already does that in the C reproducer. It just
seems that this time the tool has mutated the mount options so much
that the simple patching no longer worked (most likely because of \0
characters in between). I'll update the syz_mount_image() code.


On Thu, Aug 17, 2023 at 4:45=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Thu, Aug 17, 2023 at 04:28:33PM +0200, Aleksandr Nogikh wrote:
> > The console log has the following line:
> >
> > [   60.708717][ T5061] Kernel panic - not syncing: EXT4-fs (device
> > loop0): panic forced after error
> >
> > Can we consider a "panic forced after error" line to be a reliable
> > indicator that syzbot must ignore the report?
>
> Yes.  And the file system image that generated this bug should be
> discarded, because otherwise successive mutations will generate a
> large number of crashes that syzbot will then need to ignore, thus
> consuming syzbot resources.
>
> Alternatively, you can do the moral equivalent of "tune2fs -e continue
> foo.img" on any mutated file system seed, which will clear the "panic
> on error".
>
> (The other alternative is "tune2fs -e remount-ro", but given syzbot's
> desire to find kernel crashes, "tune2fs -e continue" is more likely
> find ways in which the kernel will find itself into trouble.  Some
> sysadmins will want to chose "remount-ro", however, since that is more
> likely to limit file system damage once the file system is discovered
> to be corrupted.)
>
>                                         - Ted
>
