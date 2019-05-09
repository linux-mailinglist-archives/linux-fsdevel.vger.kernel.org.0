Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13DFF19376
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 22:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfEIUfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 16:35:16 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:55675 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfEIUfP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 16:35:15 -0400
Received: by mail-wm1-f43.google.com with SMTP id y2so4828008wmi.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2019 13:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XxNLfsOlS9TWKruUM9gZzOAp9GfMo3RUAmDT1iHWS4=;
        b=kbQV/+pBuXLW0sdI9WlZVcGWjwH98XmnDCi2jV1+9CaV9TGGrUlQecpHjBJa/bH7YZ
         DUF9rlV+BH4h11ZvzbO8oJDniI6/B1WmYeI8CUVUFO5/sUVlpKt5n4ELv9X6IkY55Nth
         ivYvQREhcUc2BEB6aCiWgGiZRZyVYlBt1jqxpOtHcCXvE3I5WkeT+r1dCA0hHeNn7KAP
         dM5vvHohEQxyXYnPVuHm8hoGN2VrDTUoYq6fJXf0xk1sVJzK9Lfq1FyTonuvCcSlP7i7
         EePaYuPm3gB8BnMn4BN3ZGZrTa9kuj8zPkjqi+yKhbVDbK9mT0Bq5ldHbU0/nm472zxw
         lORw==
X-Gm-Message-State: APjAAAUo8gm6qKlY3fg1poFh8SBAypYVFHJTe2SXveYORRtMVPuC5hjw
        sCfSdllUgMXjzR8EvXJTdIs350QMNJOW5wYcddLJHw==
X-Google-Smtp-Source: APXvYqxisDimr1yZmuN7y8ZouAhalqPsf8pMGAku+yx3K1IdrQE3B3mZL2GjJZ7/DpbO/cP3oBD8IFDKVHRh609Kx9s=
X-Received: by 2002:a1c:81cc:: with SMTP id c195mr4241724wmd.61.1557434113690;
 Thu, 09 May 2019 13:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
 <20190507220449.GP1454@dread.disaster.area> <a409b3d1-960b-84a4-1b8d-1822c305ea18@gmail.com>
 <20190508011407.GQ1454@dread.disaster.area> <13b63de0-18bc-eb24-63b4-3c69c6a007b3@gmail.com>
 <yq1a7fwlvzb.fsf@oracle.com> <0a16285c-545a-e94a-c733-bcc3d4556557@gmail.com>
 <yq15zqkluyl.fsf@oracle.com> <99144ff8-4f2c-487d-a366-6294f87beb58@gmail.com>
 <CAHhmqcS19DUptiUeQ7q3pPCiZ6QcAXYxQwaX5nQ1FM38trzWtQ@mail.gmail.com> <ac188221-5d17-bf30-99f1-6a8d152a2f83@gmail.com>
In-Reply-To: <ac188221-5d17-bf30-99f1-6a8d152a2f83@gmail.com>
From:   Bryan Gurney <bgurney@redhat.com>
Date:   Thu, 9 May 2019 16:35:02 -0400
Message-ID: <CAHhmqcR2=i8SNtaWsA9KHbFGOi6MPjsc0W7DD6=XmpUOFrK0YA@mail.gmail.com>
Subject: Re: Testing devices for discard support properly
To:     Ric Wheeler <ricwheeler@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?B?THVrw6HFoSBDemVybmVy?= <lczerner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 9, 2019 at 1:27 PM Ric Wheeler <ricwheeler@gmail.com> wrote:
>
>
>
> On 5/9/19 12:02 PM, Bryan Gurney wrote:
> > On Wed, May 8, 2019 at 2:12 PM Ric Wheeler <ricwheeler@gmail.com> wrote:
> >>
> >> (stripped out the html junk, resending)
> >>
> >> On 5/8/19 1:25 PM, Martin K. Petersen wrote:
> >>>>> WRITE SAME also has an ANCHOR flag which provides a use case we
> >>>>> currently don't have fallocate plumbing for: Allocating blocks without
> >>>>> caring about their contents. I.e. the blocks described by the I/O are
> >>>>> locked down to prevent ENOSPC for future writes.
> >>>> Thanks for that detail! Sounds like ANCHOR in this case exposes
> >>>> whatever data is there (similar I suppose to normal block device
> >>>> behavior without discard for unused space)? Seems like it would be
> >>>> useful for virtually provisioned devices (enterprise arrays or
> >>>> something like dm-thin targets) more than normal SSD's?
> >>> It is typically used to pin down important areas to ensure one doesn't
> >>> get ENOSPC when writing journal or metadata. However, these are
> >>> typically the areas that we deliberately zero to ensure predictable
> >>> results. So I think the only case where anchoring makes much sense is on
> >>> devices that do zero detection and thus wouldn't actually provision N
> >>> blocks full of zeroes.
> >>
> >> This behavior at the block layer might also be interesting for something
> >> like the VDO device (compression/dedup make it near impossible to
> >> predict how much space is really there since it is content specific).
> >> Might be useful as a way to hint to VDO about how to give users a
> >> promise of "at least this much" space? If the content is good for
> >> compression or dedup, you would get more, but never see less.
> >>
> >
> > In the case of VDO, writing zeroed blocks will not consume space, due
> > to the zero block elimination in VDO.  However, that also means that
> > it won't "reserve" space, either.  The WRITE SAME command with the
> > ANCHOR flag is SCSI, so it won't apply to a bio-based device.
> >
> > Space savings also results in a write of N blocks having a fair chance
> > of the end result ultimately using "less than N" blocks, depending on
> > how much space savings can be achieved.  Likewise, a discard of N
> > blocks has a chance of reclaiming "less than N" blocks.
> >
>
> Are there other API's that let you allocate a minimum set of physical
> blocks to a VDO device?
>

As far as I know: no, not currently.
