Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8D73FE36D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 21:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbhIATyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 15:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37210 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237526AbhIATyC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 15:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630525985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bFy1F+QsYxR5COx5bC/TDu7Bi/by603yH1cn5pidm4Q=;
        b=T+w0Bbwkdu2qAkNcWIZCANPaMoBkVMAKsmfxdWfxiiXWaD2FKroVFLeC2AfHoY6ySc2ptd
        CTpNhCZcOdYI3tIdtahZhQqk3uzCPbiTgizKVAyRQVl9daRrkjAoCZRzQIJQ8XAjqQygE2
        lffqTzs0/xWdQXTUo9S+4WyH6baFB5A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-8nYd4N0NMpm-K_wX2vVH1Q-1; Wed, 01 Sep 2021 15:53:04 -0400
X-MC-Unique: 8nYd4N0NMpm-K_wX2vVH1Q-1
Received: by mail-wr1-f72.google.com with SMTP id n1-20020a5d4c41000000b00159305d19baso256088wrt.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Sep 2021 12:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFy1F+QsYxR5COx5bC/TDu7Bi/by603yH1cn5pidm4Q=;
        b=eKgyXQppxfedyJ9bQWGcZTvecEBmNknKYCNsuju79hsnwx5ZgMYHq6qirU7vS0UwF5
         iZLYzlo3sDCHxQhWdp/dBdL3AZgTYRmXLzqrF1Z1EFdka2FF8OH0VgVbyenCzlkJVg77
         DJ6Cotq9rsxliLfCm/3QbAWtimnZV9TPNeb4be2poav4TP3S6YJQRAy0BBZ+YPCITC85
         shrjM9CSWwrmxCfMpxjmMOFxttMoybMowwrb1ISSO4uQHRPyZ2aRduhemanVRvRI/hdD
         PhxFpAYIaN2YKvmM5wMwEBXU3EqAeGgB5V4JCwmYp1V3jvlCb4Nv9fD3+m7amsUOhHvP
         HYqg==
X-Gm-Message-State: AOAM5332YzrgiSlNf2XzUofJjhGYyTp6mAu2xPe8dFOwaMADPMhiF+QR
        rq+lfdckpxw68f3Qx9jn+ZcZapwUyUyGfA30iCIUkpapZ1tapMXBfOsTP251zC76x0K/LCJ8KmD
        LYYCJdjvlA/Fszsiocat3b2e80iYhrKJ/zZLmVi56xw==
X-Received: by 2002:a5d:674b:: with SMTP id l11mr1134423wrw.357.1630525983086;
        Wed, 01 Sep 2021 12:53:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy13a9+qZa6g03QLR52J8E62dIEzq7mnQQkvBXnCkrMx+s+g3F4vOoKLHB3KfUO0ib83MII2IoHGfd93bk24N8=
X-Received: by 2002:a5d:674b:: with SMTP id l11mr1134407wrw.357.1630525982924;
 Wed, 01 Sep 2021 12:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <CAHk-=wiUtyoTWuzroNJQwQDM9GHRXvq4974VL=y8T_3tUxDbkA@mail.gmail.com>
In-Reply-To: <CAHk-=wiUtyoTWuzroNJQwQDM9GHRXvq4974VL=y8T_3tUxDbkA@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 1 Sep 2021 21:52:51 +0200
Message-ID: <CAHc6FU7K0Ho=nH6fCK+Amc7zEg2G31v+gE3920ric3NE4MfH=A@mail.gmail.com>
Subject: Re: [PATCH v7 00/19] gfs2: Fix mmap + page fault deadlocks
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 7:17 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Aug 27, 2021 at 9:49 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > here's another update on top of v5.14-rc7.  Changes:
> >
> >  * Some of the patch descriptions have been improved.
> >
> >  * Patch "gfs2: Eliminate ip->i_gh" has been moved further to the front.
> >
> > At this point, I'm not aware of anything that still needs fixing,
>
> From a quick scan, I didn't see anything that raised my hackles.

So there's a minor merge conflict between Christoph's iomap_iter
conversion and this patch queue now, and I should probably clarify the
description of "iomap: Add done_before argument to iomap_dio_rw" that
Darrick ran into. Then there are the user copy issues that Al has
pointed out. Fixing those will create superficial conflicts with this
patch queue, but probably nothing serious.

So how should I proceed: do you expect a v8 of this patch queue on top
of the current mainline?

Thanks,
Andreas

