Return-Path: <linux-fsdevel+bounces-17572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6D68AFD11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 02:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21191F22919
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 00:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766CF4A18;
	Wed, 24 Apr 2024 00:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMt4CSqu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3426D36B
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 00:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713917013; cv=none; b=OQXbKi4uIjy/A4zXBXbKc5GM8zje8IsWh874nygslizaPHE4RF/qt6AM6Cng53viYznIYwXUdWBnUZ0KgvAQFNY/6zNvyPT1xSw/mwmxybpSpXYVcRdzJM1BgAHGR9/N7pcVccSeIslLzMLz856TtJxjWL65g4JHBSTjsUGTmd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713917013; c=relaxed/simple;
	bh=gsUtGZZq6fUGo0XzPltRplyvYybIdyhTRnloCzmNZws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCs8/fnfxBWgcRAre+KZQDt0+W6dhpd344BsSFmLB+ykfRqZpYtdJUYC244Yj8jlWKR0IcbjSh4HJJ/qX0z0090/oJTMXlXY63aN5rEEfQvd3OP8LEwA0U5krzk53iroSUy1BKjBiyBoDZg5+KajUn72jgs5+ouSr5dPxphC8aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMt4CSqu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713917011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+7QM8WAkcLyUMI8zMr5qB785VaErLLFUty72zypO/LA=;
	b=fMt4CSquVFIo0CqAIVr3ecAQU8EgVXTgl9SGDfFdb+ctUL0oLfXmPKGM4xxiRc3d4Jsux7
	clhSsg2jzAyzOG6538qq/JRk/MN3PXGQ3sYrWAsXLDwelMEshkM0iexRX3XK2CT7ztwEVK
	xllDtKee1denqBFOEyn1iyGTzpZiblk=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-iua59u9zMi-Y60CUVN8VSw-1; Tue, 23 Apr 2024 20:03:28 -0400
X-MC-Unique: iua59u9zMi-Y60CUVN8VSw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3c82c40251aso3529646b6e.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 17:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713917008; x=1714521808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7QM8WAkcLyUMI8zMr5qB785VaErLLFUty72zypO/LA=;
        b=aG7QqEDvNpMyVH2X2y5XaLhhS7H2RqfOHmdmGrcJY+VdZVCg3HFIxYS9y8u5yJ3wNl
         q6/0kP8fzowndMtj4/0DCw/W8oTa++D59x2cLm+1IEyhsmxaUKMFOQUZ+B/N1AdDvqSw
         Fs3Br+rNaVX4FnF8Dz5DA35TmJ345MvsXdDub4w95zopxEfso7MxltzRZCOUCdFgnKhd
         c/rnsuRpYUo2/QCl1rucbm29nx3ixT846fIfwzLHkJEQ7fcXONnXZDdDAZHuDVoF67Ag
         PcyPmUyzpyQhs+xrsTqaj/NpwF9evJ83VA7ihlrIVo8SUr++pFytt9Gw0zIW4KHLULXa
         86sA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ8+JUGMwysvMojp/TnsD44Z3BCdWJU5sW5qAtKeSgcJYoaXA7l1tY2C/4OFAOTPpK6MSSVpjbXjtG+sE/aVLK5C9Y+2JVB49+gOAPFg==
X-Gm-Message-State: AOJu0YzKMxx+gMLgxtp+ewZ5kYP7egN6y9YtOWPOJLJIYzSTaaXevVVA
	jJGaaCpSJxbSt8RbCCR5Co2cpomzFRwW/7zGHDfXLW0upq4Lv7WnRLT96xu2n9fdRtVjPtQpBs/
	xteycDb9fHw1Cpvp/Yr2jjvfuqmMVsZzxQgU7cCn7kTC/G41OV51w5dIsy0PkHeg=
X-Received: by 2002:a05:6870:b418:b0:221:1c2f:23ee with SMTP id x24-20020a056870b41800b002211c2f23eemr1001103oap.22.1713917008168;
        Tue, 23 Apr 2024 17:03:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOjc1kQNpUxZ3Tmzq9lEvctMcDPvQKtuoCt7wDBTr2svwK8MstO02ep08rCXVV0Zru+v4gUA==
X-Received: by 2002:a05:6870:b418:b0:221:1c2f:23ee with SMTP id x24-20020a056870b41800b002211c2f23eemr1001083oap.22.1713917007834;
        Tue, 23 Apr 2024 17:03:27 -0700 (PDT)
Received: from [10.72.116.107] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m2-20020a638c02000000b005e857e39b10sm10052652pgd.56.2024.04.23.17.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 17:03:27 -0700 (PDT)
Message-ID: <afdd1884-b1fd-42cc-b657-e2d397a7c197@redhat.com>
Date: Wed, 24 Apr 2024 08:03:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] ceph: drop usage of page_index
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Huang, Ying" <ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>,
 Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>,
 ceph-devel@vger.kernel.org
References: <20240423170339.54131-1-ryncsn@gmail.com>
 <20240423170339.54131-5-ryncsn@gmail.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20240423170339.54131-5-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/24/24 01:03, Kairui Song wrote:
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
> index 7b2e77517f23..1f92d3faaa6b 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1861,7 +1861,7 @@ static int fill_readdir_cache(struct inode *dir, struct dentry *dn,
>   	unsigned idx = ctl->index % nsize;
>   	pgoff_t pgoff = ctl->index / nsize;
>   
> -	if (!ctl->page || pgoff != page_index(ctl->page)) {
> +	if (!ctl->page || pgoff != ctl->page->index) {
>   		ceph_readdir_cache_release(ctl);
>   		if (idx == 0)
>   			ctl->page = grab_cache_page(&dir->i_data, pgoff);

LGTM.

Reviewed-by: Xiubo Li <xiubli@redhat.com>



