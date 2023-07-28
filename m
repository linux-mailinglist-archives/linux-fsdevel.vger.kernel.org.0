Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFF076792A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jul 2023 01:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbjG1XxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 19:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjG1XxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 19:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E964233
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 16:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690588347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BY29vbVRSLrx1jOwy2KzcUw26TLcuFDuJxFn8li9iP8=;
        b=SBvVmuq5YANiUvXhT5kqY7V8ZmhhNpOsYRGu+tlXmrF+MoGgPpN70pEIZM3hmA1bff9Ecd
        ofiMH7Jdujeb+EvAAPAHz1e9EG8XffCxfPneFcmIdQ7KkGPSinOSEixqurGxfQGTUJVml+
        OThygK9aGZJ6hkx5bYQW6UPgYGSsDnc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-QF0H11mpOgSewz_eLPmuog-1; Fri, 28 Jul 2023 19:52:22 -0400
X-MC-Unique: QF0H11mpOgSewz_eLPmuog-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B356185A78B;
        Fri, 28 Jul 2023 23:52:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A857F400F36;
        Fri, 28 Jul 2023 23:52:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230718160737.52c68c73@kernel.org>
References: <20230718160737.52c68c73@kernel.org> <000000000000881d0606004541d1@google.com> <0000000000001416bb06004ebf53@google.com>
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
Content-ID: <550502.1690588340.1@warthog.procyon.org.uk>
Date:   Sat, 29 Jul 2023 00:52:20 +0100
Message-ID: <550503.1690588340@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

Jakub Kicinski <kuba@kernel.org> wrote:

> Hi David, any ideas about this one? Looks like it triggers on fairly
> recent upstream?

I've managed to reproduce it finally.  Instrumenting the pipe_lock/unlock
functions, splice_to_socket() and pipe_release() seems to show that
pipe_release() is being called whilst splice_to_socket() is still running.

I *think* syzbot is arranging things such that splice_to_socket() takes a
significant amount of time so that another thread can close the socket as it
exits.

In this sample logging, the pipe is created by pid 7101:

[   66.205719] --pipe 7101
[   66.209942] lock
[   66.212526] locked
[   66.215344] unlock
[   66.218103] unlocked

splice begins in 7101 also and locks the pipe:

[   66.221057] ==>splice_to_socket() 7101
[   66.225596] lock
[   66.228177] locked

but for some reason, pid 7100 then tries to release it:

[   66.377781] release 7100

and hangs on the __pipe_lock() call in pipe_release():

[   66.381059] lock

The syz reproducer does weird things with threading - and I'm wondering if
there's a file struct refcount bug here.  Note that splice_to_socket() can't
access the pipe file structs to alter the refcount, and the involved pipe
isn't communicated to udp_sendmsg() in any way - so if there is a refcount
bug, it must be somewhere in the VFS, the pipe driver or the splice
infrastructure:-/.

I'm also not sure what's going on inside udp_sendmsg() as yet.  It doesn't
show a stack in /proc/7101/stacks, which means it doesn't hit a schedule().

David

