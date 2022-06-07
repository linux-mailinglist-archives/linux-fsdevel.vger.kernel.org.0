Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5672541A5B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 23:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377901AbiFGVcp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 17:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380746AbiFGVbM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:31:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C70822AE41;
        Tue,  7 Jun 2022 12:03:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m26so13980608wrb.4;
        Tue, 07 Jun 2022 12:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YvJr1HjhCxOrlCoCkGFSV+IIsFWm48YyeI3AKcRnUIQ=;
        b=Hms/G7n+Cgo9Oo8KkEEkY+zOKSfNSr0x2sJyW+zhwaVgQz3O94b2GcLqEXQ5rpNStl
         0HKAm9+ZoLlNQPtIgr4cociDPkwCkncIQHflys8+rX7ekkN9msPRJi3y7Z32ZVcY4EiS
         7BqJ/vQjOoHIBqnzmxcFtWqT7QYEfBo1Q/O2ARB7Zezb9YKydEPEtT4frki2lnbWxGbh
         +l4HGgVODycuk5l12Ov27ifMex6LzR4b2/m50DSQAyRbCNVvVRI16BLqIO5hxeYWqMZf
         1B5FmkDuafNHVx7eJh5UtqIQKDfI2oiQry9cQbb6BsPHPbHKrMcf9dIskCLmEL3K7DH1
         6oNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YvJr1HjhCxOrlCoCkGFSV+IIsFWm48YyeI3AKcRnUIQ=;
        b=DIYfuo3zHhXm0kxxbEBtJtyx6IyhTTpKGeEoNhHAM9ncitOxQvoIhcM8yF0Np3zdLd
         70tQILsSWCgXNPMGxpY5HpiWbAd58wEoZgV1XaGmlO3eyC3kuZLqQE5sqowhO1xUvF6H
         uBABo5tXEPn6gFb6oGqf6MDGIwH0hLuGEt8okXxFY7gWEitZljAjG9ex//z68kw9CNhh
         4MVvvV/xVHtGzAMHa/W3EpTlAUblNnfAO9HkkGHy6yqVr+9LIUwCmK3G+kMfYp6d9VNF
         PI1MA+tMp+U4t7KgH4sgCxVszR3JCIFh5hMnQeE9HXly80sFgJ2Qv8O+kgLfSe3vHiDw
         s7qA==
X-Gm-Message-State: AOAM5329wag/9ouEN6sPFCUufn5/SIeOTeRXdSzvqwQ3ztChRVLXpflV
        OmuSokHQR98TgutBSsdnDJuSLuF4e73dRFA5smw=
X-Google-Smtp-Source: ABdhPJzCEhxBgnE2TvKp0j//I+yGIGt10PvMUBcSniQ/uliTPAhBtZXCX4ft7FKRwzuXla8IHTC/85U5DKgXrpVCjbg=
X-Received: by 2002:a5d:62c7:0:b0:216:fa41:2f81 with SMTP id
 o7-20020a5d62c7000000b00216fa412f81mr17337284wrv.249.1654628595478; Tue, 07
 Jun 2022 12:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220606204050.2625949-1-willy@infradead.org> <20220606204050.2625949-8-willy@infradead.org>
In-Reply-To: <20220606204050.2625949-8-willy@infradead.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Tue, 7 Jun 2022 15:02:59 -0400
Message-ID: <CAFX2Jf=ugChaWF0Je=ew_-shhdSJYXy5dkjqsoL=9B37QWv3bA@mail.gmail.com>
Subject: Re: [PATCH 07/20] nfs: Convert to migrate_folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
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

On Mon, Jun 6, 2022 at 7:37 PM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Use a folio throughout this function.  migrate_page() will be converted
> later.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks fairly straightforward.

Acked-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

> ---
>  fs/nfs/file.c     |  4 +---
>  fs/nfs/internal.h |  6 ++++--
>  fs/nfs/write.c    | 16 ++++++++--------
>  3 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index 2d72b1b7ed74..549baed76351 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -533,9 +533,7 @@ const struct address_space_operations nfs_file_aops = {
>         .write_end = nfs_write_end,
>         .invalidate_folio = nfs_invalidate_folio,
>         .release_folio = nfs_release_folio,
> -#ifdef CONFIG_MIGRATION
> -       .migratepage = nfs_migrate_page,
> -#endif
> +       .migrate_folio = nfs_migrate_folio,
>         .launder_folio = nfs_launder_folio,
>         .is_dirty_writeback = nfs_check_dirty_writeback,
>         .error_remove_page = generic_error_remove_page,
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 8f8cd6e2d4db..437ebe544aaf 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -578,8 +578,10 @@ void nfs_clear_pnfs_ds_commit_verifiers(struct pnfs_ds_commit_info *cinfo)
>  #endif
>
>  #ifdef CONFIG_MIGRATION
> -extern int nfs_migrate_page(struct address_space *,
> -               struct page *, struct page *, enum migrate_mode);
> +int nfs_migrate_folio(struct address_space *, struct folio *dst,
> +               struct folio *src, enum migrate_mode);
> +#else
> +#define nfs_migrate_folio NULL
>  #endif
>
>  static inline int
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 1c706465d090..649b9e633459 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -2119,27 +2119,27 @@ int nfs_wb_page(struct inode *inode, struct page *page)
>  }
>
>  #ifdef CONFIG_MIGRATION
> -int nfs_migrate_page(struct address_space *mapping, struct page *newpage,
> -               struct page *page, enum migrate_mode mode)
> +int nfs_migrate_folio(struct address_space *mapping, struct folio *dst,
> +               struct folio *src, enum migrate_mode mode)
>  {
>         /*
> -        * If PagePrivate is set, then the page is currently associated with
> +        * If the private flag is set, the folio is currently associated with
>          * an in-progress read or write request. Don't try to migrate it.
>          *
>          * FIXME: we could do this in principle, but we'll need a way to ensure
>          *        that we can safely release the inode reference while holding
> -        *        the page lock.
> +        *        the folio lock.
>          */
> -       if (PagePrivate(page))
> +       if (folio_test_private(src))
>                 return -EBUSY;
>
> -       if (PageFsCache(page)) {
> +       if (folio_test_fscache(src)) {
>                 if (mode == MIGRATE_ASYNC)
>                         return -EBUSY;
> -               wait_on_page_fscache(page);
> +               folio_wait_fscache(src);
>         }
>
> -       return migrate_page(mapping, newpage, page, mode);
> +       return migrate_page(mapping, &dst->page, &src->page, mode);
>  }
>  #endif
>
> --
> 2.35.1
>
