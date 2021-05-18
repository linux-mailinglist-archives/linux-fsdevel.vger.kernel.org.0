Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53770387A08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 15:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349663AbhERNd6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 09:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349659AbhERNd5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 09:33:57 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7C4C061573
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 May 2021 06:32:38 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id f11so4948988vst.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 May 2021 06:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mOHb7KV0iIqybMPHNNCBk4g9/EZlQNNg3Qk99m8NzKQ=;
        b=jBJVmpaQ6BNJlKP1vswoqz8AUvJo0sBLr+hfCNWHeWqpaH3HBJMwdAZ8XlmI0i9oIW
         VVagGlGOG2pcFfGScJQNwIneL6jBOy52zZHUNlTSwOfc7U9zKBto9LQCPr9qBWosJw4m
         fyaVDn4mDpQL7EQ1HSn5wmyd2wgZbqj56TRV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mOHb7KV0iIqybMPHNNCBk4g9/EZlQNNg3Qk99m8NzKQ=;
        b=Xcd+a5GJpUwaDus5XbycqlrZc9BmvR+IAeIRQlWNeKeaxlR7eX30w0BzBtM2t7Zi2K
         7Y6UywG40ByT7NFhAni5WU8oWcFFuv74hdgygpOOTxhuBK+FI/aZgfj2u4Nj4u3bHJJA
         fBeGRCT+zUcpHqLFtxFZqhgmcVjmxsv5R9oeO2bOAofX2glBopMctmNGmQoBaf/o9oZI
         wznq9Sdh6zfuXjO5jIY6r5khY7A/Vog+5fizXIqsPajsCJq377/n4qcxonu/AJ9eUvA3
         81t+BL+pforYsXL+IuLRvDffCQkJIoC0PCJ10qqcpGoWZQqIz3Z8rWZrLXX3p3ybswQ/
         pTEg==
X-Gm-Message-State: AOAM533VJiQ+s2EeC1HSiUQRSDWBAXlx2SF15RmKWxhjMBOFYp3ixKab
        xyLZy/xg9A3hPpxA5oxwDgtWQ3DZ686GbC9JhFZ5ZAmaqPiVPg==
X-Google-Smtp-Source: ABdhPJzNGPeZqScCYFqkxGn/zGapuZtHgCfq2bKaiCYFh9lRHAQl69QspV9tsx8WEehkUpoKZOGJhq66NCzmKgTZ3ZM=
X-Received: by 2002:a67:db91:: with SMTP id f17mr6751308vsk.47.1621344757894;
 Tue, 18 May 2021 06:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210514061757.1077-1-changfengnan@vivo.com>
In-Reply-To: <20210514061757.1077-1-changfengnan@vivo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 18 May 2021 15:32:27 +0200
Message-ID: <CAJfpegs6kKi31LzM2EGthkHW+ZBLzF2we0c5pFdcXWOhsS7VLw@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: fix inconsistent status between faccess and mkdir
To:     Fengnan Chang <changfengnan@vivo.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 14 May 2021 at 08:18, Fengnan Chang <changfengnan@vivo.com> wrote:
>
> since FUSE caches dentries and attributes with separate timeout, It may
> happen that checking the permission returns -ENOENT, but because the
> dentries cache has not timed out, creating the file returns -EEXIST.

This should be fixed in v5.11 and later by commit df8629af2934 ("fuse:
always revalidate if exclusive create").

Thanks,
Miklos
