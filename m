Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C1D397523
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 16:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhFAOMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 10:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhFAOMS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:12:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A18AC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jun 2021 07:10:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so2029904wmq.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jun 2021 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=7iGbvcFYMb3tLwZvkHa1Xrgwf6I7yyg/yxMiEiySaC0=;
        b=ejnEUTO1DiWDFagv+Dl6hADRqW7H1logS/cF6NBmsns/CZtF8MMuELJR17uBvI2xCD
         ngbYDadN3KqmTc1Ga64JG9ipPURDyswvZSzXT8SgS+f7+2fznZZ5iWjaYZC/aQASeaFy
         V8hUWaNgJgUeTGGYdT4EErDL9mDPIsVnl+zdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=7iGbvcFYMb3tLwZvkHa1Xrgwf6I7yyg/yxMiEiySaC0=;
        b=OGp2+iIiG2f/E57DFz0gHh0WJ2TLeOw9Ew0MuSW2CpZgtJJFYWDJCjPz21KUzRCAuE
         lGbGjPu+CmN48XRQIR5f/OWd/P1HwQqXE4zOEBc4LPvGrVkVHyD+boIHWFFjiklatVmG
         5/wBsXTMoc4DcoceHJgjPmYJqQhtL5vo53SiFCrJauN/gqCg5UMEVFuHzp37Cs8X6F6S
         M/GvnnsXwVN+TZD6xBxIOELrAb0NTN4XdaKOureB2WK/WGuu3ZfMgRQUMf7OpA7cAjnf
         teSdyANx8TqwUYMWIb2m3sePM1PkfxsKC0jN09tnNMj2GKOqyRXTD+S3k33umZRTbs6b
         cmaQ==
X-Gm-Message-State: AOAM531hiNIRCLbbaNyn4lo4Zf5Zhkktyea6m4qsHXQre1Ysaj59y5cs
        EnV+FZs/yOT55m0k7H/pQqwkxQ==
X-Google-Smtp-Source: ABdhPJxmv2iRwq3JXX8sQlPH3fi0l96M70KDiLaBl1d14VByekZy30x12OgkHti6Mr59TGXbgwmE1g==
X-Received: by 2002:a05:600c:2109:: with SMTP id u9mr104645wml.7.1622556635096;
        Tue, 01 Jun 2021 07:10:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f1sm4206218wrr.63.2021.06.01.07.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:10:34 -0700 (PDT)
Date:   Tue, 1 Jun 2021 16:10:32 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, linux-fbdev@vger.kernel.org,
        linux-mm@kvack.org, Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        William Kucharski <william.kucharski@oracle.com>,
        Ian Campbell <ijc@hellion.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Jaya Kumar <jayakumar.lkml@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] fb_defio: Remove custom address_space_operations
Message-ID: <YLY/2O16fAjriZGQ@phenom.ffwll.local>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-fbdev@vger.kernel.org,
        linux-mm@kvack.org, Jani Nikula <jani.nikula@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        William Kucharski <william.kucharski@oracle.com>,
        Ian Campbell <ijc@hellion.org.uk>, linux-fsdevel@vger.kernel.org,
        Jaya Kumar <jayakumar.lkml@gmail.com>,
        Christoph Hellwig <hch@lst.de>
References: <20210310185530.1053320-1-willy@infradead.org>
 <YLPjwUUmHDRjyPpR@Ryzen-9-3900X.localdomain>
 <YLQALv2YENIDh77N@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLQALv2YENIDh77N@casper.infradead.org>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 30, 2021 at 10:14:22PM +0100, Matthew Wilcox wrote:
> On Sun, May 30, 2021 at 12:13:05PM -0700, Nathan Chancellor wrote:
> > Hi Matthew,
> > 
> > On Wed, Mar 10, 2021 at 06:55:30PM +0000, Matthew Wilcox (Oracle) wrote:
> > > There's no need to give the page an address_space.  Leaving the
> > > page->mapping as NULL will cause the VM to handle set_page_dirty()
> > > the same way that it's handled now, and that was the only reason to
> > > set the address_space in the first place.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> > 
> > This patch in mainline as commit ccf953d8f3d6 ("fb_defio: Remove custom
> > address_space_operations") causes my Hyper-V based VM to no longer make
> > it to a graphical environment.
> 
> Hi Nathan,
> 
> Thanks for the report.  I sent Daniel a revert patch with a full
> explanation last week, which I assume he'll queue up for a pull soon.
> You can just git revert ccf953d8f3d6 for yourself until that shows up.
> Sorry for the inconvenience.

Uh that patch didn't get cc'ed to any list so I've ignored it. I've found
it now, but lack of lore link is awkward. Can you pls resubmit with
dri-devel on cc? fbdev list is dead, I don't look there.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
