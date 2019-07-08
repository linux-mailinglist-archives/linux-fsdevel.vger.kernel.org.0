Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66988625D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 18:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390296AbfGHQJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 12:09:44 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41868 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbfGHQJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:09:44 -0400
Received: by mail-yb1-f195.google.com with SMTP id 13so1186997ybx.8;
        Mon, 08 Jul 2019 09:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QsSwO+ugsOBI16xFNtRc8q7T85XnrFgpAlzVCDTaX/E=;
        b=bIHChhZi81Hvjog0qiLbxcaO1jEUw7joLB3eRUK84fA9Cd4RrF5XJAc9pVVuCiRlP0
         7dMcwRDmX53nkb8Yc8xLEV8cm7xj+kguPv6Y2odF9xw4Tzjx/kgbExs202UevOrwObZP
         kd/CCTpF4PeZUZM3es67Lh51JHk+N8YdjQnUbdtolHEWL8yFK8JZzOv+yF1XUZIY7CvG
         Z+vBhk2ANz86uYZlsVgTNkZpOD8fMdXZdtPpdrHgsHrmXqE42MWnTN2fPBTKioH1xlAi
         J2KS64k7XDeALAdL4PAdr1ij9DD3l/hdSZubgzs1+DFs7L+kD4gYFNk1qs2nwzmLDdzG
         RIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QsSwO+ugsOBI16xFNtRc8q7T85XnrFgpAlzVCDTaX/E=;
        b=I4vKMHUqfqZYhDMOuWpW8+xOvH/HxVXTfDr9W/uFDyuhlSD8aN3wRedMVYabsWZwgN
         2Fo604g9+m0aNCbf54xIlU6lbuQGIeMxzeLHnHJnR9woUNIuGvC0J6bkwfR+TrosFy7z
         ZatCB9HtN6b5cWwOHVm8NWgZ1rA2IdjRimicPBdE7RHP8pWw9Q7jgx8x1JwVbsrKYG5w
         Lm+B/IPv04jbSYpsfeCPv0gA2HV7IHCGfAt6tqj8hPJA4TlDjqxaJ7AmdCCUXYXXgUwT
         2YTvMOFSKtOQQYOesyG8YW640NXW1I/6JUWxHS4o00sXyYYNr8owG0Qk4/Ip80ct/6KG
         XnGQ==
X-Gm-Message-State: APjAAAXYkuF/ZeaM8BZ8x3DFXmOLOfnxqckW6CiogkalbHxNPxeoZtGs
        cv1zasVFlz1lTr4UzzNLhZZ8b4QGmqsCuRg/egataw==
X-Google-Smtp-Source: APXvYqyDc7f0S+MUPiRzVeR//UiyhjDLntJhf7rTZTUlTnJsDLZDpOFE+w5B+9KilDjqXcYSb68II/pQJdqIyE4Tqq4=
X-Received: by 2002:a25:c486:: with SMTP id u128mr11131932ybf.428.1562602183523;
 Mon, 08 Jul 2019 09:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190612172408.22671-1-amir73il@gmail.com> <2851a6b983ed8b5b858b3b336e70296204349762.camel@kernel.org>
 <CAOQ4uxi-uEhAbqVeYbeqAR=TXpthZHdUKkaZJB7fy1TgdZObjQ@mail.gmail.com> <20190613140804.GA2145@fieldses.org>
In-Reply-To: <20190613140804.GA2145@fieldses.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 8 Jul 2019 19:09:31 +0300
Message-ID: <CAOQ4uxjBGHh9cU7EX7X3F-iVFZkD+kax2x+Hj8YX83HMiwLqSw@mail.gmail.com>
Subject: Re: [PATCH v2] locks: eliminate false positive conflicts for write lease
To:     "J . Bruce Fields" <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 5:08 PM J . Bruce Fields <bfields@fieldses.org> wrote:
>
> On Thu, Jun 13, 2019 at 04:28:49PM +0300, Amir Goldstein wrote:
> > On Thu, Jun 13, 2019 at 4:22 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > Looks good to me. Aside from the minor nit above:
> > >
> > >     Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > >
> > > I have one file locking patch queued up for v5.3 so far, but nothing for
> > > v5.2. Miklos or Bruce, if either of you have anything to send to Linus
> > > for v5.2 would you mind taking this one too?
> > >
> >
> > Well. I did send a fix patch to Miklos for a bug introduced in v5.2-rc4,
> > so...
>
> I could take it.  I've modified it as below.
>
> I'm very happy with the patch, but not so much with the idea of 5.2 and
> stable.
>
> It seems like a subtle change with some possibility of unintended side
> effects.  (E.g. I don't think this is true any more, but my memory is
> that for a long time the only thing stopping nfsd from giving out
> (probably broken) write delegations was an extra reference that it held
> during processing.) And if the overlayfs bug's been there since 4.19,
> then waiting a little longer seems OK?
>

Getting back to this now that the patch is on its way to Linus.
Bruce, I was fine with waiting to 5.3 and I also removed CC: stable,
but did you mean that patch is not appropriate for stable or just that
we'd better wait a bit and let it soak in master before forwarding it to stable?

Thanks,
Amir.
