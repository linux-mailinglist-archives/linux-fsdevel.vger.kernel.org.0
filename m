Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B5448259D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Dec 2021 20:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhLaTVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Dec 2021 14:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhLaTVe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Dec 2021 14:21:34 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F7CC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 11:21:33 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o6so111565510edc.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 11:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YU06RrU6q8sQBZyTzdprAi1+FG3h7shQoFSUPOjUgj8=;
        b=WUx8Mhhd4JwVQESuI9u7ibjcwyDeZgExAuH1BIuRaOVdHGHErUrYtd8S4F7h9peeqh
         8OvDto1JXS/Ie82GmFUdJQWquyftRBj+vshMMwgA2gwN1hOjJnuPUG5fhS0XeSdHGSHu
         vQalMh1yNNmYCULVdEgZQLxGfTbmoE08YWuvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YU06RrU6q8sQBZyTzdprAi1+FG3h7shQoFSUPOjUgj8=;
        b=CPbC0spqSPyvjhWWxUsBBwT6EzJY1bRIdrGVViZZ9rpZ8ivkozJq9XL6m5CEWdu3Kd
         4M8SOVB5+fRJn8R3oEqJr+0o8whk90ZBzN+5vsBJUzE++343RAUquiv+nfNTyGXiZ9jj
         fcf0/IKfAVcLecKHcKiG46qvLxL9gRmhhqWQS4hjauK+Icff1pSKGtFYWN24bdWH5jnI
         2C2TopoMrspPejd7cYmd0IHtRCMDdH4E5tvPxpv2PZ5RCb2DCLOVmwm6P9Jfw00gwFz3
         VvAhzLXDAZpPSAMGUxqwcbf6RlBMYEgb+I7xw2gynIs3VhneBdkc2nuwXAnbLSY/H1xf
         iKKA==
X-Gm-Message-State: AOAM5312zXXlEAe+qKLUMf7l5iGzkUD3vUdOFyfrlPaXnTo+C3RgQDKS
        BG97wVQwV4NrY4lgAwpBKPltLW/CKpCMhjNY
X-Google-Smtp-Source: ABdhPJzGdWSwt8e2BSQbODK8loS7mIKkY87FzWI5lyyirN3b2WbY1E9Fh55TxebrRwW66ixyjV5L+w==
X-Received: by 2002:a05:6402:3588:: with SMTP id y8mr36472951edc.147.1640978492181;
        Fri, 31 Dec 2021 11:21:32 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id r24sm10702012edv.18.2021.12.31.11.21.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Dec 2021 11:21:31 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id v7so57239417wrv.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 11:21:30 -0800 (PST)
X-Received: by 2002:a5d:6211:: with SMTP id y17mr30389617wru.97.1640978490358;
 Fri, 31 Dec 2021 11:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20211202150614.22440-1-mgorman@techsingularity.net>
 <caf247ab-f6fe-a3b9-c4b5-7ce17d1d5e43@leemhuis.info> <20211229154553.09dd5bb657bc19d45c3de8dd@linux-foundation.org>
 <5c9d7c6b-05cd-4d17-b941-a93d90197cd3@leemhuis.info> <CAHk-=wi3z_aFJ7kkJb+GDLzUMAzxYMRpVzuMRh5QFaFJnhGydA@mail.gmail.com>
In-Reply-To: <CAHk-=wi3z_aFJ7kkJb+GDLzUMAzxYMRpVzuMRh5QFaFJnhGydA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 Dec 2021 11:21:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=whj9ZWJ2Fmv2vY-NAB_nR-KgpzpRx6Oxs=ayyTEN7E8zw@mail.gmail.com>
Message-ID: <CAHk-=whj9ZWJ2Fmv2vY-NAB_nR-KgpzpRx6Oxs=ayyTEN7E8zw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mark Brown <broonie@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 31, 2021 at 11:14 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Dec 31, 2021 at 6:24 AM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
> >
> > If we get it into rc8 (which is still possible, even if a bit hard due
> > to the new year festivities), it will get at least one week of testing.
>
> I took it with Hugh's ack from his reply to this, so it should be in rc8.

Pushed out as 1b4e3f26f9f7 ("mm: vmscan: Reduce throttling due to a
failure to make progress")

             Linus
