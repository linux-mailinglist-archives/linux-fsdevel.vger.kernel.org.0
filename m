Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95215578996
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 20:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiGRSaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 14:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbiGRSaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:30:04 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEC71EAF0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 11:30:03 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g1so16481211edb.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cmv5hgCvNzLGGr3LktdlyBF/B6b4xDynWT6Leb6vwMU=;
        b=KBwiHB+SXKRnkpvfkXzleS7byHrzZEABKfttt7pWmaEsExqk03fAWoqPR7nKPf3yLn
         Fyy7ZwVpbxtKJXXXE5vUlGB1XmrO7dWEjESKiVizPyTEuMwzHXNx/5JkAO4H6cQPZBsZ
         raIzGwzOE6ZLTmMNCIsGijKHIUXqYKCek8XUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cmv5hgCvNzLGGr3LktdlyBF/B6b4xDynWT6Leb6vwMU=;
        b=ohmL9vEzi/ghnFoQ9n9HRl4FBJAbElZ1SZVsHsQBDRPcGsuo++g0EzHdJK4SBAC/R6
         Rs2MxEzugeqNQKeiyMWjn9FSQ47NLXaLZIHY1BUwws3i18Hxdm+yQaWV7GLVErsjtnU2
         nSAz6zI8SUNIo6SqisPiYzRQNnW6/HhAOFizd8LepG1YohaZ1pb4Rko2jRLvT0vJJ7Gj
         tOFrcKpY9BNmAca1ly7vKOwT4AYGaNcuTyC2wTT1Q5LSDN1g66n06nlOUPmAxa58KqXY
         dxWfBXz8uvmqPr7dmXgtWU8U2ES2lKS0ch97A717Alf5tVZr7mqcomyayq6mi26x3731
         Sndg==
X-Gm-Message-State: AJIora8zmpSFygIKBE6AN/6DcvWcvvTG8ZkyIykuRug+1Ew0flDI8dR9
        /sYLUE4d0ABG43QNeI3r5QArGb0keUQzoMIU
X-Google-Smtp-Source: AGRyM1tVIheXKpkNOg9sVU2aHbDK2ZEBdDQL7QbbRuQ82k7xOHeJVhHigi63Cze6ydxWnhUtp7spmA==
X-Received: by 2002:a05:6402:34ce:b0:43a:a4bb:27a6 with SMTP id w14-20020a05640234ce00b0043aa4bb27a6mr38479078edc.158.1658169001322;
        Mon, 18 Jul 2022 11:30:01 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id d25-20020aa7c1d9000000b0043a75f62155sm9053355edp.86.2022.07.18.11.30.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 11:30:00 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id a5so18286757wrx.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 11:30:00 -0700 (PDT)
X-Received: by 2002:a5d:69c2:0:b0:21d:807c:a892 with SMTP id
 s2-20020a5d69c2000000b0021d807ca892mr23808743wrw.274.1658168999877; Mon, 18
 Jul 2022 11:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
 <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
 <83A29F9C-1A91-4753-953A-0C98E8A9832C@kohlschutter.com> <CAJfpegv5W0CycWCc2-kcn4=UVqk1hP7KrvBpzXHwW-Nmkjx8zA@mail.gmail.com>
 <FFA26FD1-60EF-457E-B914-E1978CCC7B57@kohlschutter.com> <CAJfpeguDAJpLMABsomBFQ=w6Li0=sBW0bFyALv4EJrAmR2BkpQ@mail.gmail.com>
 <A31096BA-C128-4D0B-B27D-C34560844ED0@kohlschutter.com> <CAJfpegvBSCQwkCv=5LJDx1LRCN_ztTh9VMvrTbCyt0zf7W2trw@mail.gmail.com>
In-Reply-To: <CAJfpegvBSCQwkCv=5LJDx1LRCN_ztTh9VMvrTbCyt0zf7W2trw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 11:29:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjg+xyBwMpQwLx_QWPY7Qf8gUOVek8rXdQccukDyVmE+w@mail.gmail.com>
Message-ID: <CAHk-=wjg+xyBwMpQwLx_QWPY7Qf8gUOVek8rXdQccukDyVmE+w@mail.gmail.com>
Subject: Re: [PATCH] [REGRESSION] ovl: Handle ENOSYS when fileattr support is
 missing in lower/upper fs
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
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

On Mon, Jul 18, 2022 at 6:13 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> Correct.  The question is whether any application would break in this
> case.  I think not, but you are free to prove otherwise.

Most often, an error is "just an error", and most applications usually
won't care.

There are exceptions: some errors are very much "do something special"
(eg EAGAIN or EINTR _are_ often separately tested for and often mean
"just retry"). And permission error handling is often different from
EINVAL etc.

And ENOSYS can easily be such an error - people probing whether they
are running on a new kernel that supports a new system call or not.

And yeah, some of our ioctl's are odd, and we have a lot of drivers
(and driver infrastructure) that basically does "this device does not
support this ioctl, so return ENOSYS".

I don't think that's the right thing to do, but I think it's
understandable. The traditional error for "this device does not
support this ioctl" is ENOTTY, which sounds so crazy to non-tty people
that I understand why people have used ENOSYS instead.

It's sad that it's called "ENOTTY" and some (at least historical)
strerror() implementations will indeed return "Not a tty". Never mind
that modern ones will say "inappropriate ioctl for device" - even when
the string has been updated, the error number isn't called
EINAPPROPRAITEDEVICE.

But it is what it is, and so I think ENOTTY is understandably not used
in many situations just because it's such a senseless historical name.

And so if people don't use ENOSYS, they use EINVAL.

I *suspect* no application cares: partly because ioctl error numbers
are so random anyway, but also very much if this is a "without
overlayfs it does X, with overlayfs it does Y".

The sanest thing to do is likely to make ovl match what a non-ovl
setup would do in the same situation (_either_ of the overlaid
filesystems - there might be multiple cases).

But I'm missing the original report. It sounds like there was a
regression and we already have a case of "changing the error number
broke something". If so, that regression should be fixed.

In general, I'm perfectly happy with people fixing error numbers and
changing them.

The only thing I require is that if those cleanups and fixes are
reported to break something, people quickly revert (and preferably add
a big comment about "Use *this* error number, because while this
*other* error number would make sense, application XyZ expects AbC"..)

             Linus
