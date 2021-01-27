Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80601306743
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 23:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhA0Wvr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 17:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhA0Wvo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:51:44 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282F4C061354;
        Wed, 27 Jan 2021 14:51:04 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 16so3625622ioz.5;
        Wed, 27 Jan 2021 14:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KghPEGZU40F6HmOvZcdkJbtEvvG/Mj5OqeU4qLAbrBk=;
        b=vRGLo7J6JC301pFrg3XZhPgPMQhWFQs3WrPjGNBR4bJUhW1b7ayZgWHnRpEiN0fg1m
         gJ+iORoEKely8Wg1eGS+ryGIRNnlmhqHMFw2FjgGfX38yJkmrw+zgapvR9l/cOW8vxnw
         0tK2woCvBIWOuOc463ybALpR9N3IMssrqoavjE8Z7+NrzOzYa83tQYRhZkQAxkpN3zjV
         AAfhmfUsQfbGWpAMcEN0YooToZrJplO8j5N51tqm6nKcY6rYN048ziYMcyr5o4l0u74R
         98pGJlQWrLt9CIYEJV/d19sELYb4nH230Q63zRpMqE/fDvJedSmk+OkV33TIehqctmcf
         DT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KghPEGZU40F6HmOvZcdkJbtEvvG/Mj5OqeU4qLAbrBk=;
        b=f5ZJGNMvF4FkhCMFgP7XsqE+A73Up1MkLBFeed9GL0vphv6Vqd6EFOqoH/X0z2lkzA
         ez+47mOutk9bmA3cvM68EdRNxFWKA0RjCtIaI0Yfhlzj6tQG4IP5B4TEzE+pkttWS6T6
         Pfj4vcRYqPCX7n1brA3JyNB3q877J2B7qe0TeuPJuawvrJ99JIgz7IlBeFtS86HWve9c
         vL++e+3RneCPSwpwgOXHF6RwLJTEKN++snt5dfHkXLPS1tbIKpXt0WMu5Ni8MXuqsvU2
         QMKq2EZogydbTRc6vpX+yBC4V9x4+KUNYUpRoaGwWNr3JgLXG8YopZgZ/PxFunvNVJAi
         Bilw==
X-Gm-Message-State: AOAM531vteLa1Z5b2ZuIcKimDqMzVUUBfe4GkvNHYD89r5z7qs+Nh0rC
        kwYIanmVyjsvB6y+Hljtb1R3sjfh6A65G/bH3xs=
X-Google-Smtp-Source: ABdhPJyStPj5yx4BQyvOfARFMCt/BHM1nSrzBANiCDQxLeyi5a1WXtZiIx64RxYivVviTPLOFL76WG/Pzxrtw611VEU=
X-Received: by 2002:a6b:2bca:: with SMTP id r193mr9525550ior.167.1611787863568;
 Wed, 27 Jan 2021 14:51:03 -0800 (PST)
MIME-Version: 1.0
References: <20210126134103.240031-1-jlayton@kernel.org>
In-Reply-To: <20210126134103.240031-1-jlayton@kernel.org>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 27 Jan 2021 23:50:57 +0100
Message-ID: <CAOi1vP-3Ma4LdCcu6sPpwVbmrto5HnOAsJ6r9_973hYY3ODBUQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] ceph: convert to new netfs read helpers
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Ceph Development <ceph-devel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-cachefs@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 2:41 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> This patchset converts ceph to use the new netfs readpage, write_begin,
> and readahead helpers to handle buffered reads. This is a substantial
> reduction in code in ceph, but shouldn't really affect functionality in
> any way.
>
> Ilya, if you don't have any objections, I'll plan to let David pull this
> series into his tree to be merged with the netfs API patches themselves.

Sure, that works for me.

I would have expected that the new netfs infrastructure is pushed
to a public branch that individual filesystems could peruse, but since
David's set already includes patches for AFS and NFS, let's tag along.

Thanks,

                Ilya
