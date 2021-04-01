Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60422351799
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 19:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbhDARm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 13:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbhDARjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:39:10 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC27C02258A;
        Thu,  1 Apr 2021 08:20:05 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id y17so2332800ila.6;
        Thu, 01 Apr 2021 08:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOGzkmus7FSjIp58YVUbgiLPNH3heZborXBF7GU/Clg=;
        b=aXocVHnAcXWz/JSHs1MibWnjiagFRmX1kHTD9+pT8sUp3UnYNSj8W/FQOvUAKd073V
         ZzS1Sz2p9idyp20v+L17GHIF0lY98+2iIuX68nsbXcxP+JpTDrne1kA1nI5mzdGpzG00
         b7/7KYGm+EOpzru8zhMoXIUuJZNPgEyeM524WMQFsm7/dQIVnP051Mduu6D+8Mflj+ld
         BPM+16Rrwq5AEcXEh9lpR2WiwcuYWp8a9DnLYRFC/zP4Q7nV71raJFx11BZ23mAtCjDA
         RmIm0SDP9apr2FHBQqoG974sQfHzaRaW6Bf7jmeofIxxrcHsy/OZtDE0UG5II3+lAYRv
         T8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOGzkmus7FSjIp58YVUbgiLPNH3heZborXBF7GU/Clg=;
        b=VQ17TdeRiu25PBmfKEiO6RnzUTq0+ZfMhpOo3VQEhBUyI0DFIvGb0jKTz/gzKyAqiy
         /y8t2pHozHJcwvfbkrajlyFoHNc2guNzT5ANfAF+Lj/TO4vdm3w5c5vkWyLBijPURfTs
         t0jfiHQZLL5FCX1vFx9aph8drXjJX5+YaPqIy1zbGU/KsXO+eZZ/EELaa8uwZN/pWUGo
         SeWwRwLsW14VcaMsXbkg8F4HNUVzt3G/bLT9t9kyzlsZE8xjv4uQJFLoTBsGoPdznxgA
         /TEDHNszg8BJp7EYoz8htHijZv5wYe+JZmbXsJxA69qSyJgfMWo0ss+pi5piw7ONOyLS
         xWww==
X-Gm-Message-State: AOAM532+URXVG+3Snr1mjyIJktQgGdjyxh1FLJtmbRnBJad3eJOTnD/l
        5GlMlSK7KKif/qzryaqd+h7AMJDmIg76ABSzY6Y=
X-Google-Smtp-Source: ABdhPJy3/zD5YVO4iyjYbgXYKIB9ffaqmolP/6tbVqE/ejbpMobWUEni2WIv5GYCIfZ166U3eh4elEwKTT06R1iNt14=
X-Received: by 2002:a92:50b:: with SMTP id q11mr7416978ile.250.1617290404894;
 Thu, 01 Apr 2021 08:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegtUOVF-_GWk8Z-zUHUss0=GAd7HOY_qPSNroUx9og_deA@mail.gmail.com>
 <CAOQ4uxgcO-Wvjwbmjme+OwVz6bZnVz4C87dgJDJQY1u55BWGjw@mail.gmail.com> <CAJfpegvRr0dy=dfLA_NM+UMYi_jqOeGf=KsS=Pjf5dn-X6nt5A@mail.gmail.com>
In-Reply-To: <CAJfpegvRr0dy=dfLA_NM+UMYi_jqOeGf=KsS=Pjf5dn-X6nt5A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 1 Apr 2021 18:19:53 +0300
Message-ID: <CAOQ4uxjogAWRoVBDKJ85DOW6p9BbL__tZ3ApSbGiCFsWYoJdJQ@mail.gmail.com>
Subject: Re: overlayfs: overlapping upperdir path
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 1, 2021 at 6:09 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, Apr 1, 2021 at 4:30 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, Apr 1, 2021 at 4:37 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > Commit 146d62e5a586 ("ovl: detect overlapping layers") made sure we
> > > don't have overapping layers, but it also broke the arguably valid use
> > > case of
> > >
> > >  mount -olowerdir=/,upperdir=/subdir,..
> > >
> > > where subdir also resides on the root fs.
> >
> > How is 'ls /merged/subdir' expected to behave in that use case?
> > Error?
>
> -ELOOP is the error returned.
>
> >
> > >
> > > I also see that we check for a trap at lookup time, so the question is
> > > what does the up-front layer check buy us?
> > >
> >
> > I'm not sure. I know it bought us silence from syzbot that started
> > mutating many overlapping layers repos....
> > Will the lookup trap have stopped it too? maybe. We did not try.
> >
> > In general I think that if we can error out to user on mount time
> > it is preferred, but if we need to make that use case work, I'd try
> > to relax as minimum as possible from the check.
>
> Certainly.  Like lower inside upper makes zero sense, OTOH upper
> inside lower does.   So I think we just need to relax the
> upperdir/workdir layer check in this case.
>
> Like attached patch.
>

Fine by me.
Let's let syzbot have fun ;-)

Thanks,
Amir.
