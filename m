Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0F6E07F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 09:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjDMHk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 03:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDMHkz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:40:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC2183E5
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 00:40:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id si1so4968063ejb.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 00:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1681371641; x=1683963641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7T7q7sdsDEBhtepgNI0ki2glnFFLKVYBB69jyV022y8=;
        b=hmUSCKdcDl1A1sQPr36Fu1rWnStt7OexlljdywUqMv67o/3lbAXoDlgMwsngJjYhXN
         wfa84/hZ1KS4bBbPZCOAXgCkflTyq1WmKILRcSAT7vdqML+gG9mhRLEbF1CBTqI8xxTj
         Row8yT/PAoDa/BEjOFGQQXwGxx2pLCgJkRA18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681371641; x=1683963641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7T7q7sdsDEBhtepgNI0ki2glnFFLKVYBB69jyV022y8=;
        b=Av5oeZCBaO3uokhQRgoWmwd/9yNvDZH36DMboPVLPrta7FXNoUm43eWgXRH5bvKVvh
         iAW8AiqI4IMRTm5FXA7dB3XO0TJFDF6v6wM7HSyC1rgNFZo8oekLoeV5ZufVDCTdjq4a
         jHs+w08o+JOjqvHsRnaezPC4C04KRT94U/Ztatss6rHMcH7S53sYloUB9yBs3PlaSMBr
         C0akjPwED0n7Rew3uqSnQhkJXu/NcwOJJiDH6uGOLFA6FHp8cns/JAuSail6eXzQ7LJE
         Lk+HodRrf1vUsQYMPXSPLMfI9UDvgEOw8out1RnTeCzjx1vBZVGKVfCckwYP9FXNBpRe
         CEMQ==
X-Gm-Message-State: AAQBX9dHoXuyyPwdRNTHcsefMdFwlUzJRy6is5+s0EFpBzvFGDZsX9TM
        Wgw9kdDr0WQIzq9zkzy2zKD0rfluSuNHZHtk2oaF0Q==
X-Google-Smtp-Source: AKy350Y9/4S1aq5Wx7x5Sc4KVMyqW3XZKu315mG26h6vL+enjQLM5m7RJvF1SSTExWJj2J8FXSXEON931HqF2A41zvk=
X-Received: by 2002:a17:906:d20a:b0:94e:1014:3114 with SMTP id
 w10-20020a170906d20a00b0094e10143114mr752608ejz.14.1681371641053; Thu, 13 Apr
 2023 00:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230307172015.54911-2-axboe@kernel.dk> <20230412134057.381941-1-bschubert@ddn.com>
In-Reply-To: <20230412134057.381941-1-bschubert@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 13 Apr 2023 09:40:29 +0200
Message-ID: <CAJfpegt_ZCVodOhQCzF9OqKnCr65mKax0Gu4OTN8M51zP+8TcA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: add FMODE_DIO_PARALLEL_WRITE flag
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, dsingh@ddn.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 12 Apr 2023 at 15:42, Bernd Schubert <bschubert@ddn.com> wrote:
>
> Miklos, Jens,
>
> could we please also set this flag for fuse?
>
>
> Thanks,
> Bernd
>
>
> fuse: Set FMODE_DIO_PARALLEL_WRITE flag
>
> From: Bernd Schubert <bschubert@ddn.com>
>
> Fuse can also do parallel DIO writes, if userspace has enabled it.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/file.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 875314ee6f59..46e7f1196fd1 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -215,6 +215,9 @@ void fuse_finish_open(struct inode *inode, struct file *file)
>         }
>         if ((file->f_mode & FMODE_WRITE) && fc->writeback_cache)
>                 fuse_link_write_file(file);
> +
> +       if (ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES)
> +               file->f_mode |= FMODE_DIO_PARALLEL_WRITE;

fuse_direct_write_iter():

bool exclusive_lock =
    !(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES) ||
    iocb->ki_flags & IOCB_APPEND ||
    fuse_direct_write_extending_i_size(iocb, from);

If the write is size extending, then it will take the lock exclusive.
OTOH, I guess that it would be unusual for lots of  size extending
writes to be done in parallel.

What would be the effect of giving the  FMODE_DIO_PARALLEL_WRITE hint
and then still serializing the writes?

Thanks,
Miklos
