Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E1949343F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 06:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243980AbiASFSZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 00:18:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240892AbiASFSZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 00:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642569504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9a1wEH6ePGC7fV0oIaU455+6ECCky8ZZbJOjMCVJj64=;
        b=OXYmiGRJ4dm5LCi9rcPnXLzxFt8fdvyXrZwBH930TZsVE/zb69l8eeI2/gr4GKDeGZl3A6
        zHHt4Z/kRJTuChFi1RE9mtXgoj+XP42bl77Ve7nwFkjoQegjfUPWqCxJl66dTTnOPf7ujF
        zv8E0c0GWEghO+r7FQChuEnIvDOrlUo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-QRlaGYGKOTyZGdWefkjZgg-1; Wed, 19 Jan 2022 00:18:23 -0500
X-MC-Unique: QRlaGYGKOTyZGdWefkjZgg-1
Received: by mail-pg1-f197.google.com with SMTP id p6-20020a63ab06000000b0033fcc84d4f6so889053pgf.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jan 2022 21:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9a1wEH6ePGC7fV0oIaU455+6ECCky8ZZbJOjMCVJj64=;
        b=49Rq6YBRTjwBVKXOcGw5wceTT9CrtNJocs6Rz/QaA6BWLdiFV0N3fkksppeeuMGpRJ
         NnmLuS/chMfoCHEx9aUpubwocYPY9dWAe6VoiyM0tmWE3KaeaDUFL+D0IER+d2852hFK
         qFFgCcPQT+qkz49WZfNzB+25KcJ1yRq+yTDJcN25bJkdwYmF8cUAqMUBfFxPHprFRDTZ
         gGZpMJzJ8qsCgJcObspqPpa7a2haLkrTmUZnfdpC1Dm9NDnowdYzmYI7k6WIg0Q8Toym
         0gaqdOW3cqpIoCJKr31nO1IR41er55M+ToEOuNeQvPQvCoqTWWXGdPv6CoRBVI2wQA4P
         jCZg==
X-Gm-Message-State: AOAM532XxiuidN7Xp4bkosvtNHQ4bm2R8gp9mEsdwxzAXcnsrod10lWw
        8iT71kpJQqokNCowwBH3xe1kblXLscldeNnWhnEuOzLP1qQAmYm252GqWby/UjlJLtQTvtA8u72
        duJVBg+kieDrLOadyiCDFzydcYg==
X-Received: by 2002:a63:360c:: with SMTP id d12mr25785039pga.395.1642569501899;
        Tue, 18 Jan 2022 21:18:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmcOEdsEeXClRkUFdwkWTDMuyoLYhtokWHW1sIbn5SOt2Yx5gbW9QOwvgD3y1kerWmpN9ILQ==
X-Received: by 2002:a63:360c:: with SMTP id d12mr25785026pga.395.1642569501567;
        Tue, 18 Jan 2022 21:18:21 -0800 (PST)
Received: from [10.72.12.81] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r19sm7982852pgi.58.2022.01.18.21.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 21:18:20 -0800 (PST)
Subject: Re: [RFC PATCH v10 44/48] ceph: plumb in decryption during sync reads
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
References: <20220111191608.88762-1-jlayton@kernel.org>
 <20220111191608.88762-45-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <961b7838-6c03-f3bf-4004-619ff5c36252@redhat.com>
Date:   Wed, 19 Jan 2022 13:18:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220111191608.88762-45-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 1/12/22 3:16 AM, Jeff Layton wrote:
> Note that the crypto block may be smaller than a page, but the reverse
> cannot be true.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/file.c | 94 ++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 69 insertions(+), 25 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 41766b2012e9..b4f2fcd33837 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -926,9 +926,17 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
>   		bool more;
>   		int idx;
>   		size_t left;
> +		u64 read_off = off;
> +		u64 read_len = len;
> +
> +		/* determine new offset/length if encrypted */
> +		fscrypt_adjust_off_and_len(inode, &read_off, &read_len);
> +
> +		dout("sync_read orig %llu~%llu reading %llu~%llu",
> +		     off, len, read_off, read_len);
>   
>   		req = ceph_osdc_new_request(osdc, &ci->i_layout,
> -					ci->i_vino, off, &len, 0, 1,
> +					ci->i_vino, read_off, &read_len, 0, 1,
>   					CEPH_OSD_OP_READ, CEPH_OSD_FLAG_READ,
>   					NULL, ci->i_truncate_seq,
>   					ci->i_truncate_size, false);
> @@ -937,10 +945,13 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
>   			break;
>   		}
>   
> +		/* adjust len downward if the request truncated the len */
> +		if (off + len > read_off + read_len)
> +			len = read_off + read_len - off;
>   		more = len < iov_iter_count(to);
>   
> -		num_pages = calc_pages_for(off, len);
> -		page_off = off & ~PAGE_MASK;
> +		num_pages = calc_pages_for(read_off, read_len);
> +		page_off = offset_in_page(off);
>   		pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
>   		if (IS_ERR(pages)) {
>   			ceph_osdc_put_request(req);
> @@ -948,7 +959,8 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
>   			break;
>   		}
>   
> -		osd_req_op_extent_osd_data_pages(req, 0, pages, len, page_off,
> +		osd_req_op_extent_osd_data_pages(req, 0, pages, read_len,
> +						 offset_in_page(read_off),
>   						 false, false);
>   		ret = ceph_osdc_start_request(osdc, req, false);
>   		if (!ret)
> @@ -957,23 +969,50 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
>   		ceph_update_read_metrics(&fsc->mdsc->metric,
>   					 req->r_start_latency,
>   					 req->r_end_latency,
> -					 len, ret);
> +					 read_len, ret);
>   
>   		if (ret > 0)
>   			objver = req->r_version;
>   		ceph_osdc_put_request(req);
> -
>   		i_size = i_size_read(inode);
>   		dout("sync_read %llu~%llu got %zd i_size %llu%s\n",
>   		     off, len, ret, i_size, (more ? " MORE" : ""));
>   
> -		if (ret == -ENOENT)
> +		if (ret == -ENOENT) {
> +			/* No object? Then this is a hole */
>   			ret = 0;
> +		} else if (ret > 0 && IS_ENCRYPTED(inode)) {
> +			int fret;
> +
> +			fret = ceph_fscrypt_decrypt_pages(inode, pages, read_off, ret);
> +			if (fret < 0) {
> +				ceph_release_page_vector(pages, num_pages);
> +				ret = fret;
> +				break;
> +			}
> +
> +			dout("sync_read decrypted fret %d\n", fret);
> +
> +			/* account for any partial block at the beginning */
> +			fret -= (off - read_off);
> +
> +			/*
> +			 * Short read after big offset adjustment?
> +			 * Nothing is usable, just call it a zero
> +			 * len read.
> +			 */
> +			fret = max(fret, 0);
> +
> +			/* account for partial block at the end */
> +			ret = min_t(ssize_t, fret, len);
> +		}
> +
> +		/* Short read but not EOF? Zero out the remainder. */
>   		if (ret >= 0 && ret < len && (off + ret < i_size)) {
>   			int zlen = min(len - ret, i_size - off - ret);
>   			int zoff = page_off + ret;
>   			dout("sync_read zero gap %llu~%llu\n",
> -                             off + ret, off + ret + zlen);
> +			     off + ret, off + ret + zlen);
>   			ceph_zero_page_vector_range(zoff, zlen, pages);
>   			ret += zlen;
>   		}
> @@ -981,15 +1020,15 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
>   		idx = 0;
>   		left = ret > 0 ? ret : 0;
>   		while (left > 0) {
> -			size_t len, copied;
> -			page_off = off & ~PAGE_MASK;
> -			len = min_t(size_t, left, PAGE_SIZE - page_off);
> +			size_t plen, copied;
> +			plen = min_t(size_t, left, PAGE_SIZE - page_off);
>   			SetPageUptodate(pages[idx]);
>   			copied = copy_page_to_iter(pages[idx++],
> -						   page_off, len, to);
> +						   page_off, plen, to);
>   			off += copied;
>   			left -= copied;
> -			if (copied < len) {
> +			page_off = 0;
> +			if (copied < plen) {
>   				ret = -EFAULT;
>   				break;
>   			}
> @@ -1006,20 +1045,21 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
>   			break;
>   	}
>   
> -	if (off > *ki_pos) {
> -		if (off >= i_size) {
> -			*retry_op = CHECK_EOF;
> -			ret = i_size - *ki_pos;
> -			*ki_pos = i_size;
> -		} else {
> -			ret = off - *ki_pos;
> -			*ki_pos = off;
> +	if (ret > 0) {
> +		if (off > *ki_pos) {
> +			if (off >= i_size) {
> +				*retry_op = CHECK_EOF;
> +				ret = i_size - *ki_pos;
> +				*ki_pos = i_size;
> +			} else {
> +				ret = off - *ki_pos;
> +				*ki_pos = off;
> +			}
>   		}
> -	}
> -
> -	if (last_objver && ret > 0)
> -		*last_objver = objver;
>   
> +		if (last_objver)
> +			*last_objver = objver;
> +	}
>   	dout("sync_read result %zd retry_op %d\n", ret, *retry_op);
>   	return ret;
>   }
> @@ -1532,6 +1572,9 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>   		last = (pos + len) != (write_pos + write_len);
>   		rmw = first || last;
>   
> +		dout("sync_write ino %llx %lld~%llu adjusted %lld~%llu -- %srmw\n",
> +		     ci->i_vino.ino, pos, len, write_pos, write_len, rmw ? "" : "no ");
> +

Should this move to the previous patch ?


>   		/*
>   		 * The data is emplaced into the page as it would be if it were in
>   		 * an array of pagecache pages.
> @@ -1761,6 +1804,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>   		ceph_clear_error_write(ci);
>   		pos += len;
>   		written += len;
> +		dout("sync_write written %d\n", written);
>   		if (pos > i_size_read(inode)) {
>   			check_caps = ceph_inode_set_size(inode, pos);
>   			if (check_caps)

