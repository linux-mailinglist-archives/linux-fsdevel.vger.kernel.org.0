Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFFB6F4B3C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 22:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjEBUUY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 16:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjEBUUX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 16:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B41198C
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 13:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7296961EC7
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 20:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFB2C4339B;
        Tue,  2 May 2023 20:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683058821;
        bh=z461XssVzW/XEURncg76wDBq6FILF6Gn8ehNfF72gE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vz4+7uYIONcA3u9s6aR36EsZcI5nKLTNjgP9NLPPUytecC6uvHDXFPI3L9IMk7Hu9
         Mui7s/cXA1ZlLPk1j25q6XZ2TDipYZBBCozcS4lh9mwP7VJ+ZtuQmKlqDaMCnKj5pR
         Kl/be3X1JjaxcE/424Iu/9XleaXkMmcd2exwRBJU=
Date:   Tue, 2 May 2023 13:20:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm: Do not reclaim private data from pinned page
Message-Id: <20230502132020.5a720158307c11d5b8efe1d9@linux-foundation.org>
In-Reply-To: <20230428124140.30166-1-jack@suse.cz>
References: <20230428124140.30166-1-jack@suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 28 Apr 2023 14:41:40 +0200 Jan Kara <jack@suse.cz> wrote:

> If the page is pinned, there's no point in trying to reclaim it.
> Furthermore if the page is from the page cache we don't want to reclaim
> fs-private data from the page because the pinning process may be writing
> to the page at any time and reclaiming fs private info on a dirty page
> can upset the filesystem (see link below).

Obviously I'll add a cc:stable here.  I'm suspecting it's so old that
there's no real Fixes: target that makes sense?

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1901,6 +1901,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  			}
>  		}
>  
> +		/*
> +		 * Folio is unmapped now so it cannot be newly pinned anymore.
> +		 * No point in trying to reclaim folio if it is pinned.
> +		 * Furthermore we don't want to reclaim underlying fs metadata
> +		 * if the folio is pinned and thus potentially modified by the
> +		 * pinning process as that may upset the filesystem.
> +		 */
> +		if (folio_maybe_dma_pinned(folio))
> +			goto activate_locked;
> +

So I expect the -stable maintainers will be looking for a pre-folios
version of this when the time comes.

