Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005A272B388
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 21:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjFKTMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 15:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFKTMQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 15:12:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E616E50
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jun 2023 12:12:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so9466950a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jun 2023 12:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686510734; x=1689102734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=METRwazHca7MV7IOYYjapwpHKqdNnyKS+AA8r4yB2C4=;
        b=e6It/fBrUDYRdXXHufp7sklr7AMAdw5+JbDqfxu/M00mMqIdQh5niw3Vn6zLMCvkSi
         UP9klVtCTw0bEs9XXRWEkU1CX+zEBOqsa3A/BRSBf96H8IsdqOREIgFYgznIGZQSIt5V
         CYPQEtCzRu3fZ6eAWSA4rmvopPfQrVK5p0Suw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686510734; x=1689102734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=METRwazHca7MV7IOYYjapwpHKqdNnyKS+AA8r4yB2C4=;
        b=GEsUTLY+MH73R6ytPtvXDcq/oNMq2RcblBNsMmQc6rXtvslVHRkLvKvl/kHAFjKDTB
         LDqz2KFEGyIs8tGAVdxh6Hn5vMI8IdT8EhMvXxuBIaBnpF+VKr+z68y8sO4lLm93qgsu
         rMJGnrHZOCarwNoclqHvMf+mB3myRUDj68LHH+FejplZmilGqnw5rrSAjJaK42t8rkYB
         CbNc6flGeSk88IRFCfY1su7uJSe0PQxPVOfkG2mvZTdC63Jny4YjykEFqgL63KVMm+aP
         Y9ls2FboSV94gQr+TUAPzQL/aNsoN3vuGAzV5DJU1Y7KDdC9gC3UhL5f//v8Wo4/QZMa
         BOAw==
X-Gm-Message-State: AC+VfDxbTF5KfQm6HASi1+oqSD6hWw9XVHYUWlQfqR4SWBrXMLuAJmge
        G8NHputuio13WlSFc95tloQ6i2/ew7oewRvhKc3hKw==
X-Google-Smtp-Source: ACHHUZ7RBn/CljbLW3VPdao9L+E7Nxrqg62JEk8gE9vjUE4CPLlWuG+v9V2iO0GEOG2mxYNBVIJNg+jdkxfqovitQfk=
X-Received: by 2002:a17:907:2da1:b0:973:84b0:b077 with SMTP id
 gt33-20020a1709072da100b0097384b0b077mr8095251ejc.33.1686510734088; Sun, 11
 Jun 2023 12:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230611132732.1502040-1-amir73il@gmail.com> <CAJfpegugmTqJ5rWycxxeQpVBmGTxSHucnQjP7ZwT3K3jMXNcnA@mail.gmail.com>
 <CAOQ4uxgA9=-gTngiiFjBc5E1M==qP4T0aeiD5608nJxhQuqp+Q@mail.gmail.com> <CAOQ4uxiDL+u3SS-=HsNaHwPLz2CAV=8oDCED5RtzPhmFwQmkZw@mail.gmail.com>
In-Reply-To: <CAOQ4uxiDL+u3SS-=HsNaHwPLz2CAV=8oDCED5RtzPhmFwQmkZw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Sun, 11 Jun 2023 21:12:02 +0200
Message-ID: <CAJfpegu2CAvrqGfACuc+ux4430wwDrSeuXPEeUy0FE=fDrW6FA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Handle notifications on overlayfs fake path files
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
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

On Sun, 11 Jun 2023 at 19:52, Amir Goldstein <amir73il@gmail.com> wrote:

> Is it because getting f_real_path() and file_dentry() via d_real()
> is more expensive?
> and caching this information in file_fake container would be
> more efficient?
>
> I will restore the file_fake container and post v3.

I simply dislike the fact that ->d_real() is getting more complex.
I'd prefer d_real to die, which is unfortunately not so easy, as
you've explained.

But if we can make it somewhat less complex (remove the inode
parameter) instead of more complex (add a vfsmount * parameter) then
that's already a big win in my eyes.

Thanks,
Miklos
