Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57304E4F63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 10:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243275AbiCWJbF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 05:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238098AbiCWJbF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:31:05 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD316213E;
        Wed, 23 Mar 2022 02:29:35 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2e64a6b20eeso10108077b3.3;
        Wed, 23 Mar 2022 02:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RTdntLwWP7UcoqdxIbtO2gBEwkCYFZ/lgUjrNqmrzxY=;
        b=T61hvAd7cJiSJIGmZk3tv26qPToF8HN5U/lQ/m08EAvWa2SmtE6To2nDTNf374lnhT
         GPKcxTCuuPtJXa5gmEw+gX2f1CnhO+VLeiTWr2XmuaL6dVuTtvBLqYJtSXHPPzFlHs5d
         Ri/6Ne7YUODQm8T3VMLlOYE4KOjFASZnLeZ8IqhaE9iuhu7q9KNKFvXczv/h7Sgwfpuk
         P+Ovst/9RkkokTnzdrENQ2gJQlJX7TsW9sSFizNo9ppyZqVHj+5ghhwpu4GTzkQKNuQt
         kjsxCrJT+nOf4qUF+msiy+R5Tj/zMWQPy3RSPf7HIGYLtyZhwIakdPpQAIpFcLhlFiZB
         DguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTdntLwWP7UcoqdxIbtO2gBEwkCYFZ/lgUjrNqmrzxY=;
        b=qypTNF9dh1L6sa75Cer/YX4VSQGLoJCifVbTmABDtyD7UZ+C67wYVHM6sta0TLaqqX
         PMj2+lPfRJ9L0lyCD9ff9Q5vL2L6UzzJglkIUHzFqp9faI0GLtjRr6I6G+hUBPn/wLxc
         Tqgjk/NTjwUrsQEHLHAjl1nzcmzBITCV6BoG6Rt4u9KS7o9w+n/uGS3uG3QYalyhfETb
         IY4ke6sTxRJmMHNpMrRmu/4Evhp1PuZrp6/zBohF7dqAZ+WrDzieHzuGGx72AFn/ArKS
         spvgjmZYjX0OHYo9UBWDVtiVO8laK3Mv2KqhoJhRZIkVvm3ucb73d7ZM7O/axBETbXMt
         5qgQ==
X-Gm-Message-State: AOAM530JFmh5NORM5ZVh+pt7+5AD8TJasIIE64vXJ/Hwj3FJAFxe4CEz
        0nLrxAFHvH95BbXpeYyiNQx7KCsBoXQ7n+EN9FA=
X-Google-Smtp-Source: ABdhPJxsStnlEm2/XrSzPGOBMOTw5PlnKDFjWTj/c9kKouVbhUo8itraPrOCZBSFmdgor+QYZSqQ1SYIOcVDz/aGNlE=
X-Received: by 2002:a0d:c284:0:b0:2dc:37ec:f02c with SMTP id
 e126-20020a0dc284000000b002dc37ecf02cmr33701891ywd.503.1648027774854; Wed, 23
 Mar 2022 02:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220124091107.642561-1-hch@lst.de> <20220124091107.642561-2-hch@lst.de>
 <20220322211915.GA2413063@roeck-us.net> <CAKFNMonRd5QQMzLoH3T=M=C=2Q_j9d86EYzZeY4DU2HQAE3E8w@mail.gmail.com>
 <20220323064248.GA24874@lst.de>
In-Reply-To: <20220323064248.GA24874@lst.de>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 23 Mar 2022 18:29:23 +0900
Message-ID: <CAKFNMonANUN7_99oVBOq=iCJpt6jQs3qhu1ez5SwMm2g7sZUyw@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH 01/19] fs: remove mpage_alloc
To:     Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nfs@vger.kernel.org,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.co>,
        device-mapper development <dm-devel@redhat.com>,
        "Md . Haris Iqbal" <haris.iqbal@ionos.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        ntfs3@lists.linux.dev, Jack Wang <jinpu.wang@ionos.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 3:42 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Mar 23, 2022 at 06:38:22AM +0900, Ryusuke Konishi wrote:
> > This looks because the mask of GFP_KERNEL is removed along with
> > the removal of mpage_alloc().
> >
>
> > The default value of the gfp flag is set to GFP_HIGHUSER_MOVABLE by
> > inode_init_always().
> > So, __GFP_HIGHMEM hits the gfp warning at bio_alloc() that
> > do_mpage_readpage() calls.
>
> Yeah.  Let's try this to match the iomap code:
>
> diff --git a/fs/mpage.c b/fs/mpage.c
> index 9ed1e58e8d70b..d465883edf719 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -148,13 +148,11 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>         int op = REQ_OP_READ;
>         unsigned nblocks;
>         unsigned relative_block;
> -       gfp_t gfp;
> +       gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
>
>         if (args->is_readahead) {
>                 op |= REQ_RAHEAD;
> -               gfp = readahead_gfp_mask(page->mapping);
> -       } else {
> -               gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
> +               gfp |= __GFP_NORETRY | __GFP_NOWARN;
>         }
>
>         if (page_has_buffers(page))

I did not test for iomap, but this patch has fixed the same regression on the
latest mainline at least for ext2, exfat, vfat and nilfs2.  Thanks!

Ryusuke Konishi
