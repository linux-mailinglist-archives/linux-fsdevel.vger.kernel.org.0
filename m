Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C061248C020
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 09:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351712AbiALIl5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 03:41:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351717AbiALIl4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641976915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tLjy2rg3eYJZHOVGz1wK9X9TJj4518h1B0FxavhQ9qY=;
        b=TH+g19q/5YuWycISBeL58qDnjypuj6Q/qL0nrGebfBX8GYHOwIWW92hPsd7oJEfQFA1cl3
        1Z/tYx/wcDas0/7mNilcAqVwCp27IooT+H+kT9DA3+ST+7lNh5eQQ2VpDqhk1X6ymTR/1q
        ptueaTZIQXk1m/WTuZRAQAM8PHSOgZA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-F_LKmpk1MmGJ2W8F9cQhYQ-1; Wed, 12 Jan 2022 03:41:52 -0500
X-MC-Unique: F_LKmpk1MmGJ2W8F9cQhYQ-1
Received: by mail-pj1-f69.google.com with SMTP id u13-20020a17090a450d00b001b1e6726fccso6069462pjg.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jan 2022 00:41:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tLjy2rg3eYJZHOVGz1wK9X9TJj4518h1B0FxavhQ9qY=;
        b=xh7YPkk2WicKgyxRu70R1mF3P1dfiax9zaGzAs2z/sEDtYRiq4+7qTL+n1F4w3Sr0h
         TbUBgFth+NvxzLoxcfUvJOqs+1eMGqQqM+n/5hk4tO6G7XXlg7H6SrTdqIQR/4NOlM9q
         OG8lb4cuSFq9zl6R/E1hRmPi3g52eJlRLYgM+4DtNUx0i+wgDykNEq/vsx8BIksMDAwS
         Z5I8qwRlc/SOVotQkel4PwX70jJEid9PAWNv48HBPB2MOCuskfLLJsud61w+Ijn+rJC0
         sNQl6IkXnDphWDMg+l/k9Zn3H4+/2IiwLHIdtItKLryv3pEsC21W1PDUcFfbltzFQxg/
         +wEw==
X-Gm-Message-State: AOAM533kKp78L3+xt0qI3rRtSCb/lhe7S+UyyGgC7v0g4b+VclSIOxFV
        PVI+c/xvrjLKr8fCKTUeKVI3sDkXtLue3vKtGE9YgnS9moV3YxsMbl+57mn4fx2yYf9pgNGz0Mu
        gzAc29Ikqg+URPoGh+8mnS2th/w==
X-Received: by 2002:a63:7983:: with SMTP id u125mr7480586pgc.569.1641976910910;
        Wed, 12 Jan 2022 00:41:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwtA+bgpGtUnTrdt2hOvbxUZIqX58pKsNaBle5eTy1i0kMJ70jXyiP99dQC+C4WvrZ0RTdQsQ==
X-Received: by 2002:a63:7983:: with SMTP id u125mr7480549pgc.569.1641976910354;
        Wed, 12 Jan 2022 00:41:50 -0800 (PST)
Received: from [10.72.13.223] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u3sm13374787pfk.82.2022.01.12.00.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 00:41:48 -0800 (PST)
Subject: Re: [RFC PATCH v10 36/48] ceph: add truncate size handling support
 for fscrypt
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
References: <20220111191608.88762-1-jlayton@kernel.org>
 <20220111191608.88762-37-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <71750767-d0b6-26e7-f2b3-0968f2b7e0b9@redhat.com>
Date:   Wed, 12 Jan 2022 16:41:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220111191608.88762-37-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff,

I have post the V8 for this patch by switching the 'header.objver' to 
'header.change_attr' to gate the truncate operation to fix the first 
notable bug you mentioned in the cover-letter.

Regards

-- Xiubo


On 1/12/22 3:15 AM, Jeff Layton wrote:
> From: Xiubo Li <xiubli@redhat.com>
>
> This will transfer the encrypted last block contents to the MDS
> along with the truncate request only when the new size is smaller
> and not aligned to the fscrypt BLOCK size. When the last block is
> located in the file hole, the truncate request will only contain
> the header.
>
> The MDS could fail to do the truncate if there has another client
> or process has already updated the RADOS object which contains
> the last block, and will return -EAGAIN, then the kclient needs
> to retry it. The RMW will take around 50ms, and will let it retry
> 20 times for now.
>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/crypto.h |  21 +++++
>   fs/ceph/inode.c  | 217 ++++++++++++++++++++++++++++++++++++++++++++---
>   fs/ceph/super.h  |   5 ++
>   3 files changed, 229 insertions(+), 14 deletions(-)
>
> diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> index b5d360085fe8..3b7efffecbeb 100644
> --- a/fs/ceph/crypto.h
> +++ b/fs/ceph/crypto.h
> @@ -25,6 +25,27 @@ struct ceph_fname {
>   	u32		ctext_len;	// length of crypttext
>   };
>   
> +/*
> + * Header for the crypted file when truncating the size, this
> + * will be sent to MDS, and the MDS will update the encrypted
> + * last block and then truncate the size.
> + */
> +struct ceph_fscrypt_truncate_size_header {
> +       __u8  ver;
> +       __u8  compat;
> +
> +       /*
> +	* It will be sizeof(assert_ver + file_offset + block_size)
> +	* if the last block is empty when it's located in a file
> +	* hole. Or the data_len will plus CEPH_FSCRYPT_BLOCK_SIZE.
> +	*/
> +       __le32 data_len;
> +
> +       __le64 assert_ver;
> +       __le64 file_offset;
> +       __le32 block_size;
> +} __packed;
> +
>   struct ceph_fscrypt_auth {
>   	__le32	cfa_version;
>   	__le32	cfa_blob_len;
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 2497306eef58..eecda0a73908 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -586,6 +586,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
>   	ci->i_truncate_seq = 0;
>   	ci->i_truncate_size = 0;
>   	ci->i_truncate_pending = 0;
> +	ci->i_truncate_pagecache_size = 0;
>   
>   	ci->i_max_size = 0;
>   	ci->i_reported_size = 0;
> @@ -759,6 +760,10 @@ int ceph_fill_file_size(struct inode *inode, int issued,
>   		dout("truncate_size %lld -> %llu\n", ci->i_truncate_size,
>   		     truncate_size);
>   		ci->i_truncate_size = truncate_size;
> +		if (IS_ENCRYPTED(inode))
> +			ci->i_truncate_pagecache_size = size;
> +		else
> +			ci->i_truncate_pagecache_size = truncate_size;
>   	}
>   	return queue_trunc;
>   }
> @@ -1015,7 +1020,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
>   
>   	if (new_version ||
>   	    (new_issued & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR))) {
> -		u64 size = info->size;
> +		u64 size = le64_to_cpu(info->size);
>   		s64 old_pool = ci->i_layout.pool_id;
>   		struct ceph_string *old_ns;
>   
> @@ -1030,16 +1035,20 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
>   		pool_ns = old_ns;
>   
>   		if (IS_ENCRYPTED(inode) && size &&
> -		    (iinfo->fscrypt_file_len == sizeof(__le64))) {
> -			size = __le64_to_cpu(*(__le64 *)iinfo->fscrypt_file);
> -			if (info->size != round_up(size, CEPH_FSCRYPT_BLOCK_SIZE))
> -				pr_warn("size=%llu fscrypt_file=%llu\n", info->size, size);
> +		    (iinfo->fscrypt_file_len >= sizeof(__le64))) {
> +			u64 fsize = __le64_to_cpu(*(__le64 *)iinfo->fscrypt_file);
> +			if (fsize) {
> +				size = fsize;
> +				if (le64_to_cpu(info->size) !=
> +				    round_up(size, CEPH_FSCRYPT_BLOCK_SIZE))
> +					pr_warn("size=%llu fscrypt_file=%llu\n",
> +						info->size, size);
> +			}
>   		}
>   
>   		queue_trunc = ceph_fill_file_size(inode, issued,
>   					le32_to_cpu(info->truncate_seq),
> -					le64_to_cpu(info->truncate_size),
> -					le64_to_cpu(size));
> +					le64_to_cpu(info->truncate_size), size);
>   		/* only update max_size on auth cap */
>   		if ((info->cap.flags & CEPH_CAP_FLAG_AUTH) &&
>   		    ci->i_max_size != le64_to_cpu(info->max_size)) {
> @@ -2153,7 +2162,7 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
>   	/* there should be no reader or writer */
>   	WARN_ON_ONCE(ci->i_rd_ref || ci->i_wr_ref);
>   
> -	to = ci->i_truncate_size;
> +	to = ci->i_truncate_pagecache_size;
>   	wrbuffer_refs = ci->i_wrbuffer_ref;
>   	dout("__do_pending_vmtruncate %p (%d) to %lld\n", inode,
>   	     ci->i_truncate_pending, to);
> @@ -2163,7 +2172,7 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
>   	truncate_pagecache(inode, to);
>   
>   	spin_lock(&ci->i_ceph_lock);
> -	if (to == ci->i_truncate_size) {
> +	if (to == ci->i_truncate_pagecache_size) {
>   		ci->i_truncate_pending = 0;
>   		finish = 1;
>   	}
> @@ -2244,6 +2253,143 @@ static const struct inode_operations ceph_encrypted_symlink_iops = {
>   	.listxattr = ceph_listxattr,
>   };
>   
> +/*
> + * Transfer the encrypted last block to the MDS and the MDS
> + * will help update it when truncating a smaller size.
> + *
> + * We don't support a PAGE_SIZE that is smaller than the
> + * CEPH_FSCRYPT_BLOCK_SIZE.
> + */
> +static int fill_fscrypt_truncate(struct inode *inode,
> +				 struct ceph_mds_request *req,
> +				 struct iattr *attr)
> +{
> +	struct ceph_inode_info *ci = ceph_inode(inode);
> +	int boff = attr->ia_size % CEPH_FSCRYPT_BLOCK_SIZE;
> +	loff_t pos, orig_pos = round_down(attr->ia_size, CEPH_FSCRYPT_BLOCK_SIZE);
> +	u64 block = orig_pos >> CEPH_FSCRYPT_BLOCK_SHIFT;
> +	struct ceph_pagelist *pagelist = NULL;
> +	struct kvec iov;
> +	struct iov_iter iter;
> +	struct page *page = NULL;
> +	struct ceph_fscrypt_truncate_size_header header;
> +	int retry_op = 0;
> +	int len = CEPH_FSCRYPT_BLOCK_SIZE;
> +	loff_t i_size = i_size_read(inode);
> +	int got, ret, issued;
> +	u64 objver;
> +
> +	ret = __ceph_get_caps(inode, NULL, CEPH_CAP_FILE_RD, 0, -1, &got);
> +	if (ret < 0)
> +		return ret;
> +
> +	issued = __ceph_caps_issued(ci, NULL);
> +
> +	dout("%s size %lld -> %lld got cap refs on %s, issued %s\n", __func__,
> +	     i_size, attr->ia_size, ceph_cap_string(got),
> +	     ceph_cap_string(issued));
> +
> +	/* Try to writeback the dirty pagecaches */
> +	if (issued & (CEPH_CAP_FILE_BUFFER))
> +		filemap_write_and_wait(inode->i_mapping);
> +
> +	page = __page_cache_alloc(GFP_KERNEL);
> +	if (page == NULL) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	pagelist = ceph_pagelist_alloc(GFP_KERNEL);
> +	if (!pagelist) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	iov.iov_base = kmap_local_page(page);
> +	iov.iov_len = len;
> +	iov_iter_kvec(&iter, READ, &iov, 1, len);
> +
> +	pos = orig_pos;
> +	ret = __ceph_sync_read(inode, &pos, &iter, &retry_op, &objver);
> +	ceph_put_cap_refs(ci, got);
> +	if (ret < 0)
> +		goto out;
> +
> +	/* Insert the header first */
> +	header.ver = 1;
> +	header.compat = 1;
> +
> +	/*
> +	 * Always set the block_size to CEPH_FSCRYPT_BLOCK_SIZE,
> +	 * because in MDS it may need this to do the truncate.
> +	 */
> +	header.block_size = cpu_to_le32(CEPH_FSCRYPT_BLOCK_SIZE);
> +
> +	/*
> +	 * If we hit a hole here, we should just skip filling
> +	 * the fscrypt for the request, because once the fscrypt
> +	 * is enabled, the file will be split into many blocks
> +	 * with the size of CEPH_FSCRYPT_BLOCK_SIZE, if there
> +	 * has a hole, the hole size should be multiple of block
> +	 * size.
> +	 *
> +	 * If the Rados object doesn't exist, it will be set 0.
> +	 */
> +	if (!objver) {
> +		dout("%s hit hole, ppos %lld < size %lld\n", __func__,
> +		     pos, i_size);
> +
> +		header.data_len = cpu_to_le32(8 + 8 + 4);
> +
> +		/*
> +		 * If the "assert_ver" is 0 means hitting a hole, and
> +		 * the MDS will use the it to check whether hitting a
> +		 * hole or not.
> +		 */
> +		header.assert_ver = 0;
> +		header.file_offset = 0;
> +		ret = 0;
> +	} else {
> +		header.data_len = cpu_to_le32(8 + 8 + 4 + CEPH_FSCRYPT_BLOCK_SIZE);
> +		header.assert_ver = cpu_to_le64(objver);
> +		header.file_offset = cpu_to_le64(orig_pos);
> +
> +		/* truncate and zero out the extra contents for the last block */
> +		memset(iov.iov_base + boff, 0, PAGE_SIZE - boff);
> +
> +		/* encrypt the last block */
> +		ret = ceph_fscrypt_encrypt_block_inplace(inode, page,
> +						    CEPH_FSCRYPT_BLOCK_SIZE,
> +						    0, block,
> +						    GFP_KERNEL);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	/* Insert the header */
> +	ret = ceph_pagelist_append(pagelist, &header, sizeof(header));
> +	if (ret)
> +		goto out;
> +
> +	if (header.block_size) {
> +		/* Append the last block contents to pagelist */
> +		ret = ceph_pagelist_append(pagelist, iov.iov_base,
> +					   CEPH_FSCRYPT_BLOCK_SIZE);
> +		if (ret)
> +			goto out;
> +	}
> +	req->r_pagelist = pagelist;
> +out:
> +	dout("%s %p size dropping cap refs on %s\n", __func__,
> +	     inode, ceph_cap_string(got));
> +	kunmap_local(iov.iov_base);
> +	if (page)
> +		__free_pages(page, 0);
> +	if (ret && pagelist)
> +		ceph_pagelist_release(pagelist);
> +	return ret;
> +}
> +
>   int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *cia)
>   {
>   	struct ceph_inode_info *ci = ceph_inode(inode);
> @@ -2251,13 +2397,17 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *c
>   	struct ceph_mds_request *req;
>   	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
>   	struct ceph_cap_flush *prealloc_cf;
> +	loff_t isize = i_size_read(inode);
>   	int issued;
>   	int release = 0, dirtied = 0;
>   	int mask = 0;
>   	int err = 0;
>   	int inode_dirty_flags = 0;
>   	bool lock_snap_rwsem = false;
> +	bool fill_fscrypt;
> +	int truncate_retry = 20; /* The RMW will take around 50ms */
>   
> +retry:
>   	prealloc_cf = ceph_alloc_cap_flush();
>   	if (!prealloc_cf)
>   		return -ENOMEM;
> @@ -2269,6 +2419,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *c
>   		return PTR_ERR(req);
>   	}
>   
> +	fill_fscrypt = false;
>   	spin_lock(&ci->i_ceph_lock);
>   	issued = __ceph_caps_issued(ci, NULL);
>   
> @@ -2390,10 +2541,27 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *c
>   		}
>   	}
>   	if (ia_valid & ATTR_SIZE) {
> -		loff_t isize = i_size_read(inode);
> -
>   		dout("setattr %p size %lld -> %lld\n", inode, isize, attr->ia_size);
> -		if ((issued & CEPH_CAP_FILE_EXCL) && attr->ia_size >= isize) {
> +		/*
> +		 * Only when the new size is smaller and not aligned to
> +		 * CEPH_FSCRYPT_BLOCK_SIZE will the RMW is needed.
> +		 */
> +		if (IS_ENCRYPTED(inode) && attr->ia_size < isize &&
> +		    (attr->ia_size % CEPH_FSCRYPT_BLOCK_SIZE)) {
> +			mask |= CEPH_SETATTR_SIZE;
> +			release |= CEPH_CAP_FILE_SHARED | CEPH_CAP_FILE_EXCL |
> +				   CEPH_CAP_FILE_RD | CEPH_CAP_FILE_WR;
> +			set_bit(CEPH_MDS_R_FSCRYPT_FILE, &req->r_req_flags);
> +			mask |= CEPH_SETATTR_FSCRYPT_FILE;
> +			req->r_args.setattr.size =
> +				cpu_to_le64(round_up(attr->ia_size,
> +						     CEPH_FSCRYPT_BLOCK_SIZE));
> +			req->r_args.setattr.old_size =
> +				cpu_to_le64(round_up(isize,
> +						     CEPH_FSCRYPT_BLOCK_SIZE));
> +			req->r_fscrypt_file = attr->ia_size;
> +			fill_fscrypt = true;
> +		} else if ((issued & CEPH_CAP_FILE_EXCL) && attr->ia_size >= isize) {
>   			if (attr->ia_size > isize) {
>   				i_size_write(inode, attr->ia_size);
>   				inode->i_blocks = calc_inode_blocks(attr->ia_size);
> @@ -2416,7 +2584,6 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *c
>   					cpu_to_le64(round_up(isize,
>   							     CEPH_FSCRYPT_BLOCK_SIZE));
>   				req->r_fscrypt_file = attr->ia_size;
> -				/* FIXME: client must zero out any partial blocks! */
>   			} else {
>   				req->r_args.setattr.size = cpu_to_le64(attr->ia_size);
>   				req->r_args.setattr.old_size = cpu_to_le64(isize);
> @@ -2482,8 +2649,10 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *c
>   
>   	release &= issued;
>   	spin_unlock(&ci->i_ceph_lock);
> -	if (lock_snap_rwsem)
> +	if (lock_snap_rwsem) {
>   		up_read(&mdsc->snap_rwsem);
> +		lock_snap_rwsem = false;
> +	}
>   
>   	if (inode_dirty_flags)
>   		__mark_inode_dirty(inode, inode_dirty_flags);
> @@ -2495,7 +2664,27 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *c
>   		req->r_args.setattr.mask = cpu_to_le32(mask);
>   		req->r_num_caps = 1;
>   		req->r_stamp = attr->ia_ctime;
> +		if (fill_fscrypt) {
> +			err = fill_fscrypt_truncate(inode, req, attr);
> +			if (err)
> +				goto out;
> +		}
> +
> +		/*
> +		 * The truncate request will return -EAGAIN when the
> +		 * last block has been updated just before the MDS
> +		 * successfully gets the xlock for the FILE lock. To
> +		 * avoid corrupting the file contents we need to retry
> +		 * it.
> +		 */
>   		err = ceph_mdsc_do_request(mdsc, NULL, req);
> +		if (err == -EAGAIN && truncate_retry--) {
> +			dout("setattr %p result=%d (%s locally, %d remote), retry it!\n",
> +			     inode, err, ceph_cap_string(dirtied), mask);
> +			ceph_mdsc_put_request(req);
> +			ceph_free_cap_flush(prealloc_cf);
> +			goto retry;
> +		}
>   	}
>   out:
>   	dout("setattr %p result=%d (%s locally, %d remote)\n", inode, err,
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 4d2ccb51fe61..cd4a83fcbc0f 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -410,6 +410,11 @@ struct ceph_inode_info {
>   	u32 i_truncate_seq;        /* last truncate to smaller size */
>   	u64 i_truncate_size;       /*  and the size we last truncated down to */
>   	int i_truncate_pending;    /*  still need to call vmtruncate */
> +	/*
> +	 * For none fscrypt case it equals to i_truncate_size or it will
> +	 * equals to fscrypt_file_size
> +	 */
> +	u64 i_truncate_pagecache_size;
>   
>   	u64 i_max_size;            /* max file size authorized by mds */
>   	u64 i_reported_size; /* (max_)size reported to or requested of mds */

