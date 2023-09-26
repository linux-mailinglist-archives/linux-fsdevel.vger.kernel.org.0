Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60CB7AEE25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 15:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbjIZNuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 09:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbjIZNt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0445F3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 06:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695736143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4a0+/j3wqqmi1vR/kPX5Kqapr51Hnx898rdCOogEsLU=;
        b=N0bnjFWM1qDMkIIzxiUrdGMpQDv5FuI7h+MCzYzdLkUplecs3Cw0aEyfyzpu2LjcrjIOeQ
        ZfjTGLz1ry3sKY2yj8xtqG6TIRC0XwWJi3l8yGbcrwP7yd6UYXhQWVocYpUMnx/amy5B/g
        vqBrsz0Ap548cQyDwt+0CQsAzTdXW44=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-td5N-bvqNoevhu9VjagDWQ-1; Tue, 26 Sep 2023 09:48:57 -0400
X-MC-Unique: td5N-bvqNoevhu9VjagDWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2B45101A529;
        Tue, 26 Sep 2023 13:48:56 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3291A140273D;
        Tue, 26 Sep 2023 13:48:53 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
References: <20230913152238.905247-1-mszeredi@redhat.com>
        <20230913152238.905247-3-mszeredi@redhat.com>
        <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
        <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
        <20230914-lockmittel-verknallen-d1a18d76ba44@brauner>
        <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
        <20230918-grafik-zutreffen-995b321017ae@brauner>
        <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
Date:   Tue, 26 Sep 2023 15:48:51 +0200
In-Reply-To: <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
        (Miklos Szeredi's message of "Mon, 18 Sep 2023 16:14:02 +0200")
Message-ID: <871qeloxj0.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Miklos Szeredi:

> On Mon, Sep 18, 2023 at 3:51=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
>
>> I really would prefer a properly typed struct and that's what everyone
>> was happy with in the session as well. So I would not like to change the
>> main parameters.
>
> I completely  agree.  Just would like to understand this point:
>
>   struct statmnt *statmnt(u64 mntid, u64 mask, unsigned int flags);
>
> What's not properly typed about this interface?
>
> I guess the answer is that it's not a syscall interface, which will
> have an added [void *buf, size_t bufsize], while the buffer sizing is
> done by a simple libc wrapper.
>
> Do you think that's a problem?  If so, why?

Try-and-resize interfaces can be quite bad for data obtained from the
network.  If the first call provides the minimum buffer size (like
getgroups, but unlike readlink or the glibc *_r interfaces for NSS),
this could at least allow us to avoid allocating too much.  In
userspace, we cannot reduce the size of the heap allocation without
knowing where the pointers are and what they mean.

I also don't quite understand the dislike of variable-sized records.
Don't getdents, inotify, Netlink all use them?  And I think at least for
Netlink, more stuff is added all the time?

Thanks,
Florian

