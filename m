Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2AD542B54
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 11:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiFHJTr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 05:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbiFHJTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:19:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0201B23CA06
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 01:41:49 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kq6so26978617ejb.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jun 2022 01:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykimdDrNeWLYtmXklJ+9QqbVI5mT7ofTT2jbl/fL9GI=;
        b=Q+7PDVmJtYOyRc5GY8evlrrarzenLaRgTXzu/an/jXCiEaiY7Pw3ARgjXk9IyKjP9B
         zxEjGKYwNRzknViUPCAYzXJ10nJf2KFaRcJgqgBeELAQByHTbW2pcmRpcsDnCnKxnVpV
         AtAv2yUJi0yKnpzJqa9J875/SvCutI1Ad7J38CPy/sIUBfjJPyMXvsS+AWP/Yx9Iycdl
         1aj8yvCRO0vLylduVA/0/OQo46p1+/g62z6oFQOCkR3MAf2EHaSIn7U2wqohf6rLs8sP
         FX4Ini1eTw9EDiE+rKGjee9szevaBBJN8676LBd2Wj7VRxIlZitaJ3MpjJiQazoeHEo+
         oBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykimdDrNeWLYtmXklJ+9QqbVI5mT7ofTT2jbl/fL9GI=;
        b=39fiqOPiYwTgbdsCAj3RVhrPsHCLnw4ERAW6whQQscPw2Wt5pgiSwP8426F9OLQ5uS
         rhW7ID7y+34ErGpaRxcyQPrXFOzivfF12/BuHCr66oV+Gf9P3ypfxinzIWcuBNfiPUAF
         lKMVX0CkhCOetL4crU3/JwSKup1lpxLk0090l1lnOrAJGM+uIeaz6HWFZyOwK+KefkMq
         RBuvkqbvQ0BkmTZkYga1boHt+qq9Hf2gs5FBf5CFY1GE0LBp2dk6xRdcXEhNpyt4Whny
         4OEOVCVlUBbuLjVuHpOf90wjsmof/4d2RIOAz0CJOATdSPvq03NnNfj5/F29SBH/N6Dp
         ZZdw==
X-Gm-Message-State: AOAM531R8JuxtdAVQ9L5nqSk3h9NkbEVK2S9NBkJfowxjf7wxhRyDzyZ
        q+APmIqNX3aG4YvpqyCUmbuZx3H5lZDx9IOev0Yb3HwmuQ==
X-Google-Smtp-Source: ABdhPJyHJOLNmvakq2kYu52zRuJPR9cO+TD7DpupMq9lxFkW9QrLdul84/XlkjZq/U220+AGYnHL9m9sAsrW2uKYmRQ=
X-Received: by 2002:a17:906:84b:b0:70c:d506:7817 with SMTP id
 f11-20020a170906084b00b0070cd5067817mr27213028ejd.206.1654677708425; Wed, 08
 Jun 2022 01:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220607110504.198-1-xieyongji@bytedance.com> <Yp+oEPGnisNx+Nzo@redhat.com>
In-Reply-To: <Yp+oEPGnisNx+Nzo@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 8 Jun 2022 16:42:46 +0800
Message-ID: <CACycT3vKZJ4YhPgGq1VFeh3Tqnr-vK3X+rPz0rObH=MraxrhYA@mail.gmail.com>
Subject: Re: [PATCH] fuse: allow skipping abort interface for virtiofs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        =?UTF-8?B?5byg5L2z6L6w?= <zhangjiachen.jaycee@bytedance.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 8, 2022 at 3:34 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Jun 07, 2022 at 07:05:04PM +0800, Xie Yongji wrote:
> > The commit 15c8e72e88e0 ("fuse: allow skipping control
> > interface and forced unmount") tries to remove the control
> > interface for virtio-fs since it does not support aborting
> > requests which are being processed. But it doesn't work now.
>
> Aha.., so "no_control" basically has no effect? I was looking at
> the code and did not find anybody using "no_control" and I was
> wondering who is making use of "no_control" variable.
>
> I mounted virtiofs and noticed a directory named "40" showed up
> under /sys/fs/fuse/connections/. That must be belonging to
> virtiofs instance, I am assuming.
>

I think so.

> BTW, if there are multiple fuse connections, how will one figure
> out which directory belongs to which instance. Because without knowing
> that, one will be shooting in dark while trying to read/write any
> of the control files.
>

We can use "stat $mountpoint" to get the device minor ID which is the
name of the corresponding control directory.

> So I think a separate patch should be sent which just gets rid of
> "no_control" saying nobody uses. it.
>

OK.

> >
> > This commit fixes the bug, but only remove the abort interface
> > instead since other interfaces should be useful.
>
> Hmm.., so writing to "abort" file is bad as it ultimately does.
>
> fc->connected = 0;
>

Another problem is that it might trigger UAF since
virtio_fs_request_complete() doesn't know the requests are aborted.

> So getting rid of this file till we support aborting the pending
> requests properly, makes sense.
>
> I think this probably should be a separate patch which explains
> why adding "no_abort_control" is a good idea.
>

OK.

Thanks,
Yongji
