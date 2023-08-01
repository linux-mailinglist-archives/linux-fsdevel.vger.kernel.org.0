Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BEC76B785
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 16:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbjHAOcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 10:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbjHAOcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:32:21 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EE32D79;
        Tue,  1 Aug 2023 07:31:49 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-409ae93bbd0so30092561cf.0;
        Tue, 01 Aug 2023 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690900304; x=1691505104;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpvro3EfLxFN3z0F6AOvOpAWsKbp8qLvkGalM6MQnwg=;
        b=MFkiI/tWUH7qTrlZQn3zI/pTGv+0QB7gj6ZEibl8JGYPABQQlnKoldTyMIITKYSwFn
         4e3V20BhJvn9MEHh7M7VPClVQFSgrCrgprWFHpP7lX1l4ORyxD41Xf/YYuHrqNwuk6/J
         DuWgujvvfB2tgQxh17fuGU/gOmYZS0zVMuAZrkRN4ASS7OJMM8tMsOb2lbTR3kc6JMRD
         Cae/b3FD381orZ+3uWsKO+//gJXGNdL0WhqmKISdy4ziK/bk8/+HcZJ7I4i53XpJtXVk
         eJmKAIm1dJyoytPqQrTK96T4I8WDhIObnVcK+em7FTvmvW+qIpKYaLlS32qfkcN20WrC
         qzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900304; x=1691505104;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qpvro3EfLxFN3z0F6AOvOpAWsKbp8qLvkGalM6MQnwg=;
        b=OF4lgxV9vLDYcU90RIEWmn68aapaG3W5cKIuc92r1kBo9BaHvtBtyLbILYZ3CeXzYj
         hmerNcV3+glydXqNPdAVZwn1Gl5W1qcinnf+taCndSJ3QYE0PARbhQDXUhnYQ/jihWrJ
         LZCAVjsx7Z9ng4A3SAlibtiNbD/pOszaBcfGN5Rmuyl3qjU4TshSovZ4wUrlbD39Ujcy
         vDGoU8KwW1ne9TDFB21lZG4yTNqWTIh6xexd1YA8UfqHOdLXSiaEVIihzgOv7NU3+2x2
         13afbiWsZSoHmFWCnflJIjX+/qQ+sJwfqCx27puvCQr8G4AdiJXGvo2Y3p4BcZLBA6b9
         h6Rw==
X-Gm-Message-State: ABy/qLZZn3S20zqtsRyV29kYL9JcZRuiHXTQz+WB8QJ9fRvTbg+mjHxz
        xKyFLWGvREcNbrLrrwY0t60=
X-Google-Smtp-Source: APBJJlGVe1mUE4psH/jKdYS9UhTvYS7XBodqk3vrPXjJaNRz/XmWvQxFBNBAmf44hGUQzNKRBXMz7Q==
X-Received: by 2002:a05:622a:2cf:b0:40f:da50:4dbf with SMTP id a15-20020a05622a02cf00b0040fda504dbfmr706477qtx.1.1690900304510;
        Tue, 01 Aug 2023 07:31:44 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id c27-20020ac8009b000000b004054b435f8csm4469242qtg.65.2023.08.01.07.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:31:44 -0700 (PDT)
Date:   Tue, 01 Aug 2023 10:31:43 -0400
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
Message-ID: <64c9174fda48e_1bf0a42945f@willemb.c.googlers.com.notmuch>
In-Reply-To: <1409099.1690899546@warthog.procyon.org.uk>
References: <64c903b02b234_1b307829418@willemb.c.googlers.com.notmuch>
 <64c7acd57270c_169cd129420@willemb.c.googlers.com.notmuch>
 <64c6672f580e3_11d0042944e@willemb.c.googlers.com.notmuch>
 <20230718160737.52c68c73@kernel.org>
 <000000000000881d0606004541d1@google.com>
 <0000000000001416bb06004ebf53@google.com>
 <792238.1690667367@warthog.procyon.org.uk>
 <831028.1690791233@warthog.procyon.org.uk>
 <1401696.1690893633@warthog.procyon.org.uk>
 <1409099.1690899546@warthog.procyon.org.uk>
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
> The attached seems to work.  I still think copy isn't correctly calculated in
> some circumstances - as I showed, several terms in the maths cancel out,
> including the length of the data.

That arithmetic makes assumptions that are specific to a particular
set of conditions (e.g., that pagedlen is non-zero).

Since the arithmetic is so complicated and error prone, I would try
to structure a fix that is easy to reason about to only change
behavior for the MSG_SPLICE_PAGES case.
 
> I'm also not entirely sure what 'paged' means in this function.  Should it
> actually be set in the MSG_SPLICE_PAGES context?

I introduced it with MSG_ZEROCOPY. It sets up pagedlen to capture the
length that is not copied.

If the existing code would affect MSG_ZEROCOPY too, I expect syzbot
to have reported that previously.

> ---
> udp: Fix __ip_addend_data()
> 
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 6e70839257f7..54675a4f2c9f 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1157,7 +1157,7 @@ static int __ip_append_data(struct sock *sk,
>  				pskb_trim_unique(skb_prev, maxfraglen);
>  			}
>  
> -			copy = datalen - transhdrlen - fraggap - pagedlen;
> +			copy = max_t(int, datalen - transhdrlen - fraggap - pagedlen, 0);
>  			if (copy > 0 && getfrag(from, data + transhdrlen, offset, copy, fraggap, skb) < 0) {
>  				err = -EFAULT;
>  				kfree_skb(skb);
> 


