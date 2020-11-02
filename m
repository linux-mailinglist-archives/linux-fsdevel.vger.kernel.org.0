Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2702A34FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 21:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgKBUOQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 15:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgKBUOQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:14:16 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A785BC0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 12:14:14 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 12so8768967qkl.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 12:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VZ7nDwMeiwbR1b3qQePaTcRxk9HIqyc702Z9EwSs1yc=;
        b=pOiNtPTkYQNgP5/gIzQfShOSv/zRF5Ot42DlqvAIl5+sKQ/z28CYjl3e6KostwhuqI
         ffA8oLPXRmHbTbZGDZ3UOA8zDJVCCVK5YmTOu9SewVQfXsikVy0gLxnMo1FTVwDoiH17
         JLofrUeWHDsFLCKK7HbpYWBKFnABunUTFyC9bAww3qpXzSqprylOFwvrWgzyQlT2Attk
         r3O9xmihHgEMgzHaSAsAkhcwLKpk+TLyURfaZaH4V18zk6yPNyZGbEwcg8GZeokyjklb
         rlfPcDLWOySI03KKQrBkJ6r5mO65eUC5Ckb65BM68OfjsouBvRV41Wc58PZUYUpJOKf4
         myWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VZ7nDwMeiwbR1b3qQePaTcRxk9HIqyc702Z9EwSs1yc=;
        b=ceWADCfepkY4av7k54uD2E/5MAqdh3HH1n2775SgdVyr1vfJbxkMIZWW/B/S/d25LO
         VVVHmreiA7WfhCEI0+/q+ZuLwTeDWzQgBn91KU6fdJAgArbNYWjl0dG1VV+EYS13LDzy
         bZkgwhhAc49NoGVKnCx/6bX0/0YZGiiwzOO8BQwUwlZYUfgtOlPumtwQiiyejbnK0ql3
         G986A5jbfRFkc5sDM0ZoIZGZckvbQQt0BhykhOLlx5wA/27IimiX1IT0ZSmiD1E0HPOp
         3quTzv9aWM9cM4SY/1aQiuzJvzFo/1AiVYXaqv+ZyUzwaQF9yQ721H4cS3zI7a7crc7h
         YG4Q==
X-Gm-Message-State: AOAM531cAUNZsvAY/Uc0w5Lte2KLvufJsst6mS7dZy4v4ZmCpLFAGdPV
        golTKpp7tw3s7qHSr3506w==
X-Google-Smtp-Source: ABdhPJzaZrP7QgGzs8Bf3H55ClDQGO+8Hp5k9NurvTlpcmLD3IfZuqFSBeLZ33CcIdViE6H8fMh4qg==
X-Received: by 2002:a37:8984:: with SMTP id l126mr15730269qkd.443.1604348053978;
        Mon, 02 Nov 2020 12:14:13 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id n63sm8831097qka.45.2020.11.02.12.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:14:13 -0800 (PST)
Date:   Mon, 2 Nov 2020 15:14:11 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 00/17] Refactor generic_file_buffered_read
Message-ID: <20201102201411.GV2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:42:55PM +0000, Matthew Wilcox (Oracle) wrote:
> This is a combination of Christoph's work to refactor
> generic_file_buffered_read() and my THP support on top of Kent's patches
> which are currently in -mm.  I really like where this ended up.

Nice patch series, I had a look at the results in your git tree and I really
like where things ended up too.

> 
> Christoph Hellwig (2):
>   mm/filemap: rename generic_file_buffered_read to filemap_read
>   mm: simplify generic_file_read_iter
> 
> Matthew Wilcox (Oracle) (15):
>   mm/filemap: Rename generic_file_buffered_read subfunctions
>   mm/filemap: Use THPs in generic_file_buffered_read
>   mm/filemap: Pass a sleep state to put_and_wait_on_page_locked
>   mm/filemap: Support readpage splitting a page
>   mm/filemap: Inline __wait_on_page_locked_async into caller
>   mm/filemap: Don't call ->readpage if IOCB_WAITQ is set
>   mm/filemap: Change filemap_read_page calling conventions
>   mm/filemap: Change filemap_create_page arguments
>   mm/filemap: Convert filemap_update_page to return an errno
>   mm/filemap: Move the iocb checks into filemap_update_page
>   mm/filemap: Add filemap_range_uptodate
>   mm/filemap: Split filemap_readahead out of filemap_get_pages
>   mm/filemap: Remove parameters from filemap_update_page()
>   mm/filemap: Restructure filemap_get_pages
>   mm/filemap: Don't relock the page after calling readpage
> 
>  fs/btrfs/file.c         |   2 +-
>  include/linux/fs.h      |   4 +-
>  include/linux/pagemap.h |   3 +-
>  mm/filemap.c            | 493 +++++++++++++++++++---------------------
>  mm/huge_memory.c        |   4 +-
>  mm/migrate.c            |   4 +-
>  6 files changed, 237 insertions(+), 273 deletions(-)
> 
> -- 
> 2.28.0
> 
