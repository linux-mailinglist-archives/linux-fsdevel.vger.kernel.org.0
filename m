Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BE43222B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 00:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhBVXlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 18:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhBVXlI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 18:41:08 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2D4C061574;
        Mon, 22 Feb 2021 15:40:28 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id x124so3433725qkc.1;
        Mon, 22 Feb 2021 15:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lu36EvNlVpZLf9vn0AKWWzvCVJacgGfuW8XvxcdcSYc=;
        b=MKjAdzGJEiG1GANzaNG8NQwv8A3zr3O9eiZt64ixz7q3fFUbHW+A/18gmHI0mqQkl4
         c0Czceg+s2X7DgJgR1QbTh5bRcInUFBql0hvlSazNZVog5hKHyIwhda+e0uTeGUs/zOR
         0K5hMHLjyjD/7J+bGPwFMw7RfvPNpnvk0f2ypbWwsM9jQeWrTsXl+bfSgDLg7Mjm3opO
         HpJxQgsLARFWgDehBIQ8B1nccgTfM3PpKxYNblTdH0/3mqgBpI4+Qj7827/GrCjL2iyI
         u5NZ5lCtHmkelBoVSzqMvg89VdBveFbLCSai7R259PBckLLhEQ3b5O3H4+r7AVCIt/FU
         EMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lu36EvNlVpZLf9vn0AKWWzvCVJacgGfuW8XvxcdcSYc=;
        b=g6Ax6gbdhrLffUQDHhXpF69RcPPP84dh8OrL9QTeA+Pu/83PMz8v02hcI9Y19+4SCI
         KgEGSjldytGogRa6hnNDaLEl/nsrveWAW4LFsil9II59Mcopl+hts7M3UupFjPkKhQK5
         EOQmhcWK/m3s123P5xdaE/iahhD8V49zr/zNkqhJT+sAFSZyMRXiXWj5cHX/sK4ORlEp
         vlDHw8i/gWqmXBRIKVhv1GHf8rcPkvlCgVhSUXy1JWqfTBvw/IGJmyo8VoqYcMaxb96w
         BAAW3SoP/aCbyvTWSG9t/oioJk2o2r8pjFzvaHpyWKT/8qS3a1lrChBAnX3E4B+n6aXC
         aoXw==
X-Gm-Message-State: AOAM532lSnO2k+tCgQEHFxJN8dGZb7fQSZSg5tr/pHem2sIirch1ERO7
        HRINgGDV4so0/Ty6YsntTirtdkruGfVaA8vxuhgMtaombn0=
X-Google-Smtp-Source: ABdhPJyJVKWY/DkuD0WOWSp91n6+oqxtE7PSXfP+0elLYFTUbM9vBNhdR82o6I8qr+gmA6ORi+kFRielnme1ChDbDUs=
X-Received: by 2002:a05:620a:41:: with SMTP id t1mr23814731qkt.322.1614037227122;
 Mon, 22 Feb 2021 15:40:27 -0800 (PST)
MIME-Version: 1.0
References: <d2d3e617-17bf-8d43-f4a2-e4a7a2d421bd@gmail.com> <20210220173605.GD2858050@casper.infradead.org>
In-Reply-To: <20210220173605.GD2858050@casper.infradead.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 22 Feb 2021 18:40:15 -0500
Message-ID: <CAMdYzYojq--qWhxmpj4VL_feNjMFZcjN6q7mQL-+SWujScNzkQ@mail.gmail.com>
Subject: Re: [BUG] page allocation failure reading procfs ipv6 configuration
 files with cgroups
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 20, 2021 at 12:36 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Feb 20, 2021 at 12:29:18PM -0500, Peter Geis wrote:
> > Good Afternoon,
> >
> > I have been tracking down a regular bug that triggers when running OpenWRT in a lxd container.
> > Every ten minutes I was greeted with the following splat in the kernel log:
> >
> > [2122311.383389] warn_alloc: 3 callbacks suppressed
> > [2122311.383403] cat: page allocation failure: order:5, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=lxc.payload.openwrt,mems_allowed=0
>
> You want this patch:
>
> https://lore.kernel.org/linux-fsdevel/6345270a2c1160b89dd5e6715461f388176899d1.1612972413.git.josef@toxicpanda.com/

I've tested this patch against 5.10.17 for 36 hours and can confirm it
solves the problem.
Thank you.
