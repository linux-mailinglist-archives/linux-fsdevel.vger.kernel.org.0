Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E83F35B1D3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Apr 2021 07:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhDKFgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Apr 2021 01:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhDKFgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Apr 2021 01:36:46 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6965AC06138C
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Apr 2021 22:36:30 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x4so11172758edd.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Apr 2021 22:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0lwDd82fgpJThgZMHhLJnQgV6W4vkNqis2PraEjVIBw=;
        b=c4Db3epPQ7BtwNnPr8IaEN1uoC8TT4Cseg9TW2LOXl0mLgoowQzuMu0HEjnfJhWU6l
         xzrGM8hjOF8f1AvXob4ziQXk/mFjMtQD4xc7CI3foTZ4jSrKSitPBEtZsx+YmJQKz4CL
         2rxWFLJRkkr9xhYHKoO4FyXyLmIyEuT02doObAUnu5ZdTsK4/1fJ6fOIBnRyM4XwdAaO
         rwNDIsTqSR3SbA4yx+T/jvt8ShIArPdnAFni2G29Ac44P6VGKd0xcSl8weOqDXSEKsKn
         Jb+YUau5RFx4C7t8XsuqOke36WQB/kNHw24Ej3LTxaI+V9cPhxvKZv988v7Mr4mS8Nse
         hw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0lwDd82fgpJThgZMHhLJnQgV6W4vkNqis2PraEjVIBw=;
        b=lRrSKIvsdkEZsUeMtKO2Bwen/iw30DCPUz8eIhyrOal1Frbq9N+2XF3gOJS6KqmTsE
         ZItaiDDWbMIUpkh98P5WN/9Ya/3tCzGMNvz4NUNzhPkFRuAUhwBqBddfBfTy3okHDMeF
         A0r0KEUrpxVx5F0cFOdxNB3nUnn+jRX4kujZUP6dUeVNY19gPpY4laVO5oyg0ge53vsh
         a65YADqsdmq6CGDHICzLMdlK7FG9Lixy8+7uJaTbKzS4xp077Z8jhmsTVx8ZrgvTeDJ2
         Nc2XOgS1fVvKif3uxccTlrxZT7UjVDIKKM9CPjGXE/hUNebfyHD8dZpSMjI/7p7IoNDF
         1Dtw==
X-Gm-Message-State: AOAM530Kij37OJ5FhreIteysKXMGwO3Rf24/B2c8pjqEGOpqXYsNiYRI
        asPlHoBMaWcVYPTTG8FW6P5J+/5prpYQuHeQQGeL
X-Google-Smtp-Source: ABdhPJz0uxSIdyrEwimFA/W6SiCsgNrH3yatdgdl47Lv/XrisxjYBLMuDcXpWpcG+4MirvvkrrYIKqyH/L4ndSeY1QQ=
X-Received: by 2002:a05:6402:6ca:: with SMTP id n10mr24284861edy.312.1618119389097;
 Sat, 10 Apr 2021 22:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210331080519.172-1-xieyongji@bytedance.com> <20210331080519.172-4-xieyongji@bytedance.com>
 <20210409121512-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210409121512-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Sun, 11 Apr 2021 13:36:18 +0800
Message-ID: <CACycT3tPWwpGBNEqiL4NPrwGZhmUtAVHUZMOdbSHzjhN-ytg_A@mail.gmail.com>
Subject: Re: Re: [PATCH v6 03/10] vhost-vdpa: protect concurrent access to
 vhost device iotlb
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 10, 2021 at 12:16 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Mar 31, 2021 at 04:05:12PM +0800, Xie Yongji wrote:
> > Use vhost_dev->mutex to protect vhost device iotlb from
> > concurrent access.
> >
> > Fixes: 4c8cf318("vhost: introduce vDPA-based backend")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
> I could not figure out whether there's a bug there now.
> If yes when is the concurrent access triggered?
>

When userspace sends the VHOST_IOTLB_MSG_V2 message concurrently?

vhost_vdpa_chr_write_iter -> vhost_chr_write_iter ->
vhost_vdpa_process_iotlb_msg()

Thanks,
Yongji
