Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1D676B549
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 14:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjHAM6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 08:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjHAM6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:58:18 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36551AA;
        Tue,  1 Aug 2023 05:58:17 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-63d0228d32bso30796556d6.2;
        Tue, 01 Aug 2023 05:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690894697; x=1691499497;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52xtRMZBq0GtelXFCLGXXpjBQ9BYFSeOAKYA+Oh87s8=;
        b=kvXqaj+XplVDOb28tqmrpexUF28oi70HOCK4+onfdTzh9FE74ILEwwwzWOm7u/dQ+W
         fbafYj/o5j09MrGbiTty2jVcNKP/ilMf0vMOYgg/Zr1gRNhAVxMaK5xGPZ97gS1aSFPt
         ESe6WsuIjE69o7F1KM0/2Ndnde/qqi+zSWO4Ulv+9a5TjxVdYeo47KZCa6QG7GlmR6a6
         vyc2MEg7XSeR3wMxpZGUBKd31pBzT25OVd8ojchCX8BzZ3WlvMTXu7XTcWj1TAFg3Ac/
         9T4fv5z0Xfo6Pg+ZXOdI3BquNpgqs3r0Qhx3yDmMVaeCchKFYpNIXLycnXndoWI08DPj
         dFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690894697; x=1691499497;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=52xtRMZBq0GtelXFCLGXXpjBQ9BYFSeOAKYA+Oh87s8=;
        b=lVA+PRvEgXvCpNWfd2CsOMtwn928gOkiHDJrYukmfhA1p9hLtTwgNMGuEaF34D5qGF
         7lyAjE1vtdEVSXhyFW/KHolVP9rau2iZT8HQhBARTOnQn6C2sy7pS1zaE6MEoP+yHAYe
         YihC5BKdTpkTLNm/8hRc6FKXwwqEfckUtyxA1hoOZ1S9Lf4NLsQTNuvH6ne+a4W5RLsd
         gyaJfHZxGOumyQ+F1E+mSdUPQFMIcHiCIdrsnpc8UNOIsikoPp1SmYhGkVUKWxNK4O8o
         4r+IzTpidUsySETfRtiyk+suoMJZeKtEkRZn9liRVjKepENnLZHroUffPlkQKpctb9YK
         d9bA==
X-Gm-Message-State: ABy/qLZj+4oHBdDXtG1ONorpBNiJ2VkCsDRCnTg91ZILoNFZucIXPhAR
        NSO0uobMd3+aSLp/3SsDiBAuV/0j+ow=
X-Google-Smtp-Source: APBJJlEIkqTRVKZLtG2Iljy/p50YykXPDd0qhhxO1UjmNJV6WTEQmOjO1bdp1USUVPMsmBVFFenkFw==
X-Received: by 2002:ad4:5810:0:b0:636:14d4:4461 with SMTP id dd16-20020ad45810000000b0063614d44461mr9962767qvb.62.1690894696926;
        Tue, 01 Aug 2023 05:58:16 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id w10-20020a0cb54a000000b0063d47a29e6fsm3944170qvd.55.2023.08.01.05.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:58:16 -0700 (PDT)
Date:   Tue, 01 Aug 2023 08:58:16 -0400
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
Message-ID: <64c901683e0b6_1b28392946b@willemb.c.googlers.com.notmuch>
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

q

