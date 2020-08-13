Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56093243969
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 13:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMLhC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 07:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgHMLg7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:36:59 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4993C061383
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 04:36:58 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so2490917plk.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 04:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=cq63KBO13gundOWm0DnnKR0w6Etgxfdr2x+dttCqZq8=;
        b=m/ksBGzHrOcc4NZUkxtAB+W7PtLWrdjKHFGT9qrB2dB+WN3dhp7ywc2GU7e2bkI37b
         4qCaYOjM1lN52lSOUYBFrFYEH2cRBVfBD+rHbDsvUtfEu3qifAqhhkhoOSjOPXrmOZgs
         H0j1aYlcnVM0TlZLKkwS4GDmQsVRHtZccQInA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=cq63KBO13gundOWm0DnnKR0w6Etgxfdr2x+dttCqZq8=;
        b=AAHG6s4ngBVKzFaMKWHTpkpbY3Cr4gNFHZ4HoB113hkYrOhr4YOI8fAZmTF0WmzLay
         1tzru8p5d3ZuRzMFmIEVcpx+QA8LK+jf1z9QMHUJAHnkfxi93W7RLCcGfxZR+fPO/Pzj
         aVAiybsSuxx8nSNwE4iE0mYOhr7w2EryHgBNIHhr222OjlRLm/L5nQ+NA/wEaR7cUbe6
         UtKMFubhbmEx/AJuitTpuvNBoWH/k87bt+Nq+UPyaBxGFII5xGlk236xODIRqeTsN269
         Y7NDWWLjq8PdnuBHrwKXGS4uVaJYYjdButyKDcGMckDBosAkT3+Lg2IueF9RLdLSxVB8
         HC+g==
X-Gm-Message-State: AOAM532q4oZqWJuGUoX4g1XSyZAljr3/ib52/dNH1qXYKtCgsKGfPLvN
        rOw/QmV+bsfUtPOkJj7DdTO+G6QM3jk=
X-Google-Smtp-Source: ABdhPJy5+80qlcCMq9FvxHy8z+LAo9AbUMF1RvOWi5pRXnGx/+RRPk90VO5kJNou+WT43cdQiiWkDA==
X-Received: by 2002:a17:902:ed4a:: with SMTP id y10mr3578373plb.106.1597318615882;
        Thu, 13 Aug 2020 04:36:55 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-4dc5-3664-a3ed-1364.static.ipv6.internode.on.net. [2001:44b8:1113:6700:4dc5:3664:a3ed:1364])
        by smtp.gmail.com with ESMTPSA id h5sm5647204pfq.146.2020.08.13.04.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 04:36:55 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/select.c: batch user writes in do_sys_poll
In-Reply-To: <87zh6zlynh.fsf@dja-thinkpad.axtens.net>
References: <20200813071120.2113039-1-dja@axtens.net> <20200813073220.GB15436@infradead.org> <87zh6zlynh.fsf@dja-thinkpad.axtens.net>
Date:   Thu, 13 Aug 2020 21:36:52 +1000
Message-ID: <87wo22n5ez.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

>> Seem like this could simply use a copy_to_user to further simplify
>> things?
>
> I'll benchmark it and find out.

I tried this:

        for (walk = head; walk; walk = walk->next) {
-               struct pollfd *fds = walk->entries;
-               int j;
-
-               for (j = 0; j < walk->len; j++, ufds++)
-                       if (__put_user(fds[j].revents, &ufds->revents))
-                               goto out_fds;
+               if (copy_to_user(ufds, walk->entries,
+                                sizeof(struct pollfd) * walk->len))
+                       goto out_fds;
+               ufds += walk->len;
        }

With that approach, the poll2 microbenchmark (which polls 128 fds) is
about as fast as v1.

However, the poll1 microbenchmark, which polls just 1 fd, regresses a
touch (<1% - ~2%) compared to the current code, although it's largely
within the noise. Thoughts?

Kind regards,
Daniel

>> Also please don't pointlessly add overly long lines.
>
> Weird, I ran the commit through checkpatch and it didn't pick it
> up. I'll check the next version more carefully.
>
> Regards,
> Daniel
