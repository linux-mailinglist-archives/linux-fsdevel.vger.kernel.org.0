Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A554E482F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 22:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiCVVQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 17:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiCVVQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:16:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B81DF9F
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 14:15:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 5so13745314lfp.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=trfqNpkVEV+ZEGPvxk3Z2VrndmcFkmsdgc9Q9CjCl60=;
        b=CAjQDqcxULBk7zTfFtYarhPBLBc7cHTQRJvGuAq1oTUwSLpKYYBKEK+ALZCQJAYlMg
         9P75HZgCFQfc0fPKtsouOAsUhdp0Ox8WoKm1ZJ/Ts2w6cFv68vSArZRAnk8pBQSCd7RD
         A9QZSORo9lnpfL6h6pEm95rKaNAhVOQ7e6ao0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=trfqNpkVEV+ZEGPvxk3Z2VrndmcFkmsdgc9Q9CjCl60=;
        b=sLg/F4UTLx82sT23OIpF4mA3xtyMTB9rAJ/91o4CF3h/KlRjOIs26WqgZ8VZGNSnql
         Fw98HbV5Nz7wdKb4465G1/R5jRN6OyptIizBdNqoJ/g/df34+R3g6qlmJgAT457u/MWk
         NQ8XqC8U5GD/RRo2LAkGLgdZNHvQeQLDy0+1F4ZZySG1JFSdTRvEiqFmEh4c2GnIC+Ss
         ldEXzROb4TNk8IGxGHG214uM5XGWHa5haI6q8Za+m8W2j04y8PVlHyMYLVeXcs34woZi
         FyD9enJQqoLPUykTzuW8ph7haU3HuAXJHN79+aWGj1GNwT5azGs7unf7FlMPbTYdvzjO
         jzdA==
X-Gm-Message-State: AOAM533QhoFq2HFNLXdbilc8XErgZgiuHOchCCyLiU4a4NOzV/YxrqO0
        AE3nC5G5L1hzeYW5n88r8dIFVvsKbdYy1MH9yPM=
X-Google-Smtp-Source: ABdhPJx/lmK9VELt21TgtEK/R6bXqvo3fTZpDFM3glYv8o2A1T9/UYcDqPoo8KU3qXm0GMDEgtfMhg==
X-Received: by 2002:a05:6512:2287:b0:44a:3c06:54cc with SMTP id f7-20020a056512228700b0044a3c0654ccmr3201018lfu.60.1647983726464;
        Tue, 22 Mar 2022 14:15:26 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id l4-20020a2e9084000000b00244cb29e3e4sm2585440ljg.133.2022.03.22.14.15.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 14:15:25 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id o6so25719758ljp.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 14:15:24 -0700 (PDT)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr20668386ljc.506.1647983724517; Tue, 22
 Mar 2022 14:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647894991.git.dsterba@suse.com> <CAADWXX-uX74SETx8QNnGDyBGMJHY-6wr8jC9Sjpv4ARqUca0Xw@mail.gmail.com>
 <Yjo3tQO+fNNlZ4/i@localhost.localdomain>
In-Reply-To: <Yjo3tQO+fNNlZ4/i@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Mar 2022 14:15:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtS=sNkAK+DF8Gur4q1Pb0x1DrsagJ-kJCzV9eDmAebQ@mail.gmail.com>
Message-ID: <CAHk-=wjtS=sNkAK+DF8Gur4q1Pb0x1DrsagJ-kJCzV9eDmAebQ@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 5.18
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 22, 2022 at 1:55 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> This more fine-grained checking is handled by generic_remap_file_range_prep() to
> make sure we don't try to dedup a directory or pipe or some other nonsense.

Yeah, that does seem to take care of the obvious cases, and requires
that both files be regular files at least.

I'm still not a huge fan of how we use the 'f_op->remap_file_range' of
the source file, without really checking that the destination file is
ok with remap_file_range.

They end up _superficially_ very similar, yes, but I can point to
filesystems that use different f_op's for different files.

And some of those depend on - wait for it - how the filesystem was mounted.

See for example cifs:

                if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_BRL)
                        file->f_op = &cifs_file_direct_nobrl_ops;
                else
                        file->f_op = &cifs_file_direct_ops;

so I'm just thinking "what about doing remap_file_range between two
regular files that act differently - either due to mount options or
other details".

In that cifs example, read_iter and write_iter are different. Yes,
copy/remap_file_range uses the same function pointer, but it still
worries me about copying from a mount to another if there might be
different semantics for IO between them.

I think in this cifs case, the superblock ends up being the same, so
the mnt_cifs_flags end up being the same, and the above is not
actually a real issue. But conceptually I could imagine cases where
that wasn't the case - or even cases like /proc that have
fundamentally different file operations for different files)

                 Linus
