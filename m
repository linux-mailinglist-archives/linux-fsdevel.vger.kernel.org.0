Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC0D3D821D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 23:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhG0VvE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 17:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhG0VvE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:51:04 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFFAC061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jul 2021 14:51:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u3so24312234lff.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jul 2021 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GJDqmdaLtkaW7Otz+OuKF+u9n9yLDONH7a1pUz+R4g=;
        b=vU99ZBKDzMVUNqf5sfsmKOTh7f/nFBljme/8vZdWEh6VMl+6pjjr+Fh1/llaa1Tmu6
         E9e293cJN6TpD5hWLPrX7NX8k8plP1ci4gLMwOoW9HRfOhn/zBJTz95wIGo8wmUwy72t
         Q8tIijJECxZZ/W7XHUlaS1CYRF5ZbobafO8eG4ZXzbODrSoQrWT+KHtcnPJ+eTgQiKCN
         PGhFkiev0aEVZ+yPmByqlCAKbem3VGZ8EI60BhFe7uveUqq3jRNUoMwJTeq236JUuDip
         Qoxh+xV/V4nysMXdXY/TVCpkHGqeXFqXWYC3SFsVAGOZZIfMsH+Nw6n2bnmPy0sihGCH
         GWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GJDqmdaLtkaW7Otz+OuKF+u9n9yLDONH7a1pUz+R4g=;
        b=qfrYR/Ffv0zkFCiyLbcAa7IedzIZ1nO5w1Fryooq102QfpI5oEPV7U73S0RCesj6Mx
         jb5LmEWjTmZe+vFj57GkObrA4DMmKUhxrlgqeLWB23mxmO003BxTOCGvtr+v5APaaMp2
         ussQQKu+JlNeBHsgREBlyzFp6cy1PIX0JkxNRa/KLnhseILGlP9JugA6uola1l12fZO6
         FtOiYNxWQ+bRBreNUoVtlEjNDZBrTk71Q4NXof8dDZ3brWBmocFCuLrVB1k6iIvd98Nz
         vypTuUEov83KslIEp8KLuwFYFdU6BsB3iaYwi8KPXnZfHHFzEwiBa33teRrBhzz3Nvbt
         v4CQ==
X-Gm-Message-State: AOAM532bZhY7IXSJLZCEW2EN08ejyD1MhaFudhy/YyK2hh6y0hyRqD18
        DnGy0ZZUagdO8ZxeOTAa8Jwf4RcZh71q1BUcXXYSyw==
X-Google-Smtp-Source: ABdhPJxiF7JZ1IzEl8lQTFbT71fuPW6s9e8dyJcfiNsanpiLLZSmPVXEg1YBkBDYHl4Ww2jWkxptQzPlLISmcGv/3S0=
X-Received: by 2002:ac2:4d86:: with SMTP id g6mr17787703lfe.549.1627422661756;
 Tue, 27 Jul 2021 14:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com> <1b408625-d71c-0b26-b0b6-9baf00f93e69@virtuozzo.com>
In-Reply-To: <1b408625-d71c-0b26-b0b6-9baf00f93e69@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 27 Jul 2021 14:50:50 -0700
Message-ID: <CALvZod6H8atu5k3xhKf11SEMjyVjXMYFGWKBLsXStYhYs3FNCw@mail.gmail.com>
Subject: Re: [PATCH v7 04/10] memcg: enable accounting for fasync_cache
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 10:33 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> fasync_struct is used by almost all character device drivers to set up
> the fasync queue, and for regular files by the file lease code.
> This structure is quite small but long-living and it can be assigned
> for any open file.
>
> It makes sense to account for its allocations to restrict the host's
> memory consumption from inside the memcg-limited container.
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
