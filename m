Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022915230BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 12:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbiEKKfN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 06:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbiEKKfL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 06:35:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9EE6C0F6
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 03:35:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d6so1998024ede.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 03:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e9RMvdxfaUgmFv28W78x2gPvdrNxAzfKB4dqdIX05kM=;
        b=jUsxcGvMHY8GtTbYfp5So2fib+F6Jd8jOLdPWNb3IDtXLg0g+aX3UcVnd4j/fzW+Xe
         timyQuWT26SQqy3tfXt0O/l5VOUjBb3vKLQC9t7ht5dw7M6i2OZyHZCo9T9egWeAzx+Z
         SBN+JpPuwCVXUudpy7Sr5YvnYxT3/NxuCZsJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e9RMvdxfaUgmFv28W78x2gPvdrNxAzfKB4dqdIX05kM=;
        b=it0rCg/UJNvTYeuqKH+DP8K9rN/cRBpiNKI9YcqHTOCL/75ZWETwth0lrchvE+I0HO
         OazMc0UwEcCg2ugicoRZbggctWhVdv0eMHhMqx2GLebF451NnaDQl+h2DRV2uYfLEz7j
         YZa/FjK9RZLu0k95I2yc74TuVPURLnp2HWWaD5KitBPGChYuyx4cWCBbwJRMiXwmyhJS
         1TB7jAsoP5U6DQvhJzqjkIf0L+8BM5p1rZo3S/17q6xTQ3xAmba7AJSgtV5by1nSeS+s
         Qc1L2TmfyJRDBtVUSGCDPNpNcvJ8TvmbXAZxp8ynnFz6zmPHLogEawLE8ItUGN7sSGdj
         hMaA==
X-Gm-Message-State: AOAM530KIPsanI1CnBU8CCsServA9W+HlY875JEhwSdhIAhRF+JEHMAc
        D6JyUUuOvoegm83CO5D6ZpEIREEiRkBWYy+mYFkGmQ==
X-Google-Smtp-Source: ABdhPJz8rDAihlF+zRcGYP/fmKwXLVzb38QkYRUruiCxQkvF1++pZd0LH6sbiBuqtKTMi64DqlpiPIeveR0/kja2T7s=
X-Received: by 2002:a05:6402:50d1:b0:428:1473:d173 with SMTP id
 h17-20020a05640250d100b004281473d173mr27578456edb.37.1652265306607; Wed, 11
 May 2022 03:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220511013057.245827-1-dlunev@chromium.org> <CAJfpegsmyY+D4kK3ov51FLGA=RkyGDKMcYiMo2zBqYuFNs78JQ@mail.gmail.com>
 <CAONX=-dqY64VkqF6cNYvm8t-ad8XRqDhELP9icfPTPD2iLobLA@mail.gmail.com>
 <CAJfpegvUZheWb3eJwVrpBDYzwQH=zQsuq9R8mpcXb3fqzzEdiQ@mail.gmail.com> <CAONX=-cxA-tZOSo33WK9iJU61yeDX8Ct_PwOMD=5WXLYTJ-Mjg@mail.gmail.com>
In-Reply-To: <CAONX=-cxA-tZOSo33WK9iJU61yeDX8Ct_PwOMD=5WXLYTJ-Mjg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 11 May 2022 12:34:54 +0200
Message-ID: <CAJfpegsNwsWJC+x8jL6kDzYhENQQ+aUYAV9wkdpQNT-FNMXyAg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Prevent re-use of FUSE superblock after force unmount
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 11 May 2022 at 11:37, Daniil Lunev <dlunev@chromium.org> wrote:
>
> > No progress has been made in the past decade with regard to suspend.
> > I mainly put that down to lack of interest.
> >
> That is unfortunate.
>
> > It is a legitimate operation, but one that is not guaranteed to leave
> > the system in a clean state.
> Sure, I don't think I can argue about it. The current behaviour is a problem,
> however, since there is no other way to ensure the system can suspend
> reliably but force unmount - we try normal unmount first and proceed with
> force if that fails. Do you think that the approach proposed in this patchset
> is a reasonable path to mitigate the issue?

At a glance it's a gross hack.   I can think of more than one way in
which this could be achieved without adding a new field to struct
super_block.

But...  what I'd really prefer is if the underlying issue of fuse vs.
suspend was properly addressed instead of adding band-aids.  And that
takes lots more resources, for sure, and the result is not guaranteed.
But you could at least give it a try.

Thanks,
Miklos
