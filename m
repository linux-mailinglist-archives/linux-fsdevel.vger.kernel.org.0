Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03357544C91
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 14:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbiFIMus (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 08:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245058AbiFIMue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:50:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE18C2C104
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 05:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654779026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jSyVt04wqMoyKuQwGc4zbS9w9C6qNO7mTJG8w/5DiLs=;
        b=QG9LNwlLX2+zP2FFRisOkQ8oURnxcBY1TVruweSW1Dq+W8cWpiE0sZkktGYQIBMpuTLsTJ
        0M4JZKqwXhsn6G+s9W2m3H5/DIAFpBzDzKIy6i9LNm/Nzc1UsF2YlPG6hLiDnol8j/M/qh
        RvmiyYfBinu7g+c2Hrb2ejzE9aqHdTM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-hDclElawMq-YSEHxuYufYw-1; Thu, 09 Jun 2022 08:50:23 -0400
X-MC-Unique: hDclElawMq-YSEHxuYufYw-1
Received: by mail-wm1-f70.google.com with SMTP id bg13-20020a05600c3c8d00b003974d0ff917so11310223wmb.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jun 2022 05:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=jSyVt04wqMoyKuQwGc4zbS9w9C6qNO7mTJG8w/5DiLs=;
        b=7hWaBDKF8cG5qhgIVqn3GUlEbXlQCAqggennD6rjjkxsROtAei77ZN8IAVxm/Txbvd
         Kjuv+Ow5TTJVs61UqM0whnZGwkk8gKIvWDfOnuYcas0xXJn2SL4c8qW1u8oDjExeXgPe
         /X4YBYowZhg0D26k8QupnlDN2pmmtxtpd6qgob6yQN/FQO4/6lTiyNY9Soab6EjKG0EZ
         Tbru6BqtEpAIgNUKB2tOjSmwCKR1s4cK+OhY5D0pjX7E85t09CDb210CLH8K5ANJZ5+H
         s0GTLGmbVbUzChlwCdb4gABcNo89ygv3aIYfl6tGmRqI4NJiRF+iM7YqpkrGM6S6P77+
         KZOQ==
X-Gm-Message-State: AOAM533nqE7hRUHxGrGnEEwjZYpO90c5u6c7AkIpGfY1derDToktYjJa
        Yb/y8QWL9iGcDe9noPJbZqARPQBNYOQ0QRwUyNzd22TIWH1M/B6pfv0wCbwWS1O6ApreLrdub4C
        ryobTutEZ1P+dN0V6godQkUZnIw==
X-Received: by 2002:a1c:4c0d:0:b0:39c:5233:1873 with SMTP id z13-20020a1c4c0d000000b0039c52331873mr3299344wmf.28.1654779022064;
        Thu, 09 Jun 2022 05:50:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJlGErsfVOd4GnScqiilTH958FLxgjsObuI+18makmIYSKefVpu0HdsVXKQhmSAU7kjNobOQ==
X-Received: by 2002:a1c:4c0d:0:b0:39c:5233:1873 with SMTP id z13-20020a1c4c0d000000b0039c52331873mr3299322wmf.28.1654779021707;
        Thu, 09 Jun 2022 05:50:21 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id j8-20020a056000124800b002185d79dc7fsm5672822wrx.75.2022.06.09.05.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 05:50:21 -0700 (PDT)
Message-ID: <b2a81248-03fc-afb3-1041-d8206e95e08a@redhat.com>
Date:   Thu, 9 Jun 2022 14:50:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 03/19] fs: Add aops->migrate_folio
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>
References: <20220608150249.3033815-1-willy@infradead.org>
 <20220608150249.3033815-4-willy@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220608150249.3033815-4-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.06.22 17:02, Matthew Wilcox (Oracle) wrote:
> Provide a folio-based replacement for aops->migratepage.  Update the
> documentation to document migrate_folio instead of migratepage.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/filesystems/locking.rst |  5 ++--
>  Documentation/filesystems/vfs.rst     | 13 ++++++-----
>  Documentation/vm/page_migration.rst   | 33 ++++++++++++++-------------
>  include/linux/fs.h                    |  4 +++-
>  mm/compaction.c                       |  4 +++-
>  mm/migrate.c                          | 11 +++++----
>  6 files changed, 40 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index c0fe711f14d3..3d28b23676bd 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -253,7 +253,8 @@ prototypes::
>  	void (*free_folio)(struct folio *);
>  	int (*direct_IO)(struct kiocb *, struct iov_iter *iter);
>  	bool (*isolate_page) (struct page *, isolate_mode_t);
> -	int (*migratepage)(struct address_space *, struct page *, struct page *);
> +	int (*migrate_folio)(struct address_space *, struct folio *dst,
> +			struct folio *src, enum migrate_mode);
>  	void (*putback_page) (struct page *);

isolate_page/putback_page are leftovers from the previous patch, no?

>  	int (*launder_folio)(struct folio *);
>  	bool (*is_partially_uptodate)(struct folio *, size_t from, size_t count);
> @@ -281,7 +282,7 @@ release_folio:		yes
>  free_folio:		yes
>  direct_IO:
>  isolate_page:		yes
> -migratepage:		yes (both)
> +migrate_folio:		yes (both)
>  putback_page:		yes

Dito.

>  launder_folio:		yes
>  is_partially_uptodate:	yes
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index a08c652467d7..3ae1b039b03f 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -740,7 +740,8 @@ cache in your filesystem.  The following members are defined:
>  		/* isolate a page for migration */
>  		bool (*isolate_page) (struct page *, isolate_mode_t);
>  		/* migrate the contents of a page to the specified target */
> -		int (*migratepage) (struct page *, struct page *);
> +		int (*migrate_folio)(struct mapping *, struct folio *dst,
> +				struct folio *src, enum migrate_mode);
>  		/* put migration-failed page back to right list */
>  		void (*putback_page) (struct page *);

Dito.

>  		int (*launder_folio) (struct folio *);
> @@ -935,12 +936,12 @@ cache in your filesystem.  The following members are defined:
>  	is successfully isolated, VM marks the page as PG_isolated via
>  	__SetPageIsolated.
>  
> -``migrate_page``
> +``migrate_folio``
>  	This is used to compact the physical memory usage.  If the VM
> -	wants to relocate a page (maybe off a memory card that is
> -	signalling imminent failure) it will pass a new page and an old
> -	page to this function.  migrate_page should transfer any private
> -	data across and update any references that it has to the page.
> +	wants to relocate a folio (maybe from a memory device that is
> +	signalling imminent failure) it will pass a new folio and an old
> +	folio to this function.  migrate_folio should transfer any private
> +	data across and update any references that it has to the folio.
>  
>  ``putback_page``
>  	Called by the VM when isolated page's migration fails.

Dito.

> diff --git a/Documentation/vm/page_migration.rst b/Documentation/vm/page_migration.rst
> index 8c5cb8147e55..e0f73ddfabb1 100644
> --- a/Documentation/vm/page_migration.rst
> +++ b/Documentation/vm/page_migration.rst
> @@ -181,22 +181,23 @@ which are function pointers of struct address_space_operations.
>     Once page is successfully isolated, VM uses page.lru fields so driver
>     shouldn't expect to preserve values in those fields.
>  
> -2. ``int (*migratepage) (struct address_space *mapping,``
> -|	``struct page *newpage, struct page *oldpage, enum migrate_mode);``
> -
> -   After isolation, VM calls migratepage() of driver with the isolated page.
> -   The function of migratepage() is to move the contents of the old page to the
> -   new page
> -   and set up fields of struct page newpage. Keep in mind that you should
> -   indicate to the VM the oldpage is no longer movable via __ClearPageMovable()
> -   under page_lock if you migrated the oldpage successfully and returned
> -   MIGRATEPAGE_SUCCESS. If driver cannot migrate the page at the moment, driver
> -   can return -EAGAIN. On -EAGAIN, VM will retry page migration in a short time
> -   because VM interprets -EAGAIN as "temporary migration failure". On returning
> -   any error except -EAGAIN, VM will give up the page migration without
> -   retrying.
> -
> -   Driver shouldn't touch the page.lru field while in the migratepage() function.
> +2. ``int (*migrate_folio) (struct address_space *mapping,``
> +|	``struct folio *dst, struct folio *src, enum migrate_mode);``
> +
> +   After isolation, VM calls the driver's migrate_folio() with the
> +   isolated folio.  The purpose of migrate_folio() is to move the contents
> +   of the source folio to the destination folio and set up the fields
> +   of destination folio.  Keep in mind that you should indicate to the
> +   VM the source folio is no longer movable via __ClearPageMovable()
> +   under folio if you migrated the source successfully and returned
> +   MIGRATEPAGE_SUCCESS.  If driver cannot migrate the folio at the
> +   moment, driver can return -EAGAIN. On -EAGAIN, VM will retry folio
> +   migration in a short time because VM interprets -EAGAIN as "temporary
> +   migration failure".  On returning any error except -EAGAIN, VM will
> +   give up the folio migration without retrying.
> +
> +   Driver shouldn't touch the folio.lru field while in the migrate_folio()
> +   function.
>  
>  3. ``void (*putback_page)(struct page *);``

Hmm, here it's a bit more complicated now, because we essentially have
two paths: LRU+migrate_folio or !LRU+movable_ops
(isolate/migrate/putback page)



-- 
Thanks,

David / dhildenb

