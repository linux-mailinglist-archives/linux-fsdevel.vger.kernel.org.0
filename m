Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663663034B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbhAZF0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbhAZB3o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:29:44 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE877C0698D3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 17:28:55 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p21so15523466lfu.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 17:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eCBiVPLnNd99s9ixAeOAKiUEku0CKs85XbwIxF+qIiU=;
        b=LKe3NezafxofVDDFMckuJejnvRhI98RhnDFXvBKXGftcSflu2cCY4yPblP7gnkxnWY
         6nyy8Lng59qDw3xg86xE7YL+nsgf/Da4VzTjdVrdeAKrrgl4DiwcDMsjCfhZE9OSQfrG
         1tuZInnROaBkJou88CLzvrHw6RmAC4/LrchEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCBiVPLnNd99s9ixAeOAKiUEku0CKs85XbwIxF+qIiU=;
        b=mS1jseWxbAUnfqlA7pzqK7RWk+e/Po6esVleEnfru1pYGmNqm6cNxwrsnx1nsZF72W
         2rP22BHXmFC8Lws2KEomaeYY6X/Q6U/xjQ+zlhTtiT+Cbd3P9I+qvEWaUcFy0UEqWGgB
         tv7qgKNkDzF8OoAgUWtRI4xMe8Y4yVPatF6iGq6duE4Zw1eDsNjjo+GcTd9WR36C1sLU
         x4DI70wOdkjezWQjUzGptFhrY7m4ZIpAFX5bEBkyKqAGN23ev9/lb6nk3BWio1bu3H/D
         Fws1Jf6KE3K1fhBYv1WnZf62HOFr2Fl+cD4KmVeM8BDxJ/thyZyfHEn9ggfjm8WU/Fiq
         IBaw==
X-Gm-Message-State: AOAM531ycUsCNiqimrbMHr89sQuDL8wcok2XfXC8UTI5EGlEfJZ1pVzV
        8gNEhOZX/mWfUWft/hc+YVyuFsbs6gUEzw==
X-Google-Smtp-Source: ABdhPJx4HI6TyQ8Y4vOhxqHCLpfm1QAAQvYzm+OK+xie8VbNkNAtVEHj/UQ1+nVnJAtKd0NEHcRS9g==
X-Received: by 2002:ac2:4249:: with SMTP id m9mr1616590lfl.594.1611624534066;
        Mon, 25 Jan 2021 17:28:54 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id f6sm732388lje.127.2021.01.25.17.28.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 17:28:53 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id v67so20631260lfa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 17:28:52 -0800 (PST)
X-Received: by 2002:ac2:420a:: with SMTP id y10mr1414183lfh.377.1611624532705;
 Mon, 25 Jan 2021 17:28:52 -0800 (PST)
MIME-Version: 1.0
References: <20210125213614.24001-1-axboe@kernel.dk> <CAHk-=whh=+nkoZFqb1zztY9kUo-Ua75+zY16HeU_3j1RV4JR0Q@mail.gmail.com>
 <4bd713e8-58e7-e961-243e-dbbdc2a1f60c@kernel.dk>
In-Reply-To: <4bd713e8-58e7-e961-243e-dbbdc2a1f60c@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Jan 2021 17:28:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgdL-5=7dxpertTre5+3a5Y+D7e+BJ2aVb=-cceKKcJ5w@mail.gmail.com>
Message-ID: <CAHk-=wgdL-5=7dxpertTre5+3a5Y+D7e+BJ2aVb=-cceKKcJ5w@mail.gmail.com>
Subject: Re: [PATCHSET RFC] support RESOLVE_CACHED for statx
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 5:06 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Which ones in particular? Outside of the afs one you looked a below,
> the rest should all be of the "need to do IO of some sort" and hence
> -EAGAIN is reasonable.

Several of them only do the IO conditionally, which was what I reacted
to in at least cifs.

But I think it's ok to start out doing it unconditionally, and make it
fancier if/when/as people notice or care.

              Linus
