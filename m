Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DED57685A4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jul 2023 15:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjG3Nfr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jul 2023 09:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjG3Nfq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:35:46 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C0810FF;
        Sun, 30 Jul 2023 06:35:45 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-403b6b7c0f7so24194111cf.0;
        Sun, 30 Jul 2023 06:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690724144; x=1691328944;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ5xsFH8IhLw6wkZNuYKRHa8h8wKy8G/E+zV8buPrmw=;
        b=YDNOwdaUguRv/a9duChxdEJCoe6LD73gsYc3lIwYWIqZ3MpPSt5H663nitX24LLS0f
         hZauwBkAZmTGJlqcmrgvQmyGGMXqKpC5PQwlgP3OoMZbiqMn/rwfm5Go7nu8z1X1ERTp
         JBx9ekZ/B+115+Ks6XwQmElh2Z9y413Py1NSqIosv02xmYRSMHuJYwKzvHKm2IQhuVBR
         NyiKzPUpADWIXTN73GwURKtZUUGtMyhRrSNzatOdb7XG70luLlmGTScksRCr7bMNM7zg
         nIwfzIB7K3I9dpu9v7+HoVpLdIeE+DZH0cQmDnK5MJypRRfXziiZOyVIALlQAjvaocSF
         QwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690724144; x=1691328944;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AJ5xsFH8IhLw6wkZNuYKRHa8h8wKy8G/E+zV8buPrmw=;
        b=a0/g45dbzuWD6OtrB+c41r4BD87JQ95+RK1lkNqmETc5/6zrHTFvjg3vxPcBQoTes9
         nqr/a3/RqnwfcUe2IpWy6eVgPHoEUgfxBAH4GWjarD1T9DJKt6Mb/k50FCX/Ob5D9fks
         lKGXGouV1CRJzTlkHFoGBGEn60vIwpwycZDp3Vsi+KR56oZjc7xOGegyLhGJqB+dt/OC
         ZU53/VD4+uz3Gi98mciVFAzv3PnydUVQULW7nExken2jIonthZSgDC6Hi8tx/UEZETXF
         xsX6KMeT+gD8b/s9wKJ11usextR1kpHKYamsBrXkSWfpcUt+q4i8J61CCJDotd0Qel++
         wiUQ==
X-Gm-Message-State: ABy/qLYQQEeKwhL8RmlKUgQVZbwOyZ6/KCpTZ44TCW1Av/ocLgaO4shh
        NBOGFMOesJ5vvYvcAD+BG8U=
X-Google-Smtp-Source: APBJJlFFwM1M8eKZU6q7iLMpg2JH429nyXoHSISp+LuT7GAcLSEZC7MM5Kw5XDCXA9fxGqM8SiGJ6Q==
X-Received: by 2002:a05:622a:1646:b0:403:a814:ef4d with SMTP id y6-20020a05622a164600b00403a814ef4dmr7965167qtj.49.1690724143902;
        Sun, 30 Jul 2023 06:35:43 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id x1-20020ac87001000000b00402ed9adfa1sm2711309qtm.87.2023.07.30.06.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 06:35:43 -0700 (PDT)
Date:   Sun, 30 Jul 2023 09:35:43 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Message-ID: <64c6672f580e3_11d0042944e@willemb.c.googlers.com.notmuch>
In-Reply-To: <792238.1690667367@warthog.procyon.org.uk>
References: <20230718160737.52c68c73@kernel.org>
 <000000000000881d0606004541d1@google.com>
 <0000000000001416bb06004ebf53@google.com>
 <792238.1690667367@warthog.procyon.org.uk>
Subject: RE: Endless loop in udp with MSG_SPLICE_READ - Re: [syzbot] [fs?]
 INFO: task hung in pipe_release (4)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells wrote:
> Hi Jakub, Willem,
> 
> I think I'm going to need your help with this one.
> 
> > > syzbot has bisected this issue to:
> > > 
> > > commit 7ac7c987850c3ec617c778f7bd871804dc1c648d
> > > Author: David Howells <dhowells@redhat.com>
> > > Date:   Mon May 22 12:11:22 2023 +0000
> > > 
> > >     udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES
> > > 
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15853bcaa80000
> > > start commit:   3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
> > > git tree:       upstream
> > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=17853bcaa80000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=13853bcaa80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=150188feee7071a7
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=f527b971b4bdc8e79f9e
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a86682a80000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1520ab6ca80000
> > > 
> > > Reported-by: syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com
> > > Fixes: 7ac7c987850c ("udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES")
> > > 
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> The issue that syzbot is triggering seems to be something to do with the
> calculations in the "if (copy <= 0) { ... }" chunk in __ip_append_data() when
> MSG_SPLICE_PAGES is in operation.
> 
> What seems to happen is that the test program uses sendmsg() + MSG_MORE to
> loads a UDP packet with 1406 bytes of data to the MTU size (1434) and then
> splices in 8 extra bytes.
> 
> 	r3 = socket$inet_udp(0x2, 0x2, 0x0)
> 	setsockopt$sock_int(r3, 0x1, 0x6, &(0x7f0000000140)=0x32, 0x4)
> 	bind$inet(r3, &(0x7f0000000000)={0x2, 0x0, @dev={0xac, 0x14, 0x14, 0x15}}, 0x10)
> 	connect$inet(r3, &(0x7f0000000200)={0x2, 0x0, @broadcast}, 0x10)
> 	sendmmsg(r3, &(0x7f0000000180)=[{{0x0, 0x0, 0x0}}, {{0x0, 0xfffffffffffffed3, &(0x7f0000000940)=[{&(0x7f00000006c0)='O', 0x57e}], 0x1}}], 0x4000000000003bd, 0x8800)
> 	write$binfmt_misc(r1, &(0x7f0000000440)=ANY=[], 0x8)
> 	splice(r0, 0x0, r2, 0x0, 0x4ffe0, 0x0)
> 
> This results in some negative intermediate values turning up in the
> calculations - and this results in the remaining length being made longer
> from 8 to 14.
> 
> I added some printks (patch attached), resulting in the attached tracelines:
> 
> 	==>splice_to_socket() 7099
> 	udp_sendmsg(8,8)
> 	__ip_append_data(copy=-6,len=8, mtu=1434 skblen=1434 maxfl=1428)
> 	pagedlen 14 = 14 - 0
> 	copy -6 = 14 - 0 - 6 - 14
> 	length 8 -= -6 + 0
> 	__ip_append_data(copy=1414,len=14, mtu=1434 skblen=20 maxfl=1428)
> 	copy=1414 len=14
> 	skb_splice_from_iter(8,14)
> 	__ip_append_data(copy=1406,len=6, mtu=1434 skblen=28 maxfl=1428)
> 	copy=1406 len=6
> 	skb_splice_from_iter(0,6)
> 	__ip_append_data(copy=1406,len=6, mtu=1434 skblen=28 maxfl=1428)
> 	copy=1406 len=6
> 	skb_splice_from_iter(0,6)
> 	__ip_append_data(copy=1406,len=6, mtu=1434 skblen=28 maxfl=1428)
> 	copy=1406 len=6
> 	skb_splice_from_iter(0,6)
> 	__ip_append_data(copy=1406,len=6, mtu=1434 skblen=28 maxfl=1428)
> 	copy=1406 len=6
> 	skb_splice_from_iter(0,6)
> 	copy=1406 len=6
> 	skb_splice_from_iter(0,6)
> 	...
> 
> 'copy' gets calculated as -6 because the maxfraglen (maxfl=1428) is 8 bytes
> less than the amount of data then in the packet (skblen=1434).
> 
> 'copy' gets recalculated part way down as -6 from datalen (14) - transhdrlen
> (0) - fraggap (6) - pagedlen (14).
> 
> datalen is 14 because it was length (8) + fraggap (6).
> 
> Inside skb_splice_from_iter(), we eventually end up in an enless loop in which
> msg_iter.count is 0 and the length to be copied is 6.  It always returns 0
> because there's nothing to copy, and so __ip_append_data() cycles round the
> loop endlessly.
> 
> Any suggestion as to how to fix this?

Still ingesting.

The syzkaller repro runs in threaded mode, so syscalls should not be
interpreted in order.

There are two seemingly (but evidently not really) independent
operations:

One involving splicing

    pipe(&(0x7f0000000100)={<r0=>0xffffffffffffffff, <r1=>0xffffffffffffffff})
    r2 = socket$inet_udp(0x2, 0x2, 0x0)
    write$binfmt_misc(r1, &(0x7f0000000440)=ANY=[], 0x8)
    splice(r0, 0x0, r2, 0x0, 0x4ffe0, 0x0)
    close(r2)

And separately the MSG_MORE transmission that you mentioned

    r3 = socket$inet_udp(0x2, 0x2, 0x0)
    setsockopt$sock_int(r3, 0x1, 0x6, &(0x7f0000000140)=0x32, 0x4)
    bind$inet(r3, &(0x7f0000000000)={0x2, 0x0, @dev={0xac, 0x14, 0x14, 0x15}}, 0x10)
    connect$inet(r3, &(0x7f0000000200)={0x2, 0x0, @broadcast}, 0x10)
    sendmmsg(r3, &(0x7f0000000180)=[{{0x0, 0x0, 0x0}}, {{0x0, 0xfffffffffffffed3, &(0x7f0000000940)=[{&(0x7f00000006c0)='O', 0x57e}], 0x1}}], 0x4000000000003bd, 0x8800)

This second program also sets setsockopt SOL_SOCKET/SO_BROADCAST. That
is likely not some random noise in the program (but that can be easily
checked, by removing it -- assuming the repro triggers quickly).

Question is whether the infinite loop happens on the r2, the socket
involving MSG_SPLICE_PAGES, or r3, the socket involving SO_BROADCAST.
If the second, on the surface it would seem that splicing is entirely
unrelated.

