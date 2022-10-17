Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4C36008B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 10:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJQIbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 04:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJQIbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:31:19 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FC32099A
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 01:31:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r14so16389571lfm.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 01:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8KsRspEgB/gOfpXeMit48jsmBa9u2K7sMr+wCGZ90pU=;
        b=iXrGdd8Ce/D/Ym1P/AKmDjhkCRodIz0sVHqhCXCbzz/70S2w/xiwhFMs2ZE6LzAOaY
         kerpA8DKLp8h2EYJv/OamQ96cNwCdVwhlMsEt2I/Fx1TXldfIxx8y8EdnjfTih1j5QQY
         mcontV8hQeGs5ML1x0iwjYx4oVH0ravWrBbKL8nhqpsejuYizWkrN/Z0xocIgE9V/nqA
         /ibMQ5BBiN6XVdPz/bWMDfcoSg3yAyVOTjHlVwPDjsYICQVyEKqxZha6l63hzWMq89fQ
         ikDz03AXZbI54WZYRpIVuo0JGyUqwrFqZ1lSI9F+0vgKA6aqXG/1CN3roD6DwyasNLJq
         0f1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KsRspEgB/gOfpXeMit48jsmBa9u2K7sMr+wCGZ90pU=;
        b=GUxQ9JCpuY0q39aYoLAQ3bYpGW7tJEwOxz84BgzB90N0U73UkeAb7+aXQjBd/k851m
         Fj5ENnSxEqjbM+fJa7YJO69FQ09Jth6gG5VTz5qr/iYQ7b/2OOtZvNbFPSn2OV0RnKDu
         i+b2ELAfZGpc0ppT09jn4rmDgVa9erSTBQsouLRd/z3hHDsDujrzzpkzi6XvJvkHRK0M
         oHS7Zuby8C5CMfWsEqCLDqvLptM6D8W+82Nxl4c4LBeVSET8PVPfS0RQ+bM0Hj6EbL4f
         OnNKgqPCcURTJz20sBNZo4RbI3SW1uOTqrHajv08Pmt5eZ+L+qn2Gxc2oicCy7zgCrEB
         2tmQ==
X-Gm-Message-State: ACrzQf0DptE3Fbf3BfMIZmjMeZM6kguggqnuCY9CkA8/q/ackgDJmpth
        AaVtVb1Un+heNwLTj56f6VV3OWbjWM3ikq/VaFbLCw==
X-Google-Smtp-Source: AMsMyM4vtxZKfG1BBKlWVvUdtQPv/C1LzAh0hWbLTBbJjcAgFk5XHPxnZIEqc8SnpuZmZ0z0x8oPZB51ly6T8M4BxPI=
X-Received: by 2002:a05:6512:358c:b0:4a2:9c55:c63c with SMTP id
 m12-20020a056512358c00b004a29c55c63cmr3765865lfr.598.1665995475449; Mon, 17
 Oct 2022 01:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221014084837.1787196-1-hrkanabar@gmail.com> <20221014091503.GA13389@twin.jikos.cz>
In-Reply-To: <20221014091503.GA13389@twin.jikos.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 Oct 2022 10:31:03 +0200
Message-ID: <CACT4Y+as3SA6C_QFLSeb5JYY30O1oGAh-FVMLCS2NrNahycSoQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/7] fs: Debug config option to disable filesystem
 checksum verification for fuzzing
To:     dsterba@suse.cz
Cc:     Hrutvik Kanabar <hrkanabar@gmail.com>,
        Hrutvik Kanabar <hrutvik@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        kasan-dev@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 14 Oct 2022 at 11:15, David Sterba <dsterba@suse.cz> wrote:
>
> On Fri, Oct 14, 2022 at 08:48:30AM +0000, Hrutvik Kanabar wrote:
> > From: Hrutvik Kanabar <hrutvik@google.com>
> >
> > Fuzzing is a proven technique to discover exploitable bugs in the Linux
> > kernel. But fuzzing filesystems is tricky: highly structured disk images
> > use redundant checksums to verify data integrity. Therefore,
> > randomly-mutated images are quickly rejected as corrupt, testing only
> > error-handling code effectively.
> >
> > The Janus [1] and Hydra [2] projects probe filesystem code deeply by
> > correcting checksums after mutation. But their ad-hoc
> > checksum-correcting code supports only a few filesystems, and it is
> > difficult to support new ones - requiring significant duplication of
> > filesystem logic which must also be kept in sync with upstream changes.
> > Corrected checksums cannot be guaranteed to be valid, and reusing this
> > code across different fuzzing frameworks is non-trivial.
> >
> > Instead, this RFC suggests a config option:
> > `DISABLE_FS_CSUM_VERIFICATION`. When it is enabled, all filesystems
> > should bypass redundant checksum verification, proceeding as if
> > checksums are valid. Setting of checksums should be unaffected. Mutated
> > images will no longer be rejected due to invalid checksums, allowing
> > testing of deeper code paths. Though some filesystems implement their
> > own flags to disable some checksums, this option should instead disable
> > all checksums for all filesystems uniformly. Critically, any bugs found
> > remain reproducible on production systems: redundant checksums in
> > mutated images can be fixed up to satisfy verification.
> >
> > The patches below suggest a potential implementation for a few
> > filesystems, though we may have missed some checksums. The option
> > requires `DEBUG_KERNEL` and is not intended for production systems.
> >
> > The first user of the option would be syzbot. We ran preliminary local
> > syzkaller tests to compare behaviour with and without these patches.
> > With the patches, we found a 19% increase in coverage, as well as many
> > new crash types and increases in the total number of crashes:
>
> I think the build-time option inflexible, but I see the point when
> you're testing several filesystems that it's one place to set up the
> environment. Alternatively I suggest to add sysfs knob available in
> debuging builds to enable/disable checksum verification per filesystem.

Hi David,

What usage scenarios do you have in mind for runtime changing of this option?
I see this option intended only for very narrow use cases which
require a specially built kernel in a number of other ways (lots of
which are not tunable at runtime, e.g. debugging configs).

> As this may not fit to other filesystems I don't suggest to do that for
> all but I am willing to do that for btrfs, with eventual extension to
> the config option you propose. The increased fuzzing coverage would be
> good to have.
