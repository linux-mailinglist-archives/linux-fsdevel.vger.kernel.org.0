Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49016C43E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 08:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjCVHQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 03:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCVHQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:16:02 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF5B974E
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 00:16:01 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id by13so15424634vsb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 00:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679469361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8ABIxJ3Qw3X7CKOLVjafzBSl3ERwZn5jJxURWzuUG4=;
        b=LsEaibH80Br30xxco2pJXWwfc3A0oy2xUm6suu/u30qHBWFBGTRF1XgjK3KJzsCMPt
         raAIiOeO4nKgdnsXg6NpsYKfO2reNH/qTWLxlJ9FQs2nDTKynyEXOlbr2dYBZa3Rk1Ge
         hFoqfyDhtjlOtXU1111FzVzwmS1eOjFFcY2GGWLGxHLD7Xx6lgrm9lEATknIgE7Ahd8u
         iLJCmotPtPEgLoUO9fcYmGWgTUHAa8FJEWGybfLntsjwssn88UCMbx88pgBUTp2ssYqw
         f65SEOv3bAT7BY3/UmqOQ6BBosl1p4tHPvMPFV8PuxDufV3SaELn78RaqKHttVrSseUl
         kGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679469361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8ABIxJ3Qw3X7CKOLVjafzBSl3ERwZn5jJxURWzuUG4=;
        b=OP6JFkxGuaGo1OFvxgeGfcmWjerYmosnU4kYnksWen3rj0ohA658UM7mShblNpHRZJ
         RGuNOIOg5T+Rinw+oNYMTp/KcdJtkef0s6jLh5JmgO8MutE9zb1ktZkUp3rxisnsTSoz
         GW3LYfokgAZaPozzVjIu9ZCWaRlXWL7316ZZ296scRJtdaVaMm9DfI4Uu2KMsSIXUNk4
         UUX8lurIjmoT5aSCvYtsHHhW9xsTfdbMC8teGsHD3HUpy198g5oFlGXkJU5+sLnWXQvX
         NN/Ix4wA25NLmHunpFh3NXHdrnQINpBw5N7dYABYebz+fGmquapGRjhKW6r20ZQnpuXb
         NgeA==
X-Gm-Message-State: AO0yUKVHyQYkO0t3e8hYHQOSp+gbByTDTqtNgB2aWN7dvmgu5vQqiAFI
        WryDRqOfITSQtCrrR8WlxB/rXXuaaPhRKBSLor/UGVMFKb0=
X-Google-Smtp-Source: AK7set/HMQFUS8VU11hshtp9f00pEHzwfzllbsQxMZUioOUVgfVL7bCrjghCUIvgeJLEaVy4ebwnk2tHDUJmzdtyflo=
X-Received: by 2002:a67:c306:0:b0:425:d57c:bbd6 with SMTP id
 r6-20020a67c306000000b00425d57cbbd6mr3462455vsj.0.1679469360824; Wed, 22 Mar
 2023 00:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <CADNhMOuFyDv5addXDX3feKGS9edJ3nwBTBh7AB1UY+CYzrreFw@mail.gmail.com>
In-Reply-To: <CADNhMOuFyDv5addXDX3feKGS9edJ3nwBTBh7AB1UY+CYzrreFw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 22 Mar 2023 09:15:49 +0200
Message-ID: <CAOQ4uxjF=oTm8wTJvVd0swfcDP0bRUmHSwq5GATYLzvUOsQfXg@mail.gmail.com>
Subject: Re: inotify on mmap writes
To:     Amol Dixit <amoldd@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 4:13=E2=80=AFAM Amol Dixit <amoldd@gmail.com> wrote=
:
>
> Hello,
> Apologies if this has been discussed or clarified in the past.
>
> The lack of file modification notification events (inotify, fanotify)
> for mmap() regions is a big hole to anybody watching file changes from
> userspace. I can imagine atleast 2 reasons why that support may be
> lacking, perhaps there are more:
>
> 1. mmap() writeback is async (unless msync/fsync triggered) driven by
> file IO and page cache writeback mechanims, unlike write system calls
> that get funneled via the vfs layer, whih is a convenient common place
> to issue notifications. Now mm code would have to find a common ground
> with filesystem/vfs, which is messy.
>
> 2. writepages, being an address-space op is treated by each file
> system independently. If mm did not want to get involved, onus would
> be on each filesystem to make their .writepages handlers notification
> aware. This is probably also considered not worth the trouble.
>
> So my question is, notwithstanding minor hurdles (like lost events,
> hardlinks etc.), would the community like to extend inotify support
> for mmap'ed writes to files? Under configs options, would a fix on a
> per filesystem basis be an acceptable solution (I can start with say
> ext4 writepages linking back to inode/dentry and firing a
> notification)?
>
> Eventually we will have larger support across the board and
> inotify/fanotify can be a reliable tracking mechanism for
> modifications to files.
>

What is the use case?
Would it be sufficient if you had an OPEN_WRITE event?
or if OPEN event had the O_ flags as an extra info to the event?
I have a patch for the above and I personally find this information
missing from OPEN events.

Are you trying to monitor mmap() calls? write to an mmaped area?
because writepages() will get you neither of these.

Please specify the use case and we will work out what can be done
from there.

Thanks,
Amir.
