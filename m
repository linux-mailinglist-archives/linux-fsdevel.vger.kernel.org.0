Return-Path: <linux-fsdevel+bounces-52148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB11AADFB5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 04:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E59C1899FE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 02:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6C522F386;
	Thu, 19 Jun 2025 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Su0j/k3L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349562B9AA
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 02:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750301143; cv=none; b=o6PtR3prx7NV49v7pOXdO/bekUbZzYGmm1SD3mjqBRpkYTo1RkmlInwExIn+BczmDQu0lK0OmX7Yq59JFqHmV/g1Fa8zTNY78qfsjqz1taPsW58eJMJe9rWmqEZSh+eU8FZv7ubog1vgJR/uSXmjla5Hr4HBwgBCbwnzuRGdI5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750301143; c=relaxed/simple;
	bh=yN5IRTf2bp0DFPhQIni3wnaPsQ3d+S++8/d0mRCJUJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAHtDrT/BAxLxuethEf6FZ+Vw/kEQFm+fEQ6oKV2XR7TWVFb7nL5wBqwf9xnbQRTwgpnEPg4GnsklAZvaXZ0c8pFyQ4PIvOgzyskefEMZM0GmTYZN9FlozQNtQkL/xBl/5HZT8YqNGy7nNMexQHD5rmI/o+HNBfu8NPFm9LTyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Su0j/k3L; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23636167b30so3271665ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 19:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750301141; x=1750905941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qVwsh/DCfF7Xz7iwx0RMWfoA+1QEfSvNmteXgwq8Uto=;
        b=Su0j/k3LLmd1VlxZSHNKn5kSjdNSMFD8W1+TZtg+83M9lKwHCnkh1uVSLjdOlGEp4g
         i2VD4Ii0o3P3JPMXvIGuTc3T5nrRyd9JvRFiXYtDxbhJeTcHdcbTJiCXW/vjlIgnuM2t
         +MwFI3iKpLApzgx6qcqdaWFCR1/eAPPKqBVUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750301141; x=1750905941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVwsh/DCfF7Xz7iwx0RMWfoA+1QEfSvNmteXgwq8Uto=;
        b=DlFTo60JfLCVD5b4mJtnBhJ4xqtLd24H9SSO/5nc6aulnpos4j5NdaixIHOzwnKrrp
         KXEPBrWPqVWV/6HWS0NXV/nu+iD9pOb0eTEGJ6BGhYH/MKcAEjsu0WpQrR/451uND6bv
         Ck6LpNXonhIDWk3D75UECBcisFjPRnMx0COsm8yqBMJNRlNoeUzLXS9ayI8SUoxwDriB
         CEW++OgtqMTouaGtjhRtPnM1dvSqcynfqW2Y4QwmsFSn7UHbDZvNjOlFs8OpRWl46Ubq
         cPL55uiIaEN7zsJejmD9vuPvs3crlcmY4uDQWuFJdxxsJvgeourBxMVPyeRv1PiP6EiW
         0BAA==
X-Forwarded-Encrypted: i=1; AJvYcCXS//S28MYziwpJQaUOk/A4tHMxkysYuSWrR64trm+hKjoSpEkeKkqi/j72dh2+CRvJu2nJjnoE+rmHRFsU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26PszNvspZkvXdiFn1DND58zi4CfjWPgVBJRPmpHCC+rttqRU
	6XVZvEtUFroQXko3cysn0DLEKFmE35kxWl2lU20394J0mJ5KOwAWq6JcIp9AtWuCcQ==
X-Gm-Gg: ASbGncsGmGZYc/cThkogVpC3wF3AK8TEHVqNBbJnpKmw8nbgr4D5lWleWxOXayoYLfT
	ysTI+jdFTuPX4iu78mUItXmcu1bbrC89J8am+atxrLGE/OAMEPeDsV/ad0Whf+iYW6rUp5FqFll
	hePeoFJokcWVR76DJ2WnW7q/Ik7ZPD6HaPDY3xbCuzZH/bTQngn527kCN4PhRselgkxWue1h4Vn
	DvBiejCk7uicU7noJzbonPeQRjRRzCCNhNNj/s+LQdBC5JqblCazVktlBrNj03666mfFhIbM+h7
	xSxATLNXc+nf3ForZLDpt1ysxZ+RD9jtBeuWgznSXQSfNIef+NvOZbJwuFZUjtoctA==
X-Google-Smtp-Source: AGHT+IEIhSKyAh/a5UXDnIfIZx40q+8DWj3yxUrqA8zj6603W5pJSAuRQjAc6FIffxONFpmzBXMSlQ==
X-Received: by 2002:a17:902:e747:b0:234:d292:be8f with SMTP id d9443c01a7336-2366b32e55bmr310856115ad.1.1750301141373;
        Wed, 18 Jun 2025 19:45:41 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:7cb6:ce70:9b77:ed3b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a226ddcsm876010a91.1.2025.06.18.19.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 19:45:41 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:45:29 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH RFC 06/29] mm/zsmalloc: make PageZsmalloc() sticky
Message-ID: <5qkfuuar3csonfv3a6nj5ikl3ghebqassnnfw24xj7rjwx77fg@cglr2plhwvfs>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-7-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618174014.1168640-7-david@redhat.com>

On (25/06/18 19:39), David Hildenbrand wrote:
> Let the buddy handle clearing the type.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

FWIW,
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

