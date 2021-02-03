Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878AC30D61D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 10:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhBCJTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 04:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbhBCJTS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:19:18 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5480C0613ED
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Feb 2021 01:18:31 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a16so8077544uad.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 01:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HieUWQakppqVFKaj0BQObJQSQhAwBKtcNJ/Ujjq5bQs=;
        b=PH4qXvG65vp3rypsDQNApyOSIPvPqL9rwKkUnCB77vhRu0lVsRWwgKQymXzaug2qck
         TQkWRkF2abwn2GNKJgnoJZMSbzjZMTHd5ik+/CU5NHHRXIzb+zt4DI2ntCI1cRkM++oH
         O/xa1EmmkoQQBSW1SVVdgNp3ya/hXOmSJl6yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HieUWQakppqVFKaj0BQObJQSQhAwBKtcNJ/Ujjq5bQs=;
        b=tJ1f+NUInd6/qCLJO9m/OQfGr/jgDr2eMYzB9e7wPwQfvDd6NUnctrivBHDIEfSKOb
         +YRmfdIOzcEQJurNM18unJCya1DxFaBw/2fiSxfIywvDBpQvBanoFRqZV/XTtzPl0mOM
         8UNT4Ozuz8i8373f4qj+5cyo0/0I3c/E7LcEyMfEmt4uzQmDRJ5at9RWjvdcyUr1hVy+
         3UXiZB064xg0ZDFjy+XT72OJnDJ9QQD0g7D8tEG0MyWA5LcPejWLsxEAcGa8A0lOGFDI
         15dQLZbmuvQNJytVYA4BT6JTEVJSlx0fIz9KwFcZBi5iEBT7UQnTiIVT2dr9bYsYHIpy
         qLSQ==
X-Gm-Message-State: AOAM531p5lte1QHcbWv/M7f/npuM0Tdzp0iJsYXone5mwtTskX4Ebv+m
        eHN1sgNwtbJWJBTaHJg6qJB8ZcBUEXqK0LgX+ssAww==
X-Google-Smtp-Source: ABdhPJxwf2sCD64/0oc0ps4lfPf69qGb0E31UhqLBApx5EmO4JRcuUAn+Q9eUMiQgdIIw3a433jG5M3OUN05Yqq9AZ0=
X-Received: by 2002:ab0:2bc3:: with SMTP id s3mr1098247uar.74.1612343910829;
 Wed, 03 Feb 2021 01:18:30 -0800 (PST)
MIME-Version: 1.0
References: <CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com>
 <YBpnBUD+QoMW9NtL@kroah.com>
In-Reply-To: <YBpnBUD+QoMW9NtL@kroah.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 3 Feb 2021 17:18:19 +0800
Message-ID: <CANMq1KAPe8F2WVsxYnP46Zx7K_0YSpnAUgod1WjenhOcHRk2kA@mail.gmail.com>
Subject: Re: [BUG] copy_file_range with sysfs file as input
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Luis Lozano <llozano@chromium.org>,
        Ian Lance Taylor <iant@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 3, 2021 at 5:04 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 25, 2021 at 03:54:31PM +0800, Nicolas Boichat wrote:
> > Hi copy_file_range experts,
> >
> > We hit this interesting issue when upgrading Go compiler from 1.13 to
> > 1.15 [1]. Basically we use Go's `io.Copy` to copy the content of
> > `/sys/kernel/debug/tracing/trace` to a temporary file.
>
> Nit, the above file is NOT a sysfs file.  Odds are it is either a
> debugfs, or a tracefs file, please check your mounts to determine which
> it is, as that matters a lot on the kernel backend side for trying to
> figure out what is going on here :)

Yes yes it's tracefs ,-) But, from the other thread
https://lkml.org/lkml/2021/1/26/2029 sysfs (and any other fs that
generates files dynamically like procfs) would likely hit issues as
well (but maybe in more rare circumstances).

Thanks!

>
> thanks,
>
> greg k-h
