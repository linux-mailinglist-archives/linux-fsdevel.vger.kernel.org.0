Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D810B4CE9ED
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 08:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiCFH4z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Mar 2022 02:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiCFH4y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 02:56:54 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B982D50B22;
        Sat,  5 Mar 2022 23:56:01 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id ay7so12179015oib.8;
        Sat, 05 Mar 2022 23:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VqwqdOtBO5lTcgjpRhFJK1zCFBnLPUcQnpstSDT1zbw=;
        b=StzwVolEsV86a+lFM6W92PVvxWExTcVntUlb+mtJgrGCtK3BXdkoLBXblnabrFlmr2
         /I7iVPB4QmADByqFfzVgIRPqjETAkgzY52TqTcLU/4xlSFFEAdBr18nvfyGtvEbzgzi4
         3K2QXxGFlImvvqBhSAOqkiyE2+TmNVG2nn2cVwVCQRgbCxhMBWfWzhfbqhUhau+M0ox5
         iBKy1zJ6Zm8GNS7EgJ6xaM/aH9iGNnBlqcH/uQ5t4VmfOZ22GgCQqkeCgUkoSkBo4IFr
         TvjplloETBJioPzWP1wfKKZdzSNzAIVgeLEq/brPGMeNOTbcgKGLUKiysnH02ba7763U
         ByYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VqwqdOtBO5lTcgjpRhFJK1zCFBnLPUcQnpstSDT1zbw=;
        b=Hpg0RmQ7G3bvx6NTVtvBHyoOVA9nuUM3Uq9juyKPXtYLoBREaDLKsdwzdyQv5TtTcd
         /nsLWg1vFMM+MjYW2c44M5I4/fJ3/hPP3eboiFOUOHRFXQmWxbnomS7coUzFF/B4A7zy
         j7WpyKFZmIHe2I1lA6KhcLH8l2piHYcx6HRbPA9qWEFLe6rLMroYRFEA6m/6M1Th6hAP
         wqVvfwulXHlsyVzC4Sn8tWlUuR1F0XZCnsGj7it0pwut3rp5NPzJqA0QoDggyBz7a6an
         zNpG8EP8sNILDiuWE7indqa0LF+O21LxVE4kW5boAEN/CXbUxu2AdX5K6b3JsJSYUfay
         50yA==
X-Gm-Message-State: AOAM530lY4VFM6xLqz+cyKW3pz8pal7+cw37MY2n9vBH5ps8z6wFgzO7
        vPRFnyb7a6ePpQUUfBEYN0MuL5MuEZdiNJS0fV7PTKUQKiA=
X-Google-Smtp-Source: ABdhPJw/bL9Y4AVwe5ELRBU6Me0VJgB9AGbxnYwg9zqCDC+BAAodez5S5jSdCsZXU0AK9iUtIJMVdv1AxseWxTt7aBk=
X-Received: by 2002:aca:b845:0:b0:2d4:4207:8fd5 with SMTP id
 i66-20020acab845000000b002d442078fd5mr14422804oif.98.1646553361087; Sat, 05
 Mar 2022 23:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20220305160424.1040102-1-amir73il@gmail.com> <YiQ2Gi8umX9LQBWr@mit.edu>
In-Reply-To: <YiQ2Gi8umX9LQBWr@mit.edu>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 6 Mar 2022 09:55:49 +0200
Message-ID: <CAOQ4uxhtB=EcXoVBOGEo8dXAzSxkPi2XubNWHUBHE1VKRdrxpg@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Generic per-sb io stats
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 6, 2022 at 6:18 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Sat, Mar 05, 2022 at 06:04:15PM +0200, Amir Goldstein wrote:
> >
> > Dave Chinner asked why the io stats should not be enabled for all
> > filesystems.  That change seems too bold for me so instead, I included
> > an extra patch to auto-enable per-sb io stats for blockdev filesystems.
>
> Perhaps something to consider is allowing users to be able to enable
> or disable I/O stats on per mount basis?
>
> Consider if a potential future user of this feature has servers with
> one or two 256-core AMD Epyc chip, and suppose that they have a
> several thousand iSCSI mounted file systems containing various
> software packages for use by Kubernetes jobs.  (Or even several
> thousand mounted overlay file systems.....)
>
> The size of the percpu counter is going to be *big* on a large CPU
> count machine, and the iostats structure has 5 of these per-cpu
> counters, so if you have one for every single mounted file system,
> even if the CPU slowdown isn't significant, the non-swappable kernel
> memory overhead might be quite large.
>
> So maybe a VFS-level mount option, say, "iostats" and "noiostats", and
> some kind of global option indicating whether the default should be
> iostats being enabled or disabled?  Bonus points if iostats can be
> enabled or disabled after the initial mount via remount operation.
>
> I could imagine some people only being interested to enable iostats on
> certain file systems, or certain classes of block devices --- so they
> might want it enabled on some ext4 file systems which are attached to
> physical devices, but not on the N thousand iSCSI or nbd mounts that
> are also happen to be using ext4.
>

Those were my thoughts as well.

As a matter of fact, I started to have a go at implementing
"iostats"/"noiostats"
and then I realized I have no clue how the designers of the new mount option
parser API intended that new generic mount options like these would be added,
so I ended up reusing SB_MAND_LOCK for the test patch.

Was I supposed to extend struct fs_context fields sb_flags/sb_flags_mask to
unsigned long and add new common SB_ flags to high 32 bits, which can only
be set via fsopen()/fsconfig() on a 64bit arch?

Or did the designers have something completely different in mind?

Perhaps the scope of the new mount API was never to deal with running out of
space for common SB_ flags?

Thanks,
Amir.
