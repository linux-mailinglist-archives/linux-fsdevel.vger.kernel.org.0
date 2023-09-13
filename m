Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C1C79EFC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 19:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjIMREV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 13:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjIMREU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:04:20 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1E6CE
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 10:04:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so2563827a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694624655; x=1695229455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oxh7tqf52Etrnl44vNn20JbZtKnr/hhWHqieQOu3iEs=;
        b=Z+KMnUC/fUibh8JgMD0cCrXgzIjsIuCGoVYFRtfB/5KVc3rjmBh+2BONQmDRBz6dn7
         jQ4dghXPAdRoY93f860dXhj9wtYFgTmh0QxEdfxrGcv8lOS0mYjdE0f9gUUCT2kEsEpZ
         RAzj42zM3u5IWyVqkptlBfzrmuK4Fb5p1fhJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694624655; x=1695229455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oxh7tqf52Etrnl44vNn20JbZtKnr/hhWHqieQOu3iEs=;
        b=HQgD8H7Yt7p2tdUOfdBtJRY1/AgouOQ7pyTNT++XTHOxoY8W2QPJJ/z3dQeUbHQJ4t
         HEoUdCcN8+8tbL/IIw04Zncu/ZTM7zFBXrp7PpNe3qCdH/wzl2WPc5v/9Ir/xoQnAEM7
         /ck2hxN0+zMFT2DCPfnvi0ytlY2n2SN51DdwmKp4fGi7TPM0g0hwsHcYnlhGfqsvowEO
         0X735Z2ckUX2cbrE5fiEdXiU5glYzs7TIPrWNcuWOw0fwHuDX+yHs6zib8UjAlIosLoN
         kty4BOTbN7SSvyg3JuqVXNkSlPDxyXlHjej87wAleBueS8c1YcUxXiK6AmWDGeFsvb4z
         kY/Q==
X-Gm-Message-State: AOJu0Yy3BH4eVL0kjdO+e7Nhg2F1z7i5sJVwfxfwkB5R0I6EK7IIGWSl
        BSaNBlrKCVt6/7xT9VvtFRrgiEK3mebZvipM59vz9ss8
X-Google-Smtp-Source: AGHT+IFcQrUCYNrXXPIqb4Q3Y3sohY2whQA8miQkxwbmN2y0nhAbo90Vgh7LpySb9PcGjEdWqbiaNA==
X-Received: by 2002:a17:906:1dd0:b0:9a2:1e14:86b9 with SMTP id v16-20020a1709061dd000b009a21e1486b9mr4346401ejh.0.1694624654881;
        Wed, 13 Sep 2023 10:04:14 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709064a1400b00991faf3810esm8806578eju.146.2023.09.13.10.04.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 10:04:13 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9a9d6b98845so266017566b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 10:04:13 -0700 (PDT)
X-Received: by 2002:a17:907:96a4:b0:9a5:c38d:6b75 with SMTP id
 hd36-20020a17090796a400b009a5c38d6b75mr9352280ejc.15.1694624653071; Wed, 13
 Sep 2023 10:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <ZO9NK0FchtYjOuIH@infradead.org> <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area> <20230906215327.18a45c89@gandalf.local.home>
 <ZPkz86RRLaYOkmx+@dread.disaster.area> <20230906225139.6ffe953c@gandalf.local.home>
 <ZPlFwHQhJS+Td6Cz@dread.disaster.area> <20230907071801.1d37a3c5@gandalf.local.home>
 <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net>
In-Reply-To: <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Sep 2023 10:03:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
Message-ID: <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Dave Chinner <david@fromorbit.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 13 Sept 2023 at 09:52, Eric Sandeen <sandeen@sandeen.net> wrote:
>
> Isn't it more typical to mark something as on its way to deprecation in
> Kconfig and/or a printk?

I haven't actually heard a good reason to really stop supporting
these. Using some kind of user-space library is ridiculous. It's *way*
more effort than just keeping them in the kernel. So anybody who says
"just move them to user space" is just making things up.

The reasons I have heard are:

 - security

Yes, don't enable them, and if you enable them, don't auto-mount them
on hot-pkug devices. Simple. People in this thread have already
pointed to the user-space support for it happening.

 - syzbot issues.

Ignore them for affs & co.

 - "they use the buffer cache".

Waah, waah, waah. The buffer cache is *trivial*. If you don't like the
buffer cache, don't use it. It's that simple.

But not liking the buffer cache and claiming that's a reason to not
support a filesystem is just complete BS.

              Linus
