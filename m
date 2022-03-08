Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5E44D1F3A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 18:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348376AbiCHRli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 12:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347792AbiCHRlh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:41:37 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B18D506EA
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 09:40:40 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id w12so9204475lfr.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 09:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j4HcIA5ZURFOUl98GOVrefN75djtXjyZm8o/dMFbKz8=;
        b=XUxN+P64bilcPljqWgWX3wqVnw3FZMXB5ZH4wIfuAfuPKU8hucKGsVwl/+klugjHvC
         xd1iG9Sq95/OIhQAcijP56EOmxpcFGCDgrpONQjnZ4xtLxScBr0K/bZ22n0j5UyeCIsH
         RdkV3T99Y854qU87ErGuLfUzTChN5wVlQfXLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j4HcIA5ZURFOUl98GOVrefN75djtXjyZm8o/dMFbKz8=;
        b=xc0nbFU47q0yGjkAADRgn4MqP8gMuQt7qfBNY3FZ0bSjpOXIkPwJagW8F8gP2JimBE
         OWPZ7IrzqK0aq95vgrDrFh7wFevI5U97Xylluifuc62rpVB8yzzBQWj9PwFDpvTQ2X3j
         F5fUZcreg3/IWscoTWmm4JzOW6v21lcLEJwqeTWmAw3Ywinad47YTDXinMXNPFXJKt2p
         cM3XMwqTHQ3CgsaqbpV9Gt7vja3QQDe73i1XD59i52QTC+BhSE5cg53FZg4E5pmtKW8i
         vdk9miB+eBe/HaqZ6sf1gFJNXynC2HW2cOB/1bahORVqztvZCnDUlVdUvON6QBRPPx0p
         qgoQ==
X-Gm-Message-State: AOAM530ruQMAEdVgD3hvRcBSDmDamw2WwGoqi5znW5JSx30sDKuz+XpP
        canOrbD6UqFBxnfiBttmKmufa15/TpTgrdIH4yA=
X-Google-Smtp-Source: ABdhPJyWPskkN7Wy6Vjkqtas293Om6RyqyZ6MvAKRCtPDYwJqtBdl87IRYIoj0SnfEDn9jfjD3CfFA==
X-Received: by 2002:ac2:5229:0:b0:448:1bd5:35c7 with SMTP id i9-20020ac25229000000b004481bd535c7mr11642808lfl.520.1646761234912;
        Tue, 08 Mar 2022 09:40:34 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id l9-20020a2ea309000000b00246299de080sm3976914lje.48.2022.03.08.09.40.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 09:40:33 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id l20so8919647lfg.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 09:40:32 -0800 (PST)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr8519640lfj.449.1646761232492; Tue, 08
 Mar 2022 09:40:32 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 09:40:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
Message-ID: <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     David Hildenbrand <david@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 8, 2022 at 9:26 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Your actual patch looks pretty nasty, though. We avoid marking it
> accessed on purpose (to avoid atomicity issues wrt hw-dirty bits etc),
> but still, that patch makes me go "there has to be a better way".

That better way might be to make q() not use GUP at all.

It doesn't want the page - it just wants to make sure the fault is
handled. For the fault_in_readable() case we already just do the user
access.

The only reason we don't do that for fault_in_safe_writeable() is that
we don't have a good non-destructive user write.

Hmm. The futex code actually uses "fixup_user_fault()" for this case.
Maybe fault_in_safe_writeable() should do that?

                            Linus
