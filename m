Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B46E3BDAD2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jul 2021 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhGFQE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 12:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229770AbhGFQE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 12:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625587309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2yfndmR2iaMQIWMAd4edCOEQikxHqB5a5e0OL47C4zE=;
        b=EF9EEslqO6cIJ/on/wqLaJPz+5Y20hxn4dKBOnyEyq44pPNuHEcl/f9oDhoKKl13QcBeq2
        G408+mZYF9h+4D1F4yspP75VbCMfjUMGqJ2jzzoWuxxjde7+wtka3unSoD1ITsS0KefDms
        iMjgBXFWDPrk6EUjzlEnjq0Yrqxuf2Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-HzWhSeOPNJOWoGPAG1iWJw-1; Tue, 06 Jul 2021 12:01:48 -0400
X-MC-Unique: HzWhSeOPNJOWoGPAG1iWJw-1
Received: by mail-wm1-f71.google.com with SMTP id a129-20020a1ce3870000b02901f050bc61d2so1113030wmh.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jul 2021 09:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2yfndmR2iaMQIWMAd4edCOEQikxHqB5a5e0OL47C4zE=;
        b=mZ4vLkjC77jcqCt7+agxZ2D9PPv28XtcTRcmPduN2Y41oXQvz47soSW97dqBpX3soT
         +65B5tiGQDwTeFclJsIWAzFJe8BB6B8hloWm0QL4ZMmhrd0vyx8luRrHrjH/XxwDz61I
         j9+YAhbqeJXvTZDn5rQRBIf7UCprO7iExGjkVbgCBoZoSVwObshPW4E9DQL5T42GGGlK
         CpxeYQVY23fl7qZe/6BYrQsw4dShsUSL7IcDwVfWBMXgm0NuoKoFT2A8kgcL/9SkqueQ
         LnoEU4NBzlHlz4ftb50JoJFKKLx5p6+LhQ1IJOj6/nyYD3cpZtH2Z5a/k+xoiJZGqufE
         xjYg==
X-Gm-Message-State: AOAM533cx6N9P7Q334OH/PeWCaxyEPYN87cRdkjcDjfarOt+4ShNW5sW
        V+GroL81+Pz3JA+UGsItubi/COolWb2bcG4Y4i3auEDqYFvgEbGvda8f2w64fETnShPn0qzYqww
        OUNeb8AJlBugzmQhlaAnJQiXn9ECL4TENAE0GX67hKg==
X-Received: by 2002:a1c:62c4:: with SMTP id w187mr4794456wmb.27.1625587306932;
        Tue, 06 Jul 2021 09:01:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf3SIjPzhBrTlg9BxLb8FhE5zoAaVaW0K9FFwNlBnAnkxzzGcrUqGlsbeH3InUge2TgjqNc6VPAXHKHt/Xe4Y=
X-Received: by 2002:a1c:62c4:: with SMTP id w187mr4794417wmb.27.1625587306675;
 Tue, 06 Jul 2021 09:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210705181824.2174165-1-agruenba@redhat.com> <20210705181824.2174165-2-agruenba@redhat.com>
 <YOPkNnQ34vRiVYs6@infradead.org>
In-Reply-To: <YOPkNnQ34vRiVYs6@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 6 Jul 2021 18:01:35 +0200
Message-ID: <CAHc6FU5j7T31OknUk+_WejRw_1s9NCuq=59YExAHY2iWHCgZZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iomap: Don't create iomap_page objects for inline files
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 6, 2021 at 7:07 AM Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Jul 05, 2021 at 08:18:23PM +0200, Andreas Gruenbacher wrote:
> > In iomap_readpage_actor, don't create iop objects for inline inodes.
> > Otherwise, iomap_read_inline_data will set PageUptodate without setting
> > iop->uptodate, and iomap_page_release will eventually complain.
> >
> > To prevent this kind of bug from occurring in the future, make sure the
> > page doesn't have private data attached in iomap_read_inline_data.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>
> As mentioned last round I'd prefer to simply not create the iomap_page
> at all in the readpage/readpages path.

I've tried that by replacing the iomap_page_create with to_iomap_page
in iomap_readpage_actor and with that, I'm getting a
VM_BUG_ON_PAGE(!PageLocked(page)) in iomap_read_end_io -> unlock_page
with generic/029. So there's obviously more to it than just not
creating the iomap_page in iomap_readpage_actor.

Getting rid of the iomap_page_create in iomap_readpage_actor
completely isn't a necessary part of the bug fix. So can we focus on
the bug fix for now, and worry about the improvement later?

> Also this patch needs to go after the current patch 2 to be bisection clean.

Yes, makes sense.

Thanks,
Andreas

