Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FD0423E04
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 14:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhJFMsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 08:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhJFMsu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:48:50 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72895C061749
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Oct 2021 05:46:58 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id j13so1719373uaq.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Oct 2021 05:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W5RbKdU0RdNE/VuLnONY3GNvrkAEDf0Jgqqzk1poVuk=;
        b=gTTpjcVz8RI+018/o+5OKjln50wQrwHs0GBpGVGFAktAYafJviz/6TqixLy+6eJDvC
         0DvBvq3LGN07BsrieLoXfX7p8Lv3mCZqzSQPTdw2isDnesJR+DWPj4p+6F2uv5p30btS
         cxdRHxmqARBygmNzVltGZgP2wbgpew9NvACqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W5RbKdU0RdNE/VuLnONY3GNvrkAEDf0Jgqqzk1poVuk=;
        b=PTENh1sVCYlZGpUYErWJHm5t5g8ryq+W0C9SqpDw6dpt51LxdQ4QF1EK60IBMuhCCf
         ZCptnQ0aOhvtTnptxYVp8OWykwrQOeZPdhuFmvIXogw+rWQCZ0DoEmEAk3+nbG6JV1lF
         t5FbIAiFBIlCea9b8fLfAJOuiLAW29gNtrQZ5DckowvgElsYgUnS16UrRWxYSVIQpz3G
         C8KA6Qo+k4SEhjTH5InTz5Q5akzCJaYEr7iYtaNUnXsiNuj7jtDhf3Ya/y31mW0hK3Od
         Wt+fifQHLYYdbdY6XfAaWgqje4kbmB5TURwY8Jm9+1UxkN8kmmUOYxZduKtEYFUauaOz
         Mdrg==
X-Gm-Message-State: AOAM531IPb/tltkF3bgLt+22ZVO2AHMsQ6FCiyDF+QS1Yetct6mihZlT
        Cz7Z6ieOuFbl2PanndHNMC3wcYS0Lx7ggJHnquV9iw==
X-Google-Smtp-Source: ABdhPJwpyyvi4CgYBjN1FAZYU4KZnCBzzYsJozNDOKYK+jMEYaUpW8oNbBWTBzf042oKCf4hvi4unlLgqYGCvaUZGzU=
X-Received: by 2002:ab0:5741:: with SMTP id t1mr17287428uac.72.1633524417211;
 Wed, 06 Oct 2021 05:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210930143850.1188628-1-vgoyal@redhat.com> <20210930143850.1188628-6-vgoyal@redhat.com>
In-Reply-To: <20210930143850.1188628-6-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 6 Oct 2021 14:46:46 +0200
Message-ID: <CAJfpeguTohOfd60+vkVMBOHEfcT4T5hTuWtE2pqCLStNTHuZFQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] virtiofs: Add a virtqueue for notifications
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Ioannis Angelakopoulos <iangelak@redhat.com>, jaggel@bu.edu,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 30 Sept 2021 at 16:39, Vivek Goyal <vgoyal@redhat.com> wrote:

> @@ -34,10 +35,12 @@ static LIST_HEAD(virtio_fs_instances);
>
>  enum {
>         VQ_TYPE_HIPRIO,
> -       VQ_TYPE_REQUEST
> +       VQ_TYPE_REQUEST,
> +       VQ_TYPE_NOTIFY
>  };
>
>  #define VQ_NAME_LEN    24
> +#define VQ_NOTIFY_ELEMS 16     /* Number of notification elements */

Where does this number come from?

Thanks,
Miklos
