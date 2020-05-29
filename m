Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8050F1E7211
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 03:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437887AbgE2B15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 21:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437523AbgE2B15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 21:27:57 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B7AC08C5C7
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 18:27:55 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b6so581568ljj.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 18:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9DDH+ka577yWN8I1lwER+N2nfRC2WU0Ckv2Lu1OmbU=;
        b=c3Co8BnhP/+fpOuPHGIDwU4Zp4Sa2cqOLC6C5vXoWp8xHdS4zCAeFxT3cnyP/W5jRQ
         9z0IlAP5Pfc8kc9hkuA28qt6ar69ruD08xLRWHn6gdeuFA6y10LClepdBIXBKdhQGHiP
         yAqpd4zJ1skPKdhgL9YZOnpw20LZMDWu0PnDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9DDH+ka577yWN8I1lwER+N2nfRC2WU0Ckv2Lu1OmbU=;
        b=RfPlrd4hxP6CwYfvnibqHTBhKPZTeAB1kJ5uqLW6dRAYYhGXCctKosT62HKzIX9w6e
         CGmVMcg3wayxGUF8sxGm1xyN7tVyInqU6nXyI9FeKq07JRqKFF9G7ItRqgDcdSynGEjz
         SsSgnO2hFtIO9yMQUPPY4c4hckVt/Ig7cFAA9XrTfUiWAat0MwrjgfQ5sL26WmTSOVlz
         Q7apBfcPfJf0YveYGMStGN22pDlZTO3gXVwJRwBxciRljzCJYVwQqbyVlnYWlQl3+GZ8
         VlzhvBWyvizwqV9+eDEsScCY9i4Wg8eo5EPW4wJa8J9GRvT/m7XK1P1+wK4yYY3urMQT
         tFcA==
X-Gm-Message-State: AOAM530YZyGwqS4TMBKEV/0GeQpPjVnBWdelC1ImJ2ifHddXeu+8vz3F
        OcIuZ7giPP914NuJUqBqgRzJxKfK37c=
X-Google-Smtp-Source: ABdhPJwOWxOsckyZ3z99WF9mfJa5NcJ3ZrNDpH6WmdMiA+3q99wpNS6y9ivWqSDGZkoKTW4oSDJJ/w==
X-Received: by 2002:a2e:9792:: with SMTP id y18mr2916662lji.389.1590715673961;
        Thu, 28 May 2020 18:27:53 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id a22sm1728186ljm.14.2020.05.28.18.27.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 18:27:52 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id d7so285669lfi.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 18:27:52 -0700 (PDT)
X-Received: by 2002:a05:6512:62:: with SMTP id i2mr3050072lfo.152.1590715672160;
 Thu, 28 May 2020 18:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200529000345.GV23230@ZenIV.linux.org.uk> <20200529000419.4106697-1-viro@ZenIV.linux.org.uk>
 <20200529000419.4106697-2-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200529000419.4106697-2-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 18:27:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnxFLm3ZTwx3XYnJL7_zPNSWf1RbMje22joUj9QADnMQ@mail.gmail.com>
Message-ID: <CAHk-=wgnxFLm3ZTwx3XYnJL7_zPNSWf1RbMje22joUj9QADnMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dlmfs: convert dlmfs_file_read() to copy_to_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 5:04 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         if (*ppos >= i_size_read(inode))
>                 return 0;
>
> +       /* don't read past the lvb */
> +       if (count > i_size_read(inode) - *ppos)
> +               count = i_size_read(inode) - *ppos;

This isn't a new problem, since you effectively just moved this code,
but it's perhaps more obvious now..

"i_size_read()" is not necessarily stable - we do special things on
32-bit to make sure that we get _a_ stable value for it, but it's not
necessarily guaranteed to be the same value when called twice. Think
concurrent pread() with a write..

So the inode size could change in between those two accesses, and the
subtraction might end up underflowing despite the check just above.

This might not be an issue with ocfs2 (I didn't check locking), but ..

                  Linus
