Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3094853A5D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 15:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352137AbiFANUx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 09:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbiFANUw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:20:52 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1B14175A3
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 06:20:50 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-qxqzpq1EP3qjbsqo9TYE3w-1; Wed, 01 Jun 2022 09:20:46 -0400
X-MC-Unique: qxqzpq1EP3qjbsqo9TYE3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BF55383328A;
        Wed,  1 Jun 2022 13:20:45 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E802414A7E9;
        Wed,  1 Jun 2022 13:20:43 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux.dev>,
        linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: [RFC PATCH 0/4] API extension for handling sysctl
Date:   Wed,  1 Jun 2022 15:20:28 +0200
Message-Id: <cover.1654086665.git.legion@kernel.org>
In-Reply-To: <CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com>
References: <CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 01:44:50PM -0700, Linus Torvalds wrote:
> On Fri, Apr 22, 2022 at 5:53 AM Alexey Gladkov <legion@kernel.org> wrote:
> >
> > Yes, Linus, these changes are not the refactoring you were talking
> > about, but I plan to try to do such a refactoring in the my next
> > patchset.
> 
> Heh. Ok, I'm not saying these patches are pretty, and looking up the
> namespace thing is a bit subtle, but it's certainly prettier than the
> existing odd "create a new ctl_table entry because of field abuse".

As I promised, here is one of the possible options for how to get rid of dynamic
memory allocation.

We can slightly extend the API and thus be able to save data at the time the
file is opened. This will not only eliminate the need to allocate memory, but
also provide access to file struct and f_cred.

I made an RFC because I'm not sure that I did the permissions check for
ipc_sysctl. I also did not change all the places where this API can be applied
to make the patch smaller. As in the case of /proc/sys/kernel/printk where
CAP_SYS_ADMIN is checked[1] for the current process at the time of write.

I made a patchset on top of:

git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-next

Because there are my previous changes.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/printk/sysctl.c#n17

--

Alexey Gladkov (4):
  sysctl: API extension for handling sysctl
  sysctl: ipc: Do not use dynamic memory
  sysctl: userns: Do not use dynamic memory
  sysctl: mqueue: Do not use dynamic memory

 fs/proc/proc_sysctl.c          |  71 ++++++++--
 include/linux/ipc_namespace.h  |  35 -----
 include/linux/sysctl.h         |  20 ++-
 include/linux/user_namespace.h |   6 -
 ipc/ipc_sysctl.c               | 236 +++++++++++++++++----------------
 ipc/mq_sysctl.c                | 138 ++++++++++---------
 ipc/mqueue.c                   |   5 -
 ipc/namespace.c                |  10 --
 kernel/ucount.c                | 116 +++++++---------
 kernel/user_namespace.c        |  10 +-
 10 files changed, 323 insertions(+), 324 deletions(-)

-- 
2.33.3

