Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B645AD89
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2019 23:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfF2Vqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jun 2019 17:46:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41831 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfF2Vqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jun 2019 17:46:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id 205so9298418ljj.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jun 2019 14:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkEYc72WKRbMxn5L/m1epy636FdcowEH46eJVLsCsgI=;
        b=BvHlB51x8AXSGhwsCaVNbG5QNOzIXlAPn2izPhrDgIVx0PoS622WvoVB4rQ3BmqB0d
         6wbE6wyObVwpqjaM8zmw8hnjViL4ToMrglm9FJmt8sllFI0qiadUC+q7JBBrEeDAVC6+
         dFm4tsdKICzT5HDOMV9BnjZRd70bVxMtgMQrS6LWIcW8jR1HeVa6fEf68M0Q4p1dfDmi
         rR/XmXuDG8FNYtOaljqVJUVO7Sldv2tfTSTWIg87VYg211gtKN1GZZDLHk50Yy4ib2H+
         shNR7Ogpoe/TvYDpALVTIQxF/aPIJ4uMZ7fHLQ5MFPcCOPQ1TmhmbSJK3eQxK4T438i/
         Pu+Q==
X-Gm-Message-State: APjAAAU82VojrqOmssLo7GRDgOd8Gm+FaaEJtoWwaO1Ip5YKRFBNmUyB
        b7jWQwZ0K9zVRMppHu6YVGWG/vNH/pZe03e0xuaCAA==
X-Google-Smtp-Source: APXvYqzs+IPReceD2rzEsJnE/IkN+E6EJRWw+/EgGzGKxRG6U0Cq76ySy3Znw4J1ci5XIbj3n0mjZU+kzlgVbuHy2C8=
X-Received: by 2002:a2e:3e01:: with SMTP id l1mr9876346lja.208.1561844794156;
 Sat, 29 Jun 2019 14:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190626190343.22031-1-aring@mojatatu.com> <20190626190343.22031-2-aring@mojatatu.com>
 <293c9bd3-f530-d75e-c353-ddeabac27cf6@6wind.com> <18557.1561739215@warthog.procyon.org.uk>
 <CAGnkfhwe6p412q4sATwX=3ht4+NxKJDOFihRG=iwvXqWUtwgLQ@mail.gmail.com>
In-Reply-To: <CAGnkfhwe6p412q4sATwX=3ht4+NxKJDOFihRG=iwvXqWUtwgLQ@mail.gmail.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Sat, 29 Jun 2019 23:45:57 +0200
Message-ID: <CAGnkfhwKBaqE72A+0J-hLy_aWXvXWhW+tdvzOYJamM3V4iGiXA@mail.gmail.com>
Subject: Re: [RFC iproute2 1/1] ip: netns: add mounted state file for each netns
To:     David Howells <dhowells@redhat.com>
Cc:     Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Alexander Aring <aring@mojatatu.com>,
        netdev <netdev@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 28, 2019 at 7:06 PM Matteo Croce <mcroce@redhat.com> wrote:
>
> On Fri, Jun 28, 2019 at 6:27 PM David Howells <dhowells@redhat.com> wrote:
> >
> > Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
> >
> > > David Howells was working on a mount notification mechanism:
> > > https://lwn.net/Articles/760714/
> > > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=notifications
> > >
> > > I don't know what is the status of this series.
> >
> > It's still alive.  I just posted a new version on it.  I'm hoping, possibly
> > futiley, to get it in in this merge window.
> >
> > David
>
> Hi all,
>
> this could cause a clash if I create a netns with name ending with .mounted.
>
> $ sudo ip/ip netns add ns1.mounted
> $ sudo ip/ip netns add ns1
> Cannot create namespace file "/var/run/netns/ns1.mounted": File exists
> Cannot remove namespace file "/var/run/netns/ns1.mounted": Device or
> resource busy
>
> If you want to go along this road, please either:
> - disallow netns creation with names ending with .mounted
> - or properly document it in the manpage
>
> Regards,
> --
> Matteo Croce
> per aspera ad upstream

BTW, this breaks the namespace listing:

# ip netns add test
# ip netns list
Error: Peer netns reference is invalid.
Error: Peer netns reference is invalid.
test.mounted
test

A better choice IMHO could be to create a temporary file before the
placeholder, and delete it after the bind mount, so an inotify watcher
can listen for the delete event.
For example, when creating the namespace "foo":

- create /var/run/netns/.foo.mounting
- create /var/run/netns/foo
- bind mount from /proc/.. to /var/run/netns/foo
- remove /var/run/netns/.foo.mounting

and exclude .*.mounting from the netns listing

Or, announce netns creation/deletion in some other way (dbus?).

Regards,
-- 
Matteo Croce
per aspera ad upstream
