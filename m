Return-Path: <linux-fsdevel+bounces-70801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4082CA74C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 12:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3121432C0720
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 08:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4E334B430;
	Fri,  5 Dec 2025 07:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkvugYho"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1619F33A6F6;
	Fri,  5 Dec 2025 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919343; cv=none; b=NlWk7O0DwkdCglblCDJR/8c6omAowZ7DCkj4KUrTk2X9qbDstvSUE5++ffs8aDN28wCKMx19X+oLryY3Tuh4bYvwF3SGGOPPK1ndlPoOVcIgpeLDekJ/MDDMBtmrV211Et0jwBpUfwDITc+PAzcSbDfTkFcU/t+2VfjAa9pW00k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919343; c=relaxed/simple;
	bh=eRQIudDpx1y4giwhG541g90Y9MfghdnwOzskcuvD0KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8jM0NfNNhUtCdmJfMYQ4fCbODDNzNOMazyReXTZcfZTMfGwQyKgfdflNNk9SwWwZeo4uOod0C+Sxh9/5/mjPy3xtpRudbXTpvl/i3gevvBUWasdTT9fN2+jAVQkEfTOTdEdZG48W6xxCzeZJTaiLttEoUxg470DBiOWHzd8/UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkvugYho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D85BC2BCC6;
	Fri,  5 Dec 2025 07:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764919341;
	bh=eRQIudDpx1y4giwhG541g90Y9MfghdnwOzskcuvD0KY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HkvugYho0F9aIgpM0DRaEYlHie7SSEw+79avEpD0RTFvB8wX6iflW3MbDosHFDCgD
	 Pxb20SU2AQZ3XUPZA8eSb3n/RFULJglQpeHGZUNAsOdq1Ehys0jxAluu7lbow30Vgk
	 m27JnfimiwCqW7MdThES7VbmG3qxIpJ8AvC7i+g/KyK4uLE5QOgHEXQE0u/L8N2UW5
	 ACIVy5qmpWeRS+A4RYBALqV4vXvgRG3UZTlKtmOvTAIcYhkNqYOOCB4kbYE3Y29gmb
	 rA39pQAtCP6r6jR2DkpjvPxBH5tMdakSrY6M2o/8Y0rUUEEi36k3KEy8mUCDF5H6j+
	 eYifPJcMLtWVg==
Message-ID: <d651e943-99f5-431e-a67d-e4e6784e720e@kernel.org>
Date: Fri, 5 Dec 2025 08:22:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] lib: xarray: free unused spare node in
 xas_create_range()
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, willy@infradead.org,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 dev.jain@arm.com, shardulsb08@gmail.com, janak@mpiricsoftware.com
References: <20251204142625.1763372-1-shardul.b@mpiricsoftware.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251204142625.1763372-1-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/25 15:26, Shardul Bankar wrote:
> xas_create_range() is typically called in a retry loop that uses
> xas_nomem() to handle -ENOMEM errors. xas_nomem() may allocate a spare
> xa_node and store it in xas->xa_alloc for use in the retry.
> 
> If the lock is dropped after xas_nomem(), another thread can expand the
> xarray tree in the meantime. On the next retry, xas_create_range() can
> then succeed without consuming the spare node stored in xas->xa_alloc.
> If the function returns without freeing this spare node, it leaks.
> 
> xas_create_range() calls xas_create() multiple times in a loop for
> different index ranges. A spare node that isn't needed for one range
> iteration might be needed for the next, so we cannot free it after each
> xas_create() call. We can only safely free it after xas_create_range()
> completes.
> 
> Fix this by calling xas_destroy() at the end of xas_create_range() to
> free any unused spare node. This makes the API safer by default and
> prevents callers from needing to remember cleanup.
> 
> This fixes a memory leak in mm/khugepaged.c and potentially other
> callers that use xas_nomem() with xas_create_range().
> 
> Link: https://syzkaller.appspot.com/bug?id=a274d65fc733448ed518ad15481ed575669dd98c
> Link: https://lore.kernel.org/all/20251201074540.3576327-1-shardul.b@mpiricsoftware.com/ ("v3")
> Fixes: cae106dd67b9 ("mm/khugepaged: refactor collapse_file control flow")
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
>   v4:
>   - Drop redundant `if (xa_alloc)` around xas_destroy(), as xas_destroy()
>     already checks xa_alloc internally.
>   v3:
>   - Move fix from collapse_file() to xas_create_range() as suggested by Matthew Wilcox
>   - Fix in library function makes API safer by default, preventing callers from needing
>     to remember cleanup
>   - Use shared cleanup label that both restore: and success: paths jump to
>   - Clean up unused spare node on both success and error exit paths
>   v2:
>   - Call xas_destroy() on both success and failure
>   - Explained retry semantics and xa_alloc / concurrency risk
>   - Dropped cleanup_empty_nodes from previous proposal
> 
>   lib/xarray.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/xarray.c b/lib/xarray.c
> index 9a8b4916540c..f49ccfa5f57d 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -744,11 +744,16 @@ void xas_create_range(struct xa_state *xas)
>   	xas->xa_shift = shift;
>   	xas->xa_sibs = sibs;
>   	xas->xa_index = index;
> -	return;
> +	goto cleanup;
> +
>   success:
>   	xas->xa_index = index;
>   	if (xas->xa_node)
>   		xas_set_offset(xas);
> +
> +cleanup:
> +	/* Free any unused spare node from xas_nomem() */
> +	xas_destroy(xas);
>   }
>   EXPORT_SYMBOL_GPL(xas_create_range);
>   

Nothing jumped at me, except that the label situation is a bit
suboptimal.

Hoping Willy will take another look as well.

Reviewed-by: David Hildenbrand (Red Hat) <david@kernel.org>


BTW, do we have a way to test this in a test case?


A follow-up cleanup that avoids labels could be something like (untested):


diff --git a/lib/xarray.c b/lib/xarray.c
index 9a8b4916540cf..325f264530fb2 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -714,6 +714,7 @@ void xas_create_range(struct xa_state *xas)
         unsigned long index = xas->xa_index;
         unsigned char shift = xas->xa_shift;
         unsigned char sibs = xas->xa_sibs;
+       bool success = false;
  
         xas->xa_index |= ((sibs + 1UL) << shift) - 1;
         if (xas_is_node(xas) && xas->xa_node->shift == xas->xa_shift)
@@ -724,9 +725,11 @@ void xas_create_range(struct xa_state *xas)
         for (;;) {
                 xas_create(xas, true);
                 if (xas_error(xas))
-                       goto restore;
-               if (xas->xa_index <= (index | XA_CHUNK_MASK))
-                       goto success;
+                       break
+               if (xas->xa_index <= (index | XA_CHUNK_MASK)) {
+                       succeess = true;
+                       break;
+               }
                 xas->xa_index -= XA_CHUNK_SIZE;
  
                 for (;;) {
@@ -740,15 +743,17 @@ void xas_create_range(struct xa_state *xas)
                 }
         }
  
-restore:
-       xas->xa_shift = shift;
-       xas->xa_sibs = sibs;
-       xas->xa_index = index;
-       return;
-success:
-       xas->xa_index = index;
-       if (xas->xa_node)
-               xas_set_offset(xas);
+       if (success) {
+               xas->xa_index = index;
+               if (xas->xa_node)
+                       xas_set_offset(xas);
+       } else {
+               xas->xa_shift = shift;
+               xas->xa_sibs = sibs;
+               xas->xa_index = index;
+       }
+       /* Free any unused spare node from xas_nomem() */
+       xas_destroy(xas);
  }
  EXPORT_SYMBOL_GPL(xas_create_range);


-- 
Cheers

David

