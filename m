Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D40493393
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 04:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351195AbiASDVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 22:21:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349477AbiASDVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642562494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zI5/M4hZ3G0MvfuHbi3Z73517/vGjVqZ2PVlZvkizhw=;
        b=hTSEcHsGfnASJdtGwPtfqPv+1/NWQQZO7oHumaPy9/1kNxj9pgmD3ZFMwAwXN44UD2q64l
        32I+9xPWoQykefzWUigzO/G03GBNK8oISag35NlMqOsyq3YXKIbNRwE34EMw+TjH7AUVWq
        CAx1px5pgmuCBA7gaHHDExkRbVotJOs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-Fy2aexfKOAWpWWkwhPk3qw-1; Tue, 18 Jan 2022 22:21:33 -0500
X-MC-Unique: Fy2aexfKOAWpWWkwhPk3qw-1
Received: by mail-pl1-f200.google.com with SMTP id l9-20020a170903120900b0014a4205ebe3so223676plh.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jan 2022 19:21:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zI5/M4hZ3G0MvfuHbi3Z73517/vGjVqZ2PVlZvkizhw=;
        b=fVVyJ2tcwV4poarqEWAuoLH3FKDBMu6t4JtwhOhyFzZjWWo9egf75XdwTeC6N9CAwn
         rkXa6oiwa5iKxdSLPQo3VRsLArknC8pFpU16hUCZHMVFa0N7EblslvUeWy7wsXslo8WT
         QnLt90reiz8sxYr0PS7/QZ7PR/XnHAe+9w59SQxQv5fdCRUVqwL+cEkrZax9tceAouhe
         MG3Wn4YjLHiP0VRn1mCXHVnbQCfLd6xOBCJmOYCioCToH54zNqAMgcDIlTHCeyBOj/eH
         h9YDtxrvr6cSEF7FJSzF/ADATeHLpO+b0u74rDGWld+SwGyPIMOrz9upR4iXYRDPu7aI
         vm5g==
X-Gm-Message-State: AOAM531CAD+ZfmcyFud/9TeRgyK2y1zSFQ9UTgJuLSaN1yOz6rQULMxG
        /+phbBwJR4OVYuwD6TZAnaFVG+rGZmZdErt3BlzUMvSvsvqXKh9fXyUs4NAkB8rXQm9zAX3Pr2T
        cwos+r5noF8ytIXaTFC2P23ISRg==
X-Received: by 2002:aa7:92c5:0:b0:4bd:9f44:9562 with SMTP id k5-20020aa792c5000000b004bd9f449562mr28517017pfa.80.1642562492085;
        Tue, 18 Jan 2022 19:21:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2r+ku1Gi345okF1G1cUNAm3eTq99Z/1eJVnAAZONCVQGpw9OnTTrFwzEIEapqCSS2F+CGDg==
X-Received: by 2002:aa7:92c5:0:b0:4bd:9f44:9562 with SMTP id k5-20020aa792c5000000b004bd9f449562mr28516994pfa.80.1642562491722;
        Tue, 18 Jan 2022 19:21:31 -0800 (PST)
Received: from [10.72.12.81] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x20sm1732596pjk.29.2022.01.18.19.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 19:21:31 -0800 (PST)
Subject: Re: [RFC PATCH v10 43/48] ceph: add read/modify/write to
 ceph_sync_write
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
References: <20220111191608.88762-1-jlayton@kernel.org>
 <20220111191608.88762-44-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <0992447d-3522-c5d5-5d4b-1875e9d3128f@redhat.com>
Date:   Wed, 19 Jan 2022 11:21:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220111191608.88762-44-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 1/12/22 3:16 AM, Jeff Layton wrote:
> When doing a synchronous write on an encrypted inode, we have no
> guarantee that the caller is writing crypto block-aligned data. When
> that happens, we must do a read/modify/write cycle.
>
> First, expand the range to cover complete blocks. If we had to change
> the original pos or length, issue a read to fill the first and/or last
> pages, and fetch the version of the object from the result.
>
> We then copy data into the pages as usual, encrypt the result and issue
> a write prefixed by an assertion that the version hasn't changed. If it has
> changed then we restart the whole thing again.
>
> If there is no object at that position in the file (-ENOENT), we prefix
> the write on an exclusive create of the object instead.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/file.c | 260 +++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 228 insertions(+), 32 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index a6305ad5519b..41766b2012e9 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1468,18 +1468,16 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>   	struct inode *inode = file_inode(file);
>   	struct ceph_inode_info *ci = ceph_inode(inode);
>   	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
> -	struct ceph_vino vino;
> +	struct ceph_osd_client *osdc = &fsc->client->osdc;
>   	struct ceph_osd_request *req;
>   	struct page **pages;
>   	u64 len;
>   	int num_pages;
>   	int written = 0;
> -	int flags;
>   	int ret;
>   	bool check_caps = false;
>   	struct timespec64 mtime = current_time(inode);
>   	size_t count = iov_iter_count(from);
> -	size_t off;
>   
>   	if (ceph_snap(file_inode(file)) != CEPH_NOSNAP)
>   		return -EROFS;
> @@ -1499,70 +1497,267 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>   	if (ret < 0)
>   		dout("invalidate_inode_pages2_range returned %d\n", ret);
>   
> -	flags = /* CEPH_OSD_FLAG_ORDERSNAP | */ CEPH_OSD_FLAG_WRITE;
> -
>   	while ((len = iov_iter_count(from)) > 0) {
>   		size_t left;
>   		int n;
> +		u64 write_pos = pos;
> +		u64 write_len = len;
> +		u64 objnum, objoff;
> +		u32 xlen;
> +		u64 assert_ver;
> +		bool rmw;
> +		bool first, last;
> +		struct iov_iter saved_iter = *from;
> +		size_t off;
> +
> +		fscrypt_adjust_off_and_len(inode, &write_pos, &write_len);
> +
> +		/* clamp the length to the end of first object */
> +		ceph_calc_file_object_mapping(&ci->i_layout, write_pos,
> +						write_len, &objnum, &objoff,
> +						&xlen);
> +		write_len = xlen;
> +
> +		/* adjust len downward if it goes beyond current object */
> +		if (pos + len > write_pos + write_len)
> +			len = write_pos + write_len - pos;
>   
> -		vino = ceph_vino(inode);
> -		req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
> -					    vino, pos, &len, 0, 1,
> -					    CEPH_OSD_OP_WRITE, flags, snapc,
> -					    ci->i_truncate_seq,
> -					    ci->i_truncate_size,
> -					    false);
> -		if (IS_ERR(req)) {
> -			ret = PTR_ERR(req);
> -			break;
> -		}
> +		/*
> +		 * If we had to adjust the length or position to align with a
> +		 * crypto block, then we must do a read/modify/write cycle. We
> +		 * use a version assertion to redrive the thing if something
> +		 * changes in between.
> +		 */
> +		first = pos != write_pos;
> +		last = (pos + len) != (write_pos + write_len);
> +		rmw = first || last;
>   
> -		/* FIXME: express in FSCRYPT_BLOCK_SIZE units */
> -		num_pages = calc_pages_for(pos, len);
> +		/*
> +		 * The data is emplaced into the page as it would be if it were in
> +		 * an array of pagecache pages.
> +		 */
> +		num_pages = calc_pages_for(write_pos, write_len);
>   		pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
>   		if (IS_ERR(pages)) {
>   			ret = PTR_ERR(pages);
> -			goto out;
> +			break;
> +		}
> +
> +		/* Do we need to preload the pages? */
> +		if (rmw) {
> +			u64 first_pos = write_pos;
> +			u64 last_pos = (write_pos + write_len) - CEPH_FSCRYPT_BLOCK_SIZE;
> +			u64 read_len = CEPH_FSCRYPT_BLOCK_SIZE;
> +
> +			/* We should only need to do this for encrypted inodes */
> +			WARN_ON_ONCE(!IS_ENCRYPTED(inode));
> +
> +			/* No need to do two reads if first and last blocks are same */
> +			if (first && last_pos == first_pos)
> +				last = false;
> +
> +			/*
> +			 * Allocate a read request for one or two extents, depending
> +			 * on how the request was aligned.
> +			 */
> +			req = ceph_osdc_new_request(osdc, &ci->i_layout,
> +					ci->i_vino, first ? first_pos : last_pos,
> +					&read_len, 0, (first && last) ? 2 : 1,
> +					CEPH_OSD_OP_READ, CEPH_OSD_FLAG_READ,
> +					NULL, ci->i_truncate_seq,
> +					ci->i_truncate_size, false);
> +			if (IS_ERR(req)) {
> +				ceph_release_page_vector(pages, num_pages);
> +				ret = PTR_ERR(req);
> +				break;
> +			}
> +
> +			/* Something is misaligned! */
> +			if (read_len != CEPH_FSCRYPT_BLOCK_SIZE) {
> +				ret = -EIO;
> +				break;
> +			}

Do we need to call "ceph_release_page_vector()" here ?



> +
> +			/* Add extent for first block? */
> +			if (first)
> +				osd_req_op_extent_osd_data_pages(req, 0, pages,
> +							 CEPH_FSCRYPT_BLOCK_SIZE,
> +							 offset_in_page(first_pos),
> +							 false, false);
> +
> +			/* Add extent for last block */
> +			if (last) {
> +				/* Init the other extent if first extent has been used */
> +				if (first) {
> +					osd_req_op_extent_init(req, 1, CEPH_OSD_OP_READ,
> +							last_pos, CEPH_FSCRYPT_BLOCK_SIZE,
> +							ci->i_truncate_size,
> +							ci->i_truncate_seq);
> +				}
> +
> +				osd_req_op_extent_osd_data_pages(req, first ? 1 : 0,
> +							&pages[num_pages - 1],
> +							CEPH_FSCRYPT_BLOCK_SIZE,
> +							offset_in_page(last_pos),
> +							false, false);
> +			}
> +
> +			ret = ceph_osdc_start_request(osdc, req, false);
> +			if (!ret)
> +				ret = ceph_osdc_wait_request(osdc, req);
> +
> +			/* FIXME: length field is wrong if there are 2 extents */
> +			ceph_update_read_metrics(&fsc->mdsc->metric,
> +						 req->r_start_latency,
> +						 req->r_end_latency,
> +						 read_len, ret);
> +
> +			/* Ok if object is not already present */
> +			if (ret == -ENOENT) {
> +				/*
> +				 * If there is no object, then we can't assert
> +				 * on its version. Set it to 0, and we'll use an
> +				 * exclusive create instead.
> +				 */
> +				ceph_osdc_put_request(req);
> +				assert_ver = 0;
> +				ret = 0;
> +
> +				/*
> +				 * zero out the soon-to-be uncopied parts of the
> +				 * first and last pages.
> +				 */
> +				if (first)
> +					zero_user_segment(pages[0], 0,

The pages should already be released in "ceph_osdc_put_request()" ?


> +							  offset_in_page(first_pos));
> +				if (last)
> +					zero_user_segment(pages[num_pages - 1],
> +							  offset_in_page(last_pos),
> +							  PAGE_SIZE);
> +			} else {
> +				/* Grab assert version. It must be non-zero. */
> +				assert_ver = req->r_version;
> +				WARN_ON_ONCE(ret > 0 && assert_ver == 0);
> +
> +				ceph_osdc_put_request(req);
> +				if (ret < 0) {
> +					ceph_release_page_vector(pages, num_pages);

Shouldn't the pages are already released in "ceph_osdc_put_request()" ?

IMO you should put the request when you are breaking the while loop and 
just before the next "ceph_osdc_new_request()" below.



> +					break;
> +				}
> +
> +				if (first) {
> +					ret = ceph_fscrypt_decrypt_block_inplace(inode,
> +							pages[0],
> +							CEPH_FSCRYPT_BLOCK_SIZE,
> +							offset_in_page(first_pos),
> +							first_pos >> CEPH_FSCRYPT_BLOCK_SHIFT);
> +					if (ret < 0)
> +						break;
> +				}
> +				if (last) {
> +					ret = ceph_fscrypt_decrypt_block_inplace(inode,
> +							pages[num_pages - 1],
> +							CEPH_FSCRYPT_BLOCK_SIZE,
> +							offset_in_page(last_pos),
> +							last_pos >> CEPH_FSCRYPT_BLOCK_SHIFT);
> +					if (ret < 0)
> +						break;
> +				}
> +			}
>   		}
>   
>   		left = len;
> -		off = pos & ~CEPH_FSCRYPT_BLOCK_MASK;
> +		off = offset_in_page(pos);
>   		for (n = 0; n < num_pages; n++) {
> -			size_t plen = min_t(size_t, left, CEPH_FSCRYPT_BLOCK_SIZE - off);
> +			size_t plen = min_t(size_t, left, PAGE_SIZE - off);
> +
> +			/* copy the data */
>   			ret = copy_page_from_iter(pages[n], off, plen, from);
> -			off = 0;
>   			if (ret != plen) {
>   				ret = -EFAULT;
>   				break;
>   			}
> +			off = 0;
>   			left -= ret;
>   		}
> -
>   		if (ret < 0) {
> +			dout("sync_write write failed with %d\n", ret);
>   			ceph_release_page_vector(pages, num_pages);
> -			goto out;
> +			break;
>   		}
>   
> -		req->r_inode = inode;
> +		if (IS_ENCRYPTED(inode)) {
> +			ret = ceph_fscrypt_encrypt_pages(inode, pages,
> +							 write_pos, write_len,
> +							 GFP_KERNEL);
> +			if (ret < 0) {
> +				dout("encryption failed with %d\n", ret);
> +				break;
> +			}
> +		}
>   
> -		osd_req_op_extent_osd_data_pages(req, 0, pages, len,
> -						 pos & ~CEPH_FSCRYPT_BLOCK_MASK,
> -						 false, true);

The pages have already been released, you need to allocate new pages 
again here.

> +		req = ceph_osdc_new_request(osdc, &ci->i_layout,
> +					    ci->i_vino, write_pos, &write_len,
> +					    rmw ? 1 : 0, rmw ? 2 : 1,
> +					    CEPH_OSD_OP_WRITE,
> +					    CEPH_OSD_FLAG_WRITE,
> +					    snapc, ci->i_truncate_seq,
> +					    ci->i_truncate_size, false);
> +		if (IS_ERR(req)) {
> +			ret = PTR_ERR(req);
> +			ceph_release_page_vector(pages, num_pages);
> +			break;
> +		}
>   
> +		dout("sync_write write op %lld~%llu\n", write_pos, write_len);
> +		osd_req_op_extent_osd_data_pages(req, rmw ? 1 : 0, pages, write_len,
> +						 offset_in_page(write_pos), false,
> +						 true);
> +		req->r_inode = inode;
>   		req->r_mtime = mtime;
> -		ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
> +
> +		/* Set up the assertion */
> +		if (rmw) {
> +			/*
> +			 * Set up the assertion. If we don't have a version number,
> +			 * then the object doesn't exist yet. Use an exclusive create
> +			 * instead of a version assertion in that case.
> +			 */
> +			if (assert_ver) {
> +				osd_req_op_init(req, 0, CEPH_OSD_OP_ASSERT_VER, 0);
> +				req->r_ops[0].assert_ver.ver = assert_ver;
> +			} else {
> +				osd_req_op_init(req, 0, CEPH_OSD_OP_CREATE,
> +						CEPH_OSD_OP_FLAG_EXCL);
> +			}
> +		}
> +
> +		ret = ceph_osdc_start_request(osdc, req, false);
>   		if (!ret)
> -			ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
> +			ret = ceph_osdc_wait_request(osdc, req);
>   
>   		ceph_update_write_metrics(&fsc->mdsc->metric, req->r_start_latency,
>   					  req->r_end_latency, len, ret);
> -out:
>   		ceph_osdc_put_request(req);
>   		if (ret != 0) {
> +			dout("sync_write osd write returned %d\n", ret);
> +			/* Version changed! Must re-do the rmw cycle */
> +			if ((assert_ver && (ret == -ERANGE || ret == -EOVERFLOW)) ||
> +			     (!assert_ver && ret == -EEXIST)) {
> +				/* We should only ever see this on a rmw */
> +				WARN_ON_ONCE(!rmw);
> +
> +				/* The version should never go backward */
> +				WARN_ON_ONCE(ret == -EOVERFLOW);
> +
> +				*from = saved_iter;
> +
> +				/* FIXME: limit number of times we loop? */
> +				continue;
> +			}
>   			ceph_set_error_write(ci);
>   			break;
>   		}
> -
>   		ceph_clear_error_write(ci);
>   		pos += len;
>   		written += len;
> @@ -1580,6 +1775,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>   		ret = written;
>   		iocb->ki_pos = pos;
>   	}
> +	dout("sync_write returning %d\n", ret);
>   	return ret;
>   }
>   

