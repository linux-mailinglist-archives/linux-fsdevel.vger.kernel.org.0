Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4E83942D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 20:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbfFGSVT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 14:21:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32824 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfFGSVT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:21:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id y17so2337572lfe.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jun 2019 11:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcUcDDcC5mC90UP39oOfydyRccLWkfoYEANrC6Q5vzo=;
        b=s0tXCBipeEZLiyUq1kIA5uOtAITcdEM2lIuJevLlsm348D+kxPA3J0V1UMiYsScdAV
         iAkDqV6bEkCbWJ5ZBCwRJS1uPgXYp7JtbOCoYyXJketTPNdC9kGyawJL9bUnU5nK39l4
         FHhXUjX0EqZSvk8lIa472w6FrvLcyQjjmDX1sR2t97Sf39cEObUd8QoNPR49Zgfl7C2M
         YBl4GwAkXuKx13NThm39wmolwYBovdJAuD8LIEIZx6C6RQ1T7k9NLAH6SnjgTNNPphF9
         ZcvFK8KKTTflixMahpi/BDTxLfOBluVyRtg+BXnSsEmXEGs+FLEeoGSkwuX0s3gdTgVT
         3Oqw==
X-Gm-Message-State: APjAAAW85+LvJ3mBgD0wS9PWMm09zyiWfygySMDE63BPpbyy523Jgu+7
        tg3gsQzXtjqSfIpO89ggkWVDFEZ3i1wns7kKGhVqfQ==
X-Google-Smtp-Source: APXvYqxS5uzW3XR5kdyFjRpxOZreggJNwlHKkhL6Tmcr675Z5ilYvHwgYSkiUD3WZM5T1zybdCcFiR7fD7A9J2bVdkU=
X-Received: by 2002:a19:22d8:: with SMTP id i207mr25716706lfi.97.1559931677223;
 Fri, 07 Jun 2019 11:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190607003646.10411-1-mcroce@redhat.com> <ea97df59-481b-3f05-476c-33e733b5c4ba@gmail.com>
In-Reply-To: <ea97df59-481b-3f05-476c-33e733b5c4ba@gmail.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Fri, 7 Jun 2019 20:20:40 +0200
Message-ID: <CAGnkfhx_h1d6k+wZk7xZXnECDZ+Z+oLw9zAWvDFRe+mHLksszA@mail.gmail.com>
Subject: Re: [PATCH linux-next v2] mpls: don't build sysctl related code when
 sysctl is disabled
To:     David Ahern <dsahern@gmail.com>
Cc:     netdev <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 7, 2019 at 7:14 PM David Ahern <dsahern@gmail.com> wrote:
>
> On 6/6/19 6:36 PM, Matteo Croce wrote:
> > Some sysctl related code and data structures is never referenced
> > when CONFIG_SYSCTL is not set.
> > While this is usually harmless, it produces a build failure since sysctl
> > shared variables exists, due to missing sysctl_vals symbol:
> >
> >     ld: net/mpls/af_mpls.o: in function `mpls_platform_labels':
> >     af_mpls.c:(.text+0x162a): undefined reference to `sysctl_vals'
> >     ld: net/mpls/af_mpls.o:(.rodata+0x830): undefined reference to `sysctl_vals'
> >     ld: net/mpls/af_mpls.o:(.rodata+0x838): undefined reference to `sysctl_vals'
> >     ld: net/mpls/af_mpls.o:(.rodata+0x870): undefined reference to `sysctl_vals'
> >
> > Fix this by moving all sysctl related code under #ifdef CONFIG_SYSCTL
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
> > ---
> >
> > v1 -> v2: fix a crash on netns destroy
> >
> >  net/mpls/af_mpls.c | 393 ++++++++++++++++++++++++---------------------
> >  1 file changed, 207 insertions(+), 186 deletions(-)
> >
>
> As I recall you need to set platform_labels for the mpls code to even
> work, so building mpls_router without sysctl is pointless.

This would explain why so much code went under the #ifdef.
Should we select or depend on sysctl maybe?

Regards,
-- 
Matteo Croce
per aspera ad upstream
