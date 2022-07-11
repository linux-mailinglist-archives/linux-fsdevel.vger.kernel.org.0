Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7742856D75C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 10:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiGKIFn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 04:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiGKIFm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:05:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC811CFEE
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 01:05:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id m16so5220439edb.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 01:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qpNftIfufBijXs61t2fbqPPMjRNBNhYq1TOGrCn+qYw=;
        b=GtYrhB91KdGnH4XaAVnXnPLvG0Rii7bCVpBpANpwobyavUlEcUXsh8clGeRobp3QAi
         ae3etISSt+xpBnVJAsWqZE3wLhUMY6toD5rVpi1VHi9PkmHzjE0ROvuc8WWL8gY4mwZB
         6TQjKaE/pxIyf+3qce3xC5eeq1e7zyRZWTQ/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpNftIfufBijXs61t2fbqPPMjRNBNhYq1TOGrCn+qYw=;
        b=Qy1h1UprlktvcLGzgsG1XSU0hwzRfLG2QqNs+TTLAQCdIjb2EGBCiGFQ8tZY79mLg6
         AZ8ly31iAkcmcJOCV6OLsorKYDaCrR3NzTPCt4OviY9eDzQUAVXNLi2EPizYnOPYR3/t
         /FdNB7+CeFxyWxzvl8d7sVbNTdirTvfqCMrDpkJsjF8xJpD0bT1R2Sj/ILhWjgllZBgz
         446zjfm94kjE6T3qCcColc71/Wzl6Zub6oa8gQ1efJWRT5GLewbjn6/JobpIIAU/2sWC
         cl5DyiUnFjL+f2Rz85tBKnSidkwJxmOlXme22Sem4nup++b1C2QYBOCQxcx2IgdksD9T
         dekg==
X-Gm-Message-State: AJIora/Ony8kS5nBySgyFWIup18Ukn/DF6LY6HyJFg25OkYlQ/pbBJBq
        yZxHIh1fLEh/PsNWBXizGnQyEy4btdDbJpXwe9wcvg==
X-Google-Smtp-Source: AGRyM1uha8RTA/ZAChUfUSQEpusiB+IvUzqmb1E+atMn4urVHuxfTszimLLU/JHCHL2uheQ1xEtFRJZv5YTTQdlZWPU=
X-Received: by 2002:a05:6402:3202:b0:43a:86f5:a930 with SMTP id
 g2-20020a056402320200b0043a86f5a930mr22732765eda.389.1657526739373; Mon, 11
 Jul 2022 01:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220615055755.197-1-xieyongji@bytedance.com>
In-Reply-To: <20220615055755.197-1-xieyongji@bytedance.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 11 Jul 2022 10:05:28 +0200
Message-ID: <CAJfpegu8qB+omP+EKAckLqTKJtRwetFn5xRx8LfXqCeq7a=-kQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Allow skipping abort interface for virtiofs
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        =?UTF-8?B?5byg5L2z6L6w?= <zhangjiachen.jaycee@bytedance.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 15 Jun 2022 at 07:58, Xie Yongji <xieyongji@bytedance.com> wrote:
>
> The commit 15c8e72e88e0 ("fuse: allow skipping control
> interface and forced unmount") tries to remove the control
> interface for virtio-fs since it does not support aborting
> requests which are being processed. But it doesn't work now.
>
> This series fixes the bug, but only remove the abort interface
> instead since other interfaces should be useful.

I'd prefer properly wiring up the fc->no_control if there's no
concrete use case for the rest of knobs.

Thanks,
Miklos
