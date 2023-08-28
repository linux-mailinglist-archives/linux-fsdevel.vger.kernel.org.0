Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F0C78A3E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 03:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjH1BWF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Aug 2023 21:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjH1BWF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Aug 2023 21:22:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031B7116
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Aug 2023 18:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693185680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xmja/1PLodDJgYWKao/T5BYA/P9CEUYhsXxvzaEDO84=;
        b=Vb+g0Akiiuda7ZFswM5zT5HPzJcCnqCew7wm3QBM5L78I9Wj35iQI8vXqfVdjbOQ44P+qM
        UEzUFH7vp5hjIP+BKxGxI3w2Lgclor4rAJt1Slo0j8JKq663RxzhEJyAz3vcaCJa1vigrz
        eXSblJkS9E4JVENDKfyanFxmPfjo1Os=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-RKNBreczONiVo6kPsz0q2g-1; Sun, 27 Aug 2023 21:21:18 -0400
X-MC-Unique: RKNBreczONiVo6kPsz0q2g-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1c0a90de7a2so33394055ad.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Aug 2023 18:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693185677; x=1693790477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmja/1PLodDJgYWKao/T5BYA/P9CEUYhsXxvzaEDO84=;
        b=GA1p0p6xSRj1zIEfnGi+BDAC7E7RG13yA7GQgg7gLt0PwTGLKGylMpsFDxbJPJWV8a
         365NnEgUi3aSS7U8s3yKzcOh+uNMo+clpg6yDFgdunlh+AV+gbQ2i45W59WNTqVWAlSl
         8Qko9lewyHCxSgaVx9/dmYZ1GucTd1U+k2swFagf9wDFs5xexNzayzlWW7RAoC7AhLv3
         OAKuwyQ54eFYCvLeE6NND5jz6SeQaVttQrKLEGUaTdoTYK3VRtNmZy0ePmMhIqIqJ2Mq
         8KMv007VOEWJUK9bS6wn71jwjAhL1S4qVXNkcRtSwj5PDwFoSMLoM7fK4DEQwLnvhk36
         pfEg==
X-Gm-Message-State: AOJu0YyAhc8YjaglBQlr5PfifR1bYyhS0CXIDefHigYWnYZ9qbDFwtPu
        SB/S72x+2u3GE0mtOAEEsuhgt6OSMzlhlOLfQHACWN4sl+/FdeH2H9T95bbe3M7q1gNTxKMVmur
        2TjE0pl75N6bnSJXn8u8IP7hNSg==
X-Received: by 2002:a17:902:7c94:b0:1bb:cf58:531d with SMTP id y20-20020a1709027c9400b001bbcf58531dmr24304261pll.10.1693185677417;
        Sun, 27 Aug 2023 18:21:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk7z2kv2pO70y4enOxW6mKR03gcRasV88Uo9MokFbyZ79hWpRSjOtbgeIVRTN8HiEMpDLkug==
X-Received: by 2002:a17:902:7c94:b0:1bb:cf58:531d with SMTP id y20-20020a1709027c9400b001bbcf58531dmr24304256pll.10.1693185677109;
        Sun, 27 Aug 2023 18:21:17 -0700 (PDT)
Received: from [10.72.112.71] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d20-20020a170902c19400b001bd41b70b65sm5918115pld.49.2023.08.27.18.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 18:21:16 -0700 (PDT)
Message-ID: <ac005096-defd-0c3f-e5ef-37ca8dae9ed4@redhat.com>
Date:   Mon, 28 Aug 2023 09:21:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/15] ceph: Convert ceph_page_mkwrite() to use a folio
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
References: <20230825201225.348148-1-willy@infradead.org>
 <20230825201225.348148-3-willy@infradead.org>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230825201225.348148-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/26/23 04:12, Matthew Wilcox (Oracle) wrote:
> Operate on the entire folio instead of just the page.  There was an
> earlier effort to do this with thp_size(), but it had the exact type
> confusion between head & tail pages that folios are designed to avoid.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/ceph/addr.c | 35 +++++++++++++++++------------------
>   1 file changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 9a0a79833eb0..7c7dfcd63cd1 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1677,8 +1677,8 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
>   	struct ceph_inode_info *ci = ceph_inode(inode);
>   	struct ceph_file_info *fi = vma->vm_file->private_data;
>   	struct ceph_cap_flush *prealloc_cf;
> -	struct page *page = vmf->page;
> -	loff_t off = page_offset(page);
> +	struct folio *folio = page_folio(vmf->page);
> +	loff_t pos = folio_pos(folio);
>   	loff_t size = i_size_read(inode);
>   	size_t len;
>   	int want, got, err;
> @@ -1695,50 +1695,49 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
>   	sb_start_pagefault(inode->i_sb);
>   	ceph_block_sigs(&oldset);
>   
> -	if (off + thp_size(page) <= size)
> -		len = thp_size(page);
> -	else
> -		len = offset_in_thp(page, size);
> +	len = folio_size(folio);
> +	if (pos + folio_size(folio) > size)

s/folio_size(folio)/len/ ?


> +		len = size - pos;
>   
>   	dout("page_mkwrite %p %llx.%llx %llu~%zd getting caps i_size %llu\n",
> -	     inode, ceph_vinop(inode), off, len, size);
> +	     inode, ceph_vinop(inode), pos, len, size);
>   	if (fi->fmode & CEPH_FILE_MODE_LAZY)
>   		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
>   	else
>   		want = CEPH_CAP_FILE_BUFFER;
>   
>   	got = 0;
> -	err = ceph_get_caps(vma->vm_file, CEPH_CAP_FILE_WR, want, off + len, &got);
> +	err = ceph_get_caps(vma->vm_file, CEPH_CAP_FILE_WR, want, pos + len, &got);
>   	if (err < 0)
>   		goto out_free;
>   
>   	dout("page_mkwrite %p %llu~%zd got cap refs on %s\n",
> -	     inode, off, len, ceph_cap_string(got));
> +	     inode, pos, len, ceph_cap_string(got));
>   
> -	/* Update time before taking page lock */
> +	/* Update time before taking folio lock */
>   	file_update_time(vma->vm_file);
>   	inode_inc_iversion_raw(inode);
>   
>   	do {
>   		struct ceph_snap_context *snapc;
>   
> -		lock_page(page);
> +		folio_lock(folio);
>   
> -		if (page_mkwrite_check_truncate(page, inode) < 0) {
> -			unlock_page(page);
> +		if (folio_mkwrite_check_truncate(folio, inode) < 0) {
> +			folio_unlock(folio);
>   			ret = VM_FAULT_NOPAGE;
>   			break;
>   		}
>   
> -		snapc = ceph_find_incompatible(page);
> +		snapc = ceph_find_incompatible(&folio->page);
>   		if (!snapc) {
> -			/* success.  we'll keep the page locked. */
> -			set_page_dirty(page);
> +			/* success.  we'll keep the folio locked. */
> +			folio_mark_dirty(folio);
>   			ret = VM_FAULT_LOCKED;
>   			break;
>   		}
>   
> -		unlock_page(page);
> +		folio_unlock(folio);
>   
>   		if (IS_ERR(snapc)) {
>   			ret = VM_FAULT_SIGBUS;
> @@ -1762,7 +1761,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
>   	}
>   
>   	dout("page_mkwrite %p %llu~%zd dropping cap refs on %s ret %x\n",
> -	     inode, off, len, ceph_cap_string(got), ret);
> +	     inode, pos, len, ceph_cap_string(got), ret);
>   	ceph_put_cap_refs_async(ci, got);
>   out_free:
>   	ceph_restore_sigs(&oldset);

