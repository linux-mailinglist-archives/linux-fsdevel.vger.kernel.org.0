Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9D576D001
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 16:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjHBO10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 10:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjHBO1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:27:22 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0761A2D52;
        Wed,  2 Aug 2023 07:27:18 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-56661fe27cbso4674081eaf.3;
        Wed, 02 Aug 2023 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690986438; x=1691591238;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1qQgIORJRlmD0UJ8myQJ3W2VLdY4qHSEBJu+2btObE=;
        b=m/bhPUCkD7SbtEw2eb/bvy1F39jLWLEwVMcNSLoIyJKWX4L1ghEbu2JC82d9NJ9cbu
         K/H8DiudsHYUST3HeuuISIWdxNXK0JcTyMkaokgme6aVzjHfC5iQ+nmCuIvgIVPZE1GF
         ol9DF8YxH/Xh1vCd/hKG9hR757K2M8Ts1QVhyZw0eKvqzGECzxpKLhuXQcy2cJ7VOEFW
         4EWtGSKVhNJ+69XkPRDY195dD7lL7QA6NhTsgOT7hw3Alfym7x8eotbXx+Unagn7tzCW
         rcltUSomOFK85TCIv8t3Uid8d7+RWBvxxCG3ZsUhyB3Ba49z+rf2H5PwPhbHQaFuz7g9
         Jggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690986438; x=1691591238;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q1qQgIORJRlmD0UJ8myQJ3W2VLdY4qHSEBJu+2btObE=;
        b=Uo2nxsAlHT8CEHgDH3579oDseGtUPNA8Tm6/5pYrzuGC49bSjJl/5GRPKKVhnAYobP
         ms5PFZwa8JdE+rhfRCGPK5AHt28Q13JvBvmULTTyl6GqB2Bo/zuSimNvgKqW0xQLDr+J
         WU6/1VmFcdt+/e11n//pkw+pHSSXzx2snstilUp6p0eyH7pyCv3CcgYGW1avTUsrXQKR
         KgFRt6eyLJM/w4HyBWJlksQpBHUsAZqTqo5l4IPd88Tdhll/xwYNxdiBqfEWeoebL9jI
         piRm78MvGxqdB6gaqPBnNgXpvu2lYWuX/dVLvvKmtcP2V4jtK7gr4QqtTcl6DNLHhyq9
         8/zg==
X-Gm-Message-State: ABy/qLbClnwb3WQ6gH2q+idfiVWFsxaRvtY7ESTyt+cMNPzUEsJMj0Ka
        uQilW7Q3PpIhjyEdg1A5t7I=
X-Google-Smtp-Source: APBJJlE2tnKHyanb9fqR4kiTgcF0DCMwEBcvtN3sJ72Ud3TWHEHvhM9J+23wYjZgJfSdH0ImOgPmAg==
X-Received: by 2002:a05:6358:4309:b0:139:cdfa:52e9 with SMTP id r9-20020a056358430900b00139cdfa52e9mr6487878rwc.3.1690986437990;
        Wed, 02 Aug 2023 07:27:17 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id i11-20020a0cf48b000000b0063cf9478fddsm5581091qvm.128.2023.08.02.07.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 07:27:17 -0700 (PDT)
Date:   Wed, 02 Aug 2023 10:27:17 -0400
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
Message-ID: <64ca67c534d71_294ce929485@willemb.c.googlers.com.notmuch>
In-Reply-To: <1420063.1690904933@warthog.procyon.org.uk>
References: <1420063.1690904933@warthog.procyon.org.uk>
Subject: RE: [PATCH net] udp: Fix __ip_append_data()'s handling of
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
>     
> __ip_append_data() can get into an infinite loop when asked to splice into
> a partially-built UDP message that has more than the frag-limit data and up
> to the MTU limit.  Something like:
> 
>         pipe(pfd);
>         sfd = socket(AF_INET, SOCK_DGRAM, 0);
>         connect(sfd, ...);
>         send(sfd, buffer, 8161, MSG_CONFIRM|MSG_MORE);
>         write(pfd[1], buffer, 8);
>         splice(pfd[0], 0, sfd, 0, 0x4ffe0ul, 0);
> 
> where the amount of data given to send() is dependent on the MTU size (in
> this instance an interface with an MTU of 8192).
> 
> The problem is that the calculation of the amount to copy in
> __ip_append_data() goes negative in two places, and, in the second place,
> this gets subtracted from the length remaining, thereby increasing it.
> 
> This happens when pagedlen > 0 (which happens for MSG_ZEROCOPY and
> MSG_SPLICE_PAGES), because the terms in:
> 
>         copy = datalen - transhdrlen - fraggap - pagedlen;
> 
> then mostly cancel when pagedlen is substituted for, leaving just -fraggap.
> This causes:
> 
>         length -= copy + transhdrlen;
> 
> to increase the length to more than the amount of data in msg->msg_iter,
> which causes skb_splice_from_iter() to be unable to fill the request and it
> returns less than 'copied' - which means that length never gets to 0 and we
> never exit the loop.
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
> [!] Note that this ought to also affect MSG_ZEROCOPY, but MSG_ZEROCOPY
> avoids the problem by simply assuming that everything asked for got copied,
> not just the amount that was in the iterator.  This is a potential bug for
> the future.
> 
> Fixes: 7ac7c987850c ("udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES")
> Reported-by: syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/000000000000881d0606004541d1@google.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: David Ahern <dsahern@kernel.org>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: netdev@vger.kernel.org

Reviewed-by: Willem de Bruijn <willemb@google.com>

I noticed that this is still open in patchwork, no need to resend.
