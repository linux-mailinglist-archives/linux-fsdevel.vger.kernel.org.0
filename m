Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B6F744F6C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 19:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjGBRz1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 13:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGBRz0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 13:55:26 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1808E5E;
        Sun,  2 Jul 2023 10:55:24 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-c13cb2cb428so622377276.0;
        Sun, 02 Jul 2023 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688320524; x=1690912524;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B/346nUIZErMaap4Xzifysw7agxmNBKblpAJllVen+8=;
        b=HS1Xpu8RutGjzNf2cNefIvO40PuyEyyWN1lXpuUm3Zm6tYXGDXwbDrBzDuJeX7KOHr
         q1UGGgd94SVTRefQw+1rgl1gQ50uEoBHL2OdSUILUjvF+1ATH9gvheGUN++hFOwLNLid
         1XMjRZLU+9Ge2en4fJbD50bjnQdqOwyoXZfvhIPbUVY/sq6Vm6BAvUYZPRqmTRzyIG2n
         JWXOYS2flIDtpE0mu19bw1MyMQp5M6uow+iO1HWzOXqc6Z90+aO2nBs6Bf+FGR5IBS25
         laBmv/H9uClBFT1isqMjJFlPY+WcanwzxZg1N8ZxZIN6sqfmOEIBN1yT1YF0buNY5Ya/
         4xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688320524; x=1690912524;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/346nUIZErMaap4Xzifysw7agxmNBKblpAJllVen+8=;
        b=jXMzier0L+uA9uqJKLdm5TIwgOAhgiAZeSAf6CZ7pSDwvbckdaLE4/JtIdDJA73YLg
         M1yROHqCUDtrY/d6QM/kLYRfUMkUW39C0xSaijLtk7V/6zkIUKaSdF0bTK5xqzYUOJ21
         XdMwBdozbMKoKy2GJxu60H09R/zh+jyWANP2/OE6fKdooaiTPggHcKUuaA3MLv/3Jdhv
         xMdFlk1Uq/jTYzBbOIYSGt4uTRVsHD+zsMsyHJ8qfP+m6a89VPqNNafySDtenOEE0PPW
         z4AOUwPm5Bd/e0kORptURQp1sAqAxIRYTkl4iPL8RY0mSaU+4n/TgsVND+Kb7gqbxopG
         V32Q==
X-Gm-Message-State: ABy/qLbXBRFGQ9vXsWtEkPvP85QWn0z0iO+Pv2E4bf3Lh+XyNrNrqZim
        170QS63XFk2rmFh6OnNwDK/RIGMcXish1f07JoJTnJKPmcUzgQ==
X-Google-Smtp-Source: APBJJlGKLhOT4Bu7qJ+9PV6J1mFibevhHpEsj9SgVNCYM6WTAos06S2LRQMzHrHXF1fE6Av0kYh7XbCZNh0JTIxm3q8=
X-Received: by 2002:a25:2b88:0:b0:bd6:6e3e:3af3 with SMTP id
 r130-20020a252b88000000b00bd66e3e3af3mr4285143ybr.3.1688320523798; Sun, 02
 Jul 2023 10:55:23 -0700 (PDT)
MIME-Version: 1.0
From:   Askar Safin <safinaskar@gmail.com>
Date:   Sun, 2 Jul 2023 20:54:47 +0300
Message-ID: <CAPnZJGB6gk47Hw-OE2_9eSKJ0DwOzEiL+tncMJyiOD6arw6xag@mail.gmail.com>
Subject: Re: [PATCH net-next v3 17/18] sock: Remove ->sendpage*() in favour of sendmsg(MSG_SPLICE_PAGES)
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>, bpf@vger.kernel.org,
        dccp@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-sctp@vger.kernel.org, linux-wpan@vger.kernel.org,
        linux-x25@vger.kernel.org, mptcp@lists.linux.dev,
        rds-devel@oss.oracle.com, tipc-discussion@lists.sourceforge.net,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -/* In some cases, both sendpage() and sendmsg() could have added
> - * an skb to the write queue, but failed adding payload on it.
> - * We need to remove it to consume less memory, but more
> - * importantly be able to generate EPOLLOUT for Edge Trigger epoll()
> - * users.
> +/* In some cases, both sendmsg() could have added an skb to the write queue,
> + * but failed adding payload on it.  We need to remove it to consume less
> + * memory, but more importantly be able to generate EPOLLOUT for Edge Trigger
> + * epoll() users.
>   */

There is a typo here. "Both" is redundant now

-- 
Askar Safin
