Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE3928EB4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 04:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbgJOCsq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 22:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbgJOCsq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 22:48:46 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E91C0613D2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 19:48:46 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h6so1792050lfj.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 19:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPmN39XMdhH/ZRzEWbdWRJa4YGst6YX4ITt4ggC9sgk=;
        b=H7wKZzmknLGSwJX8VVMAlFL2hjitpKjoF2M0l3LGbtFcQhq6fmjQGIu0Mb77YCa8qb
         bpr2OddXeAy1ASmwtlmu8twK2w5a/a1VchvtD/FmunIJolvudip8ACBxLYa7jJ06ix40
         ZpAiCTTlJ3OI59TEjqTICKyQyumqI82mBPYIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPmN39XMdhH/ZRzEWbdWRJa4YGst6YX4ITt4ggC9sgk=;
        b=j9E5aYXVlS86jOnX7S6TYWKC5DN3QMzNAEcpmeDVeVHz7wRQt/m8bOb+bP8w79U2eR
         LbJ8iQZ+HF13RFqrA0PJQd4gC3Ferpro8o1A0q6vgZBwWlYYiE3j1SJpo0JIU2/fCPRm
         SoDWKKlIbaBNo0/s5Mj/Yj5M3/peZIa1l8aSGt9tYF9AZrr0B3+ZvAXRdoAl5+PRoWb2
         2I5ulrFaL50//bTndxBtzGFbWQjbk5Z0NdMazjVmHRRm2nQO5WXcMeqJZ/H7Co54z8+G
         Os6HJODJ/FvdUfW7kYo6FCN0CqLfGD0IefwSlOxJnMKSqT4/vQu0lXN9gUmjkIvGCHUU
         mr/Q==
X-Gm-Message-State: AOAM532rKBRcxo5/5nmzl1pMg2TnfJ6VsgJtQjxvah6hwD+dKKZB++Qy
        mt2s9WwDuKijHQuPL1QmeewzmeHfKTQe2w==
X-Google-Smtp-Source: ABdhPJyQmCNISbWPGkNn77X0x7Ax2zfv0RyXC24K2Zzea0rW74pVr//KhC5nafGaxQiD2MmJtJCebw==
X-Received: by 2002:a19:8114:: with SMTP id c20mr270076lfd.77.1602730124268;
        Wed, 14 Oct 2020 19:48:44 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id c1sm664752lji.101.2020.10.14.19.48.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 19:48:42 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id l2so1811130lfk.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 19:48:42 -0700 (PDT)
X-Received: by 2002:a19:4815:: with SMTP id v21mr336886lfa.603.1602730121761;
 Wed, 14 Oct 2020 19:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <160272187483.913987.4254237066433242737.stgit@magnolia>
In-Reply-To: <160272187483.913987.4254237066433242737.stgit@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Oct 2020 19:48:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXt28aJAoW_8gD=g1jvNaAE8NZ9M9eb7EknCJkzWc4qw@mail.gmail.com>
Message-ID: <CAHk-=wiXt28aJAoW_8gD=g1jvNaAE8NZ9M9eb7EknCJkzWc4qw@mail.gmail.com>
Subject: Re: [PATCH 0/2] vfs: move the clone/dedupe/remap helpers to a single file
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 5:31 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> So, I have a few questions, particularly for Al, Andrew, and Linus:
>
> (1) Do you find this reorganizing acceptable?

I don't see a problem.

> (3) Can I just grab the copyrights from mm/filemap.c?  Or fs/read_write.c?
> Or something entirely different?

Heh. Those copyright notices look pretty old, and I'm not sure how
much - if anything - I had to do with the remap helpers.

I suspect just a

   // SPDX-License-Identifier: GPL-2.0-only

is fine, with no need to try to drag along any other copyright notice
history from those two files.

               Linus
