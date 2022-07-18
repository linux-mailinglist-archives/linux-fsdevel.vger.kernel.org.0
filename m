Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE55E577E93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 11:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiGRJ0b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 05:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbiGRJ0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:26:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B2919C05
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 02:26:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b11so20065807eju.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 02:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=daCNX+ljjP6NnNv/228uTB2KSRG91iINfTQ/P3emSkI=;
        b=BUIEcJ1++GzEP9Jo3mLt2IRj4NuL0Wadbommuxw0oxl+l8q0LWeCzdZuqWKK1+Wkup
         Lxhx+1GLOoJMXNwuzvwpf2Zyhz3vHUaemuel8ScrW+3a/MTR4t4TY96ROfP/Xyz6I9zN
         0X4OI40L62ymTJ4grVS/AmCcWanf/HV2y+jL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=daCNX+ljjP6NnNv/228uTB2KSRG91iINfTQ/P3emSkI=;
        b=btPtt1dfB1Nnyt7IExBnhxZE/YcQ7WUI3jwJFZ40IWCWtV57bdy3TrYdlcv8edCWBc
         DZXXGe4sbv8P0ae1I0GojrANOgVGgBgorQMXNYjjFyHRTMYtew5uo1ehbJQ7q9VdFhAL
         PFKtrUr5sjOWCoyqZQc4FE7DGSkEUqOHIejN6Gy9BnDU+k73ZKppOS+YuqKjGiKjKpWh
         18+DsF9gYgx1IGhSQXMhBt34D0Wi4snxvWUJiTSe17cHyKKCLkVJtFritnxHEEgDRyUD
         pZEM7DsYzQjoCXl3db1a2EauYho59OH3gVUSLlnAVdpXUdndLuCkRhYrVcBIr32I774B
         OlCQ==
X-Gm-Message-State: AJIora+uVnbwTxlw6o4FIOXYnX+JfQP9dr5tRKHVwY2nkLiFyiGiwuuw
        VQzhiBTPOnwODj6kEP853g5kISV0dVL4EHFx9PCxQQ==
X-Google-Smtp-Source: AGRyM1td3I31s5LxUAI9oFOYzcf5In2vEusZf2WWzG4wKdxIDVLteMl43t2ceUxL4IAhNU4UxKes2fSyKLRwJxEJCpg=
X-Received: by 2002:a17:907:270b:b0:72b:1418:f3dc with SMTP id
 w11-20020a170907270b00b0072b1418f3dcmr24700105ejk.748.1658136388274; Mon, 18
 Jul 2022 02:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220718085012.155-1-xieyongji@bytedance.com>
In-Reply-To: <20220718085012.155-1-xieyongji@bytedance.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Jul 2022 11:26:17 +0200
Message-ID: <CAJfpegtqL7fn+k6NcOP1tRLgjWB=_aaEAm2cdGTm9p8dMq1OLA@mail.gmail.com>
Subject: Re: [PATCH] fuse: Remove the control interface for virtio-fs
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        =?UTF-8?B?5byg5L2z6L6w?= <zhangjiachen.jaycee@bytedance.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 18 Jul 2022 at 10:51, Xie Yongji <xieyongji@bytedance.com> wrote:
>
> The commit 15c8e72e88e0 ("fuse: allow skipping control
> interface and forced unmount") tries to remove the control
> interface for virtio-fs since it does not support aborting
> requests which are being processed. But it doesn't work now.
>
> This patch fixes it by skipping creating the control interface
> if fuse_conn->no_control is set.
>
> Fixes: 15c8e72e88e0 ("fuse: allow skipping control interface and forced unmount")
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Thanks, applied.

Miklos
