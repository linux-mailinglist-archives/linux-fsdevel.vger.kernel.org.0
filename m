Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 263B6F9515
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 17:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKLQGZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 11:06:25 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46584 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfKLQGZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:06:25 -0500
Received: by mail-yw1-f65.google.com with SMTP id i2so6590278ywg.13;
        Tue, 12 Nov 2019 08:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypu9S5NRvgB1jgf0WfQSzfM4hFIMr3jgA84CuN2cuZQ=;
        b=JEu52vo3k/XO0Svx0DDr5qhOveZFNH2IoyTYnXmjUBWyKkTN5HKsNQ3pd4nsSyDYeJ
         pePuV4Hm9bRhfp+Oim4K9utU3xWx5pIOHEzcj5i8Ve3JkPECWxDapG78EDLGvlESH68B
         fXkPATCxKzJN8QTw6y0DE7qP30Cg26D//106lpkurbgbP8Q6aB/jcPZcp0Ds7NhQqGdT
         rYDBHw6uKVBY5Kb99HsHcrNK2fObdu9zXU3IhZNdGDm9M3V1ntbVH0M1ORnVQ3Kte962
         4gCaZRxCNK5JH61t1ybe+ieLa0t+E5xZtauYdp8p5UoJ9c1PvN5uk0KpvYFIVuWVPPN/
         lD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypu9S5NRvgB1jgf0WfQSzfM4hFIMr3jgA84CuN2cuZQ=;
        b=sf0w0RwwARFGvT/Z2D0uY9qY3Gq7hcq6Kd7I2G2fN6A1VS7AYMAC7mUATrJDbjfQl3
         USeYVvyC5kKizcp3y/e6FqQM66HdSNBwUVsouoGoRftq/0Xi26Op1iifn18wu0X5OaZZ
         LbnP5cBJOX5k/rJ54VO5Epm/Wv5mcgNKxYZstXtNzeWZ9iQxogqDDmi5KFTfv85te706
         j2KOJ1vjGiQODFuMOo8J68sGf0++ujMzJIWLb1CpNyaDIsTVA9BxY6S4aTTmYLaTTPo8
         CDiReoZnngAhfIUIT5bB5dMreody3VwSi1qXsgFVgYB0pIyny5Sq1+ioZFQEMcizOZJu
         E5Qw==
X-Gm-Message-State: APjAAAUXqxOf//LIxFJ/cABpNUIVoBs/ptoQIAwnzrjzCv8tp1bI3MLv
        oFUojlF/5XoD45xqgkI4IcpfcX+QG4b5S5GDfEw=
X-Google-Smtp-Source: APXvYqz5T+lthf9ksExwvifc1gSq7vIf5VEAzIpb/3uz6BwomyXeVa0psdem1gn1oiJcnNlQS2UsH/XNRApncx1woZk=
X-Received: by 2002:a81:234c:: with SMTP id j73mr20534364ywj.181.1573574783924;
 Tue, 12 Nov 2019 08:06:23 -0800 (PST)
MIME-Version: 1.0
References: <20191111073000.2957-1-amir73il@gmail.com> <CAJfpegvASSszZoYOdX9dcffo0EUNGVe_b8RU3JTtn-tXr9O7eg@mail.gmail.com>
In-Reply-To: <CAJfpegvASSszZoYOdX9dcffo0EUNGVe_b8RU3JTtn-tXr9O7eg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 12 Nov 2019 18:06:12 +0200
Message-ID: <CAOQ4uxhMqYWYnXfXrzU7Qtv8xpR6k_tR9CFSo01NLZSvqBOxsw@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix timestamp limits
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 12, 2019 at 5:48 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, Nov 11, 2019 at 8:30 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Overlayfs timestamp overflow limits should be inherrited from upper
> > filesystem.
> >
> > The current behavior, when overlayfs is over an underlying filesystem
> > that does not support post 2038 timestamps (e.g. xfs), is that overlayfs
> > overflows post 2038 timestamps instead of clamping them.
>
> How?  Isn't the clamping supposed to happen in the underlying filesystem anyway?
>

Not sure if it is supposed to be it doesn't.
It happens in do_utimes() -> utimes_common()

clamping seems to happen when user sets the times,
so setting the overlay limits to those of upper fs seems
correct anyway.

Thanks,
Amir.
