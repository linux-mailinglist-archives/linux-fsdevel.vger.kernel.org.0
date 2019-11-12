Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDFDF965F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 17:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfKLQ4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 11:56:53 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37719 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfKLQ4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:56:52 -0500
Received: by mail-io1-f68.google.com with SMTP id 1so19486242iou.4;
        Tue, 12 Nov 2019 08:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HqwJXeNY9wk6z2+t/J/8K5zGxXhn1Q+H3q7mr3NuIM0=;
        b=lbfaVhljEpOI7EYfxB3HeVQRxYqUIq+gC/bIApH/dTVGxMV983jl+uPbDjF41nRql3
         FOel9WxXNe3P6/35QiHWkGKYhHQWYXi+/h3MiQC5xVLnPlOGiHXbTnWjEtiUKtiIY8av
         DHmv/ejyRRzheQlY4G+jGBwMUv8+n41gbh6lclYUZq8lqBrp4beZvsProiQMALL5kZNN
         15Bt0CJBZL8xKPgcRLCIFmLkdrOItPr0EHZdddjSjtrcdexhqLgT0qk/IC7Mp/dCkMUk
         l/8sCtftm4Wi8w1VEgNhVDnxWNkkQJRayMcZlVBPwMx9/MxM0Rlq5m8o2etPy8ALg8i4
         3F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HqwJXeNY9wk6z2+t/J/8K5zGxXhn1Q+H3q7mr3NuIM0=;
        b=nFBs42A+FGnRvMRD1CGBuurG8Bx6nbFsvrCs0kJ8Y/9GIZovCyHCQtd1zWS0i1x+Gs
         f0OCUP92/+fk5ZJT4pmSRROEipcWLTLR8rzo1mjDD4q9dXVZ3idfMnEcc5WViEGUMd97
         fIrRj26pXILn9MWhogOaHHgax/WKLPW0zfbWANT/hDq7A+ghVkPqAEccGt81Ws+Rgm9y
         U/m+11FDbMKRMuw2U5nYTKat3x8QYWmy3cMVzDyISf1uQzeNFK0AqNOcsumnsvOcRkLp
         k2j4kzk4oKC7L9dXctgsRYVLp1ODywAESSWdY/8HaH6GOchDTJw7T5BYoY6Wv5eqracC
         YZKQ==
X-Gm-Message-State: APjAAAWvIztj0zeR9rOxAd17RE4hjVueR/bfcCQNUxX9A2lU7F5ZgmFy
        8vlD0QxGw/Sd0VckyQeqXQ0MZs5pERiGO2E7E3g=
X-Google-Smtp-Source: APXvYqyzAJg7T4N6pMBCrhN9eKsAC4ZA5oYgjBdRuxuM8bVioMoZjAH6MhGw4WgK8qmX4B90VhovBACFUrMr60ejB3k=
X-Received: by 2002:a6b:e403:: with SMTP id u3mr31800360iog.130.1573577811692;
 Tue, 12 Nov 2019 08:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20191111073000.2957-1-amir73il@gmail.com> <CAJfpegvASSszZoYOdX9dcffo0EUNGVe_b8RU3JTtn-tXr9O7eg@mail.gmail.com>
 <CAOQ4uxhMqYWYnXfXrzU7Qtv8xpR6k_tR9CFSo01NLZSvqBOxsw@mail.gmail.com>
 <CABeXuvreoQkM1A3JBONtfD7uVLvC5MQ0hDRKX5rEQ_VUFGER8w@mail.gmail.com> <CAOQ4uxhH48Lso7ZLOngd904=YKFv8zbM=8oPfqYRPjD9fCzh7g@mail.gmail.com>
In-Reply-To: <CAOQ4uxhH48Lso7ZLOngd904=YKFv8zbM=8oPfqYRPjD9fCzh7g@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 12 Nov 2019 08:56:40 -0800
Message-ID: <CABeXuvqpyb5oQLuSLL5B6HvJNrd+Wn7ky6YezH5BLZ7O495mqA@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix timestamp limits
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 12, 2019 at 8:49 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Nov 12, 2019 at 6:45 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > On Tue, Nov 12, 2019 at 8:06 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Tue, Nov 12, 2019 at 5:48 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > >
> > > > On Mon, Nov 11, 2019 at 8:30 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > > > Overlayfs timestamp overflow limits should be inherrited from upper
> > > > > filesystem.
> > > > >
> > > > > The current behavior, when overlayfs is over an underlying filesystem
> > > > > that does not support post 2038 timestamps (e.g. xfs), is that overlayfs
> > > > > overflows post 2038 timestamps instead of clamping them.
> > > >
> > > > How?  Isn't the clamping supposed to happen in the underlying filesystem anyway?
> > > >
> > >
> > > Not sure if it is supposed to be it doesn't.
> > > It happens in do_utimes() -> utimes_common()
> >
> > Clamping also happens as part of current_time(). If this is called on
> > an inode belonging to the upper fs, then the timestamps are clamped to
> > those limits.
> >
>
> OK, but from utimes syscall they do not get clamped inside filesystem
> only in syscall itself. Right?

Yes, that's right.

-Deepa
