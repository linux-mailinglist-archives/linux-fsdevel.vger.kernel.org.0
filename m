Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628E870EED1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 09:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbjEXHBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 03:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239758AbjEXHBK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 03:01:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EECE72
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 00:00:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96fffe11714so88378866b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 00:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1684911648; x=1687503648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fAJTLElGGZ3FPpd+hHW9swqi8LLYODpFepxDuukKj48=;
        b=ELxBtF4o5IW55MyhAM6yTOMm6oDR+XkfJhvlX+7yzhV6yRAz+kRMFfkRCYja/6IwPZ
         FTcVNAUIhnZWWI9RB/TvnQRG99/ujJn+7EvSVb8go10F5ziPp4CLpuOynZN7aDG2iiKN
         FoJDD4skK5plrQNhXLERFN58xnfbYUu86ouco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684911648; x=1687503648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAJTLElGGZ3FPpd+hHW9swqi8LLYODpFepxDuukKj48=;
        b=VbC2BAHy6HSxOZ2G8p/rrXNbEltc6X7u+1BKALFTR/krEIEfEIEBh9qtvbD1B/Ewle
         8kUdc8MUy9nRGz8icmaCIBUGa3QGK8AzJYkLAUmDu/f8N8Pw1IL8doAe9W3QH88sbe3K
         1edK8fGLSkIX/1iGvA1MqyH7has5uvcUn2t61ICibn5rjWZn7zKl/ugZtpJ7AdHcjdzX
         7C9ihRVyBfAWk4kDdfNJNw6zQob3ftxF2/sV+r/zTP/u5W/codH7tevoy6X7i9wMm+Te
         HqksN7HxvqcXtqEEoCieDbdmePqdtkwDrDHUUYs4nx4Kwj+7Cnw0KcWubEoyxcw6w2K3
         OMjw==
X-Gm-Message-State: AC+VfDzM49WtG7Gk8gTcCgG71s24LbMqeFtqHijTjLawUR4Dl73pLlLE
        rFhOehBH2tgEFftYVMIeXRuqbPnbcL0LVjrE7sSMbw==
X-Google-Smtp-Source: ACHHUZ7SlvMG5x2vt/jfLi6LwhlfmuAYckVadaRzR4fxt1kxZ/GcPnJE1sq8JdB2Ei2izIpvJDmtMpewdQCFFqShZGk=
X-Received: by 2002:a17:907:5ca:b0:94f:704d:a486 with SMTP id
 wg10-20020a17090705ca00b0094f704da486mr16846446ejb.32.1684911648375; Wed, 24
 May 2023 00:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230524063810.1595778-1-hch@lst.de> <20230524063810.1595778-10-hch@lst.de>
In-Reply-To: <20230524063810.1595778-10-hch@lst.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 May 2023 09:00:36 +0200
Message-ID: <CAJfpeguT-LjhS-XrZwMystZqkxyB=HaON1zo-BTNOC0L1zCa1Q@mail.gmail.com>
Subject: Re: [PATCH 09/11] fs: factor out a direct_write_fallback helper
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 24 May 2023 at 08:38, Christoph Hellwig <hch@lst.de> wrote:
>
> Add a helper dealing with handling the syncing of a buffered write fallback
> for direct I/O.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/libfs.c         | 36 +++++++++++++++++++++++++
>  include/linux/fs.h |  2 ++
>  mm/filemap.c       | 66 +++++++++++-----------------------------------
>  3 files changed, 53 insertions(+), 51 deletions(-)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 89cf614a327158..ad37a49e2ecfb7 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1613,3 +1613,39 @@ u64 inode_query_iversion(struct inode *inode)
>         return cur >> I_VERSION_QUERIED_SHIFT;
>  }
>  EXPORT_SYMBOL(inode_query_iversion);
> +
> +ssize_t direct_write_fallback(struct kiocb *iocb, struct iov_iter *iter,
> +               ssize_t direct_written, ssize_t buffered_written)
> +{
> +       struct address_space *mapping = iocb->ki_filp->f_mapping;
> +       loff_t pos = iocb->ki_pos - buffered_written;
> +       loff_t end = iocb->ki_pos - 1;
> +       int err;
> +
> +       /*
> +        * If the buffered write fallback returned an error, we want to return
> +        * the number of bytes which were written by direct I/O, or the error
> +        * code if that was zero.
> +        *
> +        * Note that this differs from normal direct-io semantics, which will
> +        * return -EFOO even if some bytes were written.
> +        */
> +       if (unlikely(buffered_written < 0))
> +               return buffered_written;

Comment/code mismatch.   The comment says:

if (buffered_written < 0)
        return direct_written ?: buffered_written;

> +
> +       /*
> +        * We need to ensure that the page cache pages are written to disk and
> +        * invalidated to preserve the expected O_DIRECT semantics.
> +        */
> +       err = filemap_write_and_wait_range(mapping, pos, end);
> +       if (err < 0) {
> +               /*
> +                * We don't know how much we wrote, so just return the number of
> +                * bytes which were direct-written
> +                */
> +               return err;

Again comment/code mismatch.

Thanks,
Miklos
