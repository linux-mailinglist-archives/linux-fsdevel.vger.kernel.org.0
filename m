Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779B4697E45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 15:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBOOVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 09:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjBOOVd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:21:33 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE44F38E8E
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 06:21:27 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id d40so21072777eda.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 06:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=++V9SJUmsd6aNbKrrX2Vp+eNjsbnSXfCTQVhInkUQuc=;
        b=QclEkGeJaDyJ2MN5w5QfiCQ8de3GeG3+uTs0OA0VXOnBAp915fljIHV1IoA0RRTgBT
         AtADNyKxCgemkhvl5YgtEnxsHWDPD2qAlpo1Q2gcyAmZ5eGOMZ5gqoKGNxqR9q50Kbl4
         K/tC+qnzux1LedbCJfBuAcn4PWcWuom4pMdcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++V9SJUmsd6aNbKrrX2Vp+eNjsbnSXfCTQVhInkUQuc=;
        b=YShklpc8sMb9vgsKzFTU6RfhjHHuc3vebAVo/vRT8C+aJchkPPlDkSK7NXUlRtEUqH
         Q/p6nCNKbDreWOv3xyE1/11HeDMUCTM5fLImUIxgHfnY3Ym8oFNYMunG9Zyi4ZOfJQoz
         HYmZzBDo59oaMTGgqFb7iise7YuZIYRRnP1DaQvBIdO9l+D73zgV7tIc+T33oc4oCqER
         humtDx1xuTHADj5BH9H062+LhtuVcCE+beWjtzmq0KWxTSLkisPimLMzIjDBCA7FPSc1
         f7pVArWDoSGjRrw+dtX9zqqYedte7T9xSTykvDSnh2xif6cCd7aZnsUKekZQfw4n+RD8
         uXxQ==
X-Gm-Message-State: AO0yUKW0nofrX1Q2RRRmAJQuSmbmJeviGd40mt1+sML4JofDihckz6NS
        i+/RUXbLZFcDq3b9SIUuz6gdHtbrnnWl2juofZPwUw==
X-Google-Smtp-Source: AK7set8J/qhKUo3tQQmCquV6hVX4BcOX1+D6GldAwjXvhuzacLJCUaR0kGWnZj+kS/ecBNI3awJmTaF7IFjItE9S1tU=
X-Received: by 2002:a50:ab5a:0:b0:4ac:c453:6d5f with SMTP id
 t26-20020a50ab5a000000b004acc4536d5fmr1188884edc.8.1676470886215; Wed, 15 Feb
 2023 06:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20230214171330.2722188-1-dhowells@redhat.com> <20230214171330.2722188-6-dhowells@redhat.com>
In-Reply-To: <20230214171330.2722188-6-dhowells@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 15 Feb 2023 15:21:15 +0100
Message-ID: <CAJfpegshWgUYZLc5v-Vwf6g3ZGmfnHsT_t9JLwxFoV8wPrvBnA@mail.gmail.com>
Subject: Re: [PATCH v14 05/17] overlayfs: Implement splice-read
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 14 Feb 2023 at 18:14, David Howells <dhowells@redhat.com> wrote:
>
> Implement splice-read for overlayfs by passing the request down a layer
> rather than going through generic_file_splice_read() which is going to be
> changed to assume that ->read_folio() is present on buffered files.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: David Hildenbrand <david@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Miklos Szeredi <miklos@szeredi.hu>
> cc: linux-unionfs@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/overlayfs/file.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index c9d0c362c7ef..267b61df6fcd 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -419,6 +419,40 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>         return ret;
>  }
>
> +static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
> +                              struct pipe_inode_info *pipe, size_t len,
> +                              unsigned int flags)
> +{
> +       const struct cred *old_cred;
> +       struct fd real;
> +       ssize_t ret;
> +
> +       ret = ovl_real_fdget(in, &real);
> +       if (ret)
> +               return ret;
> +
> +       ret = -EINVAL;
> +       if (in->f_flags & O_DIRECT &&
> +           !(real.file->f_mode & FMODE_CAN_ODIRECT))
> +               goto out_fdput;

This is unnecessary, as it was already done in ovl_real_fdget() ->
ovl_real_fdget_meta() -> ovl_change_flags().

> +       if (!real.file->f_op->splice_read)
> +               goto out_fdput;
> +
> +       ret = rw_verify_area(READ, in, ppos, len);

Should be on real.file.

> +       if (unlikely(ret < 0))
> +               return ret;

Leaks fd.

> +
> +       old_cred = ovl_override_creds(file_inode(in)->i_sb);
> +       ret = real.file->f_op->splice_read(real.file, ppos, pipe, len, flags);
> +
> +       revert_creds(old_cred);
> +       ovl_file_accessed(in);
> +out_fdput:
> +       fdput(real);
> +
> +       return ret;
> +}
> +
>  /*
>   * Calling iter_file_splice_write() directly from overlay's f_op may deadlock
>   * due to lock order inversion between pipe->mutex in iter_file_splice_write()
> @@ -695,7 +729,7 @@ const struct file_operations ovl_file_operations = {
>         .fallocate      = ovl_fallocate,
>         .fadvise        = ovl_fadvise,
>         .flush          = ovl_flush,
> -       .splice_read    = generic_file_splice_read,
> +       .splice_read    = ovl_splice_read,
>         .splice_write   = ovl_splice_write,
>
>         .copy_file_range        = ovl_copy_file_range,
>
