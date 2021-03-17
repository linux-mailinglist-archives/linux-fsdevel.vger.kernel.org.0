Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EBA33F4A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 16:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhCQPxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 11:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbhCQPwx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 11:52:53 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DADDC06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Mar 2021 08:52:53 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id j6so984081plx.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Mar 2021 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OwoprurdfjCI69Sb0SLu5vwDZ5zDww0nnsXZt9JzSo=;
        b=qbKwC/TPm7zICPaZDHAAL+1BPFdv5DY+p59+a9c37+VmbTF/BktdFoWonN8sJxajaz
         XT9u5rQPVJhiYhkjILmMUWVNfDtgMRCP3qPo2c9ZCbCAwxiJIefCpcYdbSatEQ1eeLZd
         XhUOYTpwOUUL33up2NzfpgDERSeLcmKy1+zas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OwoprurdfjCI69Sb0SLu5vwDZ5zDww0nnsXZt9JzSo=;
        b=l0fgaF+qrkcik4PXsV7Y6q5hjcYAJNMXF3+d0ivBdZvHkJ34S8LtScMGOydwaJDDwM
         kHlZt4q2VsSrPaYMaXBfwroB34tpxxlroQ4BZnARFa0v1wL4r6V0xYDuOgCMwzdDrqOS
         DX726QZWPkDEgytDy6vHl8r9Gpi8JWPcmyhCEmL/45LOu5aIbGuS5hSTiF95rZaoSrLI
         OS4WFEHH6HAGwZDy6+N22DFhcgCjChD5E8G+A3MzD/WQGz7gE3Z6VhGPD4cHHhYetdiH
         s2slROABd9c+ozSZPr7h6P8mOddVh3YvP34K4RVEkqvIoC/PjQoJz1bji0p4Tb1fOl76
         /1mA==
X-Gm-Message-State: AOAM530rAsc/DNA8evCMUB4bk3ajEQ+CyTcaa/HVWnRm72H1WCHDtHS3
        yL7ATRJDMcnOcFD1RSbqHCXIDIFRFtdtg7wZgdQTzrGrDs0=
X-Google-Smtp-Source: ABdhPJyGRL/yd2pyZNMSbEuBBN9f1CY41OZj8vR3MMLzJGeKqybyWgNoJEUQ9CCm4Ss5YDqB+RzN1ZiwFcBqXVFlfWs=
X-Received: by 2002:a67:6786:: with SMTP id b128mr4399141vsc.9.1615995826132;
 Wed, 17 Mar 2021 08:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210316160147.289193-1-vgoyal@redhat.com> <20210316160147.289193-2-vgoyal@redhat.com>
In-Reply-To: <20210316160147.289193-2-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 17 Mar 2021 16:43:35 +0100
Message-ID: <CAJfpegtD-6Xt3JDtoOtqJLXeDzVgjfaVJhHU8OQ8Lpw9tu2FzA@mail.gmail.com>
Subject: Re: [PATCH 1/1] fuse: send file mode updates using SETATTR
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Luis Henriques <lhenriques@suse.de>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 5:02 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> If ACL changes, it is possible that file mode permission bits change. As of
> now fuse client relies on file server to make those changes. But it does
> not send enough information to server so that it can decide where SGID
> bit should be cleared or not. Server does not know if caller has CAP_FSETID
> or not. It also does not know what are caller's group memberships and if any
> of the groups match file owner group.

Right.  So what about performing the capability and group membership
check in the client and sending the result of this check to the
server?

Yes, need to extend fuse_setxattr_in.

There's still a race with uid and gid changing on the underlying
filesystem, so the attributes need to be refreshed, but I don't think
that's a big worry.

Thanks,
Miklos
