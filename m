Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B85011461D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 18:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfLERlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 12:41:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41545 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfLERlL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:41:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id m30so3120809lfp.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 09:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VxxdiKNiz39tRqLEdE4fMp8XvXCMdjUYyrnc67CIuPc=;
        b=ORPcmASmhOZl546WvwcyNPKV6KACymeuubMzw/fmh39y+aB87wlfZcWosPv03wpDII
         7wOeTc7QK3DxNZfu8fjlxFHGTJuhZ6VcelBcL9PMvS2MhK43zlFN3DY33wClA1oE7Z3i
         zfRrFnVmNk3pY9gYF4t9b/B5JFUkgzpdua73w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxxdiKNiz39tRqLEdE4fMp8XvXCMdjUYyrnc67CIuPc=;
        b=dvM5JRRID83/x8TJYUQStg9x7UCQLGXSC2kpIxO5Op4ArKasrE2jGd8b3n1VHp9z5K
         /DUJPSZ9vzsfUFfo2EQjA2v80lm+9EyAAoMtaeZ5e+auEnqemOS3206L92w2YR5Q6gR+
         /n+znLK3J+8f7tJVAoYUXu/qMnP9VO0hsf9BEj7700TSEPq0D1reVOWmKkX/Vey5DgXE
         gmvzfH6BKdNLq3Tyhwbsi4s19RPjqINBBcC+QvikNS7EsokZekuxVnAPkL2fZ01R8VV2
         Q0C+5CDHzohxm5pQJEHUDZZRdU2u4NP6Jxzk1CNph4UFn2Fav3DR70M3clhma8ah9OiU
         H2Aw==
X-Gm-Message-State: APjAAAVyN54ixX9nExXOMujgamSiKRWwwo+O3iVLFumMyZjFgaR2fsl5
        pWmmEBDg95zZsVu3zqcwAZXZ3KmfhOU=
X-Google-Smtp-Source: APXvYqwzXdrF8pSNtoVDfjb5I5amjfg9YvlTH626L+evXOAsR597IkaYYtQW96DjEya8Zr9VtJdquA==
X-Received: by 2002:ac2:465e:: with SMTP id s30mr2760609lfo.134.1575567666884;
        Thu, 05 Dec 2019 09:41:06 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id a24sm5268922ljp.97.2019.12.05.09.41.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 09:41:05 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 9so3116411lfq.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 09:41:05 -0800 (PST)
X-Received: by 2002:ac2:465e:: with SMTP id s30mr2760573lfo.134.1575567665303;
 Thu, 05 Dec 2019 09:41:05 -0800 (PST)
MIME-Version: 1.0
References: <157556649610.20869.8537079649495343567.stgit@warthog.procyon.org.uk>
 <157556651022.20869.2027577608881946885.stgit@warthog.procyon.org.uk>
In-Reply-To: <157556651022.20869.2027577608881946885.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 09:40:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgNQ2SWwYzrvdwzan5krzE2Tgh35zyDPy+i6nBEVc7EfA@mail.gmail.com>
Message-ID: <CAHk-=wgNQ2SWwYzrvdwzan5krzE2Tgh35zyDPy+i6nBEVc7EfA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pipe: Fix missing mask update after pipe_wait()
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 5, 2019 at 9:22 AM David Howells <dhowells@redhat.com> wrote:
>
> Fix pipe_write() to regenerate the ring index mask and update max_usage
> after calling pipe_wait().

Honestly, just remove the "mask" and "max_usage" caching. There are no
advantages to it. With all the function calls etc, it will just result
in moving the data from the pipe to a stack slot anyway.

Maybe you can cache it inside the inner loops or something, but
caching it at the outer level is pointless, and leads to these kinds
of bugs.

               Linus
