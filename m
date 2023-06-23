Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9979473C435
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jun 2023 00:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjFWWmM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 18:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjFWWmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:42:08 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD42E75
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 15:42:06 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so1498237e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 15:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687560125; x=1690152125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+QcHhK4jpwXJft/HBulx5tPasW6Ux53Kat5uK7dahPQ=;
        b=XAbZtp3ocHT17DrY0Sfhc9FFSS0Z23hQC4pE6Y32iP1XfQbzuQwI3QLldU85RJsARe
         qcFsA3j9wM0/0Zd3FPXm7ie24jpmuhr+rmhz9wWOh0s90uayaJdHDZl8H3lMBRRIXSAF
         3mSvU8NzQ0W8g8jlmTjNdLLnPDLxk3OX1qMDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687560125; x=1690152125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QcHhK4jpwXJft/HBulx5tPasW6Ux53Kat5uK7dahPQ=;
        b=HYtIa0FOLP/Z6XVQNJ0wsA5RgC6WvRi23ac3DMJD4XkADwpsW5SHHHBE8O61wm8Ott
         eHOzJE8yCGqpMYvN0nRWPfLMYl1zvjDalkwfW7dei5eLAHXYJHTZHUuRQtq48wLjzph/
         g6Wxmyuvf4vBxjta10gp46NuuC5+/LEC9Y0OTAfOfrQQ+UMSHpqR1cgLndBMh59CFari
         hvduxMamhcHby5xe6INNeIxtxMRn/FPK//zcJQY/mc1W16YaBFqObCJXMU2i1oDchpXV
         4jRTpAVwqckOkm7Y1R+6R3ZgiKE/kkdR9DkDgT5fKyjHqHYQBg1u8VR/fn56yjwMyAkB
         +dzA==
X-Gm-Message-State: AC+VfDwaXmEM/TBHVtmR/YR8ClQadoyVnaSR/1vImiU+E9y4fzD7DK6a
        DDafUu+lvZ5eiBahZNS3+k8rXhyG5CBAYU7J5mC8k+TD
X-Google-Smtp-Source: ACHHUZ7ivj3/BVs5Z47Cd7B3aobNNwngZOmRB6LadCN5HUTFkijKhdckgZcvdTdhLim0b5CGwHCumQ==
X-Received: by 2002:a19:4314:0:b0:4f8:70f8:d424 with SMTP id q20-20020a194314000000b004f870f8d424mr9660884lfa.65.1687560124828;
        Fri, 23 Jun 2023 15:42:04 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id w3-20020aa7d283000000b0051a2edb49b0sm17668edq.63.2023.06.23.15.42.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 15:42:04 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-519c0ad1223so1252677a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 15:42:04 -0700 (PDT)
X-Received: by 2002:aa7:d597:0:b0:51b:ecb7:23d2 with SMTP id
 r23-20020aa7d597000000b0051becb723d2mr3683631edq.18.1687560123663; Fri, 23
 Jun 2023 15:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <2730511.1687559668@warthog.procyon.org.uk>
In-Reply-To: <2730511.1687559668@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jun 2023 15:41:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXr2WTDFZi6y8c4TjZXfTnw28BkLF9Fpe=SyvmSCvP2Q@mail.gmail.com>
Message-ID: <CAHk-=wiXr2WTDFZi6y8c4TjZXfTnw28BkLF9Fpe=SyvmSCvP2Q@mail.gmail.com>
Subject: Re: [PATCH] pipe: Make a partially-satisfied blocking read wait for more
To:     David Howells <dhowells@redhat.com>
Cc:     Franck Grosjean <fgrosjea@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 23 Jun 2023 at 15:34, David Howells <dhowells@redhat.com> wrote:
>
> Can you consider merging something like the attached patch?  Unfortunately,
> there are applications out there that depend on a read from pipe() waiting
> until the buffer is full under some circumstances.  Patch a28c8b9db8a1
> removed the conditionality on there being an attached writer.

This patch seems actively wrong, in that now it's possibly waiting for
data that won't come, even if it's nonblocking.

What are these alleged broken apps? That commit a28c8b9db8a1 ("pipe:
remove 'waiting_writers' merging logic") is 3+ years old, and we
haven't heard people complain about it.

POSIX guarantees PIPE_BUF data, but that's 4kB. Your made-up test-case
is not valid, and never has been.

Yes, we used to do that write merging for performance reasons to avoid
extra system calls. And yes, we'll maintain semantics if people
actually end up having broken apps that depend on them, but I want to
know *what* broken app depends on this before I re-instate the write
merging.

And if we do re-instate it, I'm afraid we will have to do so with that
whole "waiting_writers" logic, so that we don't have the "reader waits
for data that might not come".

Because that patch of yours seems really broken. Nobody has *ever*
said "a read() on a pipe will always satisfy the whole buffer". That's
just completely bogus.

So let's name and shame the code that actually depended on it. And
maybe we'll have to revert commit a28c8b9db8a1, but after three+ years
of nobody reporting it I'm not really super-convinced.

               Linus
