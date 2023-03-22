Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98186C4B25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 13:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCVM4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 08:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjCVM4Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510AA51C83
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 05:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679489735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UVlHiTzTDc0EVCnMpHp0+jklQPQOanFvGtGl95BnDVU=;
        b=aJ4VzGGrAv9Atl2lQPRSNuoskP5IFVAXnuBuWGgRT3fDOZRqCuXOBUoUh6zKbauQ1h2CTV
        rrtvIXjmOZUgnMKz/z0DhJP++rzhTZ551eOEwDYgIV+5hSLdGS7SdVAJsGb9ynHMrwBYmH
        J1X+3a2RlFDxb2Pa8cntaJWvaM7bpRg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-bpO4Q9o9OaGcDLsKanF2gA-1; Wed, 22 Mar 2023 08:55:29 -0400
X-MC-Unique: bpO4Q9o9OaGcDLsKanF2gA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D70C3813F59;
        Wed, 22 Mar 2023 12:55:29 +0000 (UTC)
Received: from localhost (ovpn-13-195.pek2.redhat.com [10.72.13.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88E45140EBF4;
        Wed, 22 Mar 2023 12:55:27 +0000 (UTC)
Date:   Wed, 22 Mar 2023 20:55:23 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 4/4] mm: vmalloc: convert vread() to vread_iter()
Message-ID: <ZBr6u+rivMztIvn9@MiWiFi-R3L-srv>
References: <cover.1679431886.git.lstoakes@gmail.com>
 <6b3899bbbf1f4bd6b7133c8b6f27b3a8791607b0.1679431886.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b3899bbbf1f4bd6b7133c8b6f27b3a8791607b0.1679431886.git.lstoakes@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/21/23 at 08:54pm, Lorenzo Stoakes wrote:
......
> Additionally, we must account for the fact that at any point a copy may
> fail if this happens, we exit indicating fewer bytes retrieved than
> expected.
......
> -static int aligned_vread(char *buf, char *addr, unsigned long count)
> +/*
> + * small helper routine, copy contents to iter from addr.
> + * If the page is not present, fill zero.
> + *
> + * Returns the number of copied bytes.
> + */
> +static size_t aligned_vread_iter(struct iov_iter *iter,
> +				 const char *addr, size_t count)
>  {
> -	struct page *p;
> -	int copied = 0;
> +	size_t remains = count;
> +	struct page *page;
>  
> -	while (count) {
> +	while (remains > 0) {
>  		unsigned long offset, length;
> +		size_t copied = 0;
>  
>  		offset = offset_in_page(addr);
>  		length = PAGE_SIZE - offset;
> -		if (length > count)
> -			length = count;
> -		p = vmalloc_to_page(addr);
> +		if (length > remains)
> +			length = remains;
> +		page = vmalloc_to_page(addr);
>  		/*
> -		 * To do safe access to this _mapped_ area, we need
> -		 * lock. But adding lock here means that we need to add
> -		 * overhead of vmalloc()/vfree() calls for this _debug_
> -		 * interface, rarely used. Instead of that, we'll use
> -		 * kmap() and get small overhead in this access function.
> +		 * To do safe access to this _mapped_ area, we need lock. But
> +		 * adding lock here means that we need to add overhead of
> +		 * vmalloc()/vfree() calls for this _debug_ interface, rarely
> +		 * used. Instead of that, we'll use an local mapping via
> +		 * copy_page_to_iter_atomic() and accept a small overhead in
> +		 * this access function.
>  		 */
> -		if (p) {
> -			/* We can expect USER0 is not used -- see vread() */
> -			void *map = kmap_atomic(p);
> -			memcpy(buf, map + offset, length);
> -			kunmap_atomic(map);
> -		} else
> -			memset(buf, 0, length);
> +		if (page)
> +			copied = copy_page_to_iter_atomic(page, offset, length,
> +							  iter);
> +

If we decided to quit at any failing copy point, indicating fewer bytes
retrieved than expected, wondering why we don't quit here if
copy_page_to_iter_atomic() failed? 

The original zero filling is for unmapped vmalloc area, but not for
reading area if failed. Not sure if I got your point.

> +		/* Zero anything we were unable to copy. */
> +		copied += zero_iter(iter, length - copied);
> +
> +		addr += copied;
> +		remains -= copied;
>  
> -		addr += length;
> -		buf += length;
> -		copied += length;
> -		count -= length;
> +		if (copied != length)
> +			break;
>  	}
> -	return copied;
> +
> +	return count - remains;
>  }
>  
> -static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags)
> +/*
> + * Read from a vm_map_ram region of memory.
> + *
> + * Returns the number of copied bytes.
> + */
> +static size_t vmap_ram_vread_iter(struct iov_iter *iter, const char *addr,
> +				  size_t count, unsigned long flags)
>  {
>  	char *start;
>  	struct vmap_block *vb;
>  	unsigned long offset;
> -	unsigned int rs, re, n;
> +	unsigned int rs, re;
> +	size_t remains, n;
>  
>  	/*
>  	 * If it's area created by vm_map_ram() interface directly, but
>  	 * not further subdividing and delegating management to vmap_block,
>  	 * handle it here.
>  	 */
> -	if (!(flags & VMAP_BLOCK)) {
> -		aligned_vread(buf, addr, count);
> -		return;
> -	}
> +	if (!(flags & VMAP_BLOCK))
> +		return aligned_vread_iter(iter, addr, count);
>  
>  	/*
>  	 * Area is split into regions and tracked with vmap_block, read out
> @@ -3505,50 +3537,65 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
>  	 */
>  	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
>  	if (!vb)
> -		goto finished;
> +		goto finished_zero;
>  
>  	spin_lock(&vb->lock);
>  	if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
>  		spin_unlock(&vb->lock);
> -		goto finished;
> +		goto finished_zero;
>  	}
> +
> +	remains = count;
>  	for_each_set_bitrange(rs, re, vb->used_map, VMAP_BBMAP_BITS) {
> -		if (!count)
> -			break;
> +		size_t copied;
> +
> +		if (remains == 0)
> +			goto finished;
> +
>  		start = vmap_block_vaddr(vb->va->va_start, rs);
> -		while (addr < start) {
> -			if (count == 0)
> -				goto unlock;
> -			*buf = '\0';
> -			buf++;
> -			addr++;
> -			count--;
> +
> +		if (addr < start) {
> +			size_t to_zero = min_t(size_t, start - addr, remains);
> +			size_t zeroed = zero_iter(iter, to_zero);
> +
> +			addr += zeroed;
> +			remains -= zeroed;
> +
> +			if (remains == 0 || zeroed != to_zero)
> +				goto finished;
>  		}
> +
>  		/*it could start reading from the middle of used region*/
>  		offset = offset_in_page(addr);
>  		n = ((re - rs + 1) << PAGE_SHIFT) - offset;
> -		if (n > count)
> -			n = count;
> -		aligned_vread(buf, start+offset, n);
> +		if (n > remains)
> +			n = remains;
> +
> +		copied = aligned_vread_iter(iter, start + offset, n);
>  
> -		buf += n;
> -		addr += n;
> -		count -= n;
> +		addr += copied;
> +		remains -= copied;
> +
> +		if (copied != n)
> +			goto finished;
>  	}
> -unlock:
> +
>  	spin_unlock(&vb->lock);
>  
> -finished:
> +finished_zero:
>  	/* zero-fill the left dirty or free regions */
> -	if (count)
> -		memset(buf, 0, count);
> +	return count - remains + zero_iter(iter, remains);

When it jumps to finished_zero, local varialble 'remains' is still 0, we
do nothing here but return count. It doesn't look so right. You may need
to move up the 'remains' assignment as 'count' line.

> +finished:
> +	/* We couldn't copy/zero everything */
> +	spin_unlock(&vb->lock);
> +	return count - remains;
>  }
>  
>  /**
> - * vread() - read vmalloc area in a safe way.
> - * @buf:     buffer for reading data
> - * @addr:    vm address.
> - * @count:   number of bytes to be read.
> + * vread_iter() - read vmalloc area in a safe way to an iterator.
> + * @iter:         the iterator to which data should be written.
> + * @addr:         vm address.
> + * @count:        number of bytes to be read.
>   *
>   * This function checks that addr is a valid vmalloc'ed area, and
>   * copy data from that area to a given buffer. If the given memory range
> @@ -3568,13 +3615,12 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
>   * (same number as @count) or %0 if [addr...addr+count) doesn't
>   * include any intersection with valid vmalloc area
>   */
> -long vread(char *buf, char *addr, unsigned long count)
> +long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
>  {
>  	struct vmap_area *va;
>  	struct vm_struct *vm;
> -	char *vaddr, *buf_start = buf;
> -	unsigned long buflen = count;
> -	unsigned long n, size, flags;
> +	char *vaddr;
> +	size_t n, size, flags, remains;
>  
>  	addr = kasan_reset_tag(addr);
>  
> @@ -3582,18 +3628,22 @@ long vread(char *buf, char *addr, unsigned long count)
>  	if ((unsigned long) addr + count < count)
>  		count = -(unsigned long) addr;
>  
> +	remains = count;
> +
>  	spin_lock(&vmap_area_lock);
>  	va = find_vmap_area_exceed_addr((unsigned long)addr);
>  	if (!va)
> -		goto finished;
> +		goto finished_zero;
>  
>  	/* no intersects with alive vmap_area */
> -	if ((unsigned long)addr + count <= va->va_start)
> -		goto finished;
> +	if ((unsigned long)addr + remains <= va->va_start)
> +		goto finished_zero;
>  
>  	list_for_each_entry_from(va, &vmap_area_list, list) {
> -		if (!count)
> -			break;
> +		size_t copied;
> +
> +		if (remains == 0)
> +			goto finished;
>  
>  		vm = va->vm;
>  		flags = va->flags & VMAP_FLAGS_MASK;
> @@ -3608,6 +3658,7 @@ long vread(char *buf, char *addr, unsigned long count)
>  
>  		if (vm && (vm->flags & VM_UNINITIALIZED))
>  			continue;
> +
>  		/* Pair with smp_wmb() in clear_vm_uninitialized_flag() */
>  		smp_rmb();
>  
> @@ -3616,38 +3667,45 @@ long vread(char *buf, char *addr, unsigned long count)
>  
>  		if (addr >= vaddr + size)
>  			continue;
> -		while (addr < vaddr) {
> -			if (count == 0)
> +
> +		if (addr < vaddr) {
> +			size_t to_zero = min_t(size_t, vaddr - addr, remains);
> +			size_t zeroed = zero_iter(iter, to_zero);
> +
> +			addr += zeroed;
> +			remains -= zeroed;
> +
> +			if (remains == 0 || zeroed != to_zero)
>  				goto finished;
> -			*buf = '\0';
> -			buf++;
> -			addr++;
> -			count--;
>  		}
> +
>  		n = vaddr + size - addr;
> -		if (n > count)
> -			n = count;
> +		if (n > remains)
> +			n = remains;
>  
>  		if (flags & VMAP_RAM)
> -			vmap_ram_vread(buf, addr, n, flags);
> +			copied = vmap_ram_vread_iter(iter, addr, n, flags);
>  		else if (!(vm->flags & VM_IOREMAP))
> -			aligned_vread(buf, addr, n);
> +			copied = aligned_vread_iter(iter, addr, n);
>  		else /* IOREMAP area is treated as memory hole */
> -			memset(buf, 0, n);
> -		buf += n;
> -		addr += n;
> -		count -= n;
> +			copied = zero_iter(iter, n);
> +
> +		addr += copied;
> +		remains -= copied;
> +
> +		if (copied != n)
> +			goto finished;
>  	}
> -finished:
> -	spin_unlock(&vmap_area_lock);
>  
> -	if (buf == buf_start)
> -		return 0;
> +finished_zero:
> +	spin_unlock(&vmap_area_lock);
>  	/* zero-fill memory holes */
> -	if (buf != buf_start + buflen)
> -		memset(buf, 0, buflen - (buf - buf_start));
> +	return count - remains + zero_iter(iter, remains);
> +finished:
> +	/* Nothing remains, or We couldn't copy/zero everything. */
                              ~~~ typo, s/We/we/
> +	spin_unlock(&vmap_area_lock);
>  
> -	return buflen;
> +	return count - remains;
>  }
>  
>  /**
> -- 
> 2.39.2
> 

