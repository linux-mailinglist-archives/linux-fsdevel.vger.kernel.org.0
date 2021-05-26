Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC55D391FA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 20:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbhEZSvI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 14:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbhEZSuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 14:50:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90E2C06138E
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 11:49:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i13so2733245edb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 11:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eUw5EWsm6YpLZJa7t+q5jtkegb7JzdC7cLbi2HaDaSY=;
        b=Qa4+2I8bj+Rl4uorvYi/14nmt2vKj6hYAl7zSFojW6Kt3Nt8daf6Gpm4ZJJgyUNFWI
         xkCMAKH5NW4fxSZHUxXVEUeZGqV3qAKmIt2X/M0TvaEJyVLwexIv0T21EVajyvyO6nub
         PUaOy9tS3C89//WbcyVRpE6YWPS+N7CBNALIqPZJa7o3+FX7M8Hu2Ysql1iwx/TdO6E+
         WNikm8vzY9a+WHq+pwjhS03/CounnEJ3vgkX1e9x2Njpf9ls33p53q9xTOmQDxxF2901
         TEpQTn2TGh9aaLRKw0gbUCJR8ualRB1k8OmjD8DD5IRGpzz6W0AAUVJhXX3DTE7R0ivF
         u5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eUw5EWsm6YpLZJa7t+q5jtkegb7JzdC7cLbi2HaDaSY=;
        b=KSIqANGev3Q1Qx8gpTK10A0dyUSh3OC/iInlQpH5VK3nu0EEnPOqy6RHN/3cNMd58p
         7I7pm2EM3U9374ewT36onqPBbF9ZhEc8jxmdwDu5LRtsBCEb0cAtudG4ZU3lfvI0nPnl
         yLFfRSooqU2cWGofAcWq6tGdjx32uCMYqTsRttYQN6YqZVUb03k+1xMGOjG2fktYJubS
         ZVsUqLQZG87jGUEWIXEBmNrGwKWODb8bIv0zeVNnG+1uhZ8zbNtsHRAU04Q2EIOVeY52
         FQq4l2mb1emkff3Z555bEG5uLArLF6wUDGzoXW8kD18vnLLkT6cknK0shYzRumB0PdfU
         LSXw==
X-Gm-Message-State: AOAM530CNAe/JvfhaccL7kYsihqeM9w1kAn337xDZO8X3ZC4HXS9J84D
        r7n9fW6NlTVtQEAB0WtOGdIPAJ10UmalIElMTsvC
X-Google-Smtp-Source: ABdhPJwv0Uq8DQfJkDvdzA4OniOiI+rWA9eT/CLl2cGg/DPPNpGOFUfGKO6SZKb3UqHq3VqSm/joAe+wfqQshG0/qkY=
X-Received: by 2002:aa7:cb48:: with SMTP id w8mr39405253edt.12.1622054959225;
 Wed, 26 May 2021 11:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <162163367115.8379.8459012634106035341.stgit@sifl> <x498s41o806.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x498s41o806.fsf@segfault.boston.devel.redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 May 2021 14:49:07 -0400
Message-ID: <CAHC9VhQ9r7WHbq2ga+-PF0x5q29nkdNjbLouQETvxDtjE3QaQg@mail.gmail.com>
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

On Wed, May 26, 2021 at 10:59 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
>
> > Also, any pointers to easy-to-run io_uring tests would be helpful.  I
> > am particularly interested in tests which make use of the personality
> > option, share urings across process boundaries, and make use of the
> > sqpoll functionality.
>
> liburing contains a test suite:
>   https://git.kernel.dk/cgit/liburing/
>
> You can run it via 'make runtests'.

Thanks Jeff, I'll take a look.  Quick question as I start sifting
through the tests, are there any tests in here which share a single
ring across process boundaries?

-- 
paul moore
www.paul-moore.com
