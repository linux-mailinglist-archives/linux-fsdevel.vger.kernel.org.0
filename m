Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6C0207A23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 19:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405501AbgFXRTx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 13:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405474AbgFXRTh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:19:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153C0C061573
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 10:19:36 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i3so3460693ljg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 10:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnO8hKovA7hP7JvwvjuDQY7Jzg/02N7Frk2urzNRpI4=;
        b=P4yma5zFPApj98Kr5mjr+nS/v3AyFaHaehqB4iRF6Laev6mPoAvKUOpXS81ZdH52io
         MBVLjtssxRQN2czblUcwihfke8lVaDX2X0b0qkoR7A/UTBs4xokVujZODTlvBx7KgXeX
         3VC6Jav+FZPi4s3KLN6PaNUXdSrLsqzenGGdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnO8hKovA7hP7JvwvjuDQY7Jzg/02N7Frk2urzNRpI4=;
        b=EoocSEcjROEMVXiGQOhtLwjICuaJKD3ZJk/1iT39jRFIyEFKtd4kiU9UiDXhFdtAuK
         iJKZJh6oe+oO1xQ6UYGA1vPGqo4Ewg3rWwV+aadIVkSqU6rm5Q6x0H+6NfK2BeRj5c2V
         akznHyDI7XAOVln58aP/G4vFvQqMBpTfX3G/dphEZonKrGhaV1V4NDx9/3SZWQboiUkD
         sdg1PbCvy1rMzwpd57OCta6nGKN3i1VwiAqwUIe0AvdCXPlZ7VYVrU715yq5nwl4B+HC
         dcIHsbOmcge/9RTb6eDBDz5JNpXp7Q6tcM2W+/iKiGYgdovLG8GkMNprAjMHzfkPcubL
         pifQ==
X-Gm-Message-State: AOAM531UB4lAhpMQ6CC0lRnd+aVmtG8t0c/epSttp/6OdVIbDHoBKejz
        7Y5W3BLmDzGKmR/zN10xAP5d1CvKMn4=
X-Google-Smtp-Source: ABdhPJy0WsrJgK0y3k9gO0oFT7f+ZiCFKi72bAEq4ax2A62WwSxla7Z8yinfzLBCLxibxhJhQWBdZg==
X-Received: by 2002:a2e:9dc2:: with SMTP id x2mr15259082ljj.22.1593019173925;
        Wed, 24 Jun 2020 10:19:33 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id r9sm4282559ljj.127.2020.06.24.10.19.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 10:19:33 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id y13so1689561lfe.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 10:19:32 -0700 (PDT)
X-Received: by 2002:ac2:5093:: with SMTP id f19mr16132062lfm.10.1593019172581;
 Wed, 24 Jun 2020 10:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de>
In-Reply-To: <20200624162901.1814136-4-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Jun 2020 10:19:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
Message-ID: <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file operations
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 9:29 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Add two new file operations that are identical to ->read and ->write
> except that they can also safely take kernel pointers using the uptr_t
> type.

Honestly, I think this is the wrong way to go.

All of this new complexity and messiness, just to remove a few
unimportant final cases?

If somebody can't be bothered to convert a driver to
iter_read/iter_write, why would they be bothered to convert it to
read_uptr/write_uptr?

And this messiness will stay around for decades.

So let's not go down that path.

If you want to do "splice() and kernel_read() requires read_iter"
(with a warning so that we find any cases), then that's fine. But
let's not add yet _another_ read type.

Why did you care so much about sysctl, and why couldn't they use the iter ops?

                    Linus
