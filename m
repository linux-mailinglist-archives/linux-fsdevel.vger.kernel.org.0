Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B0D76BA23
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 18:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjHAQ6f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 12:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjHAQ6d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE41DA
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 09:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690909066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZKlr7hPRFIg1XM1Mg6RUtTCl8BMjdJxudj9aZC6n25E=;
        b=f/xJRKlBpiJ3cPJXSjNSd/3N+XvLgdUpel+tGEjdHIqkSnZYJ1NZ5WA9QsN5QLOYDiaHRM
        KQdCLw+tC5nIYUv9Pc9TYBWIgqMxj8sImXq/fwikRkxYZYV+zVbeBUXzWS8naY5HRhC/3U
        Xedqg7A/LARjqtpji14pw4u6IFP44Qc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-z-DU3XkbPMy31HetIn3hYg-1; Tue, 01 Aug 2023 12:57:44 -0400
X-MC-Unique: z-DU3XkbPMy31HetIn3hYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36A678007CE;
        Tue,  1 Aug 2023 16:57:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 743114024F83;
        Tue,  1 Aug 2023 16:57:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <64c93109c084e_1c5e3529452@willemb.c.googlers.com.notmuch>
References: <64c93109c084e_1c5e3529452@willemb.c.googlers.com.notmuch> <1420063.1690904933@warthog.procyon.org.uk>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] udp: Fix __ip_append_data()'s handling of MSG_SPLICE_PAGES
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1481563.1690909060.1@warthog.procyon.org.uk>
Date:   Tue, 01 Aug 2023 17:57:40 +0100
Message-ID: <1481564.1690909060@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> copy -= -fraggap definitely seems off. You point out that it even can
> turn length negative?

Yes.  See the logging I posted:

	==>splice_to_socket() 6630
	udp_sendmsg(8,8)
	__ip_append_data(copy=-1,len=8, mtu=8192 skblen=8189 maxfl=8188)
	pagedlen 9 = 9 - 0
	copy -1 = 9 - 0 - 1 - 9
	length 8 -= -1 + 0

Since datalen and transhdrlen cancel, and fraggap is unsigned, if fraggap is
non-zero, copy will be negative.

> The WARN_ON_ONCE, if it can be reached, will be user triggerable.
> Usually for those cases and when there is a viable return with error
> path, that is preferable. But if you prefer to taunt syzbot, ok. We
> can always remove this later.

It shouldn't be possible for length to exceed msg->msg_iter.count (assuming
there is a msg) coming from userspace; further, userspace can't directly
specify MSG_SPLICE_PAGES.

> __ip6_append_data probably needs the same.

Good point.  The arrangement of the code is a bit different, but I think it's
substantially the same in this regard.

David

