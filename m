Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A977688A6B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 00:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjBBXBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 18:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBBXBj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:01:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DEF7CCAB;
        Thu,  2 Feb 2023 15:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U96BQSukhueTg5b9SilnykHoY2bEaDS7yq/+1W3CybU=; b=EGpW+mYRg6uxPrqK1Bv3tSB4VN
        zRyAddZ+ZtTSYNrRWVblzhiFQbwVbAdpXyuagMzQKte6HckWpoUPXKR8kal8vGocyNZ07H2L9Q6VP
        cWhSbw6kyak1HX5PvGgOo6R6go92gvGAq/hYIHg6VlxdJ8WwEDslmrtOcO0H5ZN5HE4/IZygvUPjU
        O2ZHSFkBb8OX8oqdWM1rNG9hnp6+oMORoSJ3jkXjuYzi6dLmqwfJmjZPJiRKWBxQla3U0kGgcHPB9
        Li3oNK5vm2tfMAL7YwCFdiNigzFxd0LDxhFq29hdt8oKzGhOF2Jp/Se8Mu2dZoUgMrYSUay/cwCUj
        jpJIsojQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNia3-00Dnyf-VY; Thu, 02 Feb 2023 23:01:24 +0000
Date:   Thu, 2 Feb 2023 23:01:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        david@fromorbit.com, dan.j.williams@intel.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH] fsdax: dax_unshare_iter() should return a valid length
Message-ID: <Y9xAw+poZxOyMk1J@casper.infradead.org>
References: <1675341227-14-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675341227-14-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 02, 2023 at 12:33:47PM +0000, Shiyang Ruan wrote:
> The copy_mc_to_kernel() will return 0 if it executed successfully.
> Then the return value should be set to the length it copied.
> 
> Fixes: d984648e428b ("fsdax,xfs: port unshare to fsdax")
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index c48a3a93ab29..a5b4deb5def3 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1274,6 +1274,7 @@ static s64 dax_unshare_iter(struct iomap_iter *iter)
>  	ret = copy_mc_to_kernel(daddr, saddr, length);
>  	if (ret)
>  		ret = -EIO;
> +	ret = length;

Umm.  Surely should be:

	else
		ret = length;

otherwise you've just overwritten the -EIO.

And maybe this should be:

	ret = length - copy_mc_to_kernel(daddr, saddr, length);
	if (ret < length)
		ret = -EIO;

What do you think?
