Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014606D9352
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 11:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbjDFJwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 05:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbjDFJte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:49:34 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA338A273
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Apr 2023 02:47:55 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id n125so45468974ybg.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Apr 2023 02:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680774414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FazgrPFY3djyzZPHPYX9nbN/ODMQXNog1/KIwCKeFDY=;
        b=X7uAqrbGclHVXqbYHSh/EAecrBEubuaY39NatmOxJE0XIXqV8zUrvnNRbRfyxqZkbc
         XoA5P3emiPKJCmTlP8dTV7Z7PY/gLsd/EA3OPXruLvTILNv4BQvr7691dHmjCJoCu/dv
         kSRJzazXWogjQWoS6uAM9rQR0SRZevXHSTgZ1puYjHxUEYABV/qTIeaV4IoGBLHRBG7z
         7vkXzUZTZ4IM1ED3JJwGLf2MYawCXHKQPp+q1lhO2vhETvQE8NZGWsn24RSx8ZXnImfR
         UcpU6yox1sEmDInIwFUPnzBR2K9m7QrY5R2HDAjL51azojaPsgDh33MezwbrMapIA5Yz
         d2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680774414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FazgrPFY3djyzZPHPYX9nbN/ODMQXNog1/KIwCKeFDY=;
        b=a2Yc3A7lOXesFqVfGA/GSig3VH33oxZmwUOX9sstweP1J7BN5B9JVT7WaQUWiXLRbN
         CVqdZZVRmQQiYFKHKrJD0RYWx+xwsZHLsRjEWcJHDGmlTD9S26Sml0hqPqDuFmkvBeSs
         Q/skajyyItIbBFRVTeiLupgSnJlNpdu589bxwdttt8B7Ou12o6bflmV9Zb8noV0a9WkR
         1w0m4ZKekIz3PMt/AYH5ZN2rdEEX1fb96k2jbYf1XnCctKE+izslaGsxmciC0XOVfh3v
         Ju4OhK0A0khk0oS7NRIgekpxiGMdAkmCDt3EGQ4RvQHI1w5JxLuFSJV2Yf1R8KnSZVJs
         O7jg==
X-Gm-Message-State: AAQBX9eR5qHpAyGcnCxfn+U83QwH/kPOOozVOc0tFsKCVNziiRmjTFrc
        zkh08Qypy2CexbLvC/2ZVhRQinNmKhqZmE06PXvNMQ==
X-Google-Smtp-Source: AKy350bq1WlXWlO1l5s2v33lxsNrk8T8LtvMzV0VPBJGlSoPDOhtqDrZ3Ce6iIYQONUD9yoeD0168koK8RkL0a8PXBY=
X-Received: by 2002:a25:da46:0:b0:b09:6f3d:ea1f with SMTP id
 n67-20020a25da46000000b00b096f3dea1fmr1704437ybf.4.1680774414032; Thu, 06 Apr
 2023 02:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230406094245.3633290-1-dhowells@redhat.com>
In-Reply-To: <20230406094245.3633290-1-dhowells@redhat.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 6 Apr 2023 11:46:42 +0200
Message-ID: <CANn89iLFc3gxo-5gEn36VFYdocXQPiAqRsTPEHcB8JA3mw8+8g@mail.gmail.com>
Subject: Re: [PATCH net-next v5 00/19] splice, net: Replace sendpage with
 sendmsg(MSG_SPLICE_PAGES), part 1
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 6, 2023 at 11:42=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Here's the first tranche of patches towards providing a MSG_SPLICE_PAGES
> internal sendmsg flag that is intended to replace the ->sendpage() op wit=
h
> calls to sendmsg().  MSG_SPLICE is a hint that tells the protocol that it
> should splice the pages supplied if it can and copy them if not.
>

I find this patch series quite big/risky for 6.4

Can you spell out why we need "unspliceable pages support" ?
This seems to add quite a lot of code in fast paths.
Thanks.
