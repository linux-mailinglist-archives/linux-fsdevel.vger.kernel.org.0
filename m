Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21A573C4CD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jun 2023 01:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjFWXcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 19:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjFWXcY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:32:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DB9268C
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 16:32:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-988f066f665so131343766b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687563141; x=1690155141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Apfq7AhNdXkzjdfdSdVi+dqQ3I5tsUXwD6FmqXc0zjI=;
        b=KiYwDNslKP5ltIuFKMD1G8+70Y7YorPLtSVRZwk6fkbJzdOZ/gSkzboBt2HSrUwr/B
         dHU5ZdRQ/lMr1eCufBOsgUbTTadK8qHur+Pxx7Wq1hSihR1P9ypkU7zwL/MxFlDlqDfk
         TAaZKmzJPF1RdUNbmO5fa7oFUnON6wErQRpTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687563141; x=1690155141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Apfq7AhNdXkzjdfdSdVi+dqQ3I5tsUXwD6FmqXc0zjI=;
        b=DKfCWap+/nFxvKkPuMq3nAtqW01x3uP5/EPzqnv2UoXB2ZfGgZteZg+GFx76T8nvet
         RIQ6oGWRAq6e/J+kQ6oYmTJr9DKRGXUt3BRYyIWTYQjKMtdl4SyQA92rwDTIuY8g1A9k
         jf7F15lLwrHQGoN88JTwnGIPP1OO6kTR5qoZiPKgQnMvuPbl52ilEPWen1X6rCe0hh4z
         oTivqF+NFoxa96bZcvwagj+0loXBs4J2E1cbgIF6PIaU8mSo523CIC0xXdUbPbwxA9qN
         7v47jZ7Btj605hq9bitMoM8Dp1N7mDWWREh5qy8mM/KFbn07YA0xKr1f5yqHZSsTO8on
         yx6A==
X-Gm-Message-State: AC+VfDxJopeZdeVDOCdVJccQBElueVRdmDFw8yzJegqMFQotjw9XSC5s
        VXzMfUqpzdWRZwH5vNj6CiweObQPdkHceDF3nKe/2Tu9
X-Google-Smtp-Source: ACHHUZ5eBwD6HsKNaL0LQFMB/Yo7I5ig9czuXQFprvZHPidF4L2+xijUc1v9Jp779PJWHeS2iUKAfg==
X-Received: by 2002:a17:907:1c96:b0:96f:8439:6143 with SMTP id nb22-20020a1709071c9600b0096f84396143mr21899878ejc.40.1687563141541;
        Fri, 23 Jun 2023 16:32:21 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id j18-20020a170906831200b0098733a40bb7sm188629ejx.155.2023.06.23.16.32.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 16:32:21 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51bf8fd1e8fso1217001a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 16:32:20 -0700 (PDT)
X-Received: by 2002:a05:6402:1344:b0:51b:e5d7:98eb with SMTP id
 y4-20020a056402134400b0051be5d798ebmr4390582edw.41.1687563140463; Fri, 23 Jun
 2023 16:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <2730511.1687559668@warthog.procyon.org.uk> <CAHk-=wiXr2WTDFZi6y8c4TjZXfTnw28BkLF9Fpe=SyvmSCvP2Q@mail.gmail.com>
 <CAHk-=wjjNErGaMCepX-2q_3kuZV_aNoqB5SE-LLR_eLk2+OHJA@mail.gmail.com>
In-Reply-To: <CAHk-=wjjNErGaMCepX-2q_3kuZV_aNoqB5SE-LLR_eLk2+OHJA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jun 2023 16:32:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrsPMko==NyQ1Y=Cta-ATshCwzSn9OwCq6KAx8Gh8RLA@mail.gmail.com>
Message-ID: <CAHk-=wjrsPMko==NyQ1Y=Cta-ATshCwzSn9OwCq6KAx8Gh8RLA@mail.gmail.com>
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

On Fri, 23 Jun 2023 at 16:08, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In fact, I'd expect that patch to fail immediately on a perfectly
> normal program that passes a token around by doing a small write to a
> pipe, and have the "token reader" do a bigger write.

Bigger _read_, of course.

This might be hidden by such programs typically doing a single byte
write and a single byte read, but I could easily imagine situations
where people actually depend on the POSIX atomicity guarantees, ie you
write a "token packet" that might be variable-sized, and the reader
then just does a maximally sized read, knowing that it will get a full
packet or nothing.

So a read() of a pipe absolutely has to return when it has gotten
*any* data. Except if it can know that there is a writer that is still
busy and still in the process of writing more data.

Which was that old 'pipe->waiting_writers' logic - it basically
counted "there are <N> active writers that still have more data to
write, but the buffer filled up".

That logic went back to ancient times, when our pipe buffer was just a
single page - so it helped throughput immensely if we had writers that
did big writes, and readers would continue to read even when the small
buffer was completely used up (rather than return data just one page
at a time for each read() system call).

               Linus
