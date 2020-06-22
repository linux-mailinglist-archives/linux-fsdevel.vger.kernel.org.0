Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4991220399B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 16:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgFVOf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 10:35:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26623 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728504AbgFVOfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592836523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m8LciREWJsj9AQY8WoqbJEs9+BzHuuZ2kYt75+dmYbI=;
        b=Hp9D6EVb64wcaFWcildgaNPli7N5VwmbiHEGuIcxtCPmbN3ZiyW8XFoqmMIUO3GE/kvHrA
        lhxAK+vP462PH9z+bAMqMq8exlMWc3m8c3RtwqR8q+L9ASLRE9DtKERCHvsTuBXNup5Bym
        8g4CdDNr47Al7iV6hU57JsJqsl+k7wA=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-Q75__HfKMKekne0tF_wCZQ-1; Mon, 22 Jun 2020 10:35:17 -0400
X-MC-Unique: Q75__HfKMKekne0tF_wCZQ-1
Received: by mail-oo1-f72.google.com with SMTP id r5so8661335ooq.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2020 07:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8LciREWJsj9AQY8WoqbJEs9+BzHuuZ2kYt75+dmYbI=;
        b=fLPI07QiCB89ISlZ2MZZPbtmJwSUbI3ISACdw1CY7+NyE62t1Pf1fypEgYtj0PAQwl
         37XyNVP3I3PZjDthtRtP0ny75wnPWRoo6GmPivO77tigbi0mNivySj+DPJ6MqOTWeTfo
         YkQJqTRPF4LzDueb0FmYTTMdGXDd7qKfhYn7EFM8pNZPvZ09BuwUF3ANSvUD2OniOEap
         EHOa4n6ektkQFOeKNOkVQ0/u8hFpdV+6wnu68IR9QIMOABL/llOPAKG3r+FE6z3CXBVR
         azmNXjGvzirfQA8/mP8Zjsrw+CUbic6nMDsAgHJBLJKercQTg7Y/gxw+2m+d69+RfmEA
         WhCw==
X-Gm-Message-State: AOAM533DxCM++dgYmJa09Q6kjhvWWMPqTvTD2pWoyeJAn/DdecyJt4fm
        VwOT4+1YPIYoGmsA8NGzq8DCuaeQtabYlXugMn26xBGWRbW2MQuMar8pKA4xjUotTygxPMrE4lA
        7qjkIOAGhBoplrbjXPKIKER8ViOx//6fG2HS1V1ZCxw==
X-Received: by 2002:a4a:868a:: with SMTP id x10mr5394719ooh.31.1592836517114;
        Mon, 22 Jun 2020 07:35:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmNbgEQyfxangZ/xtw/LtBecn8SD7Han8BUwPHyelwFuDLXZvgVZ4AhpiZLmG4l0zJHroGpJ6M/R2ujIRrCNs=
X-Received: by 2002:a4a:868a:: with SMTP id x10mr5394700ooh.31.1592836516902;
 Mon, 22 Jun 2020 07:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200619155036.GZ8681@bombadil.infradead.org> <20200622003215.GC2040@dread.disaster.area>
In-Reply-To: <20200622003215.GC2040@dread.disaster.area>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 22 Jun 2020 16:35:05 +0200
Message-ID: <CAHc6FU4b_z+vhjVPmaU46VhqoD+Y7jLN3=BRDZPrS2v=_pVpfw@mail.gmail.com>
Subject: Re: [RFC] Bypass filesystems for reading cached pages
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 2:32 AM Dave Chinner <david@fromorbit.com> wrote:
> On Fri, Jun 19, 2020 at 08:50:36AM -0700, Matthew Wilcox wrote:
> >
> > This patch lifts the IOCB_CACHED idea expressed by Andreas to the VFS.
> > The advantage of this patch is that we can avoid taking any filesystem
> > lock, as long as the pages being accessed are in the cache (and we don't
> > need to readahead any pages into the cache).  We also avoid an indirect
> > function call in these cases.
>
> What does this micro-optimisation actually gain us except for more
> complexity in the IO path?
>
> i.e. if a filesystem lock has such massive overhead that it slows
> down the cached readahead path in production workloads, then that's
> something the filesystem needs to address, not unconditionally
> bypass the filesystem before the IO gets anywhere near it.

I'm fine with not moving that functionality into the VFS. The problem
I have in gfs2 is that taking glocks is really expensive. Part of that
overhead is accidental, but we definitely won't be able to fix it in
the short term. So something like the IOCB_CACHED flag that prevents
generic_file_read_iter from issuing readahead I/O would save the day
for us. Does that idea stand a chance?

We could theoretically also create a copy of
generic_file_buffered_read in gfs2 and strip out the I/O parts, but
that would be very messy.

Thanks,
Andreas

