Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE390537A76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 14:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbiE3MNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 08:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbiE3MNd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 08:13:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4756B1CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 May 2022 05:13:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b8so5297174edf.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 May 2022 05:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWQq0Cn88HLsmrdESDZ42o7nCNRv8Za1ThOM0o4taxQ=;
        b=ETiH40/iyFN2AtDNl+SwVYIRE0FX+vCYzR2ZX/HdD1AKx4J792GfA2qCmw8TFBCxMu
         UV6T011ETCJ6el9OJtKYrD6EVBW2Iqh6r7oIT+/Noh/WJdRSKo/HwCZOECS9I5E17clE
         uJw96Ipmrmu6y5jxhYWpzfHxgL8iwB9Fv8rgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWQq0Cn88HLsmrdESDZ42o7nCNRv8Za1ThOM0o4taxQ=;
        b=8FXOJa6bTT6ZydgW/mj8ED+CDWZyOeQwByH1S7OXUKNB9iJV1KUGPAFisRRoZNkG4c
         lr0XyuFLCrXzSeDxrj9U3ZmFHrJ0w6dKDS4XGkMNfodiUSJ5ascsXBf/Ssn3Mkp6udvs
         w2h8QCLL2Mvo40o8XuIX2ZeFBhN/YqGal4OV3WMClgrfKPBY7zpQ9tTfWbxee90GPAM8
         CkUaQ0fgdIvX5FpS1tLyELymgS5qSKZ0NQ5pagZhgdaR4hRHLRPl0ZlYsHAOwa4fN5Za
         SQYxxrqe1gSi5JGUz9hxcPTTDtzWonhe8b1XP0C/Ki5zf4E5cAX9z+72/QvVw5jmxYvu
         3UoA==
X-Gm-Message-State: AOAM533MP726gZyT2nbmyt0TWDQCe8yIDhA8Doi4YIY2FE/3jkwFTsO2
        FBDvRch0B4JKGELCtxgG2eCWipRi55k0Tz/I6vcA+g==
X-Google-Smtp-Source: ABdhPJys/A6R0ZVqmT4OWNtUkENLHEXxs5c/9OcoIuwsW9PXDhf7ko24nlBUSnPUoQR8b/pW7K9hnjE0T43w/PEnWCo=
X-Received: by 2002:a05:6402:5210:b0:42b:7718:b6ef with SMTP id
 s16-20020a056402521000b0042b7718b6efmr35893562edd.22.1653912808479; Mon, 30
 May 2022 05:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220523014838.1647498-1-chenxiaosong2@huawei.com>
In-Reply-To: <20220523014838.1647498-1-chenxiaosong2@huawei.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 30 May 2022 14:13:17 +0200
Message-ID: <CAJfpegt-+6oSCxx1-LHet4qm4s7p0jSoP9Vg8PJka3=1dqBXng@mail.gmail.com>
Subject: Re: [PATCH -next,v2] fuse: return the more nuanced writeback error on close()
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ChenXiaoSong <chenxiaosong2@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuyongqiang13@huawei.com, "zhangyi (F)" <yi.zhang@huawei.com>,
        zhangxiaoxu5@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 23 May 2022 at 03:35, ChenXiaoSong <chenxiaosong2@huawei.com> wrote:
>
> As filemap_check_errors() only report -EIO or -ENOSPC, we return more nuanced
> writeback error -(file->f_mapping->wb_err & MAX_ERRNO).
>
>   filemap_write_and_wait
>     filemap_write_and_wait_range
>       filemap_check_errors
>         -ENOSPC or -EIO
>   filemap_check_wb_err
>     errseq_check
>       return -(file->f_mapping->wb_err & MAX_ERRNO)
>
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> ---
>  fs/fuse/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f18d14d5fea1..9917bc2795e6 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -488,10 +488,10 @@ static int fuse_flush(struct file *file, fl_owner_t id)
>         inode_unlock(inode);
>
>         err = filemap_check_errors(file->f_mapping);
> +       /* return more nuanced writeback errors */
>         if (err)
> -               return err;
> +               return filemap_check_wb_err(file->f_mapping, 0);

I'm wondering if this should be file_check_and_advance_wb_err() instead.

Is there a difference between ->flush() and ->fsync()?

Jeff, can you please help?

Thanks,
Miklos
