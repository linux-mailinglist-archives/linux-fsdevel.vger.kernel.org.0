Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8E3321451
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 11:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhBVKoY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 05:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhBVKoX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 05:44:23 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5C8C06178A
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Feb 2021 02:43:43 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id r19so3880970uak.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Feb 2021 02:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGx+p/p8owpmSUDwuRNhpCccOX1UMZKYVIz5GlkKCFU=;
        b=Tp5HhHQ+7xXusDThp42v+uu1IuDrtCMsElwRUTwklw6OAANyUZamlep3jeesXQ3r2n
         2nQUkmipbZ8GLS/LYt5iO86fGJXF5SGRo2aoPxVtPG62UBwBlP3uipkUyIqUzmnl3kgP
         roh7CEVN6hRKr3uPUFVXgxVv8fy0ni79lppaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGx+p/p8owpmSUDwuRNhpCccOX1UMZKYVIz5GlkKCFU=;
        b=MecfZMkNFeM6V6GUjqa26ersW5sWh+DFzYku+P6AgVHJE/9jtY8wxzzMInPW4Z4XSF
         ybpy1NJfrdMpBLtJKBgDqvtYQPn9fYbTnsQmPphZO5t0nAl2aE6okdZcmh+cbEF1BqI5
         C0bunhzvpSSYV3wco3W38hmVcpFIXUPjYWooMVP3qGzyDzAf7Y71OYJF9jlgLFr8pQ24
         /eedmiN48qlSD4FUrWeIc3IK3cHE2qRLMGtEZOP3cZGdcReSAzaxwo94/7k2cSqJKqN/
         3ug50Cew2OAj1OE3EWGKau6GRQN2BV+EMmq1LOhfzCMhQ8UYSp20ZR3LB19liV/l/9Pb
         wrWg==
X-Gm-Message-State: AOAM5337Yb3f2cP4viKPJbuVbS8KueeTjg6fqe0xhcG8YJRqkQYyRL1M
        uDUL/XXJQw1JegYLcH9h4/lRtVD3K2W94yNhntneaV3Fqwcp2w==
X-Google-Smtp-Source: ABdhPJx5UpSYlBUPqyAmUQddxEyygTUykeG5B0X0CaMz97S+x8dtQPvYmbt/aAUhig3HHaD3+naBIdUR3ZDW5TowCWg=
X-Received: by 2002:ab0:5963:: with SMTP id o32mr13463482uad.11.1613990622153;
 Mon, 22 Feb 2021 02:43:42 -0800 (PST)
MIME-Version: 1.0
References: <CAF6XXKWCwqSa72p+iQjg4QSBmAkX4Y5DxGrRR1tW1ar2uthd=w@mail.gmail.com>
In-Reply-To: <CAF6XXKWCwqSa72p+iQjg4QSBmAkX4Y5DxGrRR1tW1ar2uthd=w@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 22 Feb 2021 11:43:31 +0100
Message-ID: <CAJfpegsJ0kWcGS1Si1dWHmpORKk3c7PUNO2tJdh3_W2YWmY5gg@mail.gmail.com>
Subject: Re: [BUG] KASAN: global-out-of-bounds in __fuse_write_file_get.isra.0+0x81/0xe0
To:     Marios Makassikis <mmakassikis@freebox.fr>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 21, 2021 at 2:30 AM Marios Makassikis
<mmakassikis@freebox.fr> wrote:
>
> Hello,
>
> I hope this is the correct list to report this bug I've been seeing.
>
> Background: I am testing a kernel SMB server implementation
> ("ksmbd": https://github.com/cifsd-team/cifsd).
>
> As part of my tests, I tried having a Windows client store a backup on a SMB
> share that is backed by an NTFS formatted disk. In doing so, the kernel
> reports a BUG and locks up (either immediately, or after a few minutes).

Seems like fi->write_files list gets corrupted.

Is list debugging turned on?

Can you get a crashdump, and see if the rest of the fi structure is okay?

Thanks,
Miklos
