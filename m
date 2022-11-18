Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D4962EE4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 08:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241135AbiKRH2f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 02:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRH2d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:28:33 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC6712AF4;
        Thu, 17 Nov 2022 23:28:33 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-370547b8ca0so42388627b3.0;
        Thu, 17 Nov 2022 23:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fIq4B8jpHjtTC9rO6U/0HlBjNi37g7n6MUt5O1wpmQg=;
        b=dm0GlyXu/u1A7mUk7Kpzb+S9xN11ABAeHAmQ2R3TECYaO4UN8w7kl4nBwhGUMUASxx
         te6IE0BM0UWzsm64/VfhthqpIEX8zbzCz/09hxY4uBcInKWKdv2uBzWA29Yn0SxS03Kg
         S9JZQaZVmf2WCVlkinYCE/wuUriZmhJqhpazgkslkUvfx+zfWDqooBKhJV7X6Tvr1Ymq
         BjbjUu7DaLLtzdykxn8SzyctnXGsiB/6VL3bdhJCpEsKpVsVPAICFrMO4rPrxSaqN1Gm
         MBStvVruu7+oqD1a8AvZqm+CRqsJjq9Bci/HjCkvO4W6XOL1U3iv4KHZiZHGXFBtElZC
         k6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIq4B8jpHjtTC9rO6U/0HlBjNi37g7n6MUt5O1wpmQg=;
        b=pTQAkiQweCFMJ4uEdRPgcKEY3cx9CD0wRnIy6arr2fI7tbanK02in3Cz0FUievlkvI
         SCptzvBwqDqACIuN7csiX4hUXzkjpQRX/cHsyWunVQ34p96b8PJhHbVsCJxSSs0ziMXS
         1WyN/xmPCip4jiy1JKPLwtIiJLRnuYG1O2tJvvy/rhu7+EpiNBA6Qr489ftjbbyMhe0y
         ffYlNqSAQFfiBRWlkb/i7DvoY7LdwnT+wftHuw7dHm0Yjf+9tbny8HMZ8OO/0Vsn768Y
         RPMBmAC+TWC2AbKZRSOmJv6OwTIOteZNhSoxJk3y16dUIsFNgvWMhPcyW76DSUdtf9gN
         awWQ==
X-Gm-Message-State: ANoB5plpry3lwJV2bHUEn15Qw8gHSlZzWuvqJCvaaWaxZ9wiE6yvi5Da
        qXRqZ/E+EC0Ixh6eCXyKWBAeClXIjwSvxO5qvmkDuZOwaN8=
X-Google-Smtp-Source: AA0mqf73sdMy68XJbQb5H8Jg1dOLOXOpr9ua8cw7FhlPmjQN4idUvFlr60RJSMN1hAftvDfbKPSOXxzi93FI47+WTgY=
X-Received: by 2002:a81:c206:0:b0:38d:c23a:c541 with SMTP id
 z6-20020a81c206000000b0038dc23ac541mr5412773ywc.109.1668756512447; Thu, 17
 Nov 2022 23:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20221118021410.24420-1-vishal.moola@gmail.com> <20221118021410.24420-2-vishal.moola@gmail.com>
In-Reply-To: <20221118021410.24420-2-vishal.moola@gmail.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Thu, 17 Nov 2022 23:28:21 -0800
Message-ID: <CAOzc2pxYSpQGEEads3qfxyJgdcDzMoEyTg01Z3D2ZaAjUSOznw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ext4: Convert move_extent_per_page() to use folios
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, naoya.horiguchi@nec.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 17, 2022 at 6:14 PM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
>
> Converts move_extent_per_page() to use folios. This change removes
> 5 calls to compound_head() and is in preparation for the removal of
> the try_to_release_page() wrapper.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  fs/ext4/move_extent.c | 52 ++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 21 deletions(-)
>
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 044e34cd835c..aa67eb240ca6 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -253,6 +253,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
>  {
>         struct inode *orig_inode = file_inode(o_filp);
>         struct page *pagep[2] = {NULL, NULL};
> +       struct folio *folio[2] = {NULL, NULL};
>         handle_t *handle;
>         ext4_lblk_t orig_blk_offset, donor_blk_offset;
>         unsigned long blocksize = orig_inode->i_sb->s_blocksize;
> @@ -313,6 +314,13 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
>          * hold page's lock, if it is still the case data copy is not
>          * necessary, just swap data blocks between orig and donor.
>          */
> +       folio[0] = page_folio(pagep[0]);
> +       folio[1] = page_folio(pagep[1]);
> +
> +       VM_BUG_ON_FOLIO(!folio_test_large(folio[0]), folio[0]);
> +       VM_BUG_ON_FOLIO(!folio_test_large(folio[1]), folio[1]);
> +       VM_BUG_ON_FOLIO(folio_nr_pages(folio[0]) != folio_nr_pages(folio[1]), folio[1]);

Looks like I got my assertions backward. We want to BUG if the folios are large,
or if they are different sizes. Disregard v2, its fixed in v3.
