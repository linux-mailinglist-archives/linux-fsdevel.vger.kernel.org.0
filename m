Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EDC76B577
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 15:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjHANIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 09:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjHANIO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:08:14 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E86E1727;
        Tue,  1 Aug 2023 06:08:02 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40e268fe7ddso13448021cf.3;
        Tue, 01 Aug 2023 06:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690895281; x=1691500081;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AccyrdI4Islk0cLDdXZ9MEAhmea3ReAH0ddsNjoh+g0=;
        b=FiwR3Bgf2y/IASlAH4AmTy+Tw1/tBeY/GGYIfvB59YuFHC2g77MRGPDc+Rx20KGaI3
         xK9RnOYDh27Q9omDLsTtyLSOzeB9y9tJBJ7yzuEZdz9IrpGitbJr9Vky4ffjia300lw0
         A6FLFOY9gIq+p7DGF2aXTUMvZ8BjFlhv3ft+yupcBIAB0YAlDib7NCfHk3G4ESmJK9Ut
         IY0saMFeik2bu9euj+rIQAZC8DjdzU1WF16EXuc9suR+6psgpYYYENrLotwTMnvv8CBx
         zzaKWHH++9Dfz2dbJAvVYtPU8TYeussEg1JAw17BaHYD70Mnl2yVD2Js4jfuZ0xflkBs
         VzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690895281; x=1691500081;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AccyrdI4Islk0cLDdXZ9MEAhmea3ReAH0ddsNjoh+g0=;
        b=PCTUsfSB2AV4XhXDL0KJ80/TxMt3c6NvrryScU4xDvbL+6d+yfRbP8b525CXrgJYmv
         VMB7IUCfh8xmV2CGoRKpik336i2Zo+CoCux8q79BWzAPkTXuZ8jRR0IGwAYw7j8W5UNh
         9X/VLRzP2x0FnS3tdRo7rH+vpA9I710P9x9LUB48JpMB/BjeQ6wz6WVIgwgFg90Hct1y
         5TY3jGdcsHBQLa3AN739gjQaZH3qmagDwcT282VpEhb7ZelUUt2Pxz//wznrDMC0zVof
         UDxq/veI77XshLZZ44lWk14mXUhAzuN7+nAfsVm6VFFhY4+vOvD4Jyfhpc1tAy/CGOvQ
         KgYg==
X-Gm-Message-State: ABy/qLZnK+RKM+5C78x/f8tJBaFBIgbaHOR0zr460SKULumxTkc4EFyA
        Kx3Q9zygJnofAYbwkGJ2YOk=
X-Google-Smtp-Source: APBJJlFQTOqNYYriaEQOeEiGlgbmt6PYyFxrbqc33voaEdXCrTIeb5nY1uOaHhYNXQXkkREB2/Qk7A==
X-Received: by 2002:ac8:5792:0:b0:40a:fc6a:e86e with SMTP id v18-20020ac85792000000b0040afc6ae86emr9900180qta.62.1690895281288;
        Tue, 01 Aug 2023 06:08:01 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id i3-20020ac84f43000000b0040553dac952sm4352606qtw.28.2023.08.01.06.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 06:08:00 -0700 (PDT)
Date:   Tue, 01 Aug 2023 09:08:00 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
        syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Message-ID: <64c903b02b234_1b307829418@willemb.c.googlers.com.notmuch>
In-Reply-To: <1401696.1690893633@warthog.procyon.org.uk>
References: <64c7acd57270c_169cd129420@willemb.c.googlers.com.notmuch>
 <64c6672f580e3_11d0042944e@willemb.c.googlers.com.notmuch>
 <20230718160737.52c68c73@kernel.org>
 <000000000000881d0606004541d1@google.com>
 <0000000000001416bb06004ebf53@google.com>
 <792238.1690667367@warthog.procyon.org.uk>
 <831028.1690791233@warthog.procyon.org.uk>
 <1401696.1690893633@warthog.procyon.org.uk>
Subject: Re: Endless loop in udp with MSG_SPLICE_READ - Re: [syzbot] [fs?]
 INFO: task hung in pipe_release (4)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells wrote:
> The more I look at __ip_append_data(), the more I think the maths is wrong.
> In the bit that allocates a new skbuff:
> 
> 	if (copy <= 0) {
> 	...
> 		datalen = length + fraggap;
> 		if (datalen > mtu - fragheaderlen)
> 			datalen = maxfraglen - fragheaderlen;
> 		fraglen = datalen + fragheaderlen;
> 		pagedlen = 0;
> 	...
> 		if ((flags & MSG_MORE) &&
> 		    !(rt->dst.dev->features&NETIF_F_SG))
> 	...
> 		else if (!paged &&
> 			 (fraglen + alloc_extra < SKB_MAX_ALLOC ||
> 			  !(rt->dst.dev->features & NETIF_F_SG)))
> 	...
> 		else {
> 			alloclen = fragheaderlen + transhdrlen;
> 			pagedlen = datalen - transhdrlen;
> 		}
> 	...
> 
> In the MSG_SPLICE_READ but not MSG_MORE case, we go through that else clause.
> The values used here, a few lines further along:
> 
> 		copy = datalen - transhdrlen - fraggap - pagedlen;
> 
> are constant over the intervening span.  This means that, provided the splice
> isn't going to exceed the MTU on the second fragment, the calculation of
> 'copy' can then be simplified algebraically thus:
> 
> 		copy = (length + fraggap) - transhdrlen - fraggap - pagedlen;
> 
> 		copy = length - transhdrlen - pagedlen;
> 
> 		copy = length - transhdrlen - (datalen - transhdrlen);
> 
> 		copy = length - transhdrlen - datalen + transhdrlen;
> 
> 		copy = length - datalen;
> 
> 		copy = length - (length + fraggap);
> 
> 		copy = length - length - fraggap;
> 
> 		copy = -fraggap;
> 
> I think we might need to recalculate copy after the conditional call to
> getfrag().  Possibly we should skip that entirely for MSG_SPLICE_READ.  The
> root seems to be that we're subtracting pagedlen from datalen - but probably
> we shouldn't be doing getfrag() if pagedlen > 0.

That getfrag is needed. For non-splice cases, to fill the linear part
of an skb. As your example shows, it is skipped if all data is covered
by pagedlen?

In this edge case, splicing appends pagedlen to an skb that holds only
a small linear part for fragheaderlen and fraggap.

Splicing has no problem appending to a normal linear skb, right. Say

  send(fd, buf, 100, MSG_MORE);
  write(pipe[1], buf, 8);
  splice(pipe[2], 0, fd, 0, 8, 0);

This only happens when a new skb has to be allocated during the splice
call.

What causes the infinite loop: does skb_splice_from_iter return 0 and
therefore the loop neither decrements copy, nor breaks out with error?

Apologies for the earlier mail. Accidentally hit send too soon..
