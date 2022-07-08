Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D8E56B0B8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 04:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbiGHCuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 22:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbiGHCug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 22:50:36 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4DD7478B
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jul 2022 19:50:33 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id k14so25570112qtm.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jul 2022 19:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Ad97sT16le5gjY7PgDU6gmeetvBzm9wlE8bQkILVjNc=;
        b=tCcxRqjITVsiKb1O2qN38oOtehuQYEQmQlnA5EmpLLTcqVHGWkBNn5r6VjhB95uftz
         oBhwab0Wa2p2hfzUf6HitqoN4V8My4lx3Sr3LHdaGn7TrTI27nd6mE0wsQOIBv87ES7u
         uwlTgHRa2iafBHAxVTfOiHdPWVETU8CJjwRGskRUwQecY/1YbABG8fpWqJ0i5forgO17
         n0R7m15mcAmskoYtfNfHUvAotB5BgPlp6Llxsn+Fa0qYPR44yx2cfMCeEIswKRQZAgPI
         NLOhCVeNcKdBjtuIw/nnF9iOSfGliNNxy/YqmZphg0HMl4dZzroFochhJCRrtxDrneBV
         hZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Ad97sT16le5gjY7PgDU6gmeetvBzm9wlE8bQkILVjNc=;
        b=Jwj7VgwZLpeRLbdwVXaKYJ3Dk4McVyl7/9pAoft4OqmQvwdK8EDpC9FYHm6vGQ40aj
         ayUhM8uVKtmyiRZ2hRhDIXe8HwWX8CtfbiVkMcX7sQOmTgm05V0UXGdolQTUGkQ9266T
         s/PY9X8+Zf1wCeF1aSVJMtBSWRPJq+oCVT8T+ANdiZ0W7IbPwsoNH3re1N1vS94whRq0
         hFqvo74H13fXp3PElMd7AoR449LEGny9Qi8gOqp61r964MSnEtvY38ZOSXSm0pet9haW
         liwNSjst9hqrv8F7NYPS6ufOutC6LrznMcDX/h9lWxr7NEDRJIEZNKC8EN1smkgWwe98
         QDjA==
X-Gm-Message-State: AJIora+0ZthjItG8tLk2cAnVc+7nPBpTUyBDIQnbhuczbtn9/i+Fiaud
        YjzNlYe+iMWocRNrbwicjDMAPQ==
X-Google-Smtp-Source: AGRyM1tJqq+vsbrqVwAmw8UZQYXdEmN7Cq4ADeDpayYOUxqHMEno4PbopiKhNsYF91bJVygTm51HMQ==
X-Received: by 2002:ac8:7d52:0:b0:319:51f0:e418 with SMTP id h18-20020ac87d52000000b0031951f0e418mr1088284qtb.481.1657248632632;
        Thu, 07 Jul 2022 19:50:32 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a254700b006a65c58db99sm35676841qko.64.2022.07.07.19.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 19:50:32 -0700 (PDT)
Date:   Thu, 7 Jul 2022 19:50:17 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 07/19] mm/migrate: Convert expected_page_refs() to
 folio_expected_refs()
In-Reply-To: <20220608150249.3033815-8-willy@infradead.org>
Message-ID: <6e7599d1-8a5f-bf16-383c-febd753bd051@google.com>
References: <20220608150249.3033815-1-willy@infradead.org> <20220608150249.3033815-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 8 Jun 2022, Matthew Wilcox (Oracle) wrote:

> Now that both callers have a folio, convert this function to
> take a folio & rename it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/migrate.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 2975f0c4d7cf..2e2f41572066 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -336,13 +336,18 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
>  }
>  #endif
>  
> -static int expected_page_refs(struct address_space *mapping, struct page *page)
> +static int folio_expected_refs(struct address_space *mapping,
> +		struct folio *folio)
>  {
> -	int expected_count = 1;
> +	int refs = 1;
> +	if (!mapping)
> +		return refs;
>  
> -	if (mapping)
> -		expected_count += compound_nr(page) + page_has_private(page);
> -	return expected_count;
> +	refs += folio_nr_pages(folio);
> +	if (folio_get_private(folio))
> +		refs++;
> +
> +	return refs;
>  }
>  
>  /*
> @@ -359,7 +364,7 @@ int folio_migrate_mapping(struct address_space *mapping,
>  	XA_STATE(xas, &mapping->i_pages, folio_index(folio));
>  	struct zone *oldzone, *newzone;
>  	int dirty;
> -	int expected_count = expected_page_refs(mapping, &folio->page) + extra_count;
> +	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
>  	long nr = folio_nr_pages(folio);
>  
>  	if (!mapping) {
> @@ -669,7 +674,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>  		return migrate_page(mapping, &dst->page, &src->page, mode);
>  
>  	/* Check whether page does not have extra refs before we do more work */
> -	expected_count = expected_page_refs(mapping, &src->page);
> +	expected_count = folio_expected_refs(mapping, src);
>  	if (folio_ref_count(src) != expected_count)
>  		return -EAGAIN;
>  
> -- 
> 2.35.1

This commit (742e89c9e352d38df1a5825fe40c4de73a5d5f7a in pagecache.git
folio/for-next and recent linux-next) is dangerously wrong, at least
for swapcache, and probably for some others.

I say "dangerously" because it tells page migration a swapcache page
is safe for migration when it certainly is not.

The fun that typically ensues is kernel BUG at include/linux/mm.h:750!
put_page_testzero() VM_BUG_ON_PAGE(page_ref_count(page) == 0, page),
if CONFIG_DEBUG_VM=y (bisecting for that is what brought me to this).
But I guess you might get silent data corruption too.

I assumed at first that you'd changed the rules, and were now expecting
any subsystem that puts a non-zero value into folio->private to raise
its refcount - whereas the old convention (originating with buffer heads)
is that setting PG_private says an extra refcount has been taken, please
call try_to_release_page() to lower it, and maybe that will use data in
page->private to do so; but page->private free for the subsystem owning
the page to use as it wishes, no refcount implication.  But that you
had missed updating swapcache.

So I got working okay with the patch below; but before turning it into
a proper patch, noticed that there were still plenty of other places
applying the test for PG_private: so now think that maybe you set out
with intention as above, realized it wouldn't work, but got distracted
before cleaning up some places you'd already changed.  And patch below
now goes in the wrong direction.

Or maybe you didn't intend any change, but the PG_private test just got
missed in a few places.  I don't know, hope you remember, but current
linux-next badly inconsistent.
Over to you, thanks,

Hugh

--- a/mm/migrate.c	2022-07-06 14:24:44.499941975 -0700
+++ b/mm/migrate.c	2022-07-06 15:49:25.000000000 -0700
@@ -351,6 +351,10 @@ unlock:
 }
 #endif
 
+static inline bool folio_counted_private(struct folio *folio)
+{
+	return !folio_test_swapcache(folio) && folio_get_private(folio);
+}
 static int folio_expected_refs(struct address_space *mapping,
 		struct folio *folio)
 {
@@ -359,7 +363,7 @@ static int folio_expected_refs(struct ad
 		return refs;
 
 	refs += folio_nr_pages(folio);
-	if (folio_get_private(folio))
+	if (folio_counted_private(folio))
 		refs++;
 
 	return refs;
--- a/mm/vmscan.c	2022-07-06 14:24:44.531942217 -0700
+++ b/mm/vmscan.c	2022-07-06 15:49:37.000000000 -0700
@@ -2494,6 +2494,10 @@ shrink_inactive_list(unsigned long nr_to
  * The downside is that we have to touch folio->_refcount against each folio.
  * But we had to alter folio->flags anyway.
  */
+static inline bool folio_counted_private(struct folio *folio)
+{
+	return !folio_test_swapcache(folio) && folio_get_private(folio);
+}
 static void shrink_active_list(unsigned long nr_to_scan,
 			       struct lruvec *lruvec,
 			       struct scan_control *sc,
@@ -2538,8 +2542,9 @@ static void shrink_active_list(unsigned
 		}
 
 		if (unlikely(buffer_heads_over_limit)) {
-			if (folio_get_private(folio) && folio_trylock(folio)) {
-				if (folio_get_private(folio))
+			if (folio_counted_private(folio) &&
+			    folio_trylock(folio)) {
+				if (folio_counted_private(folio))
 					filemap_release_folio(folio, 0);
 				folio_unlock(folio);
 			}
