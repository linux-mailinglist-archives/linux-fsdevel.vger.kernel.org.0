Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611752509BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 22:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHXUB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 16:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHXUB4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:01:56 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843EDC061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 13:01:56 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id j25so4322353ejk.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 13:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JySKM+sQHR8cWO3YfVl9HHPc5I6MOQ8YTX3XcoVi1vo=;
        b=fVAYtcW1eHTPAfiB+hHPMIgywRWp2XJj6kErZx+MpzDRyZm1c7VV4Di7AoWStNSbAM
         AoEbXiGAvkO9v+IcsvEXl8iFUiEYEDbuS0VC8Kk77Xlu0zUjKoty1nILw6DzK/RJu91r
         IQMz1eWYfGBnjdkkiv/UJMXpJtnzZRX/xIZAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JySKM+sQHR8cWO3YfVl9HHPc5I6MOQ8YTX3XcoVi1vo=;
        b=ZxOuOYQWjNAje8UKuHwcClqBAfm0LCYVx7xXX0GJ6Y6aFFbaBZwmI8M3sQxMLFy0jQ
         O6p6BR/9/+9I5Ztgh4k9d381QlF+4BQruKpQmE3loGyYUu4VreFHfVop9vQCy2G+ADb5
         vipuTWJYxeLjmq2KSSvT0qgbwawmjexmOy//MQT2DDgUJdKonDzUk817LK8H+feg3UaK
         vO9JO8f/E5ev41IbMT8L9OgUt6BSZgGieRU7ZTdfr9Y+JE9OijC4Rmv547zFaK15Q6pV
         0xT9hBQ4a/DpRf6OwQ6VNCJpjAO5urjBE3mSQnHwlHeLzpnNBEbkDT27+fW2zcek+cQu
         TNpw==
X-Gm-Message-State: AOAM531XqunBGTp2X58vGTalSC7I1KPaQhpGpgYTu/N73E9EXIQK8akk
        wqHU0H0pCasT3bs4s/hbZgQnSP31tPXwu1FD5GoWAA==
X-Google-Smtp-Source: ABdhPJxNbVf8fABNyupw5VTe9QVVnaC0s52vad29k964vEeHxg7Q4YR1giK3Bh/R4zkVW46XjEc7mccGnGiRB1L47H8=
X-Received: by 2002:a17:906:9589:: with SMTP id r9mr6954317ejx.320.1598299314728;
 Mon, 24 Aug 2020 13:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200728105503.GE2699@work-vm> <2859814.QYyEAd97eH@silver>
 <20200823234006.GD7728@dread.disaster.area> <3081309.dU5VghuM72@silver>
In-Reply-To: <3081309.dU5VghuM72@silver>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 24 Aug 2020 22:01:43 +0200
Message-ID: <CAJfpegvFQ2FDLZBBKX98zG=NMt0AAFk+kq=AocABQrz_qZO3ug@mail.gmail.com>
Subject: Re: file forks vs. xattr (was: xattr names for unprivileged stacking?)
To:     Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 5:30 PM Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>

> Hu, you're right! There is indeed a somewhat congruent effort & discussion
> going on in parallel. Pulling in Miklos into CC for that reason:
> https://lore.kernel.org/lkml/CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com/
>
> However the motivation of that other thread's PR was rather a procfs-like
> system as a unified way to retrieve implementation specific info from an
> underlying fs, and the file fork aspect would just be a 'side product'.

The motivation is a consistent interface for accessing file related
data, whatever that be.

> But as they already pointed out, it would be a problem to actually agree about
> a delimiter between the filename and the fork name portion. Miklos suggested a
> a double/triple slash, but I agree with other ones that this would render
> misbehaviours with all sorts of existing applications:
> https://lore.kernel.org/lkml/c013f32e-3931-f832-5857-2537a0b3d634@schaufler-ca.com/

That argument starts like this:

 - Path resolution has allowed multiple slashes in UNIX systems for 50
years, so everyone got used to building paths by concatenating things
ending in slashes and beginning in slashes and putting more slashes in
the middle.

This can't be argued with, we probably have to live with that for 50
more years  (if we are lucky).

The argument continues so:

 - Because everyone got lazy, we can't introduce a new interface with
new rules, because all those lazy programmers won't be bothered to fix
their ways and will use the old practices while trying to use the new
interface, which will break their new apps.

Huh?  Can't they just fix those broken apps, then?

Yeah, yeah, I know it's not as simple as that, as the path can come
from application A, while the new interface is used by application B.
But this would only be a real backward compatibility issue if the new
interface is used without consideration for such cases (i.e. clean up
paths coming from untrusted sources before using it with the new
interface).

So no, I don't buy that argument.   Anyway, starting with just path
resolution starting at the target file makes sense as a first step.

The most important thing, I think, is to not fragment the interface
further.  So O_ALT should allow not just one application (like ADS)
but should have a top level directory for selecting between the
various data sources.

Thanks,
Miklos
