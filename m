Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3DB20AE74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 10:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgFZIe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 04:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgFZIe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:34:58 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891ECC08C5C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2020 01:34:58 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id cy7so6268965edb.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2020 01:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vpokHpdx2324WEwdOPazf8PsFwQQHRpX50Zc1gbbYss=;
        b=LQxnYOG58GOteUZeYPt6sUc7fbHneWHvpiqhJaKr1OUx/z8Pk/ANp8vDVf8FE8Epim
         QNafzxjINeXBb+ejGtVjTsXquNTi8TXRYujuLtjweqCHVKQm3ECSq7Rxw2Af8INLx8DT
         ifwcXP18aWWGVpzHiL7wVjvnAtJmUuj5VBNjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vpokHpdx2324WEwdOPazf8PsFwQQHRpX50Zc1gbbYss=;
        b=KFUlETqm5l2QHr2Lihiyi9b+IROAXpgSzWnW1670UZrG/+kcTLwR0YeCR/MiUS8vKM
         AE0hhsdXJRAJFgID1Xy2NjsKuaQJgHO8Ih2Q+ij/S2r9e4/Or9yDBaSXmjtCG9g2weGv
         bBjZZ2CACeO13HpKpC3bOSnYPxAxmMDjVdQMtGJO0fbOzzwSlQ9AAqjxImfPmXhKF/2E
         ++2Sr4uL1DnlDPPywlMyHH2xO4+874AHAPvad3V7nFZ1GJwx31NksRrgKScYkBmczoNv
         +gOnOVg/LKu9uQVYckAHDy1N9qQruGraCZtd1wvVUTCude9MAHtKOa732xyDYAjLwLIF
         VxIA==
X-Gm-Message-State: AOAM533KOfoL7YrLc2S8aZqYuHEgJGuomblIk0prpLmYsbOVTUlnRxJK
        6/5BYV30lNZUO9aj490wnjdMGAP3au1RSGH18gxjXA==
X-Google-Smtp-Source: ABdhPJwrPiyir642FC7k+viZ0W53l93EXsjZvDmz/JU8BkbzSWa4IdiEOO5qS/igiF8Ig2qa25vfi+nBmuqr1uSqR44=
X-Received: by 2002:a50:cd1e:: with SMTP id z30mr2164466edi.364.1593160497236;
 Fri, 26 Jun 2020 01:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <736d172c-84ff-3e9f-c125-03ae748218e8@profihost.ag>
 <1696715.1592552822@warthog.procyon.org.uk> <4a2f5aa9-1921-8884-f854-6a8b22c488f0@profihost.ag>
 <2cfa1de5-a4df-5ad3-e35b-3024cad78ed1@profihost.ag> <CAJfpegvLJBAzGCpR6CQ1TG8-fwMB9oN8kVFijs7vK+dvQ6Tm5w@mail.gmail.com>
 <bffa6591-6698-748d-ba26-a98142b03ae8@profihost.ag>
In-Reply-To: <bffa6591-6698-748d-ba26-a98142b03ae8@profihost.ag>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 26 Jun 2020 10:34:46 +0200
Message-ID: <CAJfpegur2+5b0ecSx7YZcY-FB_VYrK=5BMY=g96w+uf3eLDcCw@mail.gmail.com>
Subject: Re: Kernel 5.4 breaks fuse 2.X nonempty mount option
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        "p.kramme@profihost.ag" <p.kramme@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 25, 2020 at 10:10 PM Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
>
> Does a userspace strace really help? I did a git bisect between kernel
> v5.3 (working) und v5.4 (not working) and it shows

I cannot reproduce this with the libfuse2 examples.  Passing
"nonempty" as a mount(2) in either v5.3 or v5.4 results in -EINVAL.
So without an strace I cannot tell what is causing the regression.

Thanks,
Miklos
