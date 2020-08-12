Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5878242E03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 19:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHLRXn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 13:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgHLRXl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 13:23:41 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83240C061385
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 10:23:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i10so3150401ljn.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrY/NxWx3/FaOMH2Zu/xiJfV6Atph/3rs8H9NXO5FQo=;
        b=b+S2a3dv91gBN5p4hLlLS3kGrhtpEqptSqM9+j4RM42U/tjZlfA5rD7v6Z2qIU4kAn
         NadltzA8Fkl37lUGOrDWZW2oPmMhkKva9Jy3+735PAhqC3zlJFArnTlW4T5zxWoFCWXE
         TjA3SPWJ77pB/afeA7ZSRuw8fAxCi87MmCf9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrY/NxWx3/FaOMH2Zu/xiJfV6Atph/3rs8H9NXO5FQo=;
        b=JEV+x1Frq8elD4RtjN/QEjvtcCXuklJ+V2FYXIrGMovalJjLDt6TsDgHbMOmlWpEza
         U33aerGXMTcmuJxDoDtWWsU+Sj0R5Zpowkqq/0g479jMwVSQRBVsYcxDv2m5aXT+0TzF
         1LROsOfAJYMUicSDlOn+Gpo75wQ1mWKHHHM0T9vLeokmmDRPCSJgAl01QEC/ph21kI7Y
         F/TTbmB1o+KLZi8+iq02fPGYrRpIS1kIi9+2y+5CJUn3XxfgraFn9EGMC34U0VGdsUr/
         LutzEpLZERjBBgy+0DgRWs+oSMlwEj4qBD4aUyZgimWrbzySRrIiD7pqVOns+1oJ4De9
         +/CQ==
X-Gm-Message-State: AOAM530EMRrUECcn6s4yJ6mqgpvj1tbrlwuZDEMFT6/OLyHr9XUCRHLi
        AtuL8tN3VL/IUUHNfd9nPBVPDb9G4m0=
X-Google-Smtp-Source: ABdhPJwJU0rYYDnJgjn3BXQbw99MeQThaULbG4Klcy9ouiItihoYBaJeZoQdV4bYO2WnWCRT3rRs1A==
X-Received: by 2002:a05:651c:2004:: with SMTP id s4mr104656ljo.89.1597253019225;
        Wed, 12 Aug 2020 10:23:39 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id c23sm605611lfm.83.2020.08.12.10.23.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 10:23:38 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id h8so1571525lfp.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 10:23:37 -0700 (PDT)
X-Received: by 2002:a19:408d:: with SMTP id n135mr215699lfa.192.1597253017201;
 Wed, 12 Aug 2020 10:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f0724405aca59f64@google.com> <20200812041518.GO1236603@ZenIV.linux.org.uk>
 <CAHk-=wgHZF+GbPS0=+9C7NWb1QUw4sPKL0t90yPGs07jJ0eczQ@mail.gmail.com> <20200812055558.GP1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200812055558.GP1236603@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Aug 2020 10:23:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkE96-0OZzAJoyJEp_J9uKuojS9K9Zo-wuU+RUOcsiKQ@mail.gmail.com>
Message-ID: <CAHk-=whkE96-0OZzAJoyJEp_J9uKuojS9K9Zo-wuU+RUOcsiKQ@mail.gmail.com>
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

On Tue, Aug 11, 2020 at 10:56 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Aug 11, 2020 at 09:29:47PM -0700, Linus Torvalds wrote:
> >
> > Do you want me to apply directly, or do you have other fixes pending
> > and I'll get a pull request?
>
> Not at the moment - I can throw it into #fixes and send a pull request
> if you wish, but there won't be anything else in it...

Ok, I applied the patch directly. Thanks,

                Linus
