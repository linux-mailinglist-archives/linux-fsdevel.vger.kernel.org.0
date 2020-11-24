Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FEF2C1FB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 09:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgKXIQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 03:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgKXIQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:16:20 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A14C0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 00:16:19 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id v6so10634976vsd.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 00:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJCaGTUSDIgP4+hl5FVgfWsV076zXP11j5oXpg/4Oxk=;
        b=AsJvvSVJJnWt7g1EEkD7kcLWWM3qeX4x38lp+nkGX1D37OqCxVAtFw7KXVMbBQ6U43
         4J/oz8xIVgpoRaYObF75XfiUSvzyVSV4KJxv7q5LMfx+CJGeqow1IYSCqSc/Gkqul2Fe
         Y3+1BDv6RmeTNsGP6GgCVHRiuWPPk6M2ltFtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJCaGTUSDIgP4+hl5FVgfWsV076zXP11j5oXpg/4Oxk=;
        b=sTZY9dKcAYE3/BX7tdHlmCqsb0mdMeTEqs3W6r/a/GIc7EBMNcrFkWRvkp00zTSzSB
         ohZP+l66k9NkcjmwqxjG5AN9mKS/1GrY1yTi0Ge0PcMiKtfd/wmG4gFM5d9ui5xxgXGH
         xxYgX3hCdmTP9zYXJ5zDEV6EZWa7q3jX4MejDQx6pcjBykvy7jOv/agS88wIlNETQ1A5
         34fvgqydJC0KPEuGFRVGHUofVpSh1PA1skS5R/ki2J0LrS8gckFsxKuIZQlRpRQRA50t
         nAGhdDJQGPizXX+1N98M3AJB9tjtUnxHeouArVz77MJiDKFmn3csXV2FRa3uuq5aqs88
         pH+A==
X-Gm-Message-State: AOAM530PAA+p9N1Ykv5Blp/us6n6IZtM2S1N+9oZFqbXfrCWRc2EXOoP
        YYxQBc/20w8xVKFVQO6PSwMj8SHigx9oGa3LKQkmtA==
X-Google-Smtp-Source: ABdhPJycVUMsJFLFmH4S7dnFzyklhDgUD7jq1BqMwGReUWTzafULEECCyOthvdUtOLCrHibeLE9pIuHxtxFNGlsgHtE=
X-Received: by 2002:a67:ce1a:: with SMTP id s26mr2931095vsl.0.1606205779081;
 Tue, 24 Nov 2020 00:16:19 -0800 (PST)
MIME-Version: 1.0
References: <DM6PR12MB33857B8B2E49DF0DD0C4F950DD5D0@DM6PR12MB3385.namprd12.prod.outlook.com>
 <CAJfpegu6-hKCdEiZxb9KrZUrMT_UozjaWC5qY00xwqqopb=1SA@mail.gmail.com>
 <DM6PR12MB33856CB9CC50BE5D7E9B436DDD540@DM6PR12MB3385.namprd12.prod.outlook.com>
 <DM6PR12MB3385C2556A59B3F33FE8B980DD520@DM6PR12MB3385.namprd12.prod.outlook.com>
 <CAJfpegv5EckmJ_PCqHc2N3_jHaXfinMwvDNSttYNXcan1wr1fQ@mail.gmail.com> <DM6PR12MB33851BCA35DC6EB3158C84B5DDFC0@DM6PR12MB3385.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB33851BCA35DC6EB3158C84B5DDFC0@DM6PR12MB3385.namprd12.prod.outlook.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 24 Nov 2020 09:16:08 +0100
Message-ID: <CAJfpeguja0QPtn3jKcd1k4MK=eauLt4RgHyqJnxYeTU8h=WDcg@mail.gmail.com>
Subject: Re: [fuse-devel] Cross-host entry caching and file open/create
To:     Ken Schalk <kschalk@nvidia.com>
Cc:     "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 10:07 PM Ken Schalk <kschalk@nvidia.com> wrote:
>
> On Thu, Oct 1, 2020 Miklos Szeredi <miklos@szeredi.hu> wrote:
> > On Fri, Aug 28, 2020 at 11:01 PM Ken Schalk <kschalk@nvidia.com> wrote:
> > > > Thanks very much for your help.  The patch you provided does solve
> > > > the problem in the O_CREAT|O_EXCL case (by making a lookup call to
> > > > re-validate the entry of the since deleted file), but not in the
> > > > O_CREAT case.  (In that case the kernel still winds up making a FUSE
> > > > open request rather than a FUSE create request.)  I'd like to
> > > > suggest the slightly different attached patch instead, which
> > > > triggers re-validation in both cases.
>
> > Which is a problem, because that makes O_CREAT on existing files (a
> > fairly common case) add a new synchronous request, possibly
> > resulting in a performance regression.
>
> > I don't see an easy way this can be fixed, and I'm not sure this
> > needs to be fixed.
>
> > Are you seeing a real issue with just O_CREAT?
>
> Yes, we definitely do see issues with just O_CREAT.  The specific
> sequence that involves O_CREAT without O_EXCL is:
>
> 1. A file exists and is accessed through our FUSE distributed
>    filesystem on host X.  The kernel on host X caches the directory
>    entry for the file.
>
> 2. The file is unlinked through our FUSE distributed filesystem on
>    host Y.
>
> 3. An open(2) call with O_CREAT for the file occurs on host X.
>    Because the kernel has a cached dentry for the now deleted file, it
>    makes a FUSE open request to our filesystem (rather than a FUSE
>    create request).
>
> 4. Our filesystem's open handler finds that the file does not exist
>    (because it was unlinked in step 2) and replies to the open request
>    with ENOENT.

ESTALE is the correct error value here, not ENOENT.   I agree this is
subtle and not well documented, but it's quite logical:  the cache
contains stale lookup information and hence open finds the file
non-existent.  In no case shall the OPEN request return ENOENT, that's
up to the LOOKUP request.

Exclusive create is a different matter.  It must not open an existing
file, and so it must never send an OPEN request.

Thanks,
Miklos
