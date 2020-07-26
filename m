Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BED22E0E8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 17:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgGZPts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 11:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgGZPts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 11:49:48 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07578C0619D5
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2020 08:49:47 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v4so4937016ljd.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2020 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+JgIZ8XfCVppOLBrKaCfrOJgti4dCoQC3LmXNgyBOk=;
        b=YKwnn8UwB1kyyPy7SGhOqEHVh3ir85jWVNvGHsICQkfXCfHpp08JaYZO+rmkz+r+4H
         a8PGGYXhKp4ik66+nOyiykRRF8GkhBtxTG58y01F0XwJ0PDRSUZIKrcxNdZZrYj/LaW0
         LanUodOh2id6DDdrcBqqolyXpt0XJy8o+3CEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+JgIZ8XfCVppOLBrKaCfrOJgti4dCoQC3LmXNgyBOk=;
        b=DCcOEtN1lbUJ6EYsLkvdsEHD6ufFaIAocKxk/dq3GTZyqxDDY6TJ5CAWFJSy7vul5k
         eGIKUEMonh6hNxjgX9QAG9/FAMQa6pLVC0Lbtq4StUBBH05/x6YhsDuse2sU1oXjDbLD
         9TpGsc4o8r0HGIhWGsdr13iVt/8mX6xtSDFu5QscxNj8DZGhq2b9/vbCnW8gMlCz1Eze
         vsbgSP1k+I+Bf4GQDx1I7rd0JuJkubnMPtBPYVmoYQ2KD8BWZS1tKuv5XpgZrdDZg3bR
         EGI7kD/q++ecGQnkQg/t7zlVZUbZst/J2/iB/pqjnd8VCSfTsmTW0US8M40t9kEB+2WS
         IuCQ==
X-Gm-Message-State: AOAM532V6OgTipOZPF+P3tFIZCIpkzUAL1KnY9ruJ9tKzUEIefFiGi/w
        6X1xN5rEC9m55oYXEO1cUc/ozcCXDsE=
X-Google-Smtp-Source: ABdhPJy2yKZfvyiZ5myAdts9EeewhyR2Z9JUqVKwPJPanJlEU4DV/aiOuxQF0p/vS8g9KTeZIlRRwA==
X-Received: by 2002:a2e:b042:: with SMTP id d2mr8535228ljl.252.1595778585882;
        Sun, 26 Jul 2020 08:49:45 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id s12sm1870515ljd.116.2020.07.26.08.49.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2020 08:49:44 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id r19so14576881ljn.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2020 08:49:44 -0700 (PDT)
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr7676040lji.70.1595778583932;
 Sun, 26 Jul 2020 08:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200726071356.287160-1-hch@lst.de>
In-Reply-To: <20200726071356.287160-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Jul 2020 08:49:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgq8evViJD9Hnjugq=V0eUAn7K6ZjOP7P7qki-nOTx_jg@mail.gmail.com>
Message-ID: <CAHk-=wgq8evViJD9Hnjugq=V0eUAn7K6ZjOP7P7qki-nOTx_jg@mail.gmail.com>
Subject: Re: add file system helpers that take kernel pointers for the init
 code v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 26, 2020 at 12:14 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Al and Linus,
>
> currently a lot of the file system calls in the early in code (and the
> devtmpfs kthread) rely on the implicit set_fs(KERNEL_DS) during boot.
> This is one of the few last remaining places we need to deal with to kill
> off set_fs entirely, so this series adds new helpers that take kernel
> pointers.  These helpers are in init/ and marked __init and thus will
> be discarded after bootup.  A few also need to be duplicated in devtmpfs,
> though unfortunately.

I see nothing objectionable here.

The only bikeshed comment I have is that I think the "for_init.c" name
is ugly and pointless - I think you could just call it "fs/init.c" and
it's both simpler and more straightforward. It _is_ init code, it's
not "for" init.

Other than that it all looked straightforward to me.

                Linus
