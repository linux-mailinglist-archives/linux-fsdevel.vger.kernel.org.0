Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D856E6D6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 22:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjDRUXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 16:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjDRUXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:23:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D20213F
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 13:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B4A662C64
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 20:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C69AC433D2;
        Tue, 18 Apr 2023 20:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681849402;
        bh=xe57lYTArGPQSZ0c8toSVkf0QUEBjrXjOaskLu5n/BM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JmC4y8FGADpzgu1WMdNmMtEdSkx7lNFFwm0lEObXmRFviYGd/YE+LQICPcbJGtZoU
         6fCanqJrxCIzOEKHW1JfoySmHOTRWIBkikFoSC4oC5bUdoXLyQwV2vbbRyDiKrooul
         wtr5zB7UobW4C/Ql0Dc4s9BU6zogO3T8ZB5B780w=
Date:   Tue, 18 Apr 2023 13:23:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, tytso@mit.edu, broonie@kernel.org,
        sfr@canb.auug.org.au, hch@lst.de,
        Eric Biggers <ebiggers@kernel.org>,
        syzbot+d1ae544e6e9dc29bcba5@syzkaller.appspotmail.com,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH] ext4: Handle error pointers being returned from
 __filemap_get_folio
Message-Id: <20230418132321.4cfac3c19488c158a9e08281@linux-foundation.org>
In-Reply-To: <20230418200636.3006418-1-willy@infradead.org>
References: <20230418200636.3006418-1-willy@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 18 Apr 2023 21:06:35 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> Commit "mm: return an ERR_PTR from __filemap_get_folio" changed from
> returning NULL to returning an ERR_PTR().  This cannot be fixed in either
> the ext4 tree or the mm tree, so this patch should be applied as part
> of merging the two trees.

Well that's awkward.

> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -566,8 +566,9 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
>  	 * started */
>  	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
>  			mapping_gfp_mask(mapping));
> -	if (!folio) {
> -		ret = -ENOMEM;
> +	if (IS_ERR(folio)) {
> +		ret = PTR_ERR(folio);
> +		folio = NULL;
>  		goto out;
>  	}

I suppose this could go into the ext4 tree, with IS_ERR_OR_NULL and a
FIXME for later.

Or linux-next can carry it as one of its merge/build/other resolution
patches?

