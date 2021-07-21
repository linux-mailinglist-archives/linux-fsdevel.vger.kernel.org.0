Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316D83D0F19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 15:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbhGUMMX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 08:12:23 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:42505 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbhGUMMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:12:21 -0400
Received: by mail-ej1-f52.google.com with SMTP id hd33so3053948ejc.9;
        Wed, 21 Jul 2021 05:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wsly7dfNO7RHOMY3dXRgAFX5p64QtWOR8DbRF5XBWeY=;
        b=L6FAgkgVe2FiwyzweOkHcOIA9JA6Oaut+S8vVX/4bk6bFjM+g30gPijU0MAu1o9rAM
         mJCJ0lGCsU+m4qVtXodVyclBxlr1JKMJDAr5ZuZeQBDwKyNohaloEMZMZgby9xHeuX+a
         G40Kg0yjU0i1kWQezTOmEsh2060GkguKeRrh+hGEFJN80CbP1fNtczH1zbCdnr35jdfI
         kpkIEQlxqmyllr/tVIJMCjzmJPGL3sZvaclEinmxV2Jt5JykiBe9pG4fyBfOmAm8n67Y
         Mycxu12H7Q8eU7P7srxKELstxJ7RT6Xnon4obQEV3oZhZhqXfZJzNPrZuf+QpYOfCkI4
         hGkw==
X-Gm-Message-State: AOAM533oIE+jq03BnPQULUy7OzJFFOnKRZ94wtpiaRzIWH5qaeg1+AKx
        fgvKNPZ5aXykFXlN0RNN1RQZ1+wZUYsMrQ==
X-Google-Smtp-Source: ABdhPJxQd5SmTMG76o2kHJRGUtVdh0RvL2nZREFjHaZ5Xwtwdga2UTS1brD3gS0TMh4XFehDQfyGDg==
X-Received: by 2002:a17:906:17c4:: with SMTP id u4mr39240798eje.481.1626871976472;
        Wed, 21 Jul 2021 05:52:56 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id ja13sm8263484ejc.82.2021.07.21.05.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 05:52:56 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso920297wmj.4;
        Wed, 21 Jul 2021 05:52:56 -0700 (PDT)
X-Received: by 2002:a7b:c318:: with SMTP id k24mr37781201wmj.144.1626871975944;
 Wed, 21 Jul 2021 05:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <162610726011.3408253.2771348573083023654.stgit@warthog.procyon.org.uk>
 <162610728339.3408253.4604750166391496546.stgit@warthog.procyon.org.uk>
In-Reply-To: <162610728339.3408253.4604750166391496546.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Wed, 21 Jul 2021 09:52:45 -0300
X-Gmail-Original-Message-ID: <CAB9dFduhRHzZCRBenqLsPPYe+ba19TnX6ftooSVgjSULCnLH9w@mail.gmail.com>
Message-ID: <CAB9dFduhRHzZCRBenqLsPPYe+ba19TnX6ftooSVgjSULCnLH9w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] afs: Fix setting of writeback_index
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 1:28 PM David Howells <dhowells@redhat.com> wrote:
>
> Fix afs_writepages() to always set mapping->writeback_index to a page index
> and not a byte position[1].
>
> Fixes: 31143d5d515e ("AFS: implement basic file write support")
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Link: https://lore.kernel.org/r/CAB9dFdvHsLsw7CMnB+4cgciWDSqVjuij4mH3TaXnHQB8sz5rHw@mail.gmail.com/ [1]
> cc: linux-afs@lists.infradead.org
> ---
>
>  fs/afs/write.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/afs/write.c b/fs/afs/write.c
> index 1ed62e0ccfe5..c0534697268e 100644
> --- a/fs/afs/write.c
> +++ b/fs/afs/write.c
> @@ -784,7 +784,7 @@ int afs_writepages(struct address_space *mapping,
>         } else if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX) {
>                 ret = afs_writepages_region(mapping, wbc, 0, LLONG_MAX, &next);
>                 if (wbc->nr_to_write > 0 && ret == 0)
> -                       mapping->writeback_index = next;
> +                       mapping->writeback_index = next / PAGE_SIZE;
>         } else {
>                 ret = afs_writepages_region(mapping, wbc,
>                                             wbc->range_start, wbc->range_end, &next);
>
>
>

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc
