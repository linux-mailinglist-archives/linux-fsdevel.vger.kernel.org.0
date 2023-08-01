Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772EE76BF07
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 23:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjHAVMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 17:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjHAVL6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:11:58 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D9B2110;
        Tue,  1 Aug 2023 14:11:53 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40fd276621aso9462211cf.2;
        Tue, 01 Aug 2023 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690924313; x=1691529113;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3zhuV25N+sKl5MeQNDP3GSv+2aK6nHaXNUe9w7Bzhg=;
        b=QAdnD5dDVzuHGTWPgk+NokNBjRSI0MQVV2bIyVShEg+sHhvL/Im5L2WAOTt3B7+GJU
         Jwr5VyVI7TNqXQopiGLXsS8Xu6SxysqIAHxsynfEd+HgXpEw//gltw0ahYvc0D0mMNrj
         GqjxTb9vWZL2s+KLk2rioDTV2lvg5lFVniqjGac1+XJaAee9C747dFEggtPW0S/DjllT
         p+S9MlwnzxVt0mFfNdBlZmlExTxDn9tupzCw/2HZkVZKsSfHHz3V4NQy7gdjuBhA8tbW
         RZJ1ofCxrjyoxZ8Cu1mYQW3np/HIQuD+KQFDZjAYpdHRkCrIokw1w7Pu/xPB7mWgGV/z
         Mm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690924313; x=1691529113;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a3zhuV25N+sKl5MeQNDP3GSv+2aK6nHaXNUe9w7Bzhg=;
        b=j4TVP5SkGX3BHaPhc8V9cssVE+dWjFM7N+HmkbmsBEzFylVgYgr1jM4yRnnfxoaZk/
         Jd4VTHrGdpbW6qedI9GF8biEcLabkIl6IaxiHyMvTD45iyuI0rmS/n0J9V5W9dfPnAFs
         W6Az1dIELA6vQgzz03Y3G4t8OyNJLMcTtu6uyshZlHWKBg5lz1cVL4BvWLO9boXw+AxG
         gsL46WOOdNrz8/aRQG0LzyL0PGJfZRFE765M8wykOZkf/v7EajyI8bdLUykrbzbPkIsm
         g9YWnbqvUeeNnjRQ9HzprH2JQJBbfD6AheN5Pij5Rlu6Zk3d9woek9BO4dp2BIA9Xqxf
         Sd/g==
X-Gm-Message-State: ABy/qLalBC38zPnqf4zxVabtQDwYaeR0lH6Yt/oJfxCDXgNQJIrk2bOR
        nX5k7Vm4bgUjHRRsClyPsqs=
X-Google-Smtp-Source: APBJJlFn+X3tW+qdknM5FvgQu6Ze7KHGA3P8xvhRqR6rSXj3+EjRSESXRAxSIoF4UovrhBFcuRHrCA==
X-Received: by 2002:a05:622a:1aa5:b0:40c:21b2:4090 with SMTP id s37-20020a05622a1aa500b0040c21b24090mr15099218qtc.56.1690924312729;
        Tue, 01 Aug 2023 14:11:52 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id gx7-20020a05622a27c700b0040f200feb4fsm2117213qtb.80.2023.08.01.14.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 14:11:50 -0700 (PDT)
Date:   Tue, 01 Aug 2023 17:11:49 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
Message-ID: <64c975155d6f3_1d4d6f2941e@willemb.c.googlers.com.notmuch>
In-Reply-To: <1501753.1690920713@warthog.procyon.org.uk>
References: <64c93109c084e_1c5e3529452@willemb.c.googlers.com.notmuch>
 <1420063.1690904933@warthog.procyon.org.uk>
 <1501753.1690920713@warthog.procyon.org.uk>
Subject: Re: [PATCH net] udp: Fix __ip_append_data()'s handling of
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
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> > __ip6_append_data probably needs the same.
> 
> Now that's interesting.  __ip6_append_data() has a check for this and returns
> -EINVAL in this case:
> 
> 		copy = datalen - transhdrlen - fraggap - pagedlen;
> 		if (copy < 0) {
> 			err = -EINVAL;
> 			goto error;
> 		}
> 
> but should I bypass that check for MSG_SPLICE_PAGES?  It hits the check when
> it should be able to get past it.  The code seems to go back to prehistoric
> times, so I'm not sure why it's there.

Argh, saved by inconsistency between the two stacks.

I don't immediately understand the race that caused this code to move,
in commit 232cd35d0804 ("ipv6: fix out of bound writes in __ip6_append_data()").
Maybe a race with a mtu update?

Technically there is no Fixes tag to apply, so this would not be a fix
for net.

If we want equivalent behavior, a patch removing this branch is probably
best sent to net-next, in a way that works from the start.
