Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2D731145D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 18:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbfLERZP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 12:25:15 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33552 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbfLERZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:25:12 -0500
Received: by mail-lf1-f68.google.com with SMTP id n25so3140164lfl.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 09:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcGyAgv2BiiKMB4o1JPjh3c4/KLE1QL1Cs5ZGEHCDIc=;
        b=h8R8qn2a8yMheUZxZicjSxy1mjJzLS/SXEZWNWhN2n29VR1l3aKAlm1cuqN3fZyRfk
         7RiJ2tHBwlnu/dxOScE0uVy3iZQZ7SYeh67Cd1w1vNd2lAU44JJHrRfgT90jo1Vxdgk6
         hfczULjbW6MoOj6k0umoQaFr+3JFVFJeh4/gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcGyAgv2BiiKMB4o1JPjh3c4/KLE1QL1Cs5ZGEHCDIc=;
        b=NmC1/pLwOzsv6N3qZe3eLFGiXXVaa1rfoAzlruFTY6kuFCxMVXqevwK08+rCtXOzei
         8AXiU1oX+sov5LrahoMRoaddCxX8DLh55HoZ3wE1RXK1pLAZdyfoAYZKYbE7Psl5rzF9
         O6fMqzU+2vH8vX+22VkPcNEvmBozx8Auilj/C7SVLC5XHhHzmo7Lp9ExfdXCYDCVz0w1
         iJ7PX9+aOjlo6/WZDradJGDex1ABZAX/2VjlkIPbRkk1ysIHDTCq8pTh3DnGxgS5YRJR
         2k/11KQn8Iso6ik5f0KvTskrC2dv2we3uzvP/8tcWpPSYU9xqtTRCosvU0gjxI0LX9Wu
         umZg==
X-Gm-Message-State: APjAAAUV7NHkYYrWBDBw+d90aaxJfRU2CmRj0jbPxTAE6EVqxdrl/QGp
        YovXysi3xQvPxEp4w7Q438CQ4AoJ+GA=
X-Google-Smtp-Source: APXvYqyRe+gVq2lo/kzn4VT7OqMYvagLY64BvahHAwnMihI/mAloAShbJ4BJoMUhXfRZf0oj62I1Pg==
X-Received: by 2002:ac2:5216:: with SMTP id a22mr5870101lfl.18.1575566709561;
        Thu, 05 Dec 2019 09:25:09 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id w71sm6136706lff.0.2019.12.05.09.25.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 09:25:08 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 21so4547249ljr.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 09:25:08 -0800 (PST)
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr3763207ljg.82.1575566707941;
 Thu, 05 Dec 2019 09:25:07 -0800 (PST)
MIME-Version: 1.0
References: <31452.1574721589@warthog.procyon.org.uk> <20191205125826.GK2734@twin.jikos.cz>
 <1593.1575554217@warthog.procyon.org.uk> <CAHk-=wgwwJ+ZEtycujFdNmpS8TjwCYyT+oHfV7d-GekyaX91xg@mail.gmail.com>
In-Reply-To: <CAHk-=wgwwJ+ZEtycujFdNmpS8TjwCYyT+oHfV7d-GekyaX91xg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 09:24:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi_on1EAbVi1Q01i7=0_GL=nKmz6s9677YZf74H8=Sw0g@mail.gmail.com>
Message-ID: <CAHk-=wi_on1EAbVi1Q01i7=0_GL=nKmz6s9677YZf74H8=Sw0g@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: Notification queue preparation
To:     David Howells <dhowells@redhat.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 5, 2019 at 9:12 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It would be interesting to hear if somebody else is waiting on the
> read side too.

Looking once more at that commit, I find at least one bug, but I'm
pretty sure that's not the cause of this problem.

DavidH, watch out for things like this:

-       for (idx = 0; idx < pipe->nrbufs && rem < len; idx++)
+       for (idx = tail; idx < head && rem < len; idx++)

which is a completely buggy conversion.

You can't compare tail and head with an inequality, it gets the
wraparound case wrong.

But I found only one of those, and it's fuse-specific, plus the
overflow would take a long time to trigger, so I'm pretty sure this
isn't what DavidS is reporting.

               Linus
