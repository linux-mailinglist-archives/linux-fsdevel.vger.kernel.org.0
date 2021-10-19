Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD081432F22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 09:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhJSHRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 03:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhJSHRw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:17:52 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC50CC06161C;
        Tue, 19 Oct 2021 00:15:39 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h10so17474943ilq.3;
        Tue, 19 Oct 2021 00:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hl1u9M0rl+9gSZUge+5bqfea4i7wHZvAs7wZITYpJJA=;
        b=nlDfQiCw4MTxALTdhD/5ocAg54hueHcy/dOILGBUU87jwiukUiMy/UmCkYBqhj+rVj
         I/a1WANgLOExWOwX/d1E+p+QVTtEVNWIEJryS/DPnZXj4O9q9uj7uvwkTB0E2h8SUJ37
         AJYEQiTkTC9llejX7E7wbcgwQz8gAEyTabybDfshVqUzmiuH5dN7nXNX/ocoDdH4266d
         GbtPvd94vS1YRTh8hnIe1GcOIsvLSC3FonqrJsrKmgEPJ9/NxCu+DasngdEGCjPRwRYz
         +mJyaspMFaBQpeLrXD7jC1El18QDhzlPLz0N55yEFLOia05TmUeQF9N6T4MEOlqyGPY+
         yDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hl1u9M0rl+9gSZUge+5bqfea4i7wHZvAs7wZITYpJJA=;
        b=IUEmD526lTaYGYpb6EIJE2fqW4WQ9cRCgkcPLxM2Os55GEO3VeSrfluIkoG+r8Fdw8
         g7q3dbnyS9AeF3vvcQJVnr4B3MFo7HRhtwPqkgwPTmN9yuNYlJx1Jp8eoJH/4RPo7ecb
         m5Nof8O8Q2wMqRlXrIYAhypBz5i7aGfzBZXHvENZgHog5J7v5uf9vfnP8GGNp7wtbJWZ
         UEnDiOIBXTRTAdkXPfNMtAjPvXL6Ms9CgF2uCfak23jbDCII4u/O1jKCrnjGH6rOL+eu
         bsZHOYRA9fj87PVQQtTaC+FfIruNCuKbE99MCLz73oiqmUzYCH1euL3CbBWAZ9i/xEC0
         VmvQ==
X-Gm-Message-State: AOAM533K9a4Bt1yumVzlWOAI5kedXoneerD2akWKtttBHb7KmdSQQO7V
        cT3DVXmZvJ5lhckLes+cBbrM3dTo5271XETU3ZY=
X-Google-Smtp-Source: ABdhPJwOXz1RO8P/VLPzBCkzHmzOYMWA6zWUBuDUmc2QhEF54bdXUDQl5UZv3uXWYAYwUpd827+MtKqGv1ZxDPm4dtg=
X-Received: by 2002:a92:cd82:: with SMTP id r2mr18370814ilb.198.1634627739368;
 Tue, 19 Oct 2021 00:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210923130814.140814-1-cgxu519@mykernel.net> <20210923130814.140814-10-cgxu519@mykernel.net>
In-Reply-To: <20210923130814.140814-10-cgxu519@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Oct 2021 10:15:28 +0300
Message-ID: <CAOQ4uxj4no4zHaOKSXyefUpP+JuMsjeuMPzpZ8BAm1xrs2h+Aw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 09/10] fs: introduce new helper sync_fs_and_blockdev()
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 4:08 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> Overlayfs needs to call upper layer's ->sync_fs
> and __sync_blockdev() to sync metadata during syncfs(2).
>
> Currently, __sync_blockdev() does not export to module
> so introduce new helper sync_fs_and_blockdev() to wrap
> those operations.

Heads up: looks like __sync_blockdev() will be gone soon,
but you will have other exported symbols that overlayfs can use

https://lore.kernel.org/linux-fsdevel/20211019062530.2174626-1-hch@lst.de/T/

Thanks,
Amir.
