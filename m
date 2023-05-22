Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7560470C234
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 17:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjEVPUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 11:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjEVPUe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 11:20:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDDDE0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 08:20:33 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96f6e83e12fso527877166b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 08:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1684768832; x=1687360832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sXylGKi1rWwW1V2NNE6iruQyUfcknd1oVKM5gNk8Svw=;
        b=LLdfXJZ0eSPwsPR9PduLg6V8he1mxPGhVtQJr/6BhTR6NXjk6R3OY4ws153KJh6001
         zIZn1v9A1/E9rDZdAMGP7gX56Xoxqv3nZhu/AV6joee7JN/X0zcEIfZnJ4K2niTu1FXY
         t0YI+UeJVzKOU0Jz1W4BDx5oAv/EuDtl2tgOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684768832; x=1687360832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXylGKi1rWwW1V2NNE6iruQyUfcknd1oVKM5gNk8Svw=;
        b=LCwM8iffFV5eZpNI9e8e3N0s+CN0arRAo+//Ffd0EyUBcoOsUJfzytSv3WeiII0l0z
         ZdkkLUEAdK3JjDtTZezlAeMlmk/tIK/pR9sAjPwdGMwLu9nrYkJ09vibXfrLEa/gnRRf
         KYD2opYCdDDlsrBry4KGaHuLhMtRqRhmsMkmiJ1yHmXGd1xIN+K5B3G+RRi8JQKjbDON
         LsJRSMAj8xmtH+OyHLkf8ZzGpJX55g6UYKdv9ULXaw6wZcSm0hBft91muWgBO6+OZMIX
         q1UQGVz8R1EiC+58qF/MTNmWgU0mkq0PXRxyFGNQFV9+tAdaH29sdf0PDebPuK6ZhXXT
         NBPg==
X-Gm-Message-State: AC+VfDz+97LFFYLHm1of1gnZ9uja7+fBnWhtL9hRfTOLKSEZOKI0860i
        dIKBwlwVBStFa22WczoalJf3aGcmAALGeHtHx8y/Lg==
X-Google-Smtp-Source: ACHHUZ4HaqImK9dYbBOqieW1s8qE8xvW1sBDPdxKWVrv7i4hYsrWzEOG0VeDTlcJSiWAWDd82pMSgzwxRVoCSox8tHY=
X-Received: by 2002:a17:907:98d:b0:96f:a86f:9d16 with SMTP id
 bf13-20020a170907098d00b0096fa86f9d16mr5100918ejc.23.1684768831852; Mon, 22
 May 2023 08:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <20230519125705.598234-6-amir73il@gmail.com>
In-Reply-To: <20230519125705.598234-6-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 22 May 2023 17:20:20 +0200
Message-ID: <CAJfpeguhmZbjP3JLqtUy0AdWaHOkAPWeP827BBWwRFEAUgnUcQ@mail.gmail.com>
Subject: Re: [PATCH v13 05/10] fuse: Handle asynchronous read and write in passthrough
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 19 May 2023 at 14:57, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Extend the passthrough feature by handling asynchronous IO both for read
> and write operations.
>
> When an AIO request is received, if the request targets a FUSE file with
> the passthrough functionality enabled, a new identical AIO request is
> created.  The new request targets the backing file and gets assigned
> a special FUSE passthrough AIO completion callback.
>
> When the backing file AIO request is completed, the FUSE
> passthrough AIO completion callback is executed and propagates the
> completion signal to the FUSE AIO request by triggering its completion
> callback as well.

Overlayfs added refcounting to the async req (commit 9a2544037600
("ovl: fix use after free in struct ovl_aio_req")).  Is that not
needed for fuse as well?

Would it make sense to try and merge the two implementations?

Thanks,
Miklos
