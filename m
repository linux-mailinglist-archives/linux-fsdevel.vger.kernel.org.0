Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947964C8C22
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 14:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbiCANBT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 08:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiCANBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:01:17 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC28F9A4DC
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 05:00:35 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id f2so12476421ilq.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Mar 2022 05:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QG2k2eItwE4VAk3PGGex6QHZy3T0xaD3lTCoY/HpYco=;
        b=ZQjeLrdHbWEck4K6RpeBY4QI1uE5CcoVwO5sZTKvbH0jCtE/epL+AV1J2T6nTvQB7B
         /yPS0KVOUZAhUGfHU54H1jmlgYJUgdfLLmM3xmB3rY9RzzFoWNFI2Zci83Jzu2Okp0E4
         AJRAtv/WKjpa/XnIsui/qXUZ2c4GyPza8OAZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QG2k2eItwE4VAk3PGGex6QHZy3T0xaD3lTCoY/HpYco=;
        b=GfDJBqOY37zsjwZ/5gyZJp8qYpnb0YBAcrmEOU1J/icoJ/QHVCtsGweGUQIZv49R5o
         iDSRAIX/G+Yx1Apwt2loxbkmpxx5Ft3GzhLaf4MS3sY9pPYgdQb1PYDNX2khyHpsvdi3
         2V3wG++qMQ8Ldhuy8aXK2WbJLiLIHA0wJJAz75GtH6hkDr4fVPsKLBtcgMlXJxRsObzx
         I41zzns7ymFS7dRRRhkVm3CCbFOAObU2jsY2RZiFJ3lw3xpufOdNg6JA0NpSDjlg8Mnd
         W2XwL2ENAT4ihrRMrLlt1BP7Yh0g1XWHcrE2bsooQ8NCUxin2mMSOiUn47hQ3PnmOqHS
         Z1Nw==
X-Gm-Message-State: AOAM533ZV5jJ59FR9GL5/1TFfmd6k2suxaDrdhTdKh+XhgO6bM8inAVg
        xen2L7choAdrEW7d8YiOHJn5NcrPB4mv9V9oo1uB1A==
X-Google-Smtp-Source: ABdhPJygTkLKJoxpKoMnQComCB9wJUKiAgXMWJlY4Oqe0COwyi0CYb7/OKDFQvAmbtgocYjrHTjH3LgZXlKpwAjqw/Q=
X-Received: by 2002:a92:cf12:0:b0:2be:3a27:67c7 with SMTP id
 c18-20020a92cf12000000b002be3a2767c7mr23363367ilo.187.1646139635155; Tue, 01
 Mar 2022 05:00:35 -0800 (PST)
MIME-Version: 1.0
References: <164549971112.9187.16871723439770288255.stgit@noble.brown> <164549983736.9187.16755913785880819183.stgit@noble.brown>
In-Reply-To: <164549983736.9187.16755913785880819183.stgit@noble.brown>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 1 Mar 2022 14:00:24 +0100
Message-ID: <CAJfpegs=DhCO62EFV0Q_i2fmqJnziJy1t4itP9deS=FuWEA=TQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] MM: improve cleanup when ->readpages doesn't
 process all pages.
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, linux-nilfs@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Ext4 <linux-ext4@vger.kernel.org>, ceph-devel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 22 Feb 2022 at 04:18, NeilBrown <neilb@suse.de> wrote:
>
> If ->readpages doesn't process all the pages, then it is best to act as
> though they weren't requested so that a subsequent readahead can try
> again.
> So:
>   - remove any 'ahead' pages from the page cache so they can be loaded
>     with ->readahead() rather then multiple ->read()s
>   - update the file_ra_state to reflect the reads that were actually
>     submitted.
>
> This allows ->readpages() to abort early due e.g.  to congestion, which
> will then allow us to remove the inode_read_congested() test from
> page_Cache_async_ra().
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  mm/readahead.c |   19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 73b2bc5302e0..8a97bd408cf6 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -104,7 +104,13 @@
>   * for necessary resources (e.g.  memory or indexing information) to
>   * become available.  Pages in the final ``async_size`` may be
>   * considered less urgent and failure to read them is more acceptable.
> - * They will eventually be read individually using ->readpage().
> + * In this case it is best to use delete_from_page_cache() to remove the
> + * pages from the page cache as is automatically done for pages that
> + * were not fetched with readahead_page().  This will allow a
> + * subsequent synchronous read ahead request to try them again.  If they
> + * are left in the page cache, then they will be read individually using
> + * ->readpage().
> + *
>   */
>
>  #include <linux/kernel.h>
> @@ -226,8 +232,17 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
>
>         if (aops->readahead) {
>                 aops->readahead(rac);
> -               /* Clean up the remaining pages */
> +               /*
> +                * Clean up the remaining pages.  The sizes in ->ra
> +                * maybe be used to size next read-ahead, so make sure
> +                * they accurately reflect what happened.
> +                */
>                 while ((page = readahead_page(rac))) {
> +                       rac->ra->size -= 1;
> +                       if (rac->ra->async_size > 0) {
> +                               rac->ra->async_size -= 1;
> +                               delete_from_page_cache(page);
> +                       }

Does the  above imply that filesystem should submit at least ra->size
pages, regardless of congestion?

Thanks,
Miklos
