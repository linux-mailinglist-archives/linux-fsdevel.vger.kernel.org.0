Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C1929EFB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 16:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgJ2P0F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 11:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgJ2P0A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:26:00 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F383C0613D6
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 08:25:59 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id d125so778630vkh.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TKA8BKb8i1utD9tGg1rDX3comc5+Hr03WuwdtvMqQLA=;
        b=Kp/b/eAolt5iKyiqV0LryXlku0eukwKvS7YYnx0Vu5M0emCJ0KYgTEIo704jzP4yyt
         OdLEOBhAqDfj091ssnVd8CGhjHebyVzGGApz5dLvDrsAooZmE/+AZKpFslKMMpUMMWac
         rsUGUV69EQoGuBDnMQVQktMf5j5std+OnmQ+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKA8BKb8i1utD9tGg1rDX3comc5+Hr03WuwdtvMqQLA=;
        b=PikTJ8A5YqoyeQ6qFihAjDuxJ0a6U7TgZSM2CPqJ7ysESq15I+U09/UkQ6bK58w+7+
         0CxrQV6xd1dKy/EHdaRNNRpcuWKlORkfPqp4yb6nELJWhwkWK4bkwSX1kqByrnD3wnNT
         yiNMdJcEUnm1fFb15oS7F0Zewq/E1xC74+YFet3u2RcdNDggjtIkinwR+y+T9lKSAdwx
         o+Li2nxWNMSTMYoAvDQAtyIWw0ywj/WY+GL0UJK+s2xjjjibBysYFbfMmq7FpxhKtjfq
         qxzh/bWih/Zz3mdhMDv+M4qGOmNiLkqnCqpwGO+zhFxdfssWjNcTMheQvXchL0cgA7VP
         bhQw==
X-Gm-Message-State: AOAM533Q00zWrCS3isl5TytbiMq9ZGNva3BWFsmIc9uP8jPtbJZEJqkh
        8H8fEbHu+uNjNn1INd53Z4BtlIW9LUmwdUZE5ZycTQ==
X-Google-Smtp-Source: ABdhPJyTqDIYeWl5UkkdMDkJjpCaNs+GL2C8l11+oxl+W7oJCToCDgBfPA9iGP0UmOptGW9XZi2xsMw0u5z9inQT/xM=
X-Received: by 2002:a1f:23d0:: with SMTP id j199mr3615428vkj.11.1603985158633;
 Thu, 29 Oct 2020 08:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <5e1bf70a-0c6b-89b6-dc9f-474ccfcfe597@huawei.com>
In-Reply-To: <5e1bf70a-0c6b-89b6-dc9f-474ccfcfe597@huawei.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 29 Oct 2020 16:25:47 +0100
Message-ID: <CAJfpegtcU_=hhmq9C-n1dkCBOcTX7VzkdXDpOZZNh1iZ73-t0w@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix potential accessing NULL pointer problem in fuse_send_init()
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linfeilong <linfeilong@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lihaotian <lihaotian9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 22, 2020 at 4:52 PM Zhiqiang Liu <liuzhiqiang26@huawei.com> wrote:
>
>
> In fuse_send_init func, ia is allocated by calling kzalloc func, and
> we donot check whether ia is NULL before using it. Thus, if allocating
> ia fails, accessing NULL pointer problem will occur.

Note the __GFP_NOFAIL flag for kzalloc(), which ensures that it will not fail.

Thanks,
Miklos
