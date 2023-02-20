Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1852069CB6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 13:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjBTMx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 07:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjBTMx0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:53:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDE283F5
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 04:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676897558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mi2k6ov9PIEEOKF8HtnT+0K1MGZyhTRbqIFEKucrAxQ=;
        b=Pi27/CwsY/H/a2ClsPQY4Dak9WhqcJ00dblzmrrxhUeiPYufyi0mTLx/0yOw7D8qoi48e4
        xswS1ULkSOpVhUMww3SOD3E1u7j/EMCIbUQSgAmjaG2sGI2B9eBcF5NeXo2BpiOPMM6zxE
        Mf6Lk9Y+wCkZMmtqTI5z5F74Uuyqpfo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-97-xfWndiqnOg6fzI0ytmeCRA-1; Mon, 20 Feb 2023 07:52:37 -0500
X-MC-Unique: xfWndiqnOg6fzI0ytmeCRA-1
Received: by mail-pg1-f197.google.com with SMTP id g13-20020a63f40d000000b005015be7b9faso861798pgi.15
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 04:52:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mi2k6ov9PIEEOKF8HtnT+0K1MGZyhTRbqIFEKucrAxQ=;
        b=eLg6+CkxYOh3GLjOopOawxZhJGoh1Htx0c4tKHQEC80XQJxcEfDvmEWdDvuNzn3lQB
         MoUtaAKqwYgo0jtv/hrw4B9QzGUQUsY5TcUWZ3Z1qTC7/PcN1YdTd0hze2iI1IiJz3q8
         TkeCQNyR4TMxK9pHFC4PQKHUV/G4YbwUd5ELX9Ao2y0hHQDXHhl1hSQrpTf8wv/X6deS
         r2Ms0excMuOqu/V9oYVNCDV2saPwAO17nCNPXX80x+bfpi35FIs0u5+S/fZV+io8JCLo
         iLilB/3N26hHbU5EJH7GPD2eNGDB+Q8ZzXbVwznBn7TN5a4F6TDBDfZjnUedyWTqirbx
         Osjg==
X-Gm-Message-State: AO0yUKV9T7ZKLr6cSVnUsE/t/Ru1bzk0bNhtvpuNJPXgN2eXZcY/tIad
        Y+OKEMuPscEXC33e4OmybV2pVdf5qP16Aj4K9XCbLMJNNa6Nim0aXK9rKD21GC9UZRc1nmMhnbg
        TRxg2nud35J6JLCpV6abjrttNeRkMNCbjBMSxS/LCEQ==
X-Received: by 2002:a17:903:449:b0:19a:f63a:47db with SMTP id iw9-20020a170903044900b0019af63a47dbmr191498plb.2.1676897556567;
        Mon, 20 Feb 2023 04:52:36 -0800 (PST)
X-Google-Smtp-Source: AK7set/HmWnP91UrLVg24xciP71WBRN1oXKx7zdnbGZIUV6VrXz5Bnk6LyVvuteQq63xg3d0WGyePBM+ET5m+YQOvdI=
X-Received: by 2002:a17:903:449:b0:19a:f63a:47db with SMTP id
 iw9-20020a170903044900b0019af63a47dbmr191497plb.2.1676897556296; Mon, 20 Feb
 2023 04:52:36 -0800 (PST)
MIME-Version: 1.0
References: <20230210145823.756906-1-omosnace@redhat.com>
In-Reply-To: <20230210145823.756906-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 20 Feb 2023 13:52:24 +0100
Message-ID: <CAFqZXNt84oqHo5aQQbjuroA6fGzMyso9HuN4fz3u1mygze2Yrw@mail.gmail.com>
Subject: Re: [PATCH] sysctl: fix proc_dobool() usability
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 10, 2023 at 3:58 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Currently proc_dobool expects a (bool *) in table->data, but sizeof(int)
> in table->maxsize, because it uses do_proc_dointvec() directly.
>
> This is unsafe for at least two reasons:
> 1. A sysctl table definition may use { .data = &variable, .maxsize =
>    sizeof(variable) }, not realizing that this makes the sysctl unusable
>    (see the Fixes: tag) and that they need to use the completely
>    counterintuitive sizeof(int) instead.
> 2. proc_dobool() will currently try to parse an array of values if given
>    .maxsize >= 2*sizeof(int), but will try to write values of type bool
>    by offsets of sizeof(int), so it will not work correctly with neither
>    an (int *) nor a (bool *). There is no .maxsize validation to prevent
>    this.
>
> Fix this by:
> 1. Constraining proc_dobool() to allow only one value and .maxsize ==
>    sizeof(bool).
> 2. Wrapping the original struct ctl_table in a temporary one with .data
>    pointing to a local int variable and .maxsize set to sizeof(int) and
>    passing this one to proc_dointvec(), converting the value to/from
>    bool as needed (using proc_dou8vec_minmax() as an example).
> 3. Extending sysctl_check_table() to enforce proc_dobool() expectations.
> 4. Fixing the proc_dobool() docstring (it was just copy-pasted from
>    proc_douintvec, apparently...).
> 5. Converting all existing proc_dobool() users to set .maxsize to
>    sizeof(bool) instead of sizeof(int).
>
> Fixes: 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled")
> Fixes: a2071573d634 ("sysctl: introduce new proc handler proc_dobool")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  fs/lockd/svc.c        |  2 +-
>  fs/proc/proc_sysctl.c |  6 ++++++
>  kernel/sysctl.c       | 43 ++++++++++++++++++++++++-------------------
>  mm/hugetlb_vmemmap.c  |  2 +-
>  4 files changed, 32 insertions(+), 21 deletions(-)

Gentle ping... Without this patch the new "dev.tty.legacy_tiocsti"
sysctl is unusable. This is blocking me from making selinux-testsuite
work with CONFIG_LEGACY_TIOCSTI=n:
https://lore.kernel.org/selinux/CAHC9VhQwrjwdW27+ktcT_9q-N7AmuUK8GYgoYbPXGVAcjwA4nQ@mail.gmail.com/T/

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

