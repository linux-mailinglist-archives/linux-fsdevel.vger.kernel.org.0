Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1D04E2D18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 17:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350626AbiCUQFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 12:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350624AbiCUQFW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AED31BEB5
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647878636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DJyMtVQ5+0AfNUolDd6Lt5IE2lynsgQekcoq9taq1eE=;
        b=iJyQuhadbBEbAoVDfgWKGCC85eUcU4ZdeewPBBjUN0B37iSMx9RBEvPRBD66eq4V0oYin7
        b8CQYK+9UvU18V9oaZbukbyGhR4IFPw8+mY/LvwUE5QVbDsnucjZRnOHl1SP+guq1Nls6C
        JUOqfFd7C3svEKHQKDJmumxVfZg3WBo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-tqlhcQEaOwuiuk4cCIL_Kg-1; Mon, 21 Mar 2022 12:03:51 -0400
X-MC-Unique: tqlhcQEaOwuiuk4cCIL_Kg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6ABC8811E84;
        Mon, 21 Mar 2022 16:03:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BC0C2166B40;
        Mon, 21 Mar 2022 16:03:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAG48ez2AAk6JpZAA6GPVgvCmKimXHJXO906e=r=WGU06k=HB3A@mail.gmail.com>
References: <CAG48ez2AAk6JpZAA6GPVgvCmKimXHJXO906e=r=WGU06k=HB3A@mail.gmail.com> <000000000000778f1005dab1558e@google.com>
To:     Jann Horn <jannh@google.com>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+011e4ea1da6692cf881c@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] possible deadlock in pipe_write
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1037988.1647878628.1@warthog.procyon.org.uk>
Date:   Mon, 21 Mar 2022 16:03:48 +0000
Message-ID: <1037989.1647878628@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> The syz reproducer is:
> 
> #{"threaded":true,"procs":1,"slowdown":1,"sandbox":"","close_fds":false}
> pipe(&(0x7f0000000240)={<r0=>0xffffffffffffffff, <r1=>0xffffffffffffffff})
> pipe2(&(0x7f00000001c0)={0xffffffffffffffff, <r2=>0xffffffffffffffff}, 0x80)
> splice(r0, 0x0, r2, 0x0, 0x1ff, 0x0)
> vmsplice(r1, &(0x7f00000006c0)=[{&(0x7f0000000080)="b5", 0x1}], 0x1, 0x0)
> 
> That 0x80 is O_NOTIFICATION_PIPE (==O_EXCL).
> 
> It looks like the bug is that when you try to splice between a normal
> pipe and a notification pipe, get_pipe_info(..., true) fails, so
> splice() falls back to treating the notification pipe like a normal
> pipe - so we end up in iter_file_splice_write(), which first locks the
> input pipe, then calls vfs_iter_write(), which locks the output pipe.
> 
> I think this probably (?) can't actually lead to deadlocks, since
> you'd need another way to nest locking a normal pipe into locking a
> watch_queue pipe, but the lockdep annotations don't make that clear.

Is this then a bug/feature in iter_file_splice_write() rather than in the
watch queue code, per se?

David

