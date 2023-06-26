Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE30F73D79B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 08:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjFZGMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 02:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjFZGMH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:12:07 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B8EEE;
        Sun, 25 Jun 2023 23:12:05 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-78a5384a5daso557659241.0;
        Sun, 25 Jun 2023 23:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687759924; x=1690351924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWiNkr7svo+LwhrDq8mI2+KVwjyWuAbuHc8qcJJ40l4=;
        b=NVg6UP3h1sfMl7waiNHRNbbIMeY6YlVJ7w6iJOS7AQkWO6A/RRe1Z8RbIBX6B7uiHm
         5kumfhuY3QGWNkP687csxPo2nc3kN8+h9Uy6D0wqt8FanGeIWzAQoLsmr3RebM00psJ/
         qyUCP3GVubSTfmD1G+wuxBXJEw5wNNXajnBsJYuCnLBjWE3rrwyrKeR7PMBGveVzN90g
         zw6KcqCrQfdyWxDsKajhLY11SqX3q9tEdX3xhP5djybzrRxEdHDtk/BsCTYLm9T8PfMf
         pHpgQGpJuCOB8Hi4sgPf7K79xwahtVeKfOn0L/lZaC7G5/wlbRawP7WrIK7OKj71QZ4n
         B0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687759924; x=1690351924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWiNkr7svo+LwhrDq8mI2+KVwjyWuAbuHc8qcJJ40l4=;
        b=P2P84rSnpQ7VOa9Z2dKz8lyR+d+DMwI7+x6TKtRiJ2JLn0qunr0BJzzR3PsURiQH8e
         avMRtwe3G8S8yLjoU75Lr3kIlS4UBWUtEbUBm74mpTNVJ7rAQSRGfBWaGhnZSoG42ERL
         wIiS28pwrpjPuLen4ipLOmw+4w02DFTgW09IxepgnZul+kaygxz1WZYOB+/Y/6zqEby6
         zLKENA2QtK/PHxyrhksG1d5wKi1iedmiQhAkC9e4rkOR9cuMDd5ztExo88QYtl9PIRxl
         CY42hggAF0t84MxnsIFamXGqJRMo0+KiH1u4Ho6+NIq9S0zyrx2CL+MULEE0xJReXRSI
         EKAA==
X-Gm-Message-State: AC+VfDwaB/GEn3hiPENxeEg2JaMKcn8JTvUt8KXjxPAF1H4CXttG6kjy
        Nc89zk3f4tO5lfuZg6+krRlBvDwEkl6J2MmZex/xl+5ENRc=
X-Google-Smtp-Source: ACHHUZ6Mt7T7WOGheqCz8eTtbl6Lv6c6WI57bKj4DOh871nBqkbJWws+6lSTfjxGhFnoy77ryhgUCD4nAaIM+KAI15w=
X-Received: by 2002:a67:fc41:0:b0:443:682e:2088 with SMTP id
 p1-20020a67fc41000000b00443682e2088mr127623vsq.12.1687759924180; Sun, 25 Jun
 2023 23:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux>
In-Reply-To: <jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 26 Jun 2023 09:11:53 +0300
Message-ID: <CAOQ4uxhut2NHc+MY-XOJay5B-OKXU2X5Fe0-6-RCMKt584ft5A@mail.gmail.com>
Subject: Re: splice(-> FIFO) never wakes up inotify IN_MODIFY?
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 6:54=E2=80=AFAM Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> Hi!
>
> Consider the following programs:
> -- >8 --
> =3D=3D> ino.c <=3D=3D
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <sys/inotify.h>
> #include <unistd.h>
> int main() {
>   int ino =3D inotify_init1(IN_CLOEXEC);
>   inotify_add_watch(ino, "/dev/fd/0", IN_MODIFY);
>
>   char buf[64 * 1024];
>   struct inotify_event ev;
>   while (read(ino, &ev, sizeof(ev)) > 0) {
>     fprintf(stderr, "%d: mask=3D%x, cook=3D%x, len=3D%x, name=3D%.*s\n", =
ev.wd, ev.mask,
>             ev.cookie, ev.len, (int)ev.len, ev.name);
>     fprintf(stderr, "rd=3D%zd\n", read(0, buf, sizeof(buf)));
>   }
> }
>

That's a very odd (and wrong) way to implement poll(2).
This is not a documented way to use pipes, so it may
happen to work with sendfile(2), but there is no guarantee.

> =3D=3D> se.c <=3D=3D
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <sys/sendfile.h>
> int main() {
>   ssize_t rd, acc =3D 0;
>   while ((rd =3D sendfile(1, 0, 0, 128 * 1024 * 1024)) > 0)
>     acc +=3D rd;
>   fprintf(stderr, "se=3D%zd: %m\n", acc);
> }
>
> =3D=3D> sp.c <=3D=3D
> #define _GNU_SOURCE
> #include <fcntl.h>
> #include <stdio.h>
> int main() {
>   ssize_t rd, acc =3D 0;
>   while ((rd =3D splice(0, 0, 1, 0, 128 * 1024 * 1024, 0)) > 0)
>     acc +=3D rd;
>   fprintf(stderr, "sp=3D%zd: %m\n", acc);
> }
> -- >8 --
>
> By all means, ./sp | ./ino and ./se | ./ino should be equivalent,
> right?
>

Maybe it should, but it's not.

> -- >8 --
> $ make se sp ino
> $ mkfifo fifo
> $ ./ino < fifo &
> [1] 230
> $ echo a > fifo
> $ echo a > fifo
> 1: mask=3D2, cook=3D0, len=3D0, name=3D
> rd=3D4
> $ echo c > fifo
> 1: mask=3D2, cook=3D0, len=3D0, name=3D
> rd=3D2
> $ ./se > fifo
> abcdef
> 1: mask=3D2, cook=3D0, len=3D0, name=3D
> asd
> ^D
> se=3D11: Success
> rd=3D11
> 1: mask=3D2, cook=3D0, len=3D0, name=3D
> rd=3D0
> $ ./sp > fifo
> abcdefg
> asd
> dsasdadadad
> sp=3D24: Success
> $ < sp ./sp > fifo
> sp=3D25856: Success
> $ < sp ./sp > fifo
> ^C
> $ echo sp > fifo
> ^C
> -- >8 --
>
> Note how in all ./sp > fifo cases, ./ino doesn't wake up!
> Note also how, thus, we've managed to fill the pipe buffer with ./sp
> (when it transferred 25856), and now we can't /ever/ write there again
> (both splicing and normal writes block, since there's no space left in
>  the pipe; ./ino hasn't seen this and will never wake up or service the
>  pipe):
> so we've effectively "denied service" by slickily using a different
> syscall to do the write, right?
>

Only applications that do not check for availability
of input in the pipe correctly will get "denied service".

> I consider this to be unexpected behaviour because (a) obviously and
> (b) sendfile() sends the inotify event.
>

The fact is that relying on inotify IN_MODIFY and IN_ACCESS events
for pipes is not a good idea.

splice(2) differentiates three different cases:
        if (ipipe && opipe) {
...
        if (ipipe) {
...
        if (opipe) {
...

IN_ACCESS will only be generated for non-pipe input
IN_MODIFY will only be generated for non-pipe output

Similarly FAN_ACCESS_PERM fanotify permission events
will only be generated for non-pipe input.

sendfile(2) OTOH does not special cases the pipe input
case at all and it generates IN_MODIFY for the pipe output
case as well.

If you would insist on fixing this inconsistency, I would be
willing to consider a patch that matches sendfile(2) behavior
to that of splice(2) and not the other way around.

My general opinion about IN_ACCESS/IN_MODIFY
(as well as FAN_ACCESS_PERM) is that they are not
very practical, not well defined for pipes and anyway do
not cover all the ways that a file can be modified/accessed
(i.e. mmap). Therefore, IMO, there is no incentive to fix
something that has been broken for decades unless
you have a very real use case - not a made up one.

Incidentally, I am working on a new set of fanotify
permission events (FAN_PRE_ACCESS/MODIFY)
that will have better defined semantics - those are not
going to be applicable to pipes though.

Thanks,
Amir.
