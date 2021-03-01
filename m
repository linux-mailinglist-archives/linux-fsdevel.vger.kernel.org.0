Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78002328639
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 18:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbhCARG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 12:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbhCAREe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:04:34 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45136C061756;
        Mon,  1 Mar 2021 09:03:53 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w21so21712879edc.7;
        Mon, 01 Mar 2021 09:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WGfH4B+NMgcssjR04f9HD8JP0KDy7y/KsXZ1Iko6tpA=;
        b=vLmK5/fmzo7WQEGL/DdMmuxprzTa7cHozAkkiX6OD7pKqKZL+gQ/Tk6XXPK+//Erpj
         q/qAoVERsSZ7GKRa/03ESr2BuZcKP3ntWnux2odEFkCikcWB5EkrbHq0IBcEgXb7BHNJ
         GHPXMcCEyXo00d7QxZSoKCVd7ge7qG2gyNXH5qNKYNkDtu9q8zvm9/a2a3Nx9hHnVTk5
         1QnnxC888CoBA2judbLCKphoiRevkSYjrdyw+1CccmAbfHOJqxsHERWS36pLxYHtoPv/
         QWYAY2iNCa45i+A3NJBH53EZgVCJ0mwPO1Z+C5cX/FYaILIyYuChsz5LaMOs7LMJI/VM
         TH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGfH4B+NMgcssjR04f9HD8JP0KDy7y/KsXZ1Iko6tpA=;
        b=oAs6sNFZaZltNZH2znlOA6+0/Yr35C9FmbqISBpWwkZ+252YnLSJGLXNelIZZdcZo7
         chX/cqGPN45VCEviRm1D3AFx4OEuGRH85rzikU5ji/mOVtWYTzSa+l9RJLG217tBwOsw
         R59X1lpJya16egE2++/bSse9co6DrXMMvQctyyRIV0+M+5J/AsY/AkZjaSdo1kNAucBV
         k9zJTql5/tGe5cp1LjGblApRK7zrH9cRod5wf1Jcm06h/AYxeQjfA0fKqtgE8Eouik7O
         TLHb2x/CqQ9SIM+vjlX8SQXNMFCacVPue/Y33f8YtCIXUvInQFJBXDJhu+/A181laLIh
         DURQ==
X-Gm-Message-State: AOAM530KTG2DeJJxQzg3WUiL6PDxf8qqyQ+EiSxPz9Xv2wCJiAVdqX4r
        kOSEEZjuZN43jmoDBC7eQE/ZY5coUtR9oYWy7DU=
X-Google-Smtp-Source: ABdhPJwjMK2YmMZVxtwYS0vnpLCsHWIpxFUwagbiRLe6A85A7rELeGBG7xWVaTa50uPOt4jHO1YXRsQLbq8n6iEkXoo=
X-Received: by 2002:aa7:cc03:: with SMTP id q3mr17670479edt.366.1614618231962;
 Mon, 01 Mar 2021 09:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20210217001322.2226796-1-shy828301@gmail.com> <CAHbLzkrEfeoofwJjncFDepcOxEKzqiAo8T7mowX2jJVCz5ikEA@mail.gmail.com>
 <YD0Ct/tP4TSok0BI@cmpxchg.org>
In-Reply-To: <YD0Ct/tP4TSok0BI@cmpxchg.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 1 Mar 2021 09:03:40 -0800
Message-ID: <CAHbLzkqimWOMWkaNCMLjeXXdCkMRt8BuXuFTxyk3+tdPrajnHQ@mail.gmail.com>
Subject: Re: [v8 PATCH 00/13] Make shrinker's nr_deferred memcg aware
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 1, 2021 at 7:05 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hello Yang,
>
> On Thu, Feb 25, 2021 at 09:00:16AM -0800, Yang Shi wrote:
> > Hi Andrew,
> >
> > Just checking in whether this series is on your radar. The patch 1/13
> > ~ patch 12/13 have been reviewed and acked. Vlastimil had had some
> > comments on patch 13/13, I'm not sure if he is going to continue
> > reviewing that one. I hope the last patch could get into the -mm tree
> > along with the others so that it can get a broader test. What do you
> > think about it?
>
> The merge window for 5.12 is/has been open, which is when maintainers
> are busy getting everything from the previous development cycle ready
> to send upstream. Usually, only fixes but no new features are picked
> up during that time. If you don't hear back, try resending in a week.

Thanks, Johannes. Totally understand.

>
> That reminds me, I also have patches I need to resend :)
