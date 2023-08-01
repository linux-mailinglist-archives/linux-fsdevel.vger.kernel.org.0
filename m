Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6574976B7F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 16:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjHAOsc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 10:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjHAOsb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:48:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A46A1BCF
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690901268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=77SgUFl2HB6+f2EfWd7XLhBOxqcp2ZcmVefhFsJwvso=;
        b=Q9wrMO7VcpmmPA+ZD+vsM2eQZcPXOlvrPLbTBx310ZEY4P9bcIJJJYW/mZYXLUpVDzcd7n
        jZIaPi40EF9t5RuJs0sk7+KMxgutuTVp2zO7qf6be3YLrkbSv7Eg47vJQvu+8GWYBfDtMZ
        geG/XOYg+6a6YlPjky9mFeTTxhYdtCE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-CN4xJSqeOzmaJVv-cmpRsQ-1; Tue, 01 Aug 2023 10:47:44 -0400
X-MC-Unique: CN4xJSqeOzmaJVv-cmpRsQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8B201064C0D;
        Tue,  1 Aug 2023 14:47:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DA8F492B01;
        Tue,  1 Aug 2023 14:47:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <64c9174fda48e_1bf0a42945f@willemb.c.googlers.com.notmuch>
References: <64c9174fda48e_1bf0a42945f@willemb.c.googlers.com.notmuch> <64c903b02b234_1b307829418@willemb.c.googlers.com.notmuch> <64c7acd57270c_169cd129420@willemb.c.googlers.com.notmuch> <64c6672f580e3_11d0042944e@willemb.c.googlers.com.notmuch> <20230718160737.52c68c73@kernel.org> <000000000000881d0606004541d1@google.com> <0000000000001416bb06004ebf53@google.com> <792238.1690667367@warthog.procyon.org.uk> <831028.1690791233@warthog.procyon.org.uk> <1401696.1690893633@warthog.procyon.org.uk> <1409099.1690899546@warthog.procyon.org.uk>
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
Content-ID: <1410189.1690901255.1@warthog.procyon.org.uk>
Date:   Tue, 01 Aug 2023 15:47:35 +0100
Message-ID: <1410190.1690901255@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> > I'm also not entirely sure what 'paged' means in this function.  Should it
> > actually be set in the MSG_SPLICE_PAGES context?
> 
> I introduced it with MSG_ZEROCOPY. It sets up pagedlen to capture the
> length that is not copied.
> 
> If the existing code would affect MSG_ZEROCOPY too, I expect syzbot
> to have reported that previously.

Ah...  I think it *should* affect MSG_ZEROCOPY also... but...  If you look at:

		} else {
			err = skb_zerocopy_iter_dgram(skb, from, copy);
			if (err < 0)
				goto error;
		}
		offset += copy;
		length -= copy;

MSG_ZEROCOPY assumes that if it didn't return an error, then
skb_zerocopy_iter_dgram() copied all the data requested - whether or not the
iterator had sufficient data to copy.

If you look in __zerocopy_sg_from_iter(), it will drop straight out, returning
0 if/when iov_iter_count() is/reaches 0, even if length is still > 0, just as
skb_splice_from_iter() does.

So there's a potential bug in the handling of MSG_ZEROCOPY - but one that you
survive because it subtracts 'copy' from 'length', reducing it to zero, exits
the loop and returns without looking at 'length' again.  The actual length to
be transmitted is in the skbuff.

> Since the arithmetic is so complicated and error prone, I would try
> to structure a fix that is easy to reason about to only change
> behavior for the MSG_SPLICE_PAGES case.

Does that mean you want to have a go at that - or did you want me to try?

David

