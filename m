Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35C64D4492
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 11:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbiCJK3A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 05:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiCJK26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:28:58 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEF81390FD
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 02:27:57 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id x4so5852316iom.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 02:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/TvTwTRE5ZLnuOuX6FmvE7twzPbdAnz0gt379FQSjM=;
        b=ZG7BKAH0cDR9Ezst+s2IovF6T9rCTxg1K2QOd7Y/2G+6aKtgE+wU3rDnk26DUQJVp+
         NlRnipPaxVJj74a1wOcxmGerVkypJtH/RxTcouma0ZFoD0nFDLuMkHyE/W4e9acshD2q
         5loYWVXWygw+qwAdMm5j5sBMgQUAVw3RHsLW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/TvTwTRE5ZLnuOuX6FmvE7twzPbdAnz0gt379FQSjM=;
        b=ihqP10aX5vnGODzxT0DAbf9rU52ChtAFsCLq4L3DPnouy6aZ0qkHi3mIdxGnQhpqDG
         91X9XCRzZGD/nvJZOGYbziFeHuuB+Q7NxkHkn7jZjNflo+L2TqGlHAiK8UECCDqAief/
         +JwjZ7XDaBCcgQ/6L0Y8oAlSrI+TFs5OEeif5oK4P+ZbnZEbCX+PeqUVd2Qpsm63WO0q
         GDZ68EFdSzAJwqqrQgfVUxbd4mVKOHWWOrskB5dnc1XpXnGGBPRZP3/lh8k6cgeovm8T
         URDmKwCBtK3UKMHWUBWwFVHerf1u1ARydtmzZB6kW1hg2SXDwBVRxQifYfBMP2i5pPlf
         YOzg==
X-Gm-Message-State: AOAM533ippg0GUxcz/8S9dNlfELmgsJFYG9noA1Im3Xzyf1xtxysHLZU
        wbuQO6aKiC/rZrocwnYx1IaGpTP2SMKGxF5eh0EStw==
X-Google-Smtp-Source: ABdhPJzdE1Ar/Z1/NhsDqf43Wfdc5EFZaml3NQ53CEZWS74q/uC2laNDDFLN7yij2ZB0BGN9GQP/B5b/7wX00uSrkvs=
X-Received: by 2002:a05:6638:3049:b0:317:9a63:ec26 with SMTP id
 u9-20020a056638304900b003179a63ec26mr3378628jak.273.1646908077073; Thu, 10
 Mar 2022 02:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20220302171816.1170782-1-kvigor@gmail.com> <20220302171816.1170782-2-kvigor@gmail.com>
In-Reply-To: <20220302171816.1170782-2-kvigor@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 10 Mar 2022 11:27:45 +0100
Message-ID: <CAJfpegvpKKO-dFg7P8fERq5-BcQSC7uh2cYzz-Ufo7wHvnvv9g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] FUSE: Add FUSE_TRUST_MAX_RA flag enabling
 readahead settings >128KB.
To:     Kevin Vigor <kvigor@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2 Mar 2022 at 18:18, Kevin Vigor <kvigor@gmail.com> wrote:
>
> The existing process_init_reply() in fs/fuse/inode.c sets the ra_pages
> value to the minimum of the max_readahead value provided by the user
> and the pre-existing ra_pages value, which is initialized to
> VM_READAHEAD_PAGES. This makes it impossible to increase the readahead
> value to larger values.
>
> Add a new flag which causes us to blindly accept the user-provided
> value. Note that the existing read_ahead_kb sysfs entry for normal
> block devices does the same (simply accepts user-provided values
> directly with no checks).

read_ahead_kb only allows root to open for write.  Allowing non-root
arbitrary read ahead window size is not a good idea, IMO.

Thanks,
Miklos
