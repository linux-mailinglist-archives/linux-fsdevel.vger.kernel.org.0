Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451CE6BECFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 16:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCQPcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 11:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjCQPcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:32:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F6461A84;
        Fri, 17 Mar 2023 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=inUvHEu4HUOp2iy8ZcRjHwFFv7P6+MbAHF55eOD5Mdw=; b=eIu8cVVErxdUVQNrKy4EFwDue/
        RJ0stM0TyUWl3VnVLFZYeOvuOTwJ2udGzfFYdyBTVKHhNKVK3VUUJ9izcE+n1jzCKOI/OyC/hbtl4
        pEzeWP1fDuv16Nh3tjqz7wfZDBzAamimQM6/6ar6GVSIC0hPeKTQjlIEnwPS7f4OSrgTpHE++8FlP
        sLbqg6taQ64TtHMZPTdjIDzRCuLAZnbC3jfhWveMaoQD1r3kPvtYOrRS7XJg3PGvrSVexghCtAKXO
        U/HqBzlSgYAz68iJFK6bhwPOrd85yzZxGvJxAq/+c5NlE7oLGtqw8yNKS+M4tzox1RZJZsPiarZoa
        qKVFIlnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pdC3d-00Fzmq-V3; Fri, 17 Mar 2023 15:31:54 +0000
Date:   Fri, 17 Mar 2023 15:31:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Christoph Hellwig <hch@infradead.org>, hubcap@omnibond.com,
        senozhatsky@chromium.org, martin@omnibond.com, minchan@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, axboe@kernel.dk,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, gost.dev@samsung.com, mcgrof@kernel.org,
        devel@lists.orangefs.org
Subject: Re: [RFC PATCH 1/3] filemap: convert page_endio to folio_endio
Message-ID: <ZBSH6Uq6IIXON/rh@casper.infradead.org>
References: <20230315123233.121593-1-p.raghav@samsung.com>
 <CGME20230315123234eucas1p2503d83ad0180cecde02e924d7b143535@eucas1p2.samsung.com>
 <20230315123233.121593-2-p.raghav@samsung.com>
 <ZBHcl8Pz2ULb4RGD@infradead.org>
 <d6cde35e-359a-e837-d2e0-f2bd362f2c3e@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6cde35e-359a-e837-d2e0-f2bd362f2c3e@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 16, 2023 at 11:04:54AM +0100, Pankaj Raghav wrote:
> -       /* clean up. */
> -       while ((page = readahead_page(rac))) {
> -               page_endio(page, false, ret);
> -               put_page(page);
> +               while ((folio = readahead_folio(rac))) {
> +                       folio_clear_uptodate(folio);
> +                       folio_set_error(folio);
> +                       folio_unlock(folio);
> +               }
> +               return;
> +       }
> +
> +       while ((folio = readahead_folio(rac))) {
> +               folio_mark_uptodate(folio);
> +               folio_unlock(folio);
>         }

readahead_folio() is a bit too heavy-weight for that, IMO.  I'd do this
as;

	while ((folio = readahead_folio(rac))) {
		if (!ret)
			folio_mark_uptodate(folio);
		folio_unlock(folio);
	}

(there's no need to call folio_set_error(), nor folio_clear_uptodate())
