Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA114E8916
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Mar 2022 19:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbiC0RRQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Mar 2022 13:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiC0RRQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Mar 2022 13:17:16 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E3C10D8;
        Sun, 27 Mar 2022 10:15:36 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 77D458205CD;
        Sun, 27 Mar 2022 17:15:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a238.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E3DE1820967;
        Sun, 27 Mar 2022 17:15:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1648401335; a=rsa-sha256;
        cv=none;
        b=mASLVU82rm04FvTtwR5TrFfus09d7x/uyne0+hA6ZJjosKuWNLRYUbf3MmldFBai+aicli
        4+iZz6aLQ/N3yOg5HN6oGDmZ2rSRduwxNBxesQlLbf5w+eViBJBcuTo9/gc+XQMSOgZhX0
        GR9afCKsUDEqRmxOwnNIpp0ILF+/KKIN7A0IriEKtpyU0u4heI1d6MZOGrFEBvZvVXzh2+
        QsJ+qzI+Ur8lRkrGRimRC+7/CFzaYOBA7BQRamcv9mTHL4mtSGaLlrgdPckCJSPd4mqaag
        DhViuiSP0nt+2KIu3PpAZ3Km4H4UakutzlH8+JM6Q/OKDCDKV4Ax3ILOko9Mrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1648401335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=w1fiPFDj2EpQaIQHXWoKn3h6vJnDYTtbXYGB2AtQB/M=;
        b=putNwyg+Awl4ppVfSdMmbl9jW6lMqWhMDbAbpoLNrdZpZ9DjbaxhK7aQVF73p81muhS55u
        itbB3/ysDs2pl/4e3b49mOrP3YV/ufQ1hUHZOicbLKt1HZlpNUC6HcryLg9hQRb8MP4ANn
        5VztJKsKOBUwnmxesQl5VByj/D3v0BIKzNMFHWZUW9WvMUnR1mSGvSPFaep9qEwEJ/4e6L
        4EKhf+mXOXxGSOuMqGzPBMLlxDDwpzcB5k2gVG89oJYVtHDC9mrjfTkSkMcMq5QbtszkJF
        bao5lRcsMmdq5hmxtUv8ApPMZjtPnICH/pLlVjzOeWJZWmp827P4N4KrTghr4Q==
ARC-Authentication-Results: i=1;
        rspamd-cf7f5c5bf-jv2nd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a238.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.123.11 (trex/6.5.3);
        Sun, 27 Mar 2022 17:15:35 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wide-Eyed-Reaction: 4ad0f3d36db091d2_1648401335307_1738802150
X-MC-Loop-Signature: 1648401335307:4236116255
X-MC-Ingress-Time: 1648401335307
Received: from offworld (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a238.dreamhost.com (Postfix) with ESMTPSA id 4KRMsf0Bryz1Nr;
        Sun, 27 Mar 2022 10:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1648401334;
        bh=w1fiPFDj2EpQaIQHXWoKn3h6vJnDYTtbXYGB2AtQB/M=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=JUHQZg3eVPW8q+YSmOiGPFv7tFcXH5OIUnb9WfpNxom52k8suKMAqjHkxMGnwNrrd
         bkicK+dtXF/BV12JTR0P9gD6dvz96zeIlWjkWF32nMt/pxz3gTWEHGnwyomC3ODAj3
         dEiYlObkZdB1Fn/7uWiCKyNPf+KbLHn0qZMjDa7IVYbAVCiwAAKiQJA8vBlO8oPKE5
         zzxu0d9GV1c2VxokOSOI4sg9Qo57m0Yge24QCJVPBXOIe5LGmoywTr+Cdj6GyZFhHD
         ADdoF0Hu5MSgsSk9FidNMBN8J8HYQY68zcGLwpSY1uKlM/RGtTZyWebYku0gJovW1O
         zQDX5A7pzt9jw==
Date:   Sun, 27 Mar 2022 10:15:30 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+19480160ef25c9ffa29d@syzkaller.appspotmail.com,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>
Subject: Re: [PATCH] list: Fix another data-race around ep->rdllist.
Message-ID: <20220327171530.sbx63nw7h72bjucw@offworld>
References: <20220326063558.89906-1-kuniyu@amazon.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220326063558.89906-1-kuniyu@amazon.co.jp>
User-Agent: NeoMutt/20201120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 26 Mar 2022, Kuniyuki Iwashima wrote:

>syzbot had reported another race around ep->rdllist.  ep_poll() calls
>list_empty_careful() locklessly to check if the list is empty or not
>by testing rdllist->prev == rdllist->next.
>
>When the list does not have any nodes, the next and prev arguments of
>__list_add() is the same head pointer.  Thus the write to head->prev
>there is racy with lockless list_empty_careful() and needs WRITE_ONCE()
>to avoid store-tearing.
>
>Note that the reader side is already fixed in the patch [0].
>
>[0]: https://lore.kernel.org/mm-commits/20220326031647.DD24EC004DD@smtp.kernel.org/
>
>BUG: KCSAN: data-race in do_epoll_ctl / do_epoll_wait

I think this needs to be part of the same list-fix-a-data-race-around-ep-rdllist.patch

Thanks,
Davidlohr
