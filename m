Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3365C67D9CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 00:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjAZXm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 18:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbjAZXm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:42:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5366C3A91
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 15:42:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B9D66195A
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 23:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AE9C433EF;
        Thu, 26 Jan 2023 23:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674776513;
        bh=OiPUHqgirjVxTh2w4QlA9W8nPKtQN2owuoVmFJo9198=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DV+cnCxe/797o4CccJ1fV3SOHCbbRm3ukNPlsCRkf/gNbK0rFM3PaAEL3MPqGVZ9X
         +HrxhhCzy1CFrNPhlnuioD34+EGhJMb+wOCh89gktVfZAonExcZlhqA25vuSKJDJjj
         A0fpVNdsadiXiWciz2df0x9H/c8S3ox55lYrm1Gs=
Date:   Thu, 26 Jan 2023 15:41:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: Add memcpy_from_file_folio()
Message-Id: <20230126154152.898a1bdfd7d729627e2a6bf4@linux-foundation.org>
In-Reply-To: <20230126201552.1681588-1-willy@infradead.org>
References: <20230126201552.1681588-1-willy@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 26 Jan 2023 20:15:52 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> This is the equivalent of memcpy_from_page().  It differs in that it
> takes the position in a file instead of offset in a folio, it accepts
> the total number of bytes to be copied (instead of the number of bytes
> to be copied from this folio) and it returns how many bytes were copied
> from the folio, rather than making the caller calculate that and then
> checking if the caller got it right.
> 
> ...
>
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -413,6 +413,35 @@ static inline void memzero_page(struct page *page, size_t offset, size_t len)
>  	kunmap_local(addr);
>  }
>  
> +/**
> + * memcpy_from_file_folio - Copy some bytes from a file folio.
> + * @to: The destination buffer.
> + * @folio: The folio to copy from.
> + * @pos: The position in the file.
> + * @len: The maximum number of bytes to copy.
> + *
> + * Copy up to @len bytes from this folio.  This may be limited by PAGE_SIZE
> + * if the folio comes from HIGHMEM, and by the size of the folio.
> + *
> + * Return: The number of bytes copied from the folio.
> + */
> +static inline size_t memcpy_from_file_folio(char *to, struct folio *folio,
> +		loff_t pos, size_t len)
> +{
> +	size_t offset = offset_in_folio(folio, pos);
> +	char *from = kmap_local_folio(folio, offset);
> +
> +	if (folio_test_highmem(folio))
> +		len = min(len, PAGE_SIZE - offset);
> +	else
> +		len = min(len, folio_size(folio) - offset);

min() blows up on arm allnoconfig.

./include/linux/highmem.h: In function 'memcpy_from_file_folio':
./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:67:25: note: in expansion of macro '__careful_cmp'
   67 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
./include/linux/highmem.h:435:23: note: in expansion of macro 'min'
  435 |                 len = min(len, PAGE_SIZE - offset);
      |                       ^~~

We could use min_t(), but perhaps and explanatorialy named variable is
nicer?

--- a/include/linux/highmem.h~mm-add-memcpy_from_file_folio-fix
+++ a/include/linux/highmem.h
@@ -430,13 +430,14 @@ static inline size_t memcpy_from_file_fo
 {
 	size_t offset = offset_in_folio(folio, pos);
 	char *from = kmap_local_folio(folio, offset);
+	size_t remaining;
 
 	if (folio_test_highmem(folio))
-		len = min(len, PAGE_SIZE - offset);
+		remaining = PAGE_SIZE - offset;
 	else
-		len = min(len, folio_size(folio) - offset);
+		remaining = folio_size(folio) - offset;
 
-	memcpy(to, from, len);
+	memcpy(to, from, min(len, remaining));
 	kunmap_local(from);
 
 	return len;
_

