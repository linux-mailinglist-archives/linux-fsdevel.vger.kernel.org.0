Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBF55BBDD6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Sep 2022 14:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIRMwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Sep 2022 08:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIRMwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Sep 2022 08:52:49 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7DC23BC9
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Sep 2022 05:52:48 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id u14so9541767ual.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Sep 2022 05:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=fXehQ/rEVKVxdinkgxDnhNCX4O1c03usz9M59Vfhye0=;
        b=ROMlZ7ZYXk0YOuaHtMbCADZLRVFqxUhfVgRdHGkJxgIuZmieGugOojCXq9ljFTmqaY
         B8DKz21OvJoyVs8nL9KpBh/ClNL2uWJn6o6f6mDjNBAESbwOdj0CY/npBVjqu37CKduR
         nTjHD2jHkhhv8v4wvjgRuQo9jK0nPnXEa97UlXsxbTHXQrqnTMisV5/XjnVLZ9eFmTLR
         Gf+g++DFgM88ft05WwbJAQR7g+83KqG8EQW2fOcSsTK6ESHwvjZaquSyB2b7aWisnE3G
         qjulbu+D8mJ1tJNSpSW3mc4dYBc6b/ExsSUI4GP59T4kBpHkrnNZtwIhvxeqN0t2ZqGc
         Ijew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fXehQ/rEVKVxdinkgxDnhNCX4O1c03usz9M59Vfhye0=;
        b=RPl/fhZBfKKszssrsFa+HbRpDWW3LC/1HNqBNNCEhRgPXZid1l/ZuoZsSaBAfPEYbW
         uyLnlY7jz2szg8AyCw8syJ7UlqZzScsqkTRSZjm9rLh/qmpO/LfJlhGwfiTpFDuO+Z2e
         CTJ4zRDyusZcYOlr6sCmLql5YlTU4L4qBLVLYfDcWtcfWbdnGa8LSvASJO05y6x8HHVL
         A0IZcBpQv+ncX9K+MGa0gtZ6aaNG0phSeJt9qDL6MwOvIuezHAJy344gW/Ind27u0jds
         9jGdrTBEF0sT0zZYokPSwpPx/SfpzEz2aHalK6Wj4HprKEq2GYi7Noj6JPooRhJXIVXc
         qQ/g==
X-Gm-Message-State: ACrzQf1Ai83g8pczjd0XodrJmTzysOWubynuposCKeFv+FaXYH2lZPpv
        J14Q8Ap2dKINM/Z9aPZftVtuYO6mbE5ITuaTD5jPMJO3TIs=
X-Google-Smtp-Source: AMsMyM71vjyrSVkTVHXqwqc2aMI0X4mzyIseUnk1lavEjR5OIVWSL2h3g4/S9R0k8lrQ8iLWd5OOh22TC+910mttZvk=
X-Received: by 2002:ab0:1c55:0:b0:3b6:3cbe:19ca with SMTP id
 o21-20020ab01c55000000b003b63cbe19camr4445176uaj.114.1663505567490; Sun, 18
 Sep 2022 05:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <87mtaxt05z.fsf@vostro.rath.org>
In-Reply-To: <87mtaxt05z.fsf@vostro.rath.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 18 Sep 2022 15:52:36 +0300
Message-ID: <CAOQ4uxioquNfdLVZ=JV8ARpN5No29fjD-BQcfk48stODTTwrig@mail.gmail.com>
Subject: Re: Should FUSE set IO_FLUSHER for the userspace process?
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 18, 2022 at 2:12 PM Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> Hi,
>
> Should the FUSE kernel driver perhaps set PR_SET_IO_FLUSHER for the FUSE
> userspace process daemon when a connection is opened?
>

This may have implications.
Not sure it is good to do that unconditionally.
Do you have a reproducer of deadlock?

Note that PR_SET_IO_FLUSHER is set for a thread - not for a process.

> If I understand correctly, this is necessary to avoid a deadlocks if the
> kernel needs to reclaim memory that has to be written back through FUSE.
>

I think the deadlock can happen also when kernel does writeback to FUSE
and then FUSE server ends up trying to do direct reclaim of memory
(not just through FUSE writeback).

In any case, I guess the problem is limited for writeback cache enabled.

> I don't think it's possible to do this in userspace, since the process
> may lack the necessary capabilities.
>

Doing something a bit more subtle would be to write the calling thread
PF_MEMALLOC_NOXX flags in the request and let kernel set the
flags of the thread reading the request, but in libfuse that is not the
worker thread is it?

Need to also check if PF_MEMALLOC_NOFS may also deadlock.
Direct reclaim of inodes can trigger a *lot* of FUSE_FORGET requests
IIRC those requests are one way, but can they block on the request
queue size limit?

Of course it is less common for the forget method to require large
memory allocations, but we cannot assume there is no deadlock
unless we make sure to prevent it.

Thanks,
Amir.
