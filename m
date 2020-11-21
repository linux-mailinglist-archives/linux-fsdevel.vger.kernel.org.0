Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85242BC166
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 19:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgKUSXe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 13:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgKUSXd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 13:23:33 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5CEC0613CF
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2020 10:23:33 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id 74so18115101lfo.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2020 10:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7cZfFDWETupzrz1W/PA0N75+saduUeI+gk15nXI7Q0=;
        b=dH00Lj87XUWDjVhZTS31u5fK+b2ZiXmaVewWBK/V48aWDdpvmlY8lYEZ3TsPZy+JuP
         Piggiet9UE2qE2SNHmspoYRK7bxHTomINqVwsLJcANApC/MOgACoEjU5ZxHckGmnDp1N
         lQ0V7X3C4QU5N8npwm/3beAXsfs54Clu8S4xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7cZfFDWETupzrz1W/PA0N75+saduUeI+gk15nXI7Q0=;
        b=bB4n1sl6K77DfMsR/em/tEg4MNDJ4RRkzL7alJKNAdEr8GUb28l655WOPd/xoj9wKI
         6X417MHB+SLJ6e8LSRLhB5VC4WW5RxPvBiIzugM2tWPHYVMDCxNUveSalACqJpJd8Ahf
         Cjx7+7GBCLlXihB7beDazuyAa5Y8wBjCQCuVg0f0DYzUsyHhsn/6Fwtobx660AloeEDV
         /Wo/1GI0fz4VrAhyJvJoqlm3gHrIbmnPZTmAmfo4Vs6ZGr3wqXthxhBVHZo5d4B2oRYV
         U+cjekO8/ea89iaooUZ05ohLstqr2sactQZQXCyPPOL4SQt+t+QZIoFD1XK30gbiK3ts
         v6DA==
X-Gm-Message-State: AOAM530CcAvtbXfGWzzaqxm7bsv4EAymkB1Z/Vsfxg6M6AhvlHT+/gwO
        9qj3DHpngvdxQoXBYQzgM13dStR7AtT2lw==
X-Google-Smtp-Source: ABdhPJzd2OvZi9jnSdyBWcr2hXMa/u1DW25iIuhf7O/P6EXJ8ni9ydApp9rPzuExuCYQObQLNcbPwA==
X-Received: by 2002:a19:7e8c:: with SMTP id z134mr7059648lfc.388.1605983011646;
        Sat, 21 Nov 2020 10:23:31 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id g8sm689280ljk.66.2020.11.21.10.23.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 10:23:30 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id u18so18103869lfd.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2020 10:23:29 -0800 (PST)
X-Received: by 2002:a19:ae06:: with SMTP id f6mr11146486lfc.133.1605983009454;
 Sat, 21 Nov 2020 10:23:29 -0800 (PST)
MIME-Version: 1.0
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Nov 2020 10:23:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj3p3eScaULtpCtWwS9NGFxT7dVTTC3mg1VyAyO2L5j7w@mail.gmail.com>
Message-ID: <CAHk-=wj3p3eScaULtpCtWwS9NGFxT7dVTTC3mg1VyAyO2L5j7w@mail.gmail.com>
Subject: Re: [PATCH 00/29] RFC: iov_iter: Switch to using an ops table
To:     David Howells <dhowells@redhat.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 21, 2020 at 6:13 AM David Howells <dhowells@redhat.com> wrote:
>
> Can someone recommend a good way to benchmark this properly?  The problem
> is that the difference this makes relative to the amount of time taken to
> actually do I/O is tiny.

Maybe try /dev/zero -> /dev/null to try a load where the IO itself is
cheap. Or vmsplice to /dev/null?

         Linus
