Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6EA1F9DCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 18:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbgFOQqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 12:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730976AbgFOQqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:46:32 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EE8C061A0E
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 09:46:32 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a9so20042033ljn.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 09:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZvZBCuCQSkLPs9g5InfZ9ThZzzENQM2asJ2hMImD+8=;
        b=ZWk3x5iEjnyTLq8IMemOkgARbFQCw/Q53/428riLywNB6u9f+bQvXVcEgFAYoeyppV
         fCCBULVD7KWfArLFv0AgIvtaFvWI/tVW+Ez2gZY7mm3zfsO/bpanBZ32Aq/zacBlYhG6
         8bUzNz2BvrW4v3rb3iq/l8f6ouqvyn24pdFzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZvZBCuCQSkLPs9g5InfZ9ThZzzENQM2asJ2hMImD+8=;
        b=PPaslxYCe47S20iICIBpYjRCjXviI9rRF0N+NWfP9bAqK7/tBf1EqTt9EkmKqvQLJY
         MRpCM+MKLNfCJWCK1mYHgd6Fo0T8ar70Cdd5oLsblNAWxA+b1Ii5JrPC8y06KtldarC8
         mfoAp8waR3wgEsi523gi0ByNa3YVp69T5ENuqbN2bdV8NySBWPOA54boNVZLKXPMAmbw
         bfDss7gi7Yos1QHFOKKb/r/3oYeT+yyLeCaF0JNkmq4gpl/f5nBWIM1utc+R0Zo8t7FA
         TeUibqNtnrM7xh4D+o9kx+ciBGaYnjk1F8eeHVVthYAzw7hNbszmE5x1JSdYh9MuBnau
         Yrxg==
X-Gm-Message-State: AOAM5308AA3xyHtmcedpSMj96umqIEtkOa3A0g/qMyh9RRNvQXCbWw40
        mAbUhHmpTNqGegdEEaUf9RCvrip8nV4=
X-Google-Smtp-Source: ABdhPJz7OdqOK1brpAF+75x5kVhwhrfcczJYM9sezDyIgPkyzF0GiZto1aO8zWD74a/cq8awGfjaJA==
X-Received: by 2002:a2e:5711:: with SMTP id l17mr12576248ljb.210.1592239590257;
        Mon, 15 Jun 2020 09:46:30 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id r22sm1698072lfm.30.2020.06.15.09.46.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 09:46:29 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id c12so9938543lfc.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 09:46:29 -0700 (PDT)
X-Received: by 2002:ac2:4422:: with SMTP id w2mr5160341lfl.152.1592239588691;
 Mon, 15 Jun 2020 09:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200615121257.798894-1-hch@lst.de> <20200615121257.798894-11-hch@lst.de>
In-Reply-To: <20200615121257.798894-11-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jun 2020 09:46:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBJjjV4NuKr_z2Q3vWEXSoGtAmkH=jZ0SkBJ=wZh4=hw@mail.gmail.com>
Message-ID: <CAHk-=wiBJjjV4NuKr_z2Q3vWEXSoGtAmkH=jZ0SkBJ=wZh4=hw@mail.gmail.com>
Subject: Re: [PATCH 10/13] integrity/ima: switch to using __kernel_read
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 5:13 AM Christoph Hellwig <hch@lst.de> wrote:
>
> __kernel_read has a bunch of additional sanity checks, and this moves
> the set_fs out of non-core code.

Wel, you also seem to be removing this part:

> -       if (!(file->f_mode & FMODE_READ))
> -               return -EBADF;

which you didn't add in the previous patch that implemented __kernel_read().

It worries me that you're making these kinds of transformations where
the comments imply it's a no-op, but the actual code doesn't agree.

Especially when it's part of one large patch series and each commit
looks trivial.

This kind of series needs more care. Maybe that test isn't necessary,
but it isn't obvious, and I really don't like how you completely
glossed over totally changing what the code did.

               Linus
