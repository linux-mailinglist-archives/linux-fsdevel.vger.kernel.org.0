Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E407A65A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjISNq3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjISNpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:45:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089F21705;
        Tue, 19 Sep 2023 06:45:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D30AC433C7;
        Tue, 19 Sep 2023 13:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695131121;
        bh=OybuJ/1CROEohwO1HH6Q9qlnvxL/LKquxrCtwmVMmy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nw8gIBr+9CIzNnoWO5EnSo8AN8gVp9Kv/RPxW69tyOqUZYGgK1Q2URee0GA3L2GOy
         22T1NAuiPRQ+OU0I8P5K9xE4xeDnM67oPTCGqEQNJFRLQdgtzqQkAjD1cyXM2MAJ77
         HlZHHwrPitaZy8+EeuY4Zau65fgG0PehuFelN+5A7W10j4cRwiavwcI9tsB+Kd8GN5
         CeZLsxS2TnI4GIQKJ6/fF4NYXUsodkiCIRVjEOmuWx5xsT5hd588XWpawbRLrLQ4Qo
         5/NBZVKAsnqJh69/YgpFCQaXuMNeS3C0gdR/Sb+XbQu6qE2H4EatHlEoPvUVGp18jh
         P7KQNCJGJ/BGQ==
Date:   Tue, 19 Sep 2023 15:45:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] pipe_fs_i.h: add pipe_buf_init()
Message-ID: <20230919-fachkenntnis-seenotrettung-3f873c1ec8da@brauner>
References: <20230919080707.1077426-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230919080707.1077426-1-max.kellermann@ionos.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> diff --git a/mm/filemap.c b/mm/filemap.c
> index 582f5317ff71..74532e0cb8d7 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2850,12 +2850,8 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
>  		struct pipe_buffer *buf = pipe_head_buf(pipe);
>  		size_t part = min_t(size_t, PAGE_SIZE - offset, size - spliced);
>  
> -		*buf = (struct pipe_buffer) {
> -			.ops	= &page_cache_pipe_buf_ops,
> -			.page	= page,
> -			.offset	= offset,
> -			.len	= part,
> -		};
> +		pipe_buf_init(buf, page, offset, part,
> +			      &page_cache_pipe_buf_ops, 0);
>  		folio_get(folio);
>  		pipe->head++;
>  		page++;
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 02e62fccc80d..75d39653b028 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2901,12 +2901,9 @@ static size_t splice_zeropage_into_pipe(struct pipe_inode_info *pipe,
>  	if (!pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
>  		struct pipe_buffer *buf = pipe_head_buf(pipe);
>  
> -		*buf = (struct pipe_buffer) {
> -			.ops	= &zero_pipe_buf_ops,
> -			.page	= ZERO_PAGE(0),
> -			.offset	= offset,
> -			.len	= size,
> -		};
> +		pipe_buf_init(buf, ZERO_PAGE(0),
> +			      offset, size,
> +			      &zero_pipe_buf_ops, 0);
>  		pipe->head++;
>  	}

So this may cause issues because the compound literal will cause all non
explicitly initialized fields to be initialized to zero values whereas
your new helper wouldn't. So pipe_buf->private may now contain garbage.
Not ideal imho. Does the helper buy us that much overall?
