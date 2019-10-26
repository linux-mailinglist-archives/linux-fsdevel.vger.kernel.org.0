Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDC1E5D88
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2019 15:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfJZNus (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Oct 2019 09:50:48 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34427 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfJZNus (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:50:48 -0400
Received: by mail-yb1-f196.google.com with SMTP id m1so2245654ybm.1;
        Sat, 26 Oct 2019 06:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJVQ7Mv09uXIyzKs7wvvXIukFTb4yLcpL99WuS5X+PA=;
        b=ouYblJ5P3exdNPneKy0LQdLJ2nFgt2ffrWomDcmlW8pCIOG2kefa7xDF0XHJfPWhV0
         jsEaCnQKfYbMSmnf9/C5Zd6pmbse0JijToddl3pRQQEvUJmuetf1QAkJe9rT9R20J7FK
         dseET/3Kckitq+aaBY7yk4qSiULvSbbfRHRIBXra1XX6JF+3nNbNTe9rRZAFkzXlVRvH
         CFREbaCnDVEcI2OLYQQ3Nyg2H2UUwU1f6bujAhYrbGuw2Fvv1QkWGp1osM7CWH+vKWN2
         3xzP+Cs0oKZ1IFa5dmhptUTGY7tNk7E3MzpqkWcfVwhTTbatlVFm0QvAY5sJYE1OIJ03
         cb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJVQ7Mv09uXIyzKs7wvvXIukFTb4yLcpL99WuS5X+PA=;
        b=paLEUQ9ygZcH1Are1RkAwpLD8kn4CA6Eb+mSaffe2Pm3/6w00VFhUJwIoyDRzbWU6s
         DFUxG8R6dlJCNORFsKC9n9ec2hh633ZoT++jfBsOzX5uYMg8zctu1PK3Xx3ODEbdEoz3
         RoqSsqUTSy7DWVMeH7HDrIr6laHwZvQ9+wJwunv9A/mFUGw2QptRbyOexselRGlI7Y1a
         JjjDWmKYf1ieHlMrOrwDt9SpiLbwJqOSrRwL+XYiLpuQDhTmHfWd0iajMBkQ5uLHqMMV
         obq86Qxm1wgCoPjeHE6cgBNRp9Au4rLKKA21hpvNeo0Um79S512S4VWOF9FV/12DIU2c
         8obg==
X-Gm-Message-State: APjAAAXEemq1JsVJs0oEjY/+j7GEUGyqxDKENpAB35L7umZffcdJSFfe
        HWbJZyVn8eHSuWb8yjOhjJpZnj9uXp14zni5VIU=
X-Google-Smtp-Source: APXvYqw2bn2yJ4dFK6zr3Hlu16l33OFEV0IufFKMM0cFH1oFkBQZkL9mOnmytY6f3cGGelOryj7e6AQJEbsnTmux6Yo=
X-Received: by 2002:a25:3744:: with SMTP id e65mr555429yba.126.1572097845998;
 Sat, 26 Oct 2019 06:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191025112917.22518-1-mszeredi@redhat.com> <20191025112917.22518-5-mszeredi@redhat.com>
In-Reply-To: <20191025112917.22518-5-mszeredi@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 26 Oct 2019 16:50:34 +0300
Message-ID: <CAOQ4uxhRfDq49s-NCP5JK5VSYCZ+LXv2oMeyOReoLqq8LePkuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] ovl: user xattr
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 25, 2019 at 10:54 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> Optionally allow using "user.overlay" namespace instead
> of"trusted.overlay".
>
> This is necessary for overlayfs to be able to be mounted in an unprivileged
> namepsace.
>
> Make the option explicit, since it makes the filesystem format be
> incompatible.
>

Ach! this was tiring..
If you get to resubmit, please consider separating the plumbing
from the userxattr implementation.

Thanks,
Amir.
