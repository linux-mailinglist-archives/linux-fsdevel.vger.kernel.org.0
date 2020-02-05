Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1C153AD5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 23:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgBEWTg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 17:19:36 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2887 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgBEWTg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:19:36 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3b3f3d0000>; Wed, 05 Feb 2020 14:18:37 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 05 Feb 2020 14:19:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 05 Feb 2020 14:19:35 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Feb
 2020 22:19:35 +0000
Subject: Re: [PATCH 8/8] xarray: Don't clear marks in xas_store()
To:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-9-jack@suse.cz>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <8ea2682b-7240-dca3-b123-2df7d0c994ba@nvidia.com>
Date:   Wed, 5 Feb 2020 14:19:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200204142514.15826-9-jack@suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580941117; bh=QcP51/11tG4WHcW63IGM4gFzJVabzZAkSLmNu9TE4KY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=PJ1y4l5tpDGTu8Q5p82nW6YxFnqo9yqOQ3D7X4U38zEvdYCzZ+mpm6FgLx2ZzNsiM
         qYezXrQqd9skuvOmCgYg2ojnKora59U7sFSPRY3qpZe72Tqb6TyNEd/nTG+L8uIgAy
         tA5ky5G4rQYgLwZlqswX9Z0KxbkqnzPeivU65333b6XqrPsmD6RJYuv+lOBWbx5gmb
         jbnv1Kn+CLus/h1rV68uV6IU9ZdHlJC5QiV0du+eGGz2velqAqLKdC5ugLLEZFd7K4
         BSP0R0r89SUujjr1+6cFYNTqU4PDu3xYY8j8WQs9FLyN8l7+2LmZ87RGk8a4GCW8Xr
         jV/R7tYY8qNLQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/4/20 6:25 AM, Jan Kara wrote:
> When storing NULL in xarray, xas_store() has been clearing all marks
> because it could otherwise confuse xas_for_each_marked(). That is
> however no longer true and no current user relies on this behavior.


However, let's not forget that the API was also documented to behave
in this way--it's not an accidental detail. Below...


> Furthermore it seems as a cleaner API to not do clearing behind caller's
> back in case we store NULL.
> 
> This provides a nice boost to truncate numbers due to saving unnecessary
> tag initialization when clearing shadow entries. Sample benchmark
> showing time to truncate 128 files 1GB each on machine with 64GB of RAM
> (so about half of entries are shadow entries):
> 
>          AVG      STDDEV
> Vanilla  4.825s   0.036
> Patched  4.516s   0.014
> 
> So we can see about 6% reduction in overall truncate time.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  lib/xarray.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/lib/xarray.c b/lib/xarray.c
> index 4e32497c51bd..f165e83652f1 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -799,17 +799,8 @@ void *xas_store(struct xa_state *xas, void *entry)
>  		if (xas->xa_sibs)
>  			xas_squash_marks(xas);
>  	}
> -	if (!entry)
> -		xas_init_marks(xas);
>  
>  	for (;;) {
> -		/*
> -		 * Must clear the marks before setting the entry to NULL,
> -		 * otherwise xas_for_each_marked may find a NULL entry and
> -		 * stop early.  rcu_assign_pointer contains a release barrier
> -		 * so the mark clearing will appear to happen before the
> -		 * entry is set to NULL.
> -		 */

So if we do this, I think we'd also want something like this (probably with
better wording, this is just a first draft):

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index 640934b6f7b4..8adeaa8c012e 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -66,10 +66,11 @@ pointer at every index.
 You can then set entries using xa_store() and get entries
 using xa_load().  xa_store will overwrite any entry with the
 new entry and return the previous entry stored at that index.  You can
-use xa_erase() instead of calling xa_store() with a
+use xa_erase() plus xas_init_marks(), instead of calling xa_store() with a
 ``NULL`` entry.  There is no difference between an entry that has never
-been stored to, one that has been erased and one that has most recently
-had ``NULL`` stored to it.
+been stored to and one that has been erased. Those, in turn, are the same
+as an entry that has had ``NULL`` stored to it and also had its marks
+erased via xas_init_marks().
 
 You can conditionally replace an entry at an index by using
 xa_cmpxchg().  Like cmpxchg(), it will only succeed if



>  		rcu_assign_pointer(*slot, entry);
>  		if (xa_is_node(next) && (!node || node->shift))
>  			xas_free_nodes(xas, xa_to_node(next));
> 



thanks,
-- 
John Hubbard
NVIDIA
