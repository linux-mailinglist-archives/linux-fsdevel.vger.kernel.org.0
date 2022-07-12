Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E2A572628
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 21:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiGLTni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 15:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiGLTnV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:43:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B5141981
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 12:24:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eq6so11385308edb.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 12:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AwQu+Slmk6b7rMdvbS+ht7NAZopFtAx7f9gViPKpYXY=;
        b=KbYcWvsMVgtmW/QqgCna+xxCJLYZETtGhYWx/Uam+qYte8ax+KAHnsuDF4E78rsPvV
         +oIqoCu6QGz1ArWD9Bnc5O0j+QaOYUCAtiNPaBwHRIIfaRFfzLw4RQDNYlmhAat3WQaS
         f/zUe3XrDVR50MpCia0uj2xsClrJ79iLRk7bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AwQu+Slmk6b7rMdvbS+ht7NAZopFtAx7f9gViPKpYXY=;
        b=UT5M7Lhb9BVMOvgjZzRU2iJhMiTpV+zvvojiezRZsooFh088ZVq0f4JWL9gbaUaFTx
         FZl3NHXWE9wRwYfm7zyD9drzS+bXJfeZyixCszfjZxbQs3FuNv/SV/+ZaVjveiTLbMA8
         TOYIUWImeDrIP/QKsBRBlaLhY+eDDfqY7jaNrMap0QxjOOLI4PgTNwV5QqOc6su0Reqq
         QS9Dt7wRCyqGG79YuPPdTejo0cKQdCl8lJcPMJMlsrUPMfUU9sAqpgurC4RyM53hc1L+
         BcKbyDWXuwVJ3yLOrzoghGe8N277T4rKO5n63Zkk4As2bUmwzrFD8n5DPuXfK9Oh6iYf
         Bnmg==
X-Gm-Message-State: AJIora/3ZGkbDPVOX9OEnKWGzLh6LlyMRag7TYWX36h9nSYuvFCdeTWX
        OAVhdE/vjg1KNXLMKpxprXyGVaoLHloXDvkrruI=
X-Google-Smtp-Source: AGRyM1ujOTNEzjRWRemtDAPo9zScJgtN/x/ik5ftARlL8Vi6YZTDNNIda8k0+FLwMPJsoOJ/bvW6aA==
X-Received: by 2002:a05:6402:3311:b0:43a:8714:d486 with SMTP id e17-20020a056402331100b0043a8714d486mr33828212eda.136.1657653853120;
        Tue, 12 Jul 2022 12:24:13 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id n7-20020a056402514700b0042bdb6a3602sm6400880edd.69.2022.07.12.12.24.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 12:24:12 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so7339492wme.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 12:24:12 -0700 (PDT)
X-Received: by 2002:a05:600c:34c9:b0:3a0:5072:9abe with SMTP id
 d9-20020a05600c34c900b003a050729abemr5529353wmq.8.1657653851871; Tue, 12 Jul
 2022 12:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
 <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com> <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
In-Reply-To: <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Tue, 12 Jul 2022 12:23:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdHoq0WEcUy61GpX7hWRcvdmQzXy5p0WCTyZKWxsUHJw@mail.gmail.com>
Message-ID: <CAHk-=wjdHoq0WEcUy61GpX7hWRcvdmQzXy5p0WCTyZKWxsUHJw@mail.gmail.com>
Subject: Re: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly files
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     ansgar.loesser@kom.tu-darmstadt.de,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=C3=B6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:07 PM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> Anything else is a bug. If you open a file, and then change the
> permissions of the file (or the ownership, or whatever) afterwards,
> the open file descriptor is still supposed to be readable or writable.

.. it works the other way too. If you have higher capabilities and
open a file, and then drop the capabilities after the open, the file
descriptor is still supposed to be available.

Again, doing some new permission check at IO time is wrong.

Of course, the sad part is that we have done that wrong thing many
times. Several /proc files have had fairly lax open-time permission
checks, and then they do stricter checks at IO time, and it's been a
serious security issue many many times.

Similarly, the traditionally horribly broken BSD model of "do SCSI
ioctl's using read/write calls" was a complete disaster in this area,
exactly because the permission checks were then done based on the IO
details (ie whatever command was written). And then that was
fundamental to the whole interface, because some commands require more
permissions than others, so  you can't do the permission checks early.

This is largely why we then have that "file->f_cred" thing, so that
you can at least do things like "use the open-time credentials for
checking at IO time". Or just say "if open-time credentials are
different from IO time credentials, just abort".

That solves the SUID issue when the actor permissions ("credentials")
change, but it doesn't solve things like "somebody actually changed
the target file permissions themselves" issue. So those really have to
be tested at open time, and IO should not do "inode_permission()"
checks, because it's just fundamentally too late by then.

Of course, on eg stateless network filesystems, the IO-time permission
checks may be the only ones that the server side *can* do, and then
you end up with non-POSIX behavior and potential breakage.

The world is a messy place.

              Linus
