Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020E576CFF5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 16:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjHBOZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 10:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjHBOZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:25:47 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68092271B;
        Wed,  2 Aug 2023 07:25:42 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-63d0f62705dso47127696d6.0;
        Wed, 02 Aug 2023 07:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690986341; x=1691591141;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjGfCJHkpMI9k9iIwIjOnqVQQFNO/gdmK6q0Dzbrkgo=;
        b=szoMmaSEm9MLeTWawWU5dNjYLMw23jK+nWPZ6yXPHDf7+dk2FlDMxC2+j5l/mTzpQq
         hkF2eouNELYBI3+0zTlcRQbE7WihLyUZZ8bvvSl8Sn5asQcTQ1uy3V+AaHtkeypKLBud
         7VVvW8/peW1t2tVBf0KwSrlqzywd6UwhmL1oHFzhR9RpxSp9X0Rmr5oMuFXgVx/4728Q
         k6tnJ+RucHyInTiPtw2T5VTGcd/Y/acDGfV9zyJsGBSJ/6XuFuZL7+zKjk3IuBHI1YZ2
         ARu5ipmcuKmrmnwK79xu5gq1JhA/N1RJsB35YIuh3TwpYRQFJex/zUF9op1s+75Xy1e1
         8p9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690986341; x=1691591141;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qjGfCJHkpMI9k9iIwIjOnqVQQFNO/gdmK6q0Dzbrkgo=;
        b=K9UO/2Y/tfBkjiqS4rP0PN6YTKE4a6yAt9xyvp6e0PpN/oAIb/uXNkpTyCPvquZP4j
         k91WJaXhqIkGc7ve3PAHRCkwcV7JV/h28kl+7MmV+IZ5jybS8h6XIVLK4gdMzBhLmF6L
         PLMRNMJ/CzQbiCJUTO6+9gVnDjIbQbmIryhdtz7Drjw2OlsNEAwIADyAXegT4tW7i1uQ
         z4MQjRiToUZk5fHIIzv8f/WoL50+NYTpYdQ1VZWsw0NAJbzNL1tqC+G0ttpbrSsXFAx6
         yX7Cd6fdp8JWrz1qT3TrbRQVYwon1v0vAbLznaOi7t7xsbKrphO+WUCyUd3IfDOgczs6
         WKRw==
X-Gm-Message-State: ABy/qLZ7YlaGmL1Hfy+Efi0vdECU/NjxBu8ge5zEIERrRwdGD1F1AaiH
        wxC7sG1SBMCWKb88J5WdSHQ=
X-Google-Smtp-Source: APBJJlHEFfN8kUg4HDOk2etMtixHMke1yb5c8y1W0MjgkKfRiR1LSGq0N7KZidGzYH/2qo4XG7S5sw==
X-Received: by 2002:a0c:e401:0:b0:635:93fb:fbfa with SMTP id o1-20020a0ce401000000b0063593fbfbfamr13940074qvl.5.1690986341311;
        Wed, 02 Aug 2023 07:25:41 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id i11-20020a0cf38b000000b0063d67548802sm3083544qvk.137.2023.08.02.07.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 07:25:41 -0700 (PDT)
Date:   Wed, 02 Aug 2023 10:25:40 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com,
        syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
Message-ID: <64ca6764b3c6b_294ce9294bc@willemb.c.googlers.com.notmuch>
In-Reply-To: <1580952.1690961810@warthog.procyon.org.uk>
References: <1580952.1690961810@warthog.procyon.org.uk>
Subject: RE: [PATCH net-next] udp6: Fix __ip6_append_data()'s handling of
 MSG_SPLICE_PAGES
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
> __ip6_append_data() can has a similar problem to __ip_append_data()[1] when
> asked to splice into a partially-built UDP message that has more than the
> frag-limit data and up to the MTU limit, but in the ipv6 case, it errors
> out with EINVAL.  This can be triggered with something like:
> 
>         pipe(pfd);
>         sfd = socket(AF_INET6, SOCK_DGRAM, 0);
>         connect(sfd, ...);
>         send(sfd, buffer, 8137, MSG_CONFIRM|MSG_MORE);
>         write(pfd[1], buffer, 8);
>         splice(pfd[0], 0, sfd, 0, 0x4ffe0ul, 0);
> 
> where the amount of data given to send() is dependent on the MTU size (in
> this instance an interface with an MTU of 8192).
> 
> The problem is that the calculation of the amount to copy in
> __ip6_append_data() goes negative in two places, but a check has been put
> in to give an error in this case.
> 
> This happens because when pagedlen > 0 (which happens for MSG_ZEROCOPY and
> MSG_SPLICE_PAGES), the terms in:
> 
>         copy = datalen - transhdrlen - fraggap - pagedlen;
> 
> then mostly cancel when pagedlen is substituted for, leaving just -fraggap.
> 
> Fix this by:
> 
>  (1) Insert a note about the dodgy calculation of 'copy'.
> 
>  (2) If MSG_SPLICE_PAGES, clear copy if it is negative from the above
>      equation, so that 'offset' isn't regressed and 'length' isn't
>      increased, which will mean that length and thus copy should match the
>      amount left in the iterator.
> 
>  (3) When handling MSG_SPLICE_PAGES, give a warning and return -EIO if
>      we're asked to splice more than is in the iterator.  It might be
>      better to not give the warning or even just give a 'short' write.
> 
>  (4) If MSG_SPLICE_PAGES, override the copy<0 check.
> 
> [!] Note that this should also affect MSG_ZEROCOPY, but that will return
> -EINVAL for the range of send sizes that requires the skbuff to be split.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: David Ahern <dsahern@kernel.org>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: netdev@vger.kernel.org
> Link: https://lore.kernel.org/r/000000000000881d0606004541d1@google.com/ [1]

Reviewed-by: Willem de Bruijn <willemb@google.com>

I'm beginning to understand your point that the bug is older and copy
should never end up equal to -fraglen. pagedlen includes all of
datalen, which includes fraggap. This is wrong, as fraggap is always
copied to skb->linear. Haven't really thought it through, but would
this solve it as well?

                        else {
                                alloclen = fragheaderlen + transhdrlen;
-                               pagedlen = datalen - transhdrlen;
+                               pagedlen = datalen - transhdrlen - fraggap;

After that copy no longer subtracts fraglen twice.

                        copy = datalen - transhdrlen - fraggap - pagedlen;

But don't mean to delay these targeted fixes for MSG_SPLICE_PAGES any
further.
