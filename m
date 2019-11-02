Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64675ED0C7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2019 23:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfKBWEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Nov 2019 18:04:07 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46390 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfKBWEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Nov 2019 18:04:07 -0400
Received: by mail-lf1-f65.google.com with SMTP id 19so4426593lft.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Nov 2019 15:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vTCI0qHuBsBb0Kz5RbeswHqlSoPusOsIRcj6s1CCCCU=;
        b=XRll/5vMVkjx89KHnpq6WWB0oHHUpEHdiN6O6XIbNfDvJpLq9nAHdnvBRo0qcYtdlV
         dDebt2KT4z/UoQ3oT2Pk6vWaFBXKSztN5uuRAQNTvGwr3g3jPPeee0pGSv+auGk2TkT9
         /FiIqnPnAFsk6ubf5wFePKPpQhSpZfg8GPgik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vTCI0qHuBsBb0Kz5RbeswHqlSoPusOsIRcj6s1CCCCU=;
        b=NbsgHS8YxwAwFlEVKIziAS+Xnpme7CCRJYdgbcbq5WP2+ktebTVc4gKOL77mWBKjE8
         5XnNBKcHCcSmi/C9nS52NF/S+phJR92cbBeC4nCRiXS9tChUaD43vH6MqK2GwEMfRK0W
         jSQ7VQ3Q4wN+PodRNvrTxmPtIsvHcGjT5HB4+Kfx6iKFb1MN0eU4nJm4DHOvxubtmnHS
         JhjM9B/HIEX2cMMEAGDgsPymEIt6Mi40kf2X4KxUy8qEh6qm1Q3XiP/RE8xnpjt9Szn9
         zuLmQEGlrLGEOF8R75YahSqEHbn5Wu+DWCrIPsbVFKSag8gDakRIL4fQLZKWRtkoSxjH
         V2Hg==
X-Gm-Message-State: APjAAAUPCCdQtV9dZyuC+YROoI/nf8L8wZsaPbJfiwwC+F/R4NpZ9s6b
        LeAoVJuOwLM9BFsRks2bBbCT148e9sY=
X-Google-Smtp-Source: APXvYqzLhRkzFy84bwkBUQE6VrXdsl+v/8fcY9wjrpUeG8Pw80D8fZ4GXuP5Az6HxhBlOCQo6UA0ag==
X-Received: by 2002:ac2:410e:: with SMTP id b14mr11409864lfi.110.1572732243367;
        Sat, 02 Nov 2019 15:04:03 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id q8sm3798805lfd.53.2019.11.02.15.04.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 15:04:00 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 139so13740114ljf.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Nov 2019 15:04:00 -0700 (PDT)
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr13611187lja.48.1572732239632;
 Sat, 02 Nov 2019 15:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <25886.1572723272@warthog.procyon.org.uk> <CC3328CC-2F05-461E-AAC3-8DEBAB1BA162@amacapital.net>
In-Reply-To: <CC3328CC-2F05-461E-AAC3-8DEBAB1BA162@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Nov 2019 15:03:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
Message-ID: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Howells <dhowells@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 2, 2019 at 1:31 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> Add in the fact that it=E2=80=99s not obvious that vmsplice *can* be used=
 correctly, and I=E2=80=99m wondering if we should just remove it or make i=
t just do write() under the hood.

Sure it can. Just don't modify the data you vmsplice. It's really that simp=
le.

That said, if we don't have any actual users, then we should look at
removing it (maybe turning it into "write()" as you say). Not because
it's hard to use, but simply because it probably doesn't have that
many uses.

               Linus
