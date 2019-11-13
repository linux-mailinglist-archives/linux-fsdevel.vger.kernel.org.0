Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C36BFAE6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 11:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfKMK00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 05:26:26 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36842 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKMK00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:26:26 -0500
Received: by mail-io1-f67.google.com with SMTP id s3so1953259ioe.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 02:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AShlT2NMuDzRkz8rOdqEHOGvn4UNwyVi7xeYItaRgrA=;
        b=NhuETSqrfqHDbGzgpPIaNKNagTdOgUz32ujfB+c45DjadHYYQJvlAZ0XGAK1X/MSBl
         66+GUNJsKic9x/G6mo1Yi0+Nn0H8kg1J79Ukw2oKQD2YcAMngWotLGI+NrIsgZT44tuR
         oOlAEDoYFwa0URw4W1STQQepzlm/PDv5FgR+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AShlT2NMuDzRkz8rOdqEHOGvn4UNwyVi7xeYItaRgrA=;
        b=b1KXeA/TYTePrh9i22Cf3h5w0ctgAlF9gEsQy1mceNEoSPLmKqtE5kookibP8fwZWk
         plJ95P4b/es8rrKTeZAafDGpCw2XdlKBDpnERHjXCLhWljuRHZhRFuI8wj1gZb7KAhWf
         y4jsJv65W1nCg2IYMueoKCi/s3amcPMObQfTrwnudQfnL260QJBnw0iBiP8S5I29Pbfi
         XwgB2oBz6dofzdhRMTLafy3+SPCN93lMAJnNUZ05DjyjbalKy4cYvLZ9HqRbHUcsAhWq
         eyz4dlYgCmMPkkJ4Be83if4gnrP3NVIcIsv+O2LWFZKXGzudJDSdaUGpboRxBwmf2m0A
         G/QQ==
X-Gm-Message-State: APjAAAXOiQrTghUkWdNnqnndnvDqVi7pxw8NkAM1beTx5JrzBg2REgnA
        VFv03zR1P01lQJBK/Qm7tsDt0vEPxgMLgjnSyZrvWlvI
X-Google-Smtp-Source: APXvYqyMHNP4A1goS5VZQeC36febOXqlyFVvxXyFyHq1h1A/RgrbDZjRFAoroTPCP1PYc7PXGpXyUVfdyUk9ETlPA8o=
X-Received: by 2002:a6b:b296:: with SMTP id b144mr548532iof.63.1573640784042;
 Wed, 13 Nov 2019 02:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20191111073000.2957-1-amir73il@gmail.com> <CAJfpegvASSszZoYOdX9dcffo0EUNGVe_b8RU3JTtn-tXr9O7eg@mail.gmail.com>
 <CAOQ4uxhMqYWYnXfXrzU7Qtv8xpR6k_tR9CFSo01NLZSvqBOxsw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhMqYWYnXfXrzU7Qtv8xpR6k_tR9CFSo01NLZSvqBOxsw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 13 Nov 2019 11:26:13 +0100
Message-ID: <CAJfpeguvm=1Dw7V4XTr4gyo3uK+-EFNYKeDCFvUmuMPJxA=TcA@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix timestamp limits
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 12, 2019 at 5:06 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Nov 12, 2019 at 5:48 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, Nov 11, 2019 at 8:30 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Overlayfs timestamp overflow limits should be inherrited from upper
> > > filesystem.
> > >
> > > The current behavior, when overlayfs is over an underlying filesystem
> > > that does not support post 2038 timestamps (e.g. xfs), is that overlayfs
> > > overflows post 2038 timestamps instead of clamping them.
> >
> > How?  Isn't the clamping supposed to happen in the underlying filesystem anyway?
> >
>
> Not sure if it is supposed to be it doesn't.
> It happens in do_utimes() -> utimes_common()

Ah.   How about moving the timestamp_truncate() inside notify_change()?

> clamping seems to happen when user sets the times,
> so setting the overlay limits to those of upper fs seems
> correct anyway.

It does seem correct, I just think moving the truncation into the
right layer would make more sense.

Thanks,
Miklos
