Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F69158CFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 11:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgBKK4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 05:56:00 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:43265 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgBKKz7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:55:59 -0500
Received: by mail-il1-f193.google.com with SMTP id o13so3038432ilg.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 02:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/ip/rGfkF7G/a6O30OvCDbXytusxYnQXnVEqCr+9FAQ=;
        b=k6I0EA0094zzaaYZwbZeS99DaTzpQusIutEmeqRj1UtEdjv0Vh3LOf6XO1D0Bm/peU
         5D5r3PKLynXB0MvhlV0ILEuPXhlx0Z/pp7Zu4XZGdcRfCKrwOliMh7ZPi4sedDdBcid/
         zqQBSheUtB8mg8pvzIlBj7yOuJb19GWr7//Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/ip/rGfkF7G/a6O30OvCDbXytusxYnQXnVEqCr+9FAQ=;
        b=k7a1EaV8mRgc/8f47eaQ7UXLZ42vCzDjFBq67BRkY4UBhXxPqI9ekT4UHcNT5YJTaz
         I1wYHQI1XpNZawwA3sLyzh11kVEunlNE5SpgEPZBPcl6s1jptYTxdfA0uLEc7KVjYKl8
         PgvTHdxW8bEda1wR87XMZu7tWUoVUkhqKNbY9ppr8s8W5eYCl8NMNkYSqCvgL1Xi+Pdn
         bXnVVdl/8PrYDoWPZkokraKt14pVOcCQ+0gnCeVtxs9OWxMwv4tT2Hfp4fN6BmiElusV
         xZ+iEU03jjWDv7Fiqt439/5FFIIIDA0d5ZEF4G50aSAPID3WMLpta9wsfuKdW6NlJJXr
         RKRA==
X-Gm-Message-State: APjAAAULZRNM1IAPYGyuhVLIoci1ivHSib9S63LfKqaKTEb65+YOo3nz
        4PFgfX0JTVSt3Kat9y+Y6z/lcTXqeghiW6N11wYxV4Qu
X-Google-Smtp-Source: APXvYqyG1RSF3lCIDiXWjx7JsJ8UmF3VhDB5MzH7ll4xhEJWj8zjGQdeG4rb9OxDTACRSBDR6cbzpWfO3/2tQV7BEV8=
X-Received: by 2002:a92:5d8d:: with SMTP id e13mr5633269ilg.285.1581418557300;
 Tue, 11 Feb 2020 02:55:57 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegtUAHPL9tsFB85ZqjAfy0xwz7ATRcCtLbzFBo8=WnCvLw@mail.gmail.com>
 <20200209080918.1562823-1-michael+lkml@stapelberg.ch>
In-Reply-To: <20200209080918.1562823-1-michael+lkml@stapelberg.ch>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Feb 2020 11:55:46 +0100
Message-ID: <CAJfpegv4iL=bW3TXP3F9w1z6-LUox8KiBmw7UBcWE-0jiK0YsA@mail.gmail.com>
Subject: Re: Still a pretty bad time on 5.4.6 with fuse_request_end.
To:     michael+lkml@stapelberg.ch
Cc:     fuse-devel <fuse-devel@lists.sourceforge.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 9, 2020 at 9:09 AM <michael+lkml@stapelberg.ch> wrote:
>
> From: Michael Stapelberg <michael+lkml@stapelberg.ch>
>
> Hey,
>
> I recently ran into this, too. The symptom for me is that processes using=
 the
> affected FUSE file system hang indefinitely, sync(2) system calls hang
> indefinitely, and even triggering an abort via echo 1 >
> /sys/fs/fuse/connections/*/abort does not get the file system unstuck (th=
ere is
> always 1 request still pending). Only removing power will get the machine
> unstuck.
>
> I=E2=80=99m triggering this when building packages for https://distr1.org=
/, which uses a
> FUSE daemon (written in Go using the jacobsa/fuse package) to provide pac=
kage
> contents.
>
> I bisected the issue to commit
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D2b319d1f6f92a4ced9897678113d176ee16ae85d
>
> With that commit, I run into a kernel oops within =E2=89=881 minute after=
 starting my
> batch build. With the commit before, I can batch build for many minutes w=
ithout
> issues.

Pretty weird.   I'm not seeing how this could change behavior, as the
args->end value is not changed after being initialized, and so moving
the test later should not make a difference.

Could you print out the complete contents of req->args?

Thanks,
Miklos
