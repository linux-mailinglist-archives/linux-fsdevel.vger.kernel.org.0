Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDAE2AF2AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 14:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgKKN4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 08:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgKKNyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:54:55 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C8CC0613D1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 05:54:55 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id p12so731998uam.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 05:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IppUYQ8GF/7LuBlILBgrSqpEAXjuA5Ok93a1QoZUdgs=;
        b=ZQL1SDTMWchSpBu6572KAIf9vY6HqcyfOBt08vmb/plT8QnQEeE82ipV5agcqGarSb
         De7BcSwnUKKIXbUKL+CH8DrsMIcof9QDryXiVGIOCq0Hl/gZ0w68liLomJiZrBoTQfQq
         ZwDg/T5sQ75ew9je9uIK/q5OMNyn1TPDcQPx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IppUYQ8GF/7LuBlILBgrSqpEAXjuA5Ok93a1QoZUdgs=;
        b=VhCDJxPzJbh5NDb3pOc0Sd9nkxXmz7nmo6B2aU3oLZEBZrgNPNNs/aloaRBlkwunM8
         zsexA6ox9HQKKIJbm18XwoMprEZPJLnb7FoENXwWcoAk0Rfc3Jv47MsPO1HAho7pK6aS
         J+P1JqRcG/bVyismmcLRaTz1n94GEkg7jCD07gZUMRKr1qrsY7OFG7ydO3c58svmRLHn
         EWR2k3WF42VydbRWwjxokwWwXOD8sgDO1cBxNkIE0F0UmzwtnSb3CUsJVgDeVJ20rm/C
         Zqjo5AuBnt4AqXlZXdAengSaW13zWRidzaGwYGu4MGBQkxvVVSG6IMt2UXxmWst3cNoX
         4rSA==
X-Gm-Message-State: AOAM532seBpw5TMFmbHZyQFTjLtGCR3EMWhKFZUBVTbzIDZNs1vpcV/M
        LDzDvg4C1WSTWW0AK+nXl01mOQmXRxqX5dCXXrU9bw==
X-Google-Smtp-Source: ABdhPJzy8FzpK2qVG0I2Zz9motfMxZONks0yGAGdOrzr2ONhMHDA4Xo7qQNrCH7kbuTzSR1iEExOEP86b43NEoAqt0Q=
X-Received: by 2002:ab0:2a1:: with SMTP id 30mr10067762uah.72.1605102894609;
 Wed, 11 Nov 2020 05:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20201009181512.65496-1-vgoyal@redhat.com> <20201009181512.65496-4-vgoyal@redhat.com>
 <CAJfpegu=ooDmc3hT9cOe2WEUHQN=twX01xbV+YfPQPJUHFMs-g@mail.gmail.com> <20201106171843.GA1445528@redhat.com>
In-Reply-To: <20201106171843.GA1445528@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 11 Nov 2020 14:54:43 +0100
Message-ID: <CAJfpegvvGL=GJX0a+cDUVhX754NibudTvHvtrBrCnk-FEnfQ6A@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] fuse: setattr should set FATTR_KILL_PRIV upon size change
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 6, 2020 at 6:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:

> I think it does not hurt to start passing FATTR_KILL_PRIV for chown()
> as well. In that case, server will always clear caps on chown but
> clear suid/sgid only if FATTR_KILL_PRIV is set. (Which will always
> be set).

Okay.

More thoughts for FUSE_HANDLE_KILLPRIV_V2:

 - clear "security.capability" on write, truncate and chown unconditionally
 - clear suid/sgid if
    o setattr has FATTR_SIZE and  FATTR_KILL_PRIV
    o setattr has FATTR_UID or FATTR_GID
    o open has O_TRUNC and FUSE_OPEN_KILL_PRIV
    o write has FUSE_WRITE_KILL_PRIV

Kernel has:
ATTR_KILL_PRIV -> clear "security.capability"
ATTR_KILL_SUID -> clear S_ISUID
ATTR_KILL_SGID -> clear S_ISGID if executable

Fuse has:
FUSE_*KILL_PRIV -> clear S_ISUID and S_ISGID if executable

So the fuse meaning of FUSE_*KILL_PRIV has a complementary meaning to
that of ATTR_KILL_PRIV, which is somewhat confusing.  Also "PRIV"
implies all privileges, including "security.capability" but the fuse
ones relate to suid/sgid only.

How about FUSE_*KILL_SUIDGID (FUSE_WRITE_KILL_SUIDGID being an alias
for FUSE_WRITE_KILL_PRIV)?

Thanks,
Miklos




>
> So anything is fine. We just need to document it well. I think I will
> write it very clearly in qemu patch depending on what goes in kernel.
>
> Thanks
> Vivek
>
