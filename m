Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D51B340B03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 18:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhCRRHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 13:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhCRRHL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:07:11 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9925FC06174A;
        Thu, 18 Mar 2021 10:07:11 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id l5so5542625ilv.9;
        Thu, 18 Mar 2021 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9K4dPkNMUlUVtOXj1MYS0wdRhlKCjVW907Y6IqGc/WI=;
        b=CjzTNdFbqB8zhvtlauDEDLO97NnwJVNiy6nJtH2yPJC7U3jgZQeOLSY41OGundz1SO
         oNTHRlOg+3O/hiD59n9IzAJjjfNjZFhI0u0ii4WoGLiupIATOlCFzGiydyd9zI/G3D9O
         7qJuft4OzxORAEk4A6umq+C33ZD7py45KYxV6Zt6YwRyUbjvdG9djqm/DnT8hyELANpd
         euTlY1T5X5XTvzv2CSlk83mdOoIbHXNmIM9eiPbs84oAOsAsuaqtjbSv5215r3J0/Sjm
         Y6iV+57BghupZbwEikSuF6RAmzEqfqMtspS918twustwcho+EFRjD8PfUMquHWJTCEBN
         qM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9K4dPkNMUlUVtOXj1MYS0wdRhlKCjVW907Y6IqGc/WI=;
        b=AIAGisqo6tTP03MgcyuBjnaX0Ov00QZmR4hYqwxKkYmcSE6a0ABkuESrMkPD58Zvjf
         FsDtn55C/DjFKMoDhBQkKMZxPFcBPxJ+ieMcTqtcFiej+E93l3ydJo6/7wmZcMMqqC82
         mei5hDKGqtmsyW2JdrEizlAQ4MnoSW3wZw/l9SigMUMSb/BNEdYYVg1UzugzlklOz8RP
         YHD5hF+WA+Y+IH7gIvEwUcSJKtNvf9iqWJXcHwc3VgDT8DK8GJVgl780OZGyygdjVtFu
         n8cA6fTzhhwRaC37/qZk8oei9Ws6ZQmBgsNfffGSUrGd34d5XQHzBRtOSF+RIGJ9peZo
         g/zA==
X-Gm-Message-State: AOAM5304lUlS3Q2Al29aeosYYkS2MsMzQZmSN9c1PZdYw2SvnZi7E2JN
        fbw+qr6zk2XTTJmUfEUzux2n87qSpEogBbfpb22kY+P+6T8=
X-Google-Smtp-Source: ABdhPJwFCayL+wDkgj5sy6/o64eznREt2OcKt4/+w0aJMsBJJAuZ8wzOKuL/HX8W1GQMtzFQC/Ht2XYKgCB1yM+g4dA=
X-Received: by 2002:a92:da48:: with SMTP id p8mr11475308ilq.137.1616087231056;
 Thu, 18 Mar 2021 10:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210304112921.3996419-1-amir73il@gmail.com> <20210316155524.GD23532@quack2.suse.cz>
 <CAOQ4uxgCv42_xkKpRH-ApMOeFCWfQGGc11CKxUkHJq-Xf=HnYg@mail.gmail.com>
 <20210317114207.GB2541@quack2.suse.cz> <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
 <20210318154413.GA21462@quack2.suse.cz>
In-Reply-To: <20210318154413.GA21462@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Mar 2021 19:07:00 +0200
Message-ID: <CAOQ4uxhpB+1iFSSoZy2NuF2diL=8uJ-j8JJVNnujqtphW147cw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > That may change when systemd home dirs feature starts to use idmapped
> > mounts. Being able to watch the user's entire home directory is a big
> > win already.
>
> Do you mean that home directory would be an extra mount with userns in
> which the user has CAP_SYS_ADMIN so he'd be able to watch subtrees on that
> mount?
>

That is what I meant.
My understanding of the systemd-homed use case for idmapped mounts is
that the user has CAP_SYS_ADMIN is the mapped userns, but I may be wrong.

> > > subtree watches would be IMO interesting to much more users.
> >
> > Agreed.
> >
> > I was looking into that as well, using the example of nfsd_acceptable()
> > to implement the subtree permission check.
> >
> > The problem here is that even if unprivileged users cannot compromise
> > security, they can still cause significant CPU overhead either queueing
> > events or filtering events and that is something I haven't been able to
> > figure out a way to escape from.
>
> WRT queueing overhead, given a user can place ~1M of directory watches, he
> can cause noticable total overhead for queueing events anyway. Furthermore

I suppose so. But a user placing 1M dir watches at least adds this overhead
knowingly. Adding a overhead on the entire filesystem when just wanting to
watch a small subtree doesn't sound ideal. Especially in very nested setups.
So yes, we need to be careful.

> the queue size is limited so unless the user spends time consuming events
> as well, the load won't last long. But I agree we need to be careful not to
> introduce too big latencies to operations generating events. So I think if
> we could quickly detect whether a generated event has a good chance of
> being relevant for some subtree watch of a group and queue it in that case
> and worry about permission checks only once events are received and thus
> receiver pays the cost of expensive checks, that might be fine as well.
>

So far the only idea I had for "quickly detect" which I cannot find flaws in
is to filter by mnt_userms, but its power is limited.

Thanks,
Amir.
