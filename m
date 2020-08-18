Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A888F247DAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 06:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgHRE7Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 00:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgHRE7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 00:59:22 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B71FC061389;
        Mon, 17 Aug 2020 21:59:22 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m22so19946850ljj.5;
        Mon, 17 Aug 2020 21:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWvfs3pZoRAHfbzdJL3Y3cJmcPJl3EQ83JBMj85BKVg=;
        b=STnpeylJPM7ZmXBbPfBFjW8BZ0FVKJ3/tV26KAQTj3lxS3V0Hc7AkmOPh0s7m9x3l7
         /mdS1wRWMnraeG3+fl+YbiraD+bo8c0BlB1LtTkefe7JlwSg2mTFGu5FHMgAIy+a1cDO
         aeueMlF616I515mTLa5rvH8SNwKrcn8sNuL62vNoMAEAeHCX7V68f32TuUX6VAiyB6cl
         7ldwbAYHbqPahTc6VpKGYcPsi4+iVuZN9UxvyQdU6vfYslKyw0pVAoPi7Ie78VCIOvFe
         w2XJrIZOp+PcJjCK68BBYIre0rr83AGszJpmBufXQ1QWrWNAe2aGTbQQJqDgu8qp7HM3
         uYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWvfs3pZoRAHfbzdJL3Y3cJmcPJl3EQ83JBMj85BKVg=;
        b=Mds3Pm+fveg+1M2BhYQ07pEBqIE+xJMN/yKrRSy2nJLUPN8bdjiVnrNBg/DBEm15rz
         DDpvIc4AL2Z6FsVgBerd7kDyXQky67b5O17bvpFEyKslWQ0xKIKifCpS6c1KK9Y+26Ty
         QBGclK1iheFiplicIX2XxDAAsCvgggnGOwcfYXeaqne/B9VzD8aMMMrVDsYGYbt9mTLY
         U3yzuo9yf9Gjadrh4UKZHJTt4SKAMerWCCnalAtF+mOIAXzlFxkIbXcmkdl6JwmRGxHm
         gje3CmXhaSQ4JJ9JRRR1fkBGNoCY7UTIqbmq5Mz+/xFQoxVxmvTwv12fJLDTXl7fVyvJ
         q1gQ==
X-Gm-Message-State: AOAM533WKcd3CF3uCFghB+M153RkZMW4lt8uJjNoX9sOzMQ/NzjxLleE
        oRxoMRtOGl+iquV/KFL4wKhm39yXMUxuKdSb0mMrIxwVhzo=
X-Google-Smtp-Source: ABdhPJx6y4H2VkYxCEf6S9qGE9psSNlAE0G3Q+Xb1HfECYAey8frDyQgopQgbM4HY9k/yXX0JvjU26XFXu+BLw+Nnz8=
X-Received: by 2002:a2e:b6cd:: with SMTP id m13mr9089799ljo.91.1597726760879;
 Mon, 17 Aug 2020 21:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org> <20200817220425.9389-10-ebiederm@xmission.com>
 <20200818022249.GC1236603@ZenIV.linux.org.uk> <87sgck4o23.fsf@x220.int.ebiederm.org>
In-Reply-To: <87sgck4o23.fsf@x220.int.ebiederm.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 17 Aug 2020 21:59:09 -0700
Message-ID: <CAADnVQKAvzT5nYZhceL3P0z1Fosm2dqB+=U4R-fET2g8YO9HmA@mail.gmail.com>
Subject: Re: [PATCH 10/17] proc/fd: In proc_readfd_common use fnext_task
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, criu@openvz.org,
        bpf <bpf@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 8:46 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I am definitely willing to look at it. Do we think there would be enough
> traffic on task_lock from /proc/<pid>/fd access to make it work doing?

not from /proc, but bpf iterator in kernel/bpf/task_iter.c that is
being modified
in the other patch is used to process 100+k tasks. The faster it can go
through them the better. We don't see task spin_lock being a bottleneck though.
To test it just do 'bpftool prog show'. It will use task iterator undercover.
