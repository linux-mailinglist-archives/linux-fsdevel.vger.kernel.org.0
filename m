Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35D446BD7D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 15:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbhLGOZt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 09:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbhLGOZq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:25:46 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DE0C061354
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 06:22:16 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id t13so26809622uad.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Dec 2021 06:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQDlZzI4YqfVWHIX5QaOd6zM0lzVL2dM+3VnuSJR0mA=;
        b=NSnWVkdDCBtXAk7+eeopHZNK+S0TVba9JEn4wSb2+CM2PDLuvE/odxCjZo7Paj7o3b
         oIYxcmfp6t3DW28++ABkUyJx65cdgHuxzzH1IB8osep2OI+zpqylv3TwdyWQS1l902YW
         +2NwM7DhKARADWEwOFjYg3BQ+9wrEM55dil00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQDlZzI4YqfVWHIX5QaOd6zM0lzVL2dM+3VnuSJR0mA=;
        b=1hDSaFJf+SQNal12mc12SzAI24WupSbdBIiFckXpRElDLav/8s4MJm99DtEFcICncK
         fdnrA5gY91IXXuwSRtwBW257GDdxpSExLu77hJZbMYD1Q6XTIwUnX6Ve565vw3ZFaNA2
         +ggpyhUEZj1hG4xgnlbhZZYQm4ED00vMv4jfndjy213LqKiQ18CD/ylaTuHarwod77Qx
         Y9HeUD2z/Bl7icyn9fi7TclF29OWv82kvo5lBQHmJQCVeNa10WOjghTObWZrw4v6lrlw
         fnXTnJ1xm/LZj/C7GjDRnlNtIIbJqyjCY438pogRvhT8aBWBtZH8iOWAWE9afH1AJ67U
         J16A==
X-Gm-Message-State: AOAM533jR2d+GLnobQW6bBhXzA40AmtzxIQfV25njj2eVmDfb4PFOGQR
        /zklc07nriuW/jJexLrYqM0wZ/sHg/13VIqmqVfW6g==
X-Google-Smtp-Source: ABdhPJxydYk9zxnXvjH5UqlJ9uhVqOyq4iaYSPDZFhiXSY1qD1M8aFu4dMRPSNRow3A9MkTnXpod9djgCG23n5S1gNc=
X-Received: by 2002:ab0:36c4:: with SMTP id v4mr50753238uau.8.1638886935724;
 Tue, 07 Dec 2021 06:22:15 -0800 (PST)
MIME-Version: 1.0
References: <20211122090531.91-1-xieyongji@bytedance.com> <CACycT3vHBUpSsDEseovmJHJm3o=pcKcOEee7J-1eumUomJO00w@mail.gmail.com>
In-Reply-To: <CACycT3vHBUpSsDEseovmJHJm3o=pcKcOEee7J-1eumUomJO00w@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Dec 2021 15:22:05 +0100
Message-ID: <CAJfpegsc1TP0LpqpHgPdj4QyJNR0wxFbHuOLXTt8hksFeR++sQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: Pass correct lend value to filemap_write_and_wait_range()
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 7 Dec 2021 at 12:30, Yongji Xie <xieyongji@bytedance.com> wrote:
>
> Ping.
>
> On Mon, Nov 22, 2021 at 5:07 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> >
> > The acceptable maximum value of lend parameter in
> > filemap_write_and_wait_range() is LLONG_MAX rather
> > than -1. And there is also some logic depending on
> > LLONG_MAX check in write_cache_pages(). So let's
> > pass LLONG_MAX to filemap_write_and_wait_range()
> > in fuse_writeback_range() instead.

Looks good; applied.

Thanks,
Miklos
