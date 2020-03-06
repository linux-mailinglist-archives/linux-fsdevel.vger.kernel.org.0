Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5B3B17BC16
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 12:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCFLss convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 6 Mar 2020 06:48:48 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35648 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgCFLss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 06:48:48 -0500
Received: by mail-qk1-f193.google.com with SMTP id 145so1989896qkl.2;
        Fri, 06 Mar 2020 03:48:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OssLuVfSGsrXqcB5wnFK1NjOnTzA8E64E6ohIGHT2Ks=;
        b=NG8097Wy8nVdiA9olEhHoh4B3VYmOA66jek11TPmim0Z+KoPmRgtUAS9ulV387ykUJ
         rRtdU/SQLjDpg5+vz4iCSgMjnH9jlU4h2+kKUJjzIgHhBg8igLzrxPlq/+AnNKJwcC5P
         GoTPY+4namw4XnoAXqib8QQYGGu2thVMlPuIPEHERJFZUO1Tr9n4dg+FytunzbuM2Z1j
         j5gZR16jtwPiVBBU/uUxJ7MnIoSG83WEzDXFmuxx8rpGHkgUnwAD5ojwfuuRqKfr51ey
         J+qmgKX77xfZjYSm+UxNueco95gtV1fboYY0Ve+LyhTC7LKCUFJBmlWI5/vYzNYiAwv+
         12Sw==
X-Gm-Message-State: ANhLgQ3yC5s6MqRhWeTgqo5fTHG5qk3zHqzqRkZIPH7w+IMcoJPeuJZj
        acBYmhJI5EICZFFLMP5v/mpDwNbK4/rHCbKiihw=
X-Google-Smtp-Source: ADFU+vvl2c2/OShAdxxf/RWQg9aKh9E2t/TGfobF57Z3ak7i7Zi7HjCaMSooYVItwCeRIDT2b22aoFKhsp2SiJsj1W8=
X-Received: by 2002:a37:73c7:: with SMTP id o190mr2545830qkc.490.1583495326750;
 Fri, 06 Mar 2020 03:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20200306080905.173466-1-syq@debian.org> <87r1y53npd.fsf@mid.deneb.enyo.de>
 <8441f497-61eb-5c14-bf1e-c90a464105a7@vivier.eu> <87mu8t3mlw.fsf@mid.deneb.enyo.de>
 <40da389d-4e74-2644-2e7c-04d988fcc26f@vivier.eu> <CAKcpw6WEO5Rmsv+WFkOMrkH+0jwtFKKy7b2n3U9xgv-xGC0UUQ@mail.gmail.com>
 <87v9nhzp6w.fsf@mid.deneb.enyo.de>
In-Reply-To: <87v9nhzp6w.fsf@mid.deneb.enyo.de>
From:   YunQiang Su <syq@debian.org>
Date:   Fri, 6 Mar 2020 19:48:35 +0800
Message-ID: <CAKcpw6VF1N2gTVXeWLU4aVOuARf5oN6yPg9O=RCzgkMrjXmxYQ@mail.gmail.com>
Subject: Re: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Laurent Vivier <laurent@vivier.eu>, torvalds@linux-foundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, Al Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> 于2020年3月6日周五 下午7:42写道：
>
> * YunQiang Su:
>
> > AT_* only has 32 slot and now. I was afraid that maybe we shouldn't take one.
> >    /* AT_* values 18 through 22 are reserved */
> >    27,28,29,30 are not used now.
> > Which should we use?
>
> Where does this limit of 32 tags come from?  I don't see it from a
> userspace perspective.

Sorry it is my mistake: In linux/auxvec.h, I saw

#define AT_RANDOM 25    /* address of 16 random bytes */
#define AT_HWCAP2 26    /* extension of AT_HWCAP */

#define AT_EXECFN  31   /* filename of program */

The number jump to 31 from 26.

It is my fault: in x86_64-linux-gnu/bits/auxv.h, the max number is 47 now.
