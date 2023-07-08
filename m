Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0717F74BA85
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jul 2023 02:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjGHAWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 20:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGHAWP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 20:22:15 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F165FC
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 17:22:14 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6f943383eso40314981fa.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 17:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688775732; x=1691367732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ul3ss8VYJZdYxVGgDPid5ExlU80Na3C7GU2PntAs5rw=;
        b=XbwWPEoyMmho6R+MG5h8BGSE2Ngd5zbGaL1kK+OLZekzeO9tZzLRjxGkwHwjiHEG6q
         JtIM2zh0ScnGQcTDr8+xlX+VqY4jaM+4eIfQhF8Pg/vPUZN6Ygpfgedx5X3qjO8e8fVh
         r01REXN6jXHDpmlsOJigeeJiviSMK26hwcOmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688775732; x=1691367732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ul3ss8VYJZdYxVGgDPid5ExlU80Na3C7GU2PntAs5rw=;
        b=F2lqTKzIajLgfwfa8sqKKSJJ75sfRkstpmFCOrTANbJzUYinmZq2948nHQay06Z6j4
         IbpQZ9YXcg/8yCyCD801yrMkltP3GIw3YBevy2q3K6i+8R2d0U8f1bmpZPHl2DmqE8TY
         l2Utq2m5O9BsWJfZ33aDlA8dCZoXikRGNCz4KzwDr3vulo0O8SnBy+Nd9vX3wqVxvd0r
         KmBny9u1uXbhJkNJRvcc1l0iCZvtV1NsCi9soVIsHfQyLqsYnoT6goj5JZSRvCFJkK5T
         uHz/9xSYdc6l/SoglsAI/gklMXZ9IWTCdeZlInZdM8TTU+FBb2FV273TyfrOx2CpfJXS
         9ztg==
X-Gm-Message-State: ABy/qLbQvhesdzEx7c1sEamekZoTlJLdZFw80MJ2p/V7t3dgaRKHu+l6
        orW8SkUucEB/m8+f+ZHjb9VoBPRU0ZSxer1S/1rzvA==
X-Google-Smtp-Source: APBJJlGomy/5+03c8u0ZHTEcxX9T+SEXPm+wt4YWz1PVy9+4ZN3jKbkODmj7iwF1jMP88bufyF6CbQ==
X-Received: by 2002:a2e:7802:0:b0:2b6:cf64:7a8e with SMTP id t2-20020a2e7802000000b002b6cf647a8emr4838743ljc.19.1688775732690;
        Fri, 07 Jul 2023 17:22:12 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id s11-20020a2e98cb000000b002b700ca0f61sm996468ljj.112.2023.07.07.17.22.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 17:22:11 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4fba74870abso3814358e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 17:22:11 -0700 (PDT)
X-Received: by 2002:a05:6512:3af:b0:4f8:6c1f:b1ab with SMTP id
 v15-20020a05651203af00b004f86c1fb1abmr4305244lfp.27.1688775731487; Fri, 07
 Jul 2023 17:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw>
 <20230626-vorverlegen-setzen-c7f96e10df34@brauner> <4sdy3yn462gdvubecjp4u7wj7hl5aah4kgsxslxlyqfnv67i72@euauz57cr3ex>
 <20230626-fazit-campen-d54e428aa4d6@brauner> <qyohloajo5pvnql3iadez4fzgiuztmx7hgokizp546lrqw3axt@ui5s6kfizj3j>
 <CAHk-=wgmLd78uSLU9A9NspXyTM9s6C23OVDiN2YjA-d8_S0zRg@mail.gmail.com>
 <ZKinHejv+xBq+gti@casper.infradead.org> <CAHk-=wjJ8YP4wswYCC8X2o68vFeVzLesXbW-QdUgzzOZKaHJQw@mail.gmail.com>
In-Reply-To: <CAHk-=wjJ8YP4wswYCC8X2o68vFeVzLesXbW-QdUgzzOZKaHJQw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jul 2023 17:21:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=widpMfo_Zh5zHqL0Ct_VNqsHiwFyLUdM8wm6NF8o6T5kQ@mail.gmail.com>
Message-ID: <CAHk-=widpMfo_Zh5zHqL0Ct_VNqsHiwFyLUdM8wm6NF8o6T5kQ@mail.gmail.com>
Subject: Re: Pending splice(file -> FIFO) excludes all other FIFO operations
 forever (was: ... always blocks read(FIFO), regardless of O_NONBLOCK on read side?)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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

On Fri, 7 Jul 2023 at 17:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> > That is, do we want SIGWINCH or SIGALRM to result in a short read?
>
> Now, that's a different issue, and is actually handled by the signal
> layer: a signal that is ignored (where "ignored" includes the case of
> "default handler") will be dropped early, exactly because we don't
> want to interrupt things like tty or pipe reads when you resize the
> window.

In case you care, it's prepare_signal() -> sig_ignored() ->
sig_task_ignored() -> sig_handler_ignored() logic that does this
short-circuiting.

And while I don't think it's required by POSIX, this was definitely a
case where lots of programs that *don't* use any signal handlers at
all are very much not expecting to see -EINTR as a return value, and
used to break exactly on things like SIGWINCH when reading from a tty
or a pipe.

But that logic goes back to before linux-1.0.

In fact, I think it goes back to at least 0.99.10 (June '93).

                 Linus
