Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C4F505FAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 00:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiDRWTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 18:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiDRWTU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:19:20 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A65029C9D
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 15:16:39 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 79so7567053iou.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 15:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRLvii3wRAA3vQqjW9pHEytsLQcX5vHIJz2bIP/mpx4=;
        b=l6QEevJfwQF14gPbgXrbOj0DmBzybU00tiIMo0wMBNpJ+H/iRLzKkLka/OWxBkrYgP
         jFXty4kByQJE7YEw+QyAAXhwje7LxvzaYzrJgtIywhL5R4TzsPTf7ZPsfjydy2/wC9GZ
         2QtkecKsAm9gQaSrCYsu76ShmelvchXR13qLsXehL7MnXy7cab7Aq7lXUu9cx6qDOZJs
         jBzyi/MGOtDHy4WojVI5IDZQRenbCs3vX4OQ9lx931wLS3dG1FE0PZ1WP0NYBeOuMfDe
         2uIifMXWh4CLqpUfeTlSsuebHidMGk6LM7gBaGRg4MhQizsJXQXlf5b5neKLTTja+2uY
         r9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRLvii3wRAA3vQqjW9pHEytsLQcX5vHIJz2bIP/mpx4=;
        b=iSFh5U3chDimzfGdAJLmfYvTSGnBUveEdD4yXuGZXSmz/KP10JFu7rjMi9ShgyOfL+
         XW7On2ibIBLGzCfZMevIKCdRiB/x9Rouctj1C+ucMVboq4DIMUxBcY90s+aCzp4Y25Y1
         vOny90c5vCXRP8udIz72CMrF3kKoWKDBOpmv4cF5IKukww7cniGrGGcMKMoZTeYyt6ut
         upQ7hysi+cZLbY+5n2q7VkRNkGkLN0u0NbpnVee3fmoK7YfUQLXF8D2h4gs5i3HhZIRS
         GiUixR4PZ7b8oxf5zTYUAOVuJxzmX4XRsq1evhng5/y/fptxp0svBaefcBj23Wd3wWpX
         nEwQ==
X-Gm-Message-State: AOAM533qFkQyXqB/4Xf8Sl8jUCu/Mn3g4i2IpExbn73yaKeeAoOjendj
        qjdlj/+nJQF7sni19Cy2jer2jQNBuyVcdaN52RJz7g==
X-Google-Smtp-Source: ABdhPJxsJdCxOAMl+kcTMlllD0Q7WmZl5V5sQ2KLaucRT2Yn25NMbujljxWpzrlbsSukgVjL6caYOrhYQz1SG9lH/3k=
X-Received: by 2002:a05:6602:168b:b0:646:3bbb:7db4 with SMTP id
 s11-20020a056602168b00b006463bbb7db4mr5564505iow.134.1650320198599; Mon, 18
 Apr 2022 15:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220412202942.386981-1-axelrasmussen@google.com>
 <20220412202942.386981-2-axelrasmussen@google.com> <20220412134159.f0a1d0d77f5b01638007bf4b@linux-foundation.org>
In-Reply-To: <20220412134159.f0a1d0d77f5b01638007bf4b@linux-foundation.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Mon, 18 Apr 2022 15:16:02 -0700
Message-ID: <CAJHvVcj=pL8y_b_urq8QvtDvRRMmjgGkquQM6xhxWwiajNrhKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] userfaultfd: selftests: modify selftest to use /dev/userfaultfd
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for looking Andrew. And, fair criticism.

In keeping with the status quo, I'm thinking of just adding a new
command-line argument which toggles between the two modes.

But, if I'm honest, it's starting to feel like the test has way too
many arguments... I'm tempted to refactor the test to use the
kselftest framework [1], get rid of all these command line arguments,
and just always test everything. But, this seems like a big and
perhaps controversial refactor, so I may take it up after this
series...

[1]: https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html

On Tue, Apr 12, 2022 at 1:42 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 12 Apr 2022 13:29:42 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> > Prefer this new interface, but if using it fails for any reason just
> > fall back to using userfaultfd(2) as before.
>
> This seems a poor idea - the old interface will henceforth be untested.
>
> Why not tweak the code to test both interfaces?
