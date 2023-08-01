Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F7676B4EF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 14:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjHAMlb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 08:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjHAMlb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:41:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF101FCB
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 05:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690893640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fdSmE0KsRkcAPc+N+tgRm738pW2M/sS8fQouKVDmKko=;
        b=ioRi8/NXu93PyWzO+QdP5tCBL1syJ7uKL7j/zGAW+w1jqgKIJjRRA+IgHRa/0fjD8e8Ohf
        0T9AJos+nr07XWZVHaeiAtxzLFoaT0J+0KkUwmraAuVT6CV/tqVl3nzqQKRIaEp4ebiqmB
        R1wYbVpUkErF+mANAbmaBsBWhksfPPM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-1QObjjXDNfmEubEKL5L97Q-1; Tue, 01 Aug 2023 08:40:37 -0400
X-MC-Unique: 1QObjjXDNfmEubEKL5L97Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FA53185A792;
        Tue,  1 Aug 2023 12:40:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72517492B01;
        Tue,  1 Aug 2023 12:40:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <64c7acd57270c_169cd129420@willemb.c.googlers.com.notmuch>
References: <64c7acd57270c_169cd129420@willemb.c.googlers.com.notmuch> <64c6672f580e3_11d0042944e@willemb.c.googlers.com.notmuch> <20230718160737.52c68c73@kernel.org> <000000000000881d0606004541d1@google.com> <0000000000001416bb06004ebf53@google.com> <792238.1690667367@warthog.procyon.org.uk> <831028.1690791233@warthog.procyon.org.uk>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
        syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: Endless loop in udp with MSG_SPLICE_READ - Re: [syzbot] [fs?] INFO: task hung in pipe_release (4)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1401695.1690893633.1@warthog.procyon.org.uk>
Date:   Tue, 01 Aug 2023 13:40:33 +0100
Message-ID: <1401696.1690893633@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The more I look at __ip_append_data(), the more I think the maths is wrong.
In the bit that allocates a new skbuff:

	if (copy <= 0) {
	...
		datalen = length + fraggap;
		if (datalen > mtu - fragheaderlen)
			datalen = maxfraglen - fragheaderlen;
		fraglen = datalen + fragheaderlen;
		pagedlen = 0;
	...
		if ((flags & MSG_MORE) &&
		    !(rt->dst.dev->features&NETIF_F_SG))
	...
		else if (!paged &&
			 (fraglen + alloc_extra < SKB_MAX_ALLOC ||
			  !(rt->dst.dev->features & NETIF_F_SG)))
	...
		else {
			alloclen = fragheaderlen + transhdrlen;
			pagedlen = datalen - transhdrlen;
		}
	...

In the MSG_SPLICE_READ but not MSG_MORE case, we go through that else clause.
The values used here, a few lines further along:

		copy = datalen - transhdrlen - fraggap - pagedlen;

are constant over the intervening span.  This means that, provided the splice
isn't going to exceed the MTU on the second fragment, the calculation of
'copy' can then be simplified algebraically thus:

		copy = (length + fraggap) - transhdrlen - fraggap - pagedlen;

		copy = length - transhdrlen - pagedlen;

		copy = length - transhdrlen - (datalen - transhdrlen);

		copy = length - transhdrlen - datalen + transhdrlen;

		copy = length - datalen;

		copy = length - (length + fraggap);

		copy = length - length - fraggap;

		copy = -fraggap;

I think we might need to recalculate copy after the conditional call to
getfrag().  Possibly we should skip that entirely for MSG_SPLICE_READ.  The
root seems to be that we're subtracting pagedlen from datalen - but probably
we shouldn't be doing getfrag() if pagedlen > 0.

David

