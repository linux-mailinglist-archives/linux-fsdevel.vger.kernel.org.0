Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C219E2A9982
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 17:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgKFQdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 11:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgKFQdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:33:14 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B280C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2020 08:33:12 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id o73so366987vka.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2020 08:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rv9/RsPL0JaHI/Y2/xGuzlUXKuZPhDUzfIQRWQ6BFYg=;
        b=axbIyE1GQ//a2Hv9kXu9gvzEHx0dQYmWqeS9/kl0aRG87i13UD9TOqDhPx1OWnvNwj
         o5WfEKYy+VCGjKtfiEXGzNq5hNLDwY6FdT65IBtoHQxc7lOVfTUSuVen0fi6ZcdyTfQC
         MfPMFQFgUTpu/sg/PjnjO2mSwQ2aNG1EMPAWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rv9/RsPL0JaHI/Y2/xGuzlUXKuZPhDUzfIQRWQ6BFYg=;
        b=OJCEG5DU+HIeuInXSoyTkpSAoFb+JQoUHV1qbad+boMN+KcrXapEJuRFrbOKI9wxHK
         1tr+gx6Wb7haXZ7yRBkLW+kqfzKpNIlzLYXLRhXbRdzoqva6uTSpCnMG0PIf49wY+SUU
         +3IlmCMY2+5XURfe4/rY5DPjEwxdwfhOAsu3JnZANoGoIyru6ilsiHckUmKQU+C2Rr2x
         y02ucq9BBbQASERMnHR+FCW08xs4mSM5L+yBma6W2n1B2MBBX2EJ2c7HXbOGA2rBExPA
         HTz9tbbWwWGCrqqVAMzLDlTrGtnXyiX5d4rIM7jKc9TNhTkJdqOZMQURG4hfGKqiEo0Z
         Ns6w==
X-Gm-Message-State: AOAM5320x02fcwSuCY0/XMrPj5POtDq9kvF2t4uFisSKuPtHwGT/Fyn6
        uOboLK3GgRQKrbNToYZ8TbD00xRmj7bPsDYHZv7PeA==
X-Google-Smtp-Source: ABdhPJzB/VrhCDe6qRTLl8vDK4Ggv0csNv8v8arRQjF12Y5WeOGt2TH7gUZVeN2UeVWpp8n3a0aRskIH3COE/obzSbo=
X-Received: by 2002:a1f:248c:: with SMTP id k134mr1468189vkk.14.1604680391580;
 Fri, 06 Nov 2020 08:33:11 -0800 (PST)
MIME-Version: 1.0
References: <20201009181512.65496-1-vgoyal@redhat.com> <20201009181512.65496-6-vgoyal@redhat.com>
 <CAJfpegvhK+5-Zze7qZFrXkUkXbN_4M1CpEqyL9Rq9UNOtb2ckg@mail.gmail.com> <20201106160015.GD1436035@redhat.com>
In-Reply-To: <20201106160015.GD1436035@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Nov 2020 17:33:00 +0100
Message-ID: <CAJfpeguSoeD9UgEKAz-hxZQhVku93gsv8FUWArv_hMtQEun9Dw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] fuse: Add a flag FUSE_OPEN_KILL_PRIV for open() request
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 6, 2020 at 5:00 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Nov 06, 2020 at 02:55:11PM +0100, Miklos Szeredi wrote:
> > On Fri, Oct 9, 2020 at 8:16 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > With FUSE_HANDLE_KILLPRIV_V2 support, server will need to kill
> > > suid/sgid/security.capability on open(O_TRUNC), if server supports
> > > FUSE_ATOMIC_O_TRUNC.
> > >
> > > But server needs to kill suid/sgid only if caller does not have
> > > CAP_FSETID. Given server does not have this information, client
> > > needs to send this info to server.
> > >
> > > So add a flag FUSE_OPEN_KILL_PRIV to fuse_open_in request which tells
> > > server to kill suid/sgid(only if group execute is set).
> >
> > This is needed for FUSE_CREATE as well (which may act as a normal open
> > in case the file exists, and no O_EXCL was specified), right?
>
> Hi Miklos,
>
> IIUC, In current code we seem to use FUSE_CREATE only if file does not exist.
> If file exists, then we probably will take FUSE_OPEN path.

That's true if the cache is up to date, one important point for
FUSE_CREATE is that it works atomically even if the cache is stale.
So if cache is negative and we send a FUSE_CREATE it may still open an
*existing* file, and we want to do suid/caps clearing in that case
also, no?

Thanks,
Miklos
