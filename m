Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2FC424FFF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 11:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbhJGJZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 05:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240592AbhJGJZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 05:25:12 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B85C061755
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 02:23:18 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id 188so6133413vsv.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 02:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rUWh8/nzui59AslYBGE2UZsOtVDOFLafNPVpXzsA5k0=;
        b=LdQoTfuILlI4bUYn34I0nglU9SK7YTIYJZ8ovMH6IzZzlwbsBelfcMO6mz/t0TnDgD
         9NPHc4AyQZxZvAwaiUbbANwYwj3v8nKg6Vwt4cJ/16oOLdhsHBKolnYGkem7Lnhbop1S
         u5EvLLkgZIayXwvPzfuUYzNF+SENB3fb1JF74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rUWh8/nzui59AslYBGE2UZsOtVDOFLafNPVpXzsA5k0=;
        b=EPiO2X1J5deyd2eFz0q1A9GLVbioT06RO5hU3mjSOU+y8yYC/TTVCHNZMrGE+Mwr4O
         r6kTfQIIea3P6OJuoH4aNaSzrlnETyrIe0oiouq2dH20+pg3lQCTk7D4C28qOLo+ltvO
         7ldEIRsvPEH4aXZJEQPIuYq8IUNWIgR1SDVqIx2d1Trh7RURf5aW8mlS3ZXHdATlOYB4
         c0XuIPVOa1kgnMBAI6eKRm5mJSgYSoaK0OdWJmvdYlgYWdwtj5TyJC3x4ZYDi3NNTu3B
         CpSq66u3dsTWpdRFaPsAgLaVhj5hC9gmVuwzcsWnixe+Lc9a/4m3ACfli5XIlQTAPvam
         Zm1Q==
X-Gm-Message-State: AOAM531ce0K1hWL3PmUCR1tvq1VDG0942t7tF6x4QwizgIbs0ORyi6vf
        RDaX1l235jWbbJjtNOFwrKwYlwEqlt6WH1+zHio299fcQZAryg==
X-Google-Smtp-Source: ABdhPJwKmuyoUN96r/uOpk7uvGkP1btKzYR/lUkNsBES9CO8VlwM7PF9JuCilztl58w8Qi5nUUZHjepATMqzufo12s0=
X-Received: by 2002:a67:ec94:: with SMTP id h20mr2591162vsp.59.1633598597621;
 Thu, 07 Oct 2021 02:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210923130814.140814-1-cgxu519@mykernel.net> <20210923130814.140814-7-cgxu519@mykernel.net>
In-Reply-To: <20210923130814.140814-7-cgxu519@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 7 Oct 2021 11:23:06 +0200
Message-ID: <CAJfpeguqj2vst4Zj5EovSktJkXiDSCSWY=X12X0Yrz4M8gPRmQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode operation
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 23 Sept 2021 at 15:08, Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> Implement overlayfs' ->write_inode to sync dirty data
> and redirty overlayfs' inode if necessary.
>
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  fs/overlayfs/super.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 2ab77adf7256..cddae3ca2fa5 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -412,12 +412,42 @@ static void ovl_evict_inode(struct inode *inode)
>         clear_inode(inode);
>  }
>
> +static int ovl_write_inode(struct inode *inode,
> +                          struct writeback_control *wbc)
> +{
> +       struct ovl_fs *ofs = inode->i_sb->s_fs_info;
> +       struct inode *upper = ovl_inode_upper(inode);
> +       unsigned long iflag = 0;
> +       int ret = 0;
> +
> +       if (!upper)
> +               return 0;
> +
> +       if (!ovl_should_sync(ofs))
> +               return 0;
> +
> +       if (upper->i_sb->s_op->write_inode)
> +               ret = upper->i_sb->s_op->write_inode(inode, wbc);

Where is page writeback on upper inode triggered?

Thanks,
Miklos
