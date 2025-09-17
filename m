Return-Path: <linux-fsdevel+bounces-61928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4A4B7F418
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE1B4A3BBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 13:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7BA2EAB89;
	Wed, 17 Sep 2025 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duQiKlgi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533F3215F4A
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114487; cv=none; b=jGLpKB8yTc3VrqIC3hDsZtYs9PnMZIu6PN17pmqnsvBVU0EkMlRVLuLT7/5Ba4f9RQwz2Y2kfe4rfYEgF7slE0lBzNzsPQpqL2vHYC0eqjCvKNAILvoew+GM8oPx8EU4/GOcgwuynEBVxGqBmHSlEWXrZebxhGxkp4nlzITSClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114487; c=relaxed/simple;
	bh=VC8i9EuI8elmGanm5n7un4HuN+k9TiFlpwIHh4VRuMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+TPNCzp8NksS109SjhhsCHAO2Ajj/ZZ8gJr4veuAqgYRKqEWkIWgINl0PfoHPFnuEvZTlU1WglfvlytgNAztmBdiPql/JnG+eI9KUqDwWUt6eVOvu06cxeYKA5VKOjMFbXsmjEh9oxDtqRn6xaPwYGvKsYePIYiZGUhWQ5OvYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duQiKlgi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758114484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9C2dGW9H76hURaUowowv+DpUt4X7AUUikHVR9izs+Tw=;
	b=duQiKlgicM8CbNZTL64aVfpVaYABzfkkaTh/BQiQW5g/HS2TONvS/FT4vFWXFkcyrfQQH3
	ERXUHeJVRNiASvRq+ytAxkzOskAtXm4ytqSwlzx/ZSZSy+KHUPsqVg5h5xsJ6BJflo034v
	Xmth+Cb01Kh5pzWIHDepgqOSAERR8ro=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-RuRJd-1MPwad3PJ5fmq2yA-1; Wed,
 17 Sep 2025 09:07:58 -0400
X-MC-Unique: RuRJd-1MPwad3PJ5fmq2yA-1
X-Mimecast-MFC-AGG-ID: RuRJd-1MPwad3PJ5fmq2yA_1758114477
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77C7D180035C;
	Wed, 17 Sep 2025 13:07:57 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.134])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9FE918003FC;
	Wed, 17 Sep 2025 13:07:55 +0000 (UTC)
Date: Wed, 17 Sep 2025 09:12:00 -0400
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] iomap: simplify iomap_iter_advance()
Message-ID: <aMqzoK1BAq0ed-pB@bfoster>
References: <20250917004001.2602922-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917004001.2602922-1-joannelkoong@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Sep 16, 2025 at 05:40:01PM -0700, Joanne Koong wrote:
> Most callers of iomap_iter_advance() do not need the remaining length
> returned. Get rid of the extra iomap_length() call that
> iomap_iter_advance() does. If the caller wants the remaining length,
> they can make the call to iomap_length().
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---

Indeed this does clean up some of the calls that create a local var
purely to work around the interface. OTOH, the reason I made the advance
update the length was so it was clear the remaining length would be used
correctly in those looping callers. Otherwise I'm not sure it's clear
the bytes/length value needs to be updated and that felt like an easy
mistake to make to me.

I don't really have a strong preference so I'll defer to whatever the
majority opinion is. I wonder though if something else worth considering
is to rename the current helper to __iomap_iter_advance() (or whatever)
and make your updated variant of iomap_iter_advance() into a wrapper of
it.

Brian

>  fs/dax.c               | 28 ++++++++++++----------------
>  fs/iomap/buffered-io.c | 16 +++++++++-------
>  fs/iomap/direct-io.c   |  6 +++---
>  fs/iomap/iter.c        | 14 +++++---------
>  fs/iomap/seek.c        |  8 ++++----
>  include/linux/iomap.h  |  6 ++----
>  6 files changed, 35 insertions(+), 43 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 20ecf652c129..29e7a150b6f9 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1534,7 +1534,7 @@ static int dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  
>  	/* already zeroed?  we're done. */
>  	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
> -		return iomap_iter_advance(iter, &length);
> +		return iomap_iter_advance(iter, length);
>  
>  	/*
>  	 * invalidate the pages whose sharing state is to be changed
> @@ -1563,9 +1563,10 @@ static int dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		if (ret < 0)
>  			return ret;
>  
> -		ret = iomap_iter_advance(iter, &length);
> +		ret = iomap_iter_advance(iter, length);
>  		if (ret)
>  			return ret;
> +		length = iomap_length(iter);
>  	} while (length > 0);
>  
>  	if (did_zero)
> @@ -1624,7 +1625,7 @@ static int dax_iomap_iter(struct iomap_iter *iomi, struct iov_iter *iter)
>  
>  		if (iomap->type == IOMAP_HOLE || iomap->type == IOMAP_UNWRITTEN) {
>  			done = iov_iter_zero(min(length, end - pos), iter);
> -			return iomap_iter_advance(iomi, &done);
> +			return iomap_iter_advance(iomi, done);
>  		}
>  	}
>  
> @@ -1709,11 +1710,12 @@ static int dax_iomap_iter(struct iomap_iter *iomi, struct iov_iter *iter)
>  					map_len, iter);
>  
>  		length = xfer;
> -		ret = iomap_iter_advance(iomi, &length);
> +		ret = iomap_iter_advance(iomi, length);
>  		if (!ret && xfer == 0)
>  			ret = -EFAULT;
>  		if (xfer < map_len)
>  			break;
> +		length = iomap_length(iomi);
>  	}
>  	dax_read_unlock(id);
>  
> @@ -1946,10 +1948,8 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, unsigned long *pfnp,
>  			ret |= VM_FAULT_MAJOR;
>  		}
>  
> -		if (!(ret & VM_FAULT_ERROR)) {
> -			u64 length = PAGE_SIZE;
> -			iter.status = iomap_iter_advance(&iter, &length);
> -		}
> +		if (!(ret & VM_FAULT_ERROR))
> +			iter.status = iomap_iter_advance(&iter, PAGE_SIZE);
>  	}
>  
>  	if (iomap_errp)
> @@ -2061,10 +2061,8 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, unsigned long *pfnp,
>  			continue; /* actually breaks out of the loop */
>  
>  		ret = dax_fault_iter(vmf, &iter, pfnp, &xas, &entry, true);
> -		if (ret != VM_FAULT_FALLBACK) {
> -			u64 length = PMD_SIZE;
> -			iter.status = iomap_iter_advance(&iter, &length);
> -		}
> +		if (ret != VM_FAULT_FALLBACK)
> +			iter.status = iomap_iter_advance(&iter, PMD_SIZE);
>  	}
>  
>  unlock_entry:
> @@ -2190,7 +2188,6 @@ static int dax_range_compare_iter(struct iomap_iter *it_src,
>  	const struct iomap *smap = &it_src->iomap;
>  	const struct iomap *dmap = &it_dest->iomap;
>  	loff_t pos1 = it_src->pos, pos2 = it_dest->pos;
> -	u64 dest_len;
>  	void *saddr, *daddr;
>  	int id, ret;
>  
> @@ -2223,10 +2220,9 @@ static int dax_range_compare_iter(struct iomap_iter *it_src,
>  	dax_read_unlock(id);
>  
>  advance:
> -	dest_len = len;
> -	ret = iomap_iter_advance(it_src, &len);
> +	ret = iomap_iter_advance(it_src, len);
>  	if (!ret)
> -		ret = iomap_iter_advance(it_dest, &dest_len);
> +		ret = iomap_iter_advance(it_dest, len);
>  	return ret;
>  
>  out_unlock:
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index fd827398afd2..fe6588ab0922 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -373,7 +373,7 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
>  		ret = iomap_read_inline_data(iter, folio);
>  		if (ret)
>  			return ret;
> -		return iomap_iter_advance(iter, &length);
> +		return iomap_iter_advance(iter, length);
>  	}
>  
>  	/* zero post-eof blocks as the page may be mapped */
> @@ -434,7 +434,7 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
>  	 * iteration.
>  	 */
>  	length = pos - iter->pos + plen;
> -	return iomap_iter_advance(iter, &length);
> +	return iomap_iter_advance(iter, length);
>  }
>  
>  static int iomap_read_folio_iter(struct iomap_iter *iter,
> @@ -1036,7 +1036,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
>  			}
>  		} else {
>  			total_written += written;
> -			iomap_iter_advance(iter, &written);
> +			iomap_iter_advance(iter, written);
>  		}
>  	} while (iov_iter_count(i) && iomap_length(iter));
>  
> @@ -1305,7 +1305,7 @@ static int iomap_unshare_iter(struct iomap_iter *iter,
>  	int status;
>  
>  	if (!iomap_want_unshare_iter(iter))
> -		return iomap_iter_advance(iter, &bytes);
> +		return iomap_iter_advance(iter, bytes);
>  
>  	do {
>  		struct folio *folio;
> @@ -1329,9 +1329,10 @@ static int iomap_unshare_iter(struct iomap_iter *iter,
>  
>  		balance_dirty_pages_ratelimited(iter->inode->i_mapping);
>  
> -		status = iomap_iter_advance(iter, &bytes);
> +		status = iomap_iter_advance(iter, bytes);
>  		if (status)
>  			break;
> +		bytes = iomap_length(iter);
>  	} while (bytes > 0);
>  
>  	return status;
> @@ -1404,9 +1405,10 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
>  		if (WARN_ON_ONCE(!ret))
>  			return -EIO;
>  
> -		status = iomap_iter_advance(iter, &bytes);
> +		status = iomap_iter_advance(iter, bytes);
>  		if (status)
>  			break;
> +		bytes = iomap_length(iter);
>  	} while (bytes > 0);
>  
>  	if (did_zero)
> @@ -1518,7 +1520,7 @@ static int iomap_folio_mkwrite_iter(struct iomap_iter *iter,
>  		folio_mark_dirty(folio);
>  	}
>  
> -	return iomap_iter_advance(iter, &length);
> +	return iomap_iter_advance(iter, length);
>  }
>  
>  vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index b84f6af2eb4c..e3544a6719a7 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -496,7 +496,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	/* Undo iter limitation to current extent */
>  	iov_iter_reexpand(dio->submit.iter, orig_count - copied);
>  	if (copied)
> -		return iomap_iter_advance(iter, &copied);
> +		return iomap_iter_advance(iter, copied);
>  	return ret;
>  }
>  
> @@ -507,7 +507,7 @@ static int iomap_dio_hole_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	dio->size += length;
>  	if (!length)
>  		return -EFAULT;
> -	return iomap_iter_advance(iter, &length);
> +	return iomap_iter_advance(iter, length);
>  }
>  
>  static int iomap_dio_inline_iter(struct iomap_iter *iomi, struct iomap_dio *dio)
> @@ -539,7 +539,7 @@ static int iomap_dio_inline_iter(struct iomap_iter *iomi, struct iomap_dio *dio)
>  	dio->size += copied;
>  	if (!copied)
>  		return -EFAULT;
> -	return iomap_iter_advance(iomi, &copied);
> +	return iomap_iter_advance(iomi, copied);
>  }
>  
>  static int iomap_dio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index cef77ca0c20b..91d2024e00da 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -13,17 +13,13 @@ static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
>  	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
>  }
>  
> -/*
> - * Advance the current iterator position and output the length remaining for the
> - * current mapping.
> - */
> -int iomap_iter_advance(struct iomap_iter *iter, u64 *count)
> +/* Advance the current iterator position and decrement the remaining length */
> +int iomap_iter_advance(struct iomap_iter *iter, u64 count)
>  {
> -	if (WARN_ON_ONCE(*count > iomap_length(iter)))
> +	if (WARN_ON_ONCE(count > iomap_length(iter)))
>  		return -EIO;
> -	iter->pos += *count;
> -	iter->len -= *count;
> -	*count = iomap_length(iter);
> +	iter->pos += count;
> +	iter->len -= count;
>  	return 0;
>  }
>  
> diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
> index 56db2dd4b10d..6cbc587c93da 100644
> --- a/fs/iomap/seek.c
> +++ b/fs/iomap/seek.c
> @@ -16,13 +16,13 @@ static int iomap_seek_hole_iter(struct iomap_iter *iter,
>  		*hole_pos = mapping_seek_hole_data(iter->inode->i_mapping,
>  				iter->pos, iter->pos + length, SEEK_HOLE);
>  		if (*hole_pos == iter->pos + length)
> -			return iomap_iter_advance(iter, &length);
> +			return iomap_iter_advance(iter, length);
>  		return 0;
>  	case IOMAP_HOLE:
>  		*hole_pos = iter->pos;
>  		return 0;
>  	default:
> -		return iomap_iter_advance(iter, &length);
> +		return iomap_iter_advance(iter, length);
>  	}
>  }
>  
> @@ -59,12 +59,12 @@ static int iomap_seek_data_iter(struct iomap_iter *iter,
>  
>  	switch (iter->iomap.type) {
>  	case IOMAP_HOLE:
> -		return iomap_iter_advance(iter, &length);
> +		return iomap_iter_advance(iter, length);
>  	case IOMAP_UNWRITTEN:
>  		*hole_pos = mapping_seek_hole_data(iter->inode->i_mapping,
>  				iter->pos, iter->pos + length, SEEK_DATA);
>  		if (*hole_pos < 0)
> -			return iomap_iter_advance(iter, &length);
> +			return iomap_iter_advance(iter, length);
>  		return 0;
>  	default:
>  		*hole_pos = iter->pos;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 73dceabc21c8..4469b2318b08 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -245,7 +245,7 @@ struct iomap_iter {
>  };
>  
>  int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
> -int iomap_iter_advance(struct iomap_iter *iter, u64 *count);
> +int iomap_iter_advance(struct iomap_iter *iter, u64 count);
>  
>  /**
>   * iomap_length_trim - trimmed length of the current iomap iteration
> @@ -282,9 +282,7 @@ static inline u64 iomap_length(const struct iomap_iter *iter)
>   */
>  static inline int iomap_iter_advance_full(struct iomap_iter *iter)
>  {
> -	u64 length = iomap_length(iter);
> -
> -	return iomap_iter_advance(iter, &length);
> +	return iomap_iter_advance(iter, iomap_length(iter));
>  }
>  
>  /**
> -- 
> 2.47.3
> 


