Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6656C3986
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 19:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCUStN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 14:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjCUStM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:49:12 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C619567AF
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 11:48:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y4so63646088edo.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 11:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679424516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0ckUw7dWkverm2igg++8Ynt0yEw3mz/3PbETIyN2lM=;
        b=QrW8QLlhXRLLsjP3F+4fhjZ2IV7VEOnnPtdH2kcuNjaRfDJSfySxSopa0Z7evi2/vh
         KzYZQ0l0gdztGMIZz+L+NfeD8ytvURoY+K8KAMU6h0FCLYrEP/O7bEinnhzm8wsuJV9V
         9+n5ef7AaK2xYbe1rb2jSLzCj4TgJ/mN5USyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0ckUw7dWkverm2igg++8Ynt0yEw3mz/3PbETIyN2lM=;
        b=O4JXko4EiXvjlTJvu7JksrJpEpyqRYrpn8OyFPsv9TzI0zftoGQlwF5xi7k0cNRRso
         bJhXaHO9q5+npXQWQ/s289Pgp6mr+SJ+XNoI+RcMe7wMhPBc8ReQZiDklH9Ph03ojn8O
         8Dx64Ru69ymCqaqaSSlUMfzw9vp9odSjrN2BuYIkSUEWF+ny459qGchbH4I3LRr9OXMK
         bE/9mtlNXO/QTXi8TOQKA3PJfto7YTDbrnIDS/YlYFA1lcYMzyyXeXlV65/a6HLT+b5e
         LD9L0yG4RQtTcasyu/RcGmCPKFHknIPTNXRJhZ1N8oPhrLAq/Rxl7YYNfRprh4WYIgRQ
         tOuQ==
X-Gm-Message-State: AO0yUKWGN+zzb4KpZKambRRXys1ArzcBuodOXsn3q+T7wG+hex9V1dkE
        q0Glyg2OqGQTUV+UiXVSbvEbmBQbXDrjZA+qcxYNQu0B
X-Google-Smtp-Source: AK7set/FIbLvlhCVlhZR3JXsbabVGjy2YqkDLPAd/ZHJJnAt3jQ7S2eV0wUvIWeH9drwTapzlYgp6Q==
X-Received: by 2002:a05:6402:7c8:b0:4af:69b8:52af with SMTP id u8-20020a05640207c800b004af69b852afmr4124528edy.24.1679424516210;
        Tue, 21 Mar 2023 11:48:36 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id k12-20020a50ce4c000000b004af70c546dasm6684663edj.87.2023.03.21.11.48.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 11:48:35 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id o12so63551002edb.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 11:48:34 -0700 (PDT)
X-Received: by 2002:a17:907:9b03:b0:932:da0d:9375 with SMTP id
 kn3-20020a1709079b0300b00932da0d9375mr2409395ejc.4.1679424514115; Tue, 21 Mar
 2023 11:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <2851036.1679417029@warthog.procyon.org.uk>
In-Reply-To: <2851036.1679417029@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Mar 2023 11:48:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1b0r+5SnwWedx=J4aZhRif1HLN_moxEG9Jzy23S6QUA@mail.gmail.com>
Message-ID: <CAHk-=wh1b0r+5SnwWedx=J4aZhRif1HLN_moxEG9Jzy23S6QUA@mail.gmail.com>
Subject: Re: [GIT PULL] keys: Miscellaneous fixes/changes
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Bharath SM <bharathsm@microsoft.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Steve French <smfrench@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        keyrings@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 9:43=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
>  (1) Fix request_key() so that it doesn't cache a looked up key on the
>      current thread if that thread is a kernel thread.  The cache is
>      cleared during notify_resume - but that doesn't happen in kernel
>      threads.  This is causing cifs DNS keys to be un-invalidateable.

I've pulled this, but I'd like people to look a bit more at this.

The issue with TIF_NOTIFY_RESUME is that it is only done on return to
user space.

And these days, PF_KTHREAD isn't the only case that never returns to
user space. PF_IO_WORKER has the exact same behaviour.

Now, to counteract this, as of this merge window (and marked for
stable) IO threads do a fake "return to user mode" handling in
io_run_task_work(), and so I think we're all good, but I'd like people
to at least think about this.

              Linus
