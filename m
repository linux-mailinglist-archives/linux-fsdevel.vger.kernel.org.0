Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D705564900A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Dec 2022 18:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLJRoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 12:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLJRog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 12:44:36 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B0E12AB7
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 09:44:35 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id j16so5985340qtv.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 09:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yTAoatGwOoXnt0vQAJ8NuajE2zV18J1XkTsw0egALjs=;
        b=DhDjZoxdz/5wNDtWgkb/FJvzeWi+Ru+CPUwRY4m2jsJbXhQIK+aTEcFAgEBdVrOaCS
         2lNvie5rtdm83NkEwCPxyCGZsdtRDuOYr1urmL6qyUI0JMzm4IKdoRz7exVViAA1JFC9
         4e+YSaiquqNKG1rgCzEKpDBCjQ/ky2qjAOgF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTAoatGwOoXnt0vQAJ8NuajE2zV18J1XkTsw0egALjs=;
        b=gHwxKcu85SZqKBusTumDx6axZ68yZlZ+24vZxc4KUUPQn6rp/gdaB5Q4ilQNhIuiiN
         9orVezx4GTRRHmM3Tu/NBGzi5sDQ6sJ46XdiYvyZOpW/hk1qcvjf5XFgVXCc5E5bPmdT
         oD07WviI5UNnyxiy71nWjhg/5tEhMU7u5wefrub6PLwWSL8oEmqMRoY+GTEhLUedjhsm
         1tlEAnwy4kW8E41AEpBv/2gXtcRwFnJhJBUXqI+33mMVWUqJ2nfYxRJLNf7jYKPtoC5Q
         o9h5o6V20atsiXNvekuNbwWIYCIOoEDeB9ejewA42aC0SjlSsRgSGXsWdyMMYCMj/n62
         dtcw==
X-Gm-Message-State: ANoB5pkrAC5kdqRyY0p9cFrTmyUnDMbM3e0PkgeHHtOPFIw2/wGO3+ea
        7wt0otO3N4kIzuzHRE2syqJkfKzXlFD+YHMb
X-Google-Smtp-Source: AA0mqf6kg6jMHH4J11kcg0QbYZbHA2LlZenmgy45IpdshNsYhdIBPP/RQw624yW+3Vf7PQI5ZOooKg==
X-Received: by 2002:ac8:5490:0:b0:3a5:485e:7cc1 with SMTP id h16-20020ac85490000000b003a5485e7cc1mr12542816qtq.64.1670694273987;
        Sat, 10 Dec 2022 09:44:33 -0800 (PST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a0bc100b006cfc01b4461sm2428533qki.118.2022.12.10.09.44.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 09:44:32 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id s14so5331713qvo.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 09:44:32 -0800 (PST)
X-Received: by 2002:ad4:4101:0:b0:4b1:856b:4277 with SMTP id
 i1-20020ad44101000000b004b1856b4277mr69940715qvp.129.1670694272567; Sat, 10
 Dec 2022 09:44:32 -0800 (PST)
MIME-Version: 1.0
References: <9f6a8d1a-aa05-626d-6764-99c376722ed7@kernel.dk>
In-Reply-To: <9f6a8d1a-aa05-626d-6764-99c376722ed7@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 10 Dec 2022 09:44:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgqkWVi3nm6HJvOOy+GUVmPt9Wun+_ZVp47wZU43FET9w@mail.gmail.com>
Message-ID: <CAHk-=wgqkWVi3nm6HJvOOy+GUVmPt9Wun+_ZVp47wZU43FET9w@mail.gmail.com>
Subject: Re: [GIT PULL] Writeback fix
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 10, 2022 at 7:36 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Just a single writeback fix from Jan, for sanity checking adding freed
> inodes to lists.

That's what the commit message says too, but that's not what the patch
actually *does*.

It also does that unexplained

+       if (inode->i_state & I_FREEING) {
+               list_del_init(&inode->i_io_list);
+               wb_io_lists_depopulated(wb);
+               return;
+       }

that is new.

And yes, it has a link: in the commit message. And yes, I followed the
link in case it had some background.

And dammit, it's ANOTHER of those stupid pointless and worthless links
that just links to the patch submission, and has NO ADDITIONAL
INFORMATION.

Those links are actively detrimental. Stop it. I just wasted time
hoping that there would be some information about why the patch was
sent to me this late in the game. Instead, I just wated time on it.

I pulled this and then unpulled it. I'm very very annoyed. This patch
has an actively misleading commit message, has no explanation for why
it's so critical that it needs to be sent, and has a useless link to
garbage.

Fix the damn explanation to actually match the change. Fix the damn
link to point to something *useful* like the error report or
something.

And STOP WASTING EVERYBODY'S TIME with these annoying links that I
keep hoping would explain something and give useful background to the
change and instead just are a source of constant disappointment.

         Linus
