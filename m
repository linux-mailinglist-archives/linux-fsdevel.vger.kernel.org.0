Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3953920A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 21:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhEZTMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 15:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbhEZTMc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 15:12:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F1DC061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 12:10:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id h20so2754800ejg.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 12:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IMN6ChejNXJFYXToAoXG4lV7NHrdkhgPtkU3r94Vvkg=;
        b=rrEpfN2eSUWFwTnN59H3JQhAB5eFLKAJCg2tSavS1ZnxCW60lgzt33IwObabQh2Fiu
         R8otedpGlExOIZh5g2t3KeDEHthFgNq1Tw5Tl27NvK/Ol5bCJAu0NtWwcAaDGALwhO/A
         bOBmrwLBshkHZB8xUhrMI1yIP2wvejtGOyxHPdwD85dbPnHecSxw/UJV9E6KSGPlbGNn
         YFMesNoT/acoDSs5GvcbN7ez6HpdH129AZcY1OlbklrTQPR5ANzn7wdWVaXScc9ZcKDd
         d2DctUe3Woib8fuZANmiFmn3S+7eNKMuWsFxjXbOWuVZQSJC/jKuj3i0PmeX6GWLwsFj
         wxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMN6ChejNXJFYXToAoXG4lV7NHrdkhgPtkU3r94Vvkg=;
        b=qnnKECrgJ1TWxnvEWay8YamdvhH7fqZsl+gL7Pz9zUqY5S9CWYaqt3jnYtJtR6l5XE
         clN8utA+bfqRy+0+015316UJSd7YY3fBG7U2Xr7Sw0HoAiFmCzZ6nhadjIvOdOhctluA
         Ajb/lsAHIVtCTR4XLU40Qp4+SOWMlDTNf6WwsM+mCIv/efVCVcVQ2es1EcZDBEg7eNmN
         3ApqyX2c6Bi4Ri3NYWLIzxopvFBDiZls+ekH8XKkCaolxMjA3ybNSlYoega228YzINne
         BNJS25oyDr5Zzl51wYPISx+FS2XWwI0KHrwIV9YHiQgX3qfQNTth/mvE9rBIsd1jXI/s
         6lJg==
X-Gm-Message-State: AOAM530HzMRRcQ/p6m6haAgDych7F3EIw9ULB2wOCZ+ixJNfWipzXbbg
        YNOZ+q8oxCN9NZzTQMakVJTsadQ59yKtJMgP6VbY
X-Google-Smtp-Source: ABdhPJw5Uo6wSn4k4zz/jz3Ayrk4WGYUWInTcmg7vYqy+K7NbwQFUmlxJqbAcL8Cf1k2FEX+enTA83rXl0PTreAKR3g=
X-Received: by 2002:a17:906:7e0f:: with SMTP id e15mr34549005ejr.398.1622056258166;
 Wed, 26 May 2021 12:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <162163367115.8379.8459012634106035341.stgit@sifl>
 <x498s41o806.fsf@segfault.boston.devel.redhat.com> <CAHC9VhQ9r7WHbq2ga+-PF0x5q29nkdNjbLouQETvxDtjE3QaQg@mail.gmail.com>
 <x49o8cxmi02.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49o8cxmi02.fsf@segfault.boston.devel.redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 May 2021 15:10:46 -0400
Message-ID: <CAHC9VhS-R-bNtoOZnENN4TJX7ztpjWBUsnLMbCfXJDpe42JdqQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Add LSM access controls and auditing to io_uring
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 26, 2021 at 3:06 PM Jeff Moyer <jmoyer@redhat.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
>
> > On Wed, May 26, 2021 at 10:59 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> >> Paul Moore <paul@paul-moore.com> writes:
> >>
> >> > Also, any pointers to easy-to-run io_uring tests would be helpful.  I
> >> > am particularly interested in tests which make use of the personality
> >> > option, share urings across process boundaries, and make use of the
> >> > sqpoll functionality.
> >>
> >> liburing contains a test suite:
> >>   https://git.kernel.dk/cgit/liburing/
> >>
> >> You can run it via 'make runtests'.
> >
> > Thanks Jeff, I'll take a look.  Quick question as I start sifting
> > through the tests, are there any tests in here which share a single
> > ring across process boundaries?
>
> Yes.  At the very least, this one:
>
> test/across-fork.c

Great, thanks!

-- 
paul moore
www.paul-moore.com
