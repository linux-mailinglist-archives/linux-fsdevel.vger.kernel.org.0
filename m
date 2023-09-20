Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792CB7A7876
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 12:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjITKBv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 06:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjITKBr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:01:47 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60F3DD;
        Wed, 20 Sep 2023 03:01:37 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6c0a3a2cc20so4174913a34.0;
        Wed, 20 Sep 2023 03:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695204097; x=1695808897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2Sxc2lzUzNR93PpRUd+yVO8Zh7S3vyEBNQBpNy/0XM=;
        b=nAIewok8Jz4uPNzrk5L5OdNdqKLfqMiMI6qHZXaKSFvdbq123fGQyOYG0RXfm++m/1
         3JjCXqpoMC85ym+PhL2l/JMYVwA+zVNV2PBR/StsG66Sq3y/IMsGUVvt/+/uzqKI9A+6
         0Yi5B3KcgMhzNbalG9yQyYgQpM8vqsSRNORaE1cd3798JYRmEriwoOACwvPe4hNkyFNn
         /wFjqzn0C0JRWs7CLlOWNaBY8HXVWaE1Ju4aBSogR1+ed4dnxkJkzVmX1Ih29GFMtoue
         Ln80b+TeysRDKz/alh3/lA2ouGnSyMQDPP4AHG2FNN+CHEW/Scx+TlyZGqSmHK+LGg9S
         tvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695204097; x=1695808897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2Sxc2lzUzNR93PpRUd+yVO8Zh7S3vyEBNQBpNy/0XM=;
        b=gIvvxszTJrsH/szJJLi2PD1s/GuTRxbUz7SvLKWdtm7ai7mQlubOESzpYKFDYvfqSl
         PiXKunG6/a7GWIyF+EPzwX1940++CL4CqzTc1H69cD5bVq68hTGgPwl1Or4di8XcuuN1
         T1dA+8wB0e/Bjffs1znhjrXbhEdjXW04HXZrSHJza1WlYh1rxNkIuk08ANWxmBIkyGrZ
         LIvfxGcPcY3HWhfiy48PzlDHTK35YQnPmtY/ffyPgrZbWombTZlZh21tIjcFBjEGHf5u
         nnA2xpB0WIY+SQpvzSIGwM9DZjlKVkYkHtKtY5SUnF+wrBZKniD8bS/eHvB8n09ie01s
         DLJg==
X-Gm-Message-State: AOJu0Yw/mqfEf2UfDDgP+wga3JEirtsJfQkOsHWz8nzwS87p6X6sSQKB
        vchyC82oCOGQqbqpyFnbIYassEoribuzPrsOSAA=
X-Google-Smtp-Source: AGHT+IF6TvvrFfInrhj56gdvCe5w+++P3HMf6bTBPikJlLKn+WLjAfLo6m95ThXJfvs6hZ63Kl1g7MzMNs/yRVqIDX8=
X-Received: by 2002:a05:6830:102:b0:6b9:b226:d08e with SMTP id
 i2-20020a056830010200b006b9b226d08emr2148062otp.34.1695204097042; Wed, 20 Sep
 2023 03:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230919045135.3635437-1-willy@infradead.org> <20230919045135.3635437-16-willy@infradead.org>
In-Reply-To: <20230919045135.3635437-16-willy@infradead.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 20 Sep 2023 19:01:20 +0900
Message-ID: <CAKFNMonL+TobLB6e6g0kKQsGY0-FP1fkQyuNQKqS8+B-QH4qig@mail.gmail.com>
Subject: Re: [PATCH 15/26] nilfs2: Convert nilfs_lookup_dirty_data_buffers to
 use folio_create_empty_buffers
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 3:47=E2=80=AFPM Matthew Wilcox (Oracle) wrote:
>
> This function was already using a folio, so this update to the new API
> removes a single folio->page->folio conversion.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/nilfs2/segment.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index 7ec16879756e..94388fe83cf8 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -731,10 +731,9 @@ static size_t nilfs_lookup_dirty_data_buffers(struct=
 inode *inode,
>                         continue;
>                 }
>                 head =3D folio_buffers(folio);
> -               if (!head) {
> -                       create_empty_buffers(&folio->page, i_blocksize(in=
ode), 0);
> -                       head =3D folio_buffers(folio);
> -               }
> +               if (!head)
> +                       head =3D folio_create_empty_buffers(folio,
> +                                       i_blocksize(inode), 0);
>                 folio_unlock(folio);
>
>                 bh =3D head;
> --
> 2.40.1
>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>


Now, I've seen all the changes to nilfs2 including the last patch.
It's almost a direct conversion throughout, and I don't see any issues
with the nilfs2 part other than the build issue.

With all 26 patches applied, nilfs2 is running without problems in
actual machine tests including stress tests.

Thank you very much for your efforts.

Regards,
Ryusuke Konishi
