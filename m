Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2872376805D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jul 2023 17:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjG2P2o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jul 2023 11:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjG2P2n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jul 2023 11:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792822D71
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jul 2023 08:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690644475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lYrjzDXQBP1JQED32eZ0I4QHdIQUaEv+ENeIzB1hNE4=;
        b=Oa0P0Ab8ngSHqGQMQitZjHoiWvdvmoAlxc1AQ0mCDjf0d1yTrMdny23Nl9uAcXzuwuDx3r
        vdNT7Tr1v80Z2xiAnxpJ5HQQOUMjD8h252+hR733o0/12NpRgko6lrbqLG03HsyjYEcYHJ
        arnf89JeMivpJiPZLJMpsx5DIL1KT1Q=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-HJQnEaRMPCORiA55xTOVMA-1; Sat, 29 Jul 2023 11:27:52 -0400
X-MC-Unique: HJQnEaRMPCORiA55xTOVMA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34FDD3803507;
        Sat, 29 Jul 2023 15:27:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91BE1140E949;
        Sat, 29 Jul 2023 15:27:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <550503.1690588340@warthog.procyon.org.uk>
References: <550503.1690588340@warthog.procyon.org.uk> <20230718160737.52c68c73@kernel.org> <000000000000881d0606004541d1@google.com> <0000000000001416bb06004ebf53@google.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] INFO: task hung in pipe_release (4)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <713502.1690644467.1@warthog.procyon.org.uk>
Date:   Sat, 29 Jul 2023 16:27:47 +0100
Message-ID: <713503.1690644467@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> I've managed to reproduce it finally.  Instrumenting the pipe_lock/unlock
> functions, splice_to_socket() and pipe_release() seems to show that
> pipe_release() is being called whilst splice_to_socket() is still running.

That's actually a bit of a red herring.  pipe_release() is so-called because
it's called as the release file op for an end of the pipe.  It doesn't
automatically free the pipe_inode_info struct - there's refcounting on that.

So the problem is that udp_sendmsg() didn't return; pipe_release() hanging on
the pipe_lock() is merely a noisy symptom thereof.

David

