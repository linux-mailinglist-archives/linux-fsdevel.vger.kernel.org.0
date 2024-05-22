Return-Path: <linux-fsdevel+bounces-19943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB39D8CB6C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 02:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4711F22E65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 00:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1964A1C;
	Wed, 22 May 2024 00:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BL0kEqqg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01635211C
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 00:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716338285; cv=none; b=nIv5M4ZifVQQ/vEDGdxYC6sl/swKBp+nEpK2C6W3ol/dJEuQPaW/rSNR70kB1bYwwXOvRIaYrl9LPgQrDiOCKCeb2Kqtvd/sLSAoj6scxTUQYCDcfiRBPoHhjeu3TR3R5Txz1SQEUjELs/qZoyP9SDvR5nO+TOEPj5CRCFDp2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716338285; c=relaxed/simple;
	bh=LAj1b+bnCms4/xk1W3Z5rJaeVNK1RzfKlW1mijUnq80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfRhmW1jDztLbGEPv8h2Z2Z+M5hHTErKFEAsjOfnlbPYpNQuCjqYFIojKiPfRmAqO9SqIexY7DylMUt4Fh6GhzsPrWZ4ozKO3dirIzn44AS4mDsIUzSPV365EvvAzKQRCgVJUGsufjgYlP0AQ5nJXGzeKXpFSBhvCwYG9CMjngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BL0kEqqg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716338282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5+Ml59SARQSuVhVqvLQWFYKARbZIUTwBnysaBLWgyU=;
	b=BL0kEqqgPxvC/qKElxaY4ensU9xUectRs0VwJYY2kvftfGkha68v4JOPB/or0EYwfLzrON
	X64qrcChwis+6Cghqm00relrOwpQz8gZeCNMm4wGdyT9zL4tBsKnakBz4e6/++yAE2ZYnk
	Fjt6kQYtUHpv9GrIi10DuFzlEU4nXJk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-kJvQRi3VPoiE0uKULhcT0Q-1; Tue, 21 May 2024 20:38:01 -0400
X-MC-Unique: kJvQRi3VPoiE0uKULhcT0Q-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6f6a41800baso319114b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 17:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716338280; x=1716943080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5+Ml59SARQSuVhVqvLQWFYKARbZIUTwBnysaBLWgyU=;
        b=GuWamTU4WvzR29xT7KtBaRc5N+dvK5zFDKzOXzJMvIyWLXbyLCjTsbeWV5pcwRP7aN
         YiaDPPfM8UenxDB7BgOt86ZUAOA2wDRHXuR73Dj1oHke1PkT7qUDhnFMXy1dgCncbnUE
         lnVzy+GtR1hxh8zsp4ICEGiDCHGgxd4cGLxA2A3ZAwGzBXlYk9Emr+CzoLbEo2NQFyOO
         2RovEbNxM3fXNiL/IbLt2MUFsdIfE0kY4doGYO4ElKJVXtgHLEfqvXwFbuLFxNkoP9kI
         X/X/cnEHeOuapGzPvvg3VP6/pMVb58FCLIHue6NhYJqdV8JYfunk2ZNrMfSfnf0M+IaT
         TjWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhqy4HZh9bYQ9gOJCQpjyf8WCRkdFw6g4f2jvfal4Eky97NLmSLWGMJeVB68Wml401JEaPUFWVQpQ3dcTWaS6Ef6R5yEou6s2cGi73vw==
X-Gm-Message-State: AOJu0YxETOoy43qrvY61LSxk90zQxBoqCP2kZtlex3tHjsaXWN+KTMbm
	AXDa+SofwoB0MhMUzjcgI31k5MWg5JLfOF+UROxl9jlNFCl/1Rc/YyAR0lAF6F1TV9UZ0rxvxvA
	nKJQkGdIRX8TH1MeDFaoa5q/IQpI9mMs+EcOHFWQqmsVc0RB91aMtVCC8Bgal2Ls=
X-Received: by 2002:a05:6a00:2e02:b0:6f4:9fc7:d239 with SMTP id d2e1a72fcca58-6f69fc6d156mr18259133b3a.14.1716338280044;
        Tue, 21 May 2024 17:38:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8g4v0rGDxwPSEFVgieLMxzSKkG2WDTV5Q9c2aX+9gur91SnL1iT4TrvoZ73SO1oZm9pnZtw==
X-Received: by 2002:a05:6a00:2e02:b0:6f4:9fc7:d239 with SMTP id d2e1a72fcca58-6f69fc6d156mr18259049b3a.14.1716338278556;
        Tue, 21 May 2024 17:37:58 -0700 (PDT)
Received: from [10.72.116.32] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d6b71760sm21601587b3a.97.2024.05.21.17.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 17:37:58 -0700 (PDT)
Message-ID: <d8d3eeea-5425-48d4-ab80-a37cc340e8d2@redhat.com>
Date: Wed, 22 May 2024 08:37:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/11] ceph: drop usage of page_index
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Huang, Ying" <ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>,
 Minchan Kim <minchan@kernel.org>, David Hildenbrand <david@redhat.com>,
 Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>,
 ceph-devel@vger.kernel.org
References: <20240521175854.96038-1-ryncsn@gmail.com>
 <20240521175854.96038-4-ryncsn@gmail.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20240521175854.96038-4-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/22/24 01:58, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
>
> page_index is needed for mixed usage of page cache and swap cache,
> for pure page cache usage, the caller can just use page->index instead.
>
> It can't be a swap cache page here, so just drop it.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: Xiubo Li <xiubli@redhat.com>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: ceph-devel@vger.kernel.org
> ---
>   fs/ceph/dir.c   | 2 +-
>   fs/ceph/inode.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 0e9f56eaba1e..570a9d634cc5 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -141,7 +141,7 @@ __dcache_find_get_entry(struct dentry *parent, u64 idx,
>   	if (ptr_pos >= i_size_read(dir))
>   		return NULL;
>   
> -	if (!cache_ctl->page || ptr_pgoff != page_index(cache_ctl->page)) {
> +	if (!cache_ctl->page || ptr_pgoff != cache_ctl->page->index) {
>   		ceph_readdir_cache_release(cache_ctl);
>   		cache_ctl->page = find_lock_page(&dir->i_data, ptr_pgoff);
>   		if (!cache_ctl->page) {
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 99561fddcb38..a69570ea2c19 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1863,7 +1863,7 @@ static int fill_readdir_cache(struct inode *dir, struct dentry *dn,
>   	unsigned idx = ctl->index % nsize;
>   	pgoff_t pgoff = ctl->index / nsize;
>   
> -	if (!ctl->page || pgoff != page_index(ctl->page)) {
> +	if (!ctl->page || pgoff != ctl->page->index) {
>   		ceph_readdir_cache_release(ctl);
>   		if (idx == 0)
>   			ctl->page = grab_cache_page(&dir->i_data, pgoff);

Reviewed-by: Xiubo Li <xiubli@redhat.com>



