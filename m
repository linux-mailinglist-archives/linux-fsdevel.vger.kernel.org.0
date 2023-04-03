Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E5B6D3F0B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 10:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjDCId4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 04:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCIdz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F71EFF06
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 01:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680510775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5zbzGcbELHVtwSCvsaP+lW1lqaSUpO9wHVrHr3uaj9U=;
        b=I4UZALQPHnrlqSP5YM9Os0wRcK9JOiRcQ/5u1Y3sBtXqTtyP6MrPwIyenVoTvu1cKSfTkK
        bnqHyo55CQISAMFeaOhTdYOgrGVK9/CR6CgPp8S0zWu6THuea7IMZSywWOiWrE3CpSFR4S
        s6l8qCLw+Hlr431yfV8b6q1utSEgu+o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-p01qS212NfOfPLBPAGiKpA-1; Mon, 03 Apr 2023 04:32:50 -0400
X-MC-Unique: p01qS212NfOfPLBPAGiKpA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CB0A1818E50;
        Mon,  3 Apr 2023 08:32:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58A43C15BA0;
        Mon,  3 Apr 2023 08:32:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <c99f1f3d-25ac-6f5c-b5f1-26f7bfa513e8@redhat.com>
References: <c99f1f3d-25ac-6f5c-b5f1-26f7bfa513e8@redhat.com> <7f7947d6-2a03-688b-dc5e-3887553f0106@redhat.com> <20230329141354.516864-1-dhowells@redhat.com> <20230329141354.516864-38-dhowells@redhat.com> <709552.1680158901@warthog.procyon.org.uk>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Subject: Re: [RFC PATCH v2 37/48] ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1814784.1680510766.1@warthog.procyon.org.uk>
Date:   Mon, 03 Apr 2023 09:32:46 +0100
Message-ID: <1814785.1680510766@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Xiubo Li <xiubli@redhat.com> wrote:

> On 3/30/23 14:48, David Howells wrote:
> > Xiubo Li <xiubli@redhat.com> wrote:
> >
> >> BTW, will this two patch depend on the others in this patch series ?
> > Yes.  You'll need patches that affect TCP at least so that TCP supports
> > MSG_SPLICE_PAGES, so 04-08 and perhaps 09.  It's also on top of the
> > patches that remove ITER_PIPE on my iov-extract branch, but I don't think
> > that should affect you.
> 
> Why I asked this is because I only could see these two ceph relevant patches
> currently.

Depends on how you defined 'relevant', I guess.  Only two patches modify ceph
directly, but there's a dependency: to make those work, TCP needs altering
also.

David

