Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9219952B128
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 06:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiEREKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 00:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiEREKW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 00:10:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CC7915F6E7
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 21:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652847018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+NOVFFIZd9DRh/qXC8inU5DUoXa1hR/cvg4Nz0WouAs=;
        b=ia4GEoSPiw6yJNsSn90En3I02Nsf45KCoQ7TvYyRkVjXDljV1t21v1aXiYBD/w/eemF5bc
        6QikwzCZ81oNEgIDkU1xe+wknhixFy9AFn3HW+mvxtmXTwNS+EfbqvOMWPGOU/AK4VJUfy
        5DmFy1GzzoloKF50tMbdHDHfE4bF3TY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-ceOjQ2HOMCe2YKkStUOF2Q-1; Wed, 18 May 2022 00:10:14 -0400
X-MC-Unique: ceOjQ2HOMCe2YKkStUOF2Q-1
Received: by mail-lf1-f70.google.com with SMTP id 21-20020ac24d55000000b00473e75f3331so485454lfp.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 21:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NOVFFIZd9DRh/qXC8inU5DUoXa1hR/cvg4Nz0WouAs=;
        b=lFkQ6zp/+g/7tfED3TGQqAiKe/JNRN/DtiorFfATd5742desrKHwatuKoptJ8EuMYF
         hNYDCjL2KFOi3Hjv1bcvtIsNQK2O4sJbQ3IZRoUAAILLF8L5jp6roceD+MVUkXwLbqFu
         9MhsiHhlL+8B8tuFr0zIxG3C5fIFUgc50gY1YB7V+BRXGvT6UhLn2C8MoqAq7N3vuELz
         h2CX1m/Jlfp1cDAHyGXxuCgSlnaC28BxqREmco+/z1fns/s1wr5JH6yQzTCoxxEvuFg4
         zBLt6rMlKE7EGbKy5mnAGKiOvciN76hk+cAXtwS04yBHnxlLcO9+C/z44PlFFFAOSyro
         CrBQ==
X-Gm-Message-State: AOAM532/lu1lMSARgyA6KbadskIOzxkPVF1j2kk7R8UKABQEOPWxzj8C
        dtkcrDWF3nBGa+5ca2gyyjBz/jMpvnn5BdM8riTuqf7evGZ/wbzh2+amzEBTnHG9VabEFfdXaiZ
        ccwxLGmhGaZ1jkIv07EeBl2QNRy39XfFIusjDMIcpPQ==
X-Received: by 2002:a05:6512:3e0a:b0:477:b256:56b with SMTP id i10-20020a0565123e0a00b00477b256056bmr2426680lfv.587.1652847012630;
        Tue, 17 May 2022 21:10:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo7LnwP2KhWd3cqQbJhDB1nD2XDUYc/xI2VSj4Lg3fzncr5rIBmRwqIBBPDJGhkob+9Xm5o+qCmV9M+3IXOIU=
X-Received: by 2002:a05:6512:3e0a:b0:477:b256:56b with SMTP id
 i10-20020a0565123e0a00b00477b256056bmr2426663lfv.587.1652847012356; Tue, 17
 May 2022 21:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220516084213.26854-1-jasowang@redhat.com> <20220516044400-mutt-send-email-mst@kernel.org>
 <YoQa4wzy9jSwDY7E@zeniv-ca.linux.org.uk>
In-Reply-To: <YoQa4wzy9jSwDY7E@zeniv-ca.linux.org.uk>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 18 May 2022 12:10:01 +0800
Message-ID: <CACGkMEvu8eVQ5Sy0675xjhukyPRoCKnTF+t0tpXw6dsexe3v1A@mail.gmail.com>
Subject: Re: [PATCH] vhost_net: fix double fget()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, kvm <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        davem <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 6:00 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, May 16, 2022 at 04:44:19AM -0400, Michael S. Tsirkin wrote:
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > and this is stable material I guess.
>
> It is, except that commit message ought to be cleaned up.  Something
> along the lines of
>
> ----
> Fix double fget() in vhost_net_set_backend()
>
> Descriptor table is a shared resource; two fget() on the same descriptor
> may return different struct file references.  get_tap_ptr_ring() is
> called after we'd found (and pinned) the socket we'll be using and it
> tries to find the private tun/tap data structures associated with it.
> Redoing the lookup by the same file descriptor we'd used to get the
> socket is racy - we need to same struct file.
>
> Thanks to Jason for spotting a braino in the original variant of patch -
> I'd missed the use of fd == -1 for disabling backend, and in that case
> we can end up with sock == NULL and sock != oldsock.
> ----
>
> Does the above sound sane for commit message?

Yes.

> And which tree would you
> prefer it to go through?  I can take it in vfs.git#fixes, or you could
> take it into your tree...
>

Consider Michael gave an ack, it would be fine if you want to take via
your tree.

Thanks

