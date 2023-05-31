Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3625717B69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 11:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjEaJLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 05:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjEaJLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 05:11:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035CC1B3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 02:11:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-514953b3aa6so5518197a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 02:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1685524285; x=1688116285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ISkp7pEP+0sRQxyl+Kb79Eh0f1S6sp18TmXfWBaAyu4=;
        b=dJOv9q/YK0iEqQ5zNLLe/oNHi3RAcMruLF/Ly97IM4UKyWQ6BU0vbwmy5XObs9rKiq
         L78AyjiMCnhu3YMlQcCsm1FY9ZM34qzmrdOcgBgszstMUHq1IAxUroiCHjwKUuIt+D8H
         mBFmnCmCovFiFJD1nOdBlhjqUIi/4hrYsHPew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685524285; x=1688116285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISkp7pEP+0sRQxyl+Kb79Eh0f1S6sp18TmXfWBaAyu4=;
        b=BP+SAkjnTejUh+zjPYhOVWsZAuLxhKERHlKmu15c1c1BIJ6W7YAF9Gx7NHSETNyNaK
         QyUH/O6i40WG7YOb6PREWXMLKHTla59QutBXQh4kyOwcETBFegI0C4pE3jCW24+XnzGo
         0vLgKofsp1pa0jBOpUPNZ+wnSRpkE59b4wbcl12oT+Wd4mJDFweG1Q/TJ5lvOaGwMv79
         zyhRpMBWE8797I1paUH756pitMQ8iYBmba1uwKWevn5TwyBo6Nf2eb/0gPiyE3dWSRCY
         wTPZUd/hy1CTYN4mGWdmT7JgyG05IbfGKog29eKSaO6TDCvOZjDuXukdtEUM2+GIScGD
         stNQ==
X-Gm-Message-State: AC+VfDyHcESwanAWqrCYwwNLqpjrWCyNFx7dFB3XT1Pq00YdNA2PbG4E
        nRZGt6H1f03P5FzIoETGxDIStLofB+QZPd15EsBMjA==
X-Google-Smtp-Source: ACHHUZ7qS7TmWM4+gPdkrDhL0bqZjnQfi2Xy2fkSny6o4W3m4Wn8XiF4R2Jdbdnsml8nAyt9sFK0bEVdcGYNFEZCdMs=
X-Received: by 2002:a17:907:7f23:b0:969:9fd0:7ce7 with SMTP id
 qf35-20020a1709077f2300b009699fd07ce7mr5700403ejc.11.1685524285339; Wed, 31
 May 2023 02:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230531075026.480237-1-hch@lst.de> <20230531075026.480237-11-hch@lst.de>
In-Reply-To: <20230531075026.480237-11-hch@lst.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 31 May 2023 11:11:13 +0200
Message-ID: <CAJfpegth2z06pAH5K5vxRsy1PqygBD=ShiQxoYGqjmJPvk1-aQ@mail.gmail.com>
Subject: Re: [PATCH 10/12] fuse: update ki_pos in fuse_perform_write
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 31 May 2023 at 09:51, Christoph Hellwig <hch@lst.de> wrote:
>
> Both callers of fuse_perform_write need to updated ki_pos, move it into
> common code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  fs/fuse/file.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 97d435874b14aa..e60e48bf392d49 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1329,7 +1329,10 @@ static ssize_t fuse_perform_write(struct kiocb *iocb,
>         fuse_write_update_attr(inode, pos, res);
>         clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
>
> -       return res > 0 ? res : err;
> +       if (!res)
> +               return err;
> +       iocb->ki_pos += res;
> +       return res;
>  }
>
>  static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
> @@ -1341,7 +1344,6 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>         struct inode *inode = mapping->host;
>         ssize_t err;
>         struct fuse_conn *fc = get_fuse_conn(inode);
> -       loff_t endbyte = 0;
>
>         if (fc->writeback_cache) {
>                 /* Update size (EOF optimization) and mode (SUID clearing) */
> @@ -1375,19 +1377,20 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>                 goto out;
>
>         if (iocb->ki_flags & IOCB_DIRECT) {
> -               loff_t pos = iocb->ki_pos;
> +               loff_t pos, endbyte;
> +
>                 written = generic_file_direct_write(iocb, from);
>                 if (written < 0 || !iov_iter_count(from))
>                         goto out;
>
> -               pos += written;
> -
> -               written_buffered = fuse_perform_write(iocb, mapping, from, pos);
> +               written_buffered = fuse_perform_write(iocb, mapping, from,
> +                                                     iocb->ki_pos);
>                 if (written_buffered < 0) {
>                         err = written_buffered;
>                         goto out;
>                 }
> -               endbyte = pos + written_buffered - 1;
> +               pos = iocb->ki_pos - written_buffered;
> +               endbyte = iocb->ki_pos - 1;
>
>                 err = filemap_write_and_wait_range(file->f_mapping, pos,
>                                                    endbyte);
> @@ -1399,17 +1402,11 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>                                          endbyte >> PAGE_SHIFT);
>
>                 written += written_buffered;
> -               iocb->ki_pos = pos + written_buffered;
>         } else {
>                 written = fuse_perform_write(iocb, mapping, from, iocb->ki_pos);
> -               if (written >= 0)
> -                       iocb->ki_pos += written;
>         }
>  out:
>         inode_unlock(inode);
> -       if (written > 0)
> -               written = generic_write_sync(iocb, written);

Why remove generic_write_sync()?  Definitely doesn't belong in this
patch even if there's a good reason.

Sorry, didn't notice this in the last round.

Thanks,
Miklos
