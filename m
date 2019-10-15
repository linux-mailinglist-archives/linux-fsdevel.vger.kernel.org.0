Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB9ED8384
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 00:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389330AbfJOWVM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 18:21:12 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41050 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731786AbfJOWVJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:21:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id r2so15701720lfn.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2019 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igJfeABa6M5mmcDSZ9XAWyfxDlpeT34TBKS5Vu4WYQ8=;
        b=LIYdbK/WEFGMNdD+uIGw2BasCdPDikOSk/1C31c/6KJAoWeweWvBbkEnJF4PHN8TkH
         BgZdUCf/ZYXj115hlOqd/koyMkdZG6Il9yGalmukOiV4kTIOYCVZSlLQpLqR2NWtyVYg
         nGZ/n1OZmV0DBw+aQ4pzCSwYlzFEdDM+SUZEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igJfeABa6M5mmcDSZ9XAWyfxDlpeT34TBKS5Vu4WYQ8=;
        b=ANfReK7fgjmfexvqwBALWe0HePHO+6JsVUjjNOE+yJLy4wz3xoPHpOW5PQod3KZc4U
         YzsFvP1SPeE1uDpQVbMgchEYt349SSw192+x5Dc26ZYEoo3U8YRbWPWBdutKnWkkQKCj
         QWSWJvrH5i80bhD0+vOPEBPtSYtcA8hixj1hZGS7kS6gOaF055AFYvoBsaKyKSDgzQXd
         hHGHRg9B8OHtYVaOXgHz30VpXAqNNl/b6yUd57HyxHuau15m26kVBFfrX8vpy3zJX98t
         WAaCuRSsZfafsFzKoOTIhl+NKleHdLfo/P+YBYB5klonUpk92bE+cn6tM5gTCFFFFmuH
         XZ/w==
X-Gm-Message-State: APjAAAWzaAK70hjykja5grZzo4Vx8oTnK4lju9fMbQ7edHe2CUO8GyTS
        LRG1INCmSIHg9yE5zwjnWv9oKSm2+ic=
X-Google-Smtp-Source: APXvYqwmH7uCNzRAslUt54PiC8xeM5xa3/uh2aXVjNdueSDaOPF2ZYktcFN9+dKeRhLA/yA8X4hD5g==
X-Received: by 2002:a19:6a18:: with SMTP id u24mr21913511lfu.52.1571178066852;
        Tue, 15 Oct 2019 15:21:06 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 134sm5475811lfk.70.2019.10.15.15.21.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 15:21:04 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id w6so15741119lfl.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2019 15:21:03 -0700 (PDT)
X-Received: by 2002:ac2:43a8:: with SMTP id t8mr22573654lfl.134.1571178063150;
 Tue, 15 Oct 2019 15:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
 <157117614109.15019.15677943675625422728.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117614109.15019.15677943675625422728.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 15:20:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivjB8Va7K_eK_fx+Z1vpbJ82DW=eVfyP33ZDusaK44EA@mail.gmail.com>
Message-ID: <CAHk-=wivjB8Va7K_eK_fx+Z1vpbJ82DW=eVfyP33ZDusaK44EA@mail.gmail.com>
Subject: Re: [RFC PATCH 08/21] pipe: Check for ring full inside of the
 spinlock in pipe_write()
To:     David Howells <dhowells@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 2:49 PM David Howells <dhowells@redhat.com> wrote:
>
> +                       if (head - pipe->tail == buffers) {

Can we just have helper inline functions for these things?

You describe them in the commit message of 03/21 (good), but it would
be even better if the code was just self-describing..

           Linus
