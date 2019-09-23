Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62633BAE46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 09:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfIWHEq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 03:04:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46467 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbfIWHEq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 03:04:46 -0400
Received: by mail-io1-f65.google.com with SMTP id c6so17687225ioo.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2019 00:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpTyDJSflBW+QPMMDDsepchJdkTTubdSdAaymkZ96XY=;
        b=l2caNgMvD9AKb2I+MSeDjdCLbYE2N/iruecE2LprCmOltoki8OYaomcgS5qG3e79w6
         O/VzvzlPeV8Ay70jLFWaGyyoS5c59RLUITFDexhCoZSsy5MUKI9CaIDuYhchM8/UDZIM
         xcZYlc8QPcJSl/7DClIOAvDjDPN3n8R4+yBG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpTyDJSflBW+QPMMDDsepchJdkTTubdSdAaymkZ96XY=;
        b=cXH0QjzbR3TJ4kNNO9P/JJ5iim987b4X063NPE+1NwaXhvhIpcn/wpMHebJbJSZcRP
         HzNNEHZ3Y+o60dBvS8QGO8USefg6nuDQr8u4yekJJHG3MqRkyeJw0/QJaUFBW1aimjH4
         kEevT/tNFqiCsk7Srk4Xrtzf/YUivolgb2k7YSrapWaw1mqkHtKpZoOz8euPpLjJy87Z
         V0mKGTYd66ajnTwJ7uwS1AAaKL7XDqwZiYwgpvWzP/ug3kcOETQUC6p0QS7doO1VxgO4
         uKdM0DykuUSAodBu7IcrvorfAkEvK4JCgEHC0J/W9LKtNZtuOU1MixhBetxPc1B3I1mk
         CQPA==
X-Gm-Message-State: APjAAAX8CpqEKn29MVA/dIHqoYodTAt26hHlTNkcDYL+bYQngdPYdQg/
        jZUIX129TLg55ymR9tAhYFUS1Am2pvacLD7h0VDqUQ==
X-Google-Smtp-Source: APXvYqyv8QeEr2wSBT9IcXI8z1NNEvPrOkpWGcMUZA43eI07YMrg7YnMkl/ppo5n03AuG/Ik6D6hFz8mSqRc2e74NtM=
X-Received: by 2002:a02:1444:: with SMTP id 65mr25612616jag.58.1569222285332;
 Mon, 23 Sep 2019 00:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <1565769549-127890-1-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1565769549-127890-1-git-send-email-zhengbin13@huawei.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 23 Sep 2019 09:04:33 +0200
Message-ID: <CAJfpeguqa2CSXsZ_OkiuP1bQrFM-UqoAs+MH4Zcv4v4S8WJwjg@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix memleak in cuse_channel_open
To:     zhengbin <zhengbin13@huawei.com>
Cc:     mszeredi@suse.cz, Ashish Samant <ashish.samant@oracle.com>,
        linux-fsdevel@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 14, 2019 at 9:52 AM zhengbin <zhengbin13@huawei.com> wrote:
>
> If cuse_send_init fails, need to fuse_conn_put cc->fc.
>
> cuse_channel_open->fuse_conn_init->refcount_set(&fc->count, 1)
>                  ->fuse_dev_alloc->fuse_conn_get
>                  ->fuse_dev_free->fuse_conn_put
>
> Fixes: cc080e9e9be1 ("fuse: introduce per-instance fuse_dev structure")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>

Thanks, applied.

Miklos
