Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B046D271E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 19:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjCaRyV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 13:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjCaRyU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:54:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEDA1A453;
        Fri, 31 Mar 2023 10:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D08B962AF4;
        Fri, 31 Mar 2023 17:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9B9C433AA;
        Fri, 31 Mar 2023 17:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680285257;
        bh=Ijr+WNx7ld4U5ZO+OP83Langs78qK2JwUNbqX48Y74E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NlUsYXunWuWGa5qJtzHr2cVFf2mzdtZdXDwqqDzEtj1erN4/UEH5oBLlA+R2q+o1M
         an2FD0E0FdazXGvuATGaJmC6tuT0zRlQ77fXpvY6pFX1I42bhRwtRYb4EwVwsSCshv
         /w7kqF7Q3A9R8Y/I8mdEGr3HrwyFsaYA6YJOFbpxZM1X9TKmHN/m1uW21mhvN0lJMK
         W/4KbeJ5FOFz+PGsFgDTzifZVWsSERPeuLJNL5OC6eK7xe2WmPdFCF+EV4iuGiHj1+
         6zB4x/ZbN1oFJEdXH97hYDgTq4gsGJ14oSMEKjopTYWGs3WLQoStd3EbVOC7opi8re
         k+Npd+3KW4cdA==
Received: by mail-lf1-f44.google.com with SMTP id c9so19523126lfb.1;
        Fri, 31 Mar 2023 10:54:17 -0700 (PDT)
X-Gm-Message-State: AAQBX9cEEI7El3iei4b7177WNMJsNMfSrtfbAb0MAFju7Ui/J6ACt5dV
        r9xU4T8J6lHjGciZXzKFH1wKvIOOyyZkKhCxHB0=
X-Google-Smtp-Source: AKy350YvKqb0dBoMYfGdDtedXvU05FWt6KdyndNuIJije8MdSUJrkHi6AamvXBmeJg5t6pczjm2RarPTQzd6MOIJepA=
X-Received: by 2002:ac2:5610:0:b0:4dd:a4e1:4861 with SMTP id
 v16-20020ac25610000000b004dda4e14861mr8234430lfd.3.1680285255256; Fri, 31 Mar
 2023 10:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680172791.git.johannes.thumshirn@wdc.com> <07ae41b981f1b5f8de80a3f0a8ab2f34034077a6.1680172791.git.johannes.thumshirn@wdc.com>
In-Reply-To: <07ae41b981f1b5f8de80a3f0a8ab2f34034077a6.1680172791.git.johannes.thumshirn@wdc.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 31 Mar 2023 10:54:03 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4gxjRx-X6d46O7SsNb=nesrUKVv+s76C1DtkZdcGmyXw@mail.gmail.com>
Message-ID: <CAPhsuW4gxjRx-X6d46O7SsNb=nesrUKVv+s76C1DtkZdcGmyXw@mail.gmail.com>
Subject: Re: [PATCH v2 15/19] md: check for failure when adding pages in alloc_behind_master_bio
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 3:44=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> alloc_behind_master_bio() can possibly add multiple pages to a bio, but i=
t
> is not checking for the return value of bio_add_page() if adding really
> succeeded.
>
> Check if the page adding succeeded and if not bail out.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/md/raid1.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 68a9e2d9985b..bd7c339a84a1 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1147,7 +1147,8 @@ static void alloc_behind_master_bio(struct r1bio *r=
1_bio,
>                 if (unlikely(!page))
>                         goto free_pages;
>
> -               bio_add_page(behind_bio, page, len, 0);
> +               if (!bio_add_page(behind_bio, page, len, 0))
> +                       goto free_pages;

We will leak page here, no?

Thanks,
Song
