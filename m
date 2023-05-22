Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0494D70C0DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 16:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjEVOT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 10:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjEVOTz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 10:19:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A9DF1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 07:19:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96fe2a1db26so224468766b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 07:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1684765190; x=1687357190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VSL7mwwp7mP3i/A2Ha5ZWYNP2l8nV9xWCZ9dDdVJyrE=;
        b=bW3JxzSWL903VRTFCHvbgK/kSmmhNGzjPmv2oTgKuUeY/4UGuj+rpVpSRqU0fLX71Z
         9x0WYxajpqEHWpasb3FMt2QPMwFvEXG1qzy09fFvoatRiySxfHmtlreAhXwdf72AH0EA
         uaD7yDQ7ocfBWwGajHKOT7vpFDgho5apenxJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684765190; x=1687357190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSL7mwwp7mP3i/A2Ha5ZWYNP2l8nV9xWCZ9dDdVJyrE=;
        b=E8JnkGmRTgoA81xU/5kE+WU2XBZh7oSMs7tbs107BOFnHF3PenpKSuaOXsF4aU4UI5
         rg3ECxCZKdfBeihYaPBrhCRSw+S9WH9kHOeiOlTdeQCmzlAWNzSXzl56/IciFBFRHOrY
         tkSBOt8Mk+zEUaL6gjkr3x847ypfYtdGvoJ+SYVkjFlDyQmjuggAw2xZ1/fLPyIqDVML
         B1tr2VgGGgL6xRLXG//ui6AODfhZ4Ce44AwQFcbmtLexalmqJf5zhxgQPZzEwa2q9Gng
         SPLOWnzhSb/DhzwOPNFd46eUIog6/D9uxRFwyUHxPKwyqo92Ic3VqI/YKAmRzl+fArsL
         gw/Q==
X-Gm-Message-State: AC+VfDxJYiyEVMPsDwaGhrHjvB16GxmFdiEnj4V8T38L2ZYxFd9KjwMt
        E5Q1Y0nC23pU+xKT/vJJaCR1GeDna4kbX5u1Ldla/w==
X-Google-Smtp-Source: ACHHUZ5pTZpoagrq7BPdRNACytZjcbnwwAzdd4/4F4mMBgFIR5olByJvr8DzGqhjgDPmmSOeMIBmAwCLlQut/WuHsuo=
X-Received: by 2002:a17:907:25c2:b0:969:edf8:f73b with SMTP id
 ae2-20020a17090725c200b00969edf8f73bmr9314077ejc.60.1684765189889; Mon, 22
 May 2023 07:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230519093521.133226-1-hch@lst.de> <20230519093521.133226-11-hch@lst.de>
In-Reply-To: <20230519093521.133226-11-hch@lst.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 22 May 2023 16:19:38 +0200
Message-ID: <CAJfpegtHb4pA=1NBRzQJSub7B0HZqnvqsMNQmYYM-8L7PTQfvw@mail.gmail.com>
Subject: Re: [PATCH 10/13] fs: factor out a direct_write_fallback helper
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
        "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
        cluster-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 19 May 2023 at 11:36, Christoph Hellwig <hch@lst.de> wrote:
>
> Add a helper dealing with handling the syncing of a buffered write fallback
> for direct I/O.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/libfs.c         | 36 ++++++++++++++++++++++++++++
>  include/linux/fs.h |  2 ++
>  mm/filemap.c       | 59 ++++++++++------------------------------------
>  3 files changed, 50 insertions(+), 47 deletions(-)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 89cf614a327158..9f3791fc6e0715 100644
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
> +       loff_t pos = iocb->ki_pos, end;

At this point pos will point after the end of the buffered write (as
per earlier patches), yes?

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
> +
> +       /*
> +        * We need to ensure that the page cache pages are written to disk and
> +        * invalidated to preserve the expected O_DIRECT semantics.
> +        */
> +       end = pos + buffered_written - 1;

So this calculation is wrong.

AFAICS this affects later patches as well.

Thanks,
Miklos
