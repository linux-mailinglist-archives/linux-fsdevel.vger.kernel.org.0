Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F5E44BEEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 11:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhKJKnA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 05:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhKJKm7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:42:59 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379FDC061764
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 02:40:12 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id e2so3750948uax.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 02:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nk6XRX2TznPXsfINO2o2w8wDXEMhAormMVW3tMxH3ek=;
        b=fDAMfo8KW5asynRYgP81/4vEsTgzUcX4BPayaaIJ0HR6+NgvLL4+kNwJqVGvJjJCea
         2Uz3KzJwR0q6cOMcZu3Rui9+TEOZE08V9F+DHXGEIY88t0jj3FywZkOyX+4zPY5gsHVl
         O9IaXA49X6qKtJXtBzmNCrnbwlJ2DNawW4fAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nk6XRX2TznPXsfINO2o2w8wDXEMhAormMVW3tMxH3ek=;
        b=Rjq6lQIoLXQDsuv/i0Az9+CGECSp5tk6PRd2cOVOfpXO3qrEQus5XMQgVU04n83oM8
         pUc9K8AUMPPnGT8O80PHPrRLwaKiWCpH7xH9PalkCF4pMD00Vdc8HLfMuPD0vakB58gi
         phguuQU4X9j04rF4yZd0mnN6elHVkh+SdKDUD0X0EwtZXNwrxeQr+LK7MRV5M+wXAQcv
         r9dybE2JDPYHa2aLSRRVv+iCLMVcTnLoG4OCYRF7qhukgAEnPRCrZDn3tbDK9klyQR3U
         AKi+zmA0yLFcU8kojQACiuX9LpJhpJSvLc4yMsf87eZuC7cn6LxhB5yixQvwkJbqgz+3
         ra8g==
X-Gm-Message-State: AOAM532sObTgTTk3Rk24D8CVlfqDSqJ2WGzrFDRTyyIyHJxE7KdJ4cDa
        zU49dC5xWzf0H0r8clyhRd0vYZUE4g5QvMJIQO9dig==
X-Google-Smtp-Source: ABdhPJz9Hms2/XF3IP6p1cXZykLJB9oFdtZz9zPVmVzMvn2dXBr8JMuEqE7NvkoTycurDcne+isPlg8hyKjkebWpY/A=
X-Received: by 2002:ab0:7259:: with SMTP id d25mr20626200uap.8.1636540811434;
 Wed, 10 Nov 2021 02:40:11 -0800 (PST)
MIME-Version: 1.0
References: <20211103011527.42711-1-flyingpeng@tencent.com>
 <CAJfpeguWtPFG_daMNA7=T-kQmgkcTPugMj7HWhh2mu+cwRWbxw@mail.gmail.com> <CAPm50a+pu0hB0WwjSkaz+F=BJEhD5mEjFfe019cZ7AGdO0t2Ow@mail.gmail.com>
In-Reply-To: <CAPm50a+pu0hB0WwjSkaz+F=BJEhD5mEjFfe019cZ7AGdO0t2Ow@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 10 Nov 2021 11:40:00 +0100
Message-ID: <CAJfpegusBqc7AsJK3+bT6Mp08UB3UN-oBn5K1yuzpgAC237DXg@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix possible write position calculation error
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 5 Nov 2021 at 08:44, Hao Peng <flyingpenghao@gmail.com> wrote:
>
> On Thu, Nov 4, 2021 at 8:18 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Wed, 3 Nov 2021 at 02:15, Peng Hao <flyingpenghao@gmail.com> wrote:
> > >
> > > The 'written' that generic_file_direct_write return through
> > > filemap_write_and_wait_range is not necessarily sequential,
> > > and its iocb->ki_pos has not been updated.
> >
> > I don't see the bug, but maybe I'm missing something.  Can you please
> > explain in detail?
> >
> I think we shouldn't add "written" to variable pos.
> generic_file_direct_write:
>                 ....
>                 written = filemap_write_and_wait_range(mapping, pos,
>                                                         pos + write_len - 1);
>                 if (written)  //the number of writes here reflects the
> amount of writeback data

No.  It's actually an error code in this case.

It is confusing, though, so I guess cleaning this up (e.g. rename
"written" to "retval") would make sense.

Thanks,
Miklos
