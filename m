Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05972DA6A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 04:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgLODHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 22:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgLODHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 22:07:09 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3179AC061793
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 19:06:29 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id w13so35568560lfd.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 19:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8AalwIW4PP8rwrt3wyiUpaOFXNpQFrbomiSOdcxppEg=;
        b=fYOz5UOQj6EzxrS+knSbYLj6/0hN69MAoew343SOLXxE2wqcZ7c5hwmXKh42X6emEY
         y4LsQ7fBXpuhAvamncrA+XdFG61bd8LsFke8+TtiPb3Lr4u7JIp8xuuYyYjYiYOVefta
         0URHS9JCMkv70gw2sJhA/FMrHOHpCg+fU1d7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8AalwIW4PP8rwrt3wyiUpaOFXNpQFrbomiSOdcxppEg=;
        b=caiwE3JDt2si0sq4+NNOl0q9GKFzoxr05Ekay3hz2LIkvSZUWtDToRCAGpd+lVpNP5
         EoQJAIjwVwZdzuEUY30EHYksZKzl5owMw3kIX5O9UXda9xKZYDWgXyUN9ydX1XS4CYdY
         IAsYrBZ/dSXdhgQVDrisXjEnUPNLCzZIRdoNl8Og3EoteUMsKBpWEaFWbLZXOCumN72v
         5rkHI9xlBA5LcRuElbPXcwTT00E8pulQYZKYj4rCHLxa1UiQoYH/6HpDiwUymRkbGm/5
         XZ5oGDtsO/y91uaNBqt0zIwwOPqdW5b/X1TfP0rKj/uB4kMMZKri/cvv8fOcLwxdJ1HH
         SznQ==
X-Gm-Message-State: AOAM531wGX8Lw9JLny59YmrpxnB9gbmOfub4AYvfuAaAy5PQuDGxaCfu
        fk/C9hBDC5gHWutFwhQulXS2khSe0+pgkQ==
X-Google-Smtp-Source: ABdhPJw4Bq2FUpdEe86as6v8twZPNkH+UQRWQBfTi/5W7L9VjSAge2RZCVn7OP3Ji9/jl0HA34WjpQ==
X-Received: by 2002:a19:4148:: with SMTP id o69mr10102389lfa.610.1608001587405;
        Mon, 14 Dec 2020 19:06:27 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id a16sm409811ljh.91.2020.12.14.19.06.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 19:06:27 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id m25so35534277lfc.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 19:06:26 -0800 (PST)
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr11914087ljc.411.1608001585633;
 Mon, 14 Dec 2020 19:06:25 -0800 (PST)
MIME-Version: 1.0
References: <20201214191323.173773-1-axboe@kernel.dk>
In-Reply-To: <20201214191323.173773-1-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Dec 2020 19:06:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh7-H541jDYiFYkJvmVKdbyUH9+zVKf+=y-SnMFEFEkZA@mail.gmail.com>
Message-ID: <CAHk-=wh7-H541jDYiFYkJvmVKdbyUH9+zVKf+=y-SnMFEFEkZA@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK / RESOLVE_NONBLOCK
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 11:13 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> I'm pretty happy with this at this point. The core change is very simple,
> and the users end up being trivial too.

It does look very simple.

It strikes me that io_statx would be another user of this. But it
obviously depends on what the actual io_uring users do..

             Linus
