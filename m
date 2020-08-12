Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F152424BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 06:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHLEaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 00:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgHLEaI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 00:30:08 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FA7C061787
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 21:30:07 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h8so431493lfp.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 21:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDwgZeCfylHcfAPvU7+q1GMSHtKUMIYb5xnIYWrEEr4=;
        b=B3aVSgoHTMeOnptotypuxeXwzcXLQNuaXirCFngMoQkYUX18nRwhqfYkwT5muF8NNb
         UKxUK5N/shaIWvw0Xb4abZJVmXGDVkhZnbu8HKy2tFr+b4sjrnMDzzOW7KpvC5hKvofh
         644/QVacgEmv5UDIs0jX0SLrxFZRlm9Rtr+/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDwgZeCfylHcfAPvU7+q1GMSHtKUMIYb5xnIYWrEEr4=;
        b=B7leGC37ub7kRVHAwTnTKrJ/AfSjMrq6Og4XTWjjdoGwYB8NAcUNFanXwVL3u+j0ON
         bXciLUFLwvft2gQ8WUQP7C0u+KXeGsocdV+Of3V2NNzxJ++m+nPrjhd6+rCcFJ2fKQh8
         zfE8ShnwzBv4kAVrAnwci+7QjKxp4XMsXkQSLnUXijT9Rxoa+6arnBXmIOLVs9EuPZNH
         s9iYW2iJQBh6LYjqyKX4kvrUyECfsYt0XAfxZSTZYCnLnxXJqczlWAo2YGIK2gI+Umb8
         SFvu2v0NdLFIyRB4FO3yhtMJesMmH8L3CKhLHFAlXO2V6z/ADyxCb7Zxc8ieCPmfDr7M
         ft8w==
X-Gm-Message-State: AOAM531naFREYp5wasz8yQTgaLaiFg0AtIAj+6KSv3xBGPwO0bzQzR5p
        b2zdM7mloyaILUX3GM/wOyJ7gjVqpLY=
X-Google-Smtp-Source: ABdhPJwZYux7jkHB3s2Jv9t4kz43UW0ZtJwnIgnmNmbkct4FQ/nXrGB8KRvqS7vD9aCknmEOXDRwVg==
X-Received: by 2002:ac2:494c:: with SMTP id o12mr4645579lfi.181.1597206605239;
        Tue, 11 Aug 2020 21:30:05 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id f12sm173421ljn.14.2020.08.11.21.30.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 21:30:04 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id g6so707589ljn.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 21:30:03 -0700 (PDT)
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr4153008ljh.70.1597206603371;
 Tue, 11 Aug 2020 21:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f0724405aca59f64@google.com> <20200812041518.GO1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200812041518.GO1236603@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 21:29:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgHZF+GbPS0=+9C7NWb1QUw4sPKL0t90yPGs07jJ0eczQ@mail.gmail.com>
Message-ID: <CAHk-=wgHZF+GbPS0=+9C7NWb1QUw4sPKL0t90yPGs07jJ0eczQ@mail.gmail.com>
Subject: Re: [PATCH] Re: KASAN: use-after-free Read in path_init (2)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+bbeb1c88016c7db4aa24@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 9:15 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> fix breakage in do_rmdir()
>
> putname() should happen only after we'd *not* branched to
> retry, same as it's done in do_unlinkat().

Looks obviously correct.

Do you want me to apply directly, or do you have other fixes pending
and I'll get a pull request?

                  Linus
