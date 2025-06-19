Return-Path: <linux-fsdevel+bounces-52147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F181ADFB57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 04:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E1217A3BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 02:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273F7231830;
	Thu, 19 Jun 2025 02:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lUP+jB2d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B431C2192EF
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 02:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750301095; cv=none; b=agsA9zIWtFsuPErOtJvu88lWt4lBBQ/m8/k0zrnamlVWdSBI2dGYD2qK6Bs8I6+2cikoDHyeG5rcpMkug+bPMJr1ms/CICyks9qtPx+hA0M91xKknJXErkcM4eu8STrIw0mPl7K3uOSnI90rdLqEyIH26JdDQn+RRLArKu59VrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750301095; c=relaxed/simple;
	bh=qoyTG+y8tPin1lSTQeGsP+HTVOL7kT5xddmxzpFuYF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGSzErnynOyvckxug/KLUNwwojz5OCwsKH+USsxsqRrmKzWQiSyPKpSVOCK5Wu/170io7Z6EChPzkez+/JiBsxJYnSTD/A05p8WH4iIanDVfz9wVF0rcF2NEgMZ1XDLsQ+8ZBI7tDkDBOOhA+l7L+Ess/oaK6DgTiqBUBPM3vL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lUP+jB2d; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-747c2cc3419so176345b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 19:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750301092; x=1750905892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NGiV4ZITlSkGta2ar3rISknYHCyA9ON09GdNG8pubLA=;
        b=lUP+jB2dib70oqGt16Y6GBeBfnzx1zSmE8b286umuV+VGipfXEGsJve7AZHadYBTLH
         kPqMZ6qXkDnO5ObjGixdg6pgSbSUoUIQjYMeFMYQlFXONkESGNBzF4x3ZTGzfAQuxXDb
         6YGuw7F5C/VJuA55bICrXOMuQCNf5zlqfej/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750301092; x=1750905892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGiV4ZITlSkGta2ar3rISknYHCyA9ON09GdNG8pubLA=;
        b=KePlYsMXDAzw6wc/PSiKobGVQWgmZ2+W4pDXP8GxebsUQCrE2ONuBc6Up0su83W+Is
         cqHbfUQI5sL7uWTilAPE4DVPydXXZ457zFQHb7NCMlcwMOixAKILXPpOM1UyabGzxYpK
         vjYU4toYBr8DjidO6DmSMkZPvznvj2m6De4FhsNtcofwsljjTs/scPuRVCWpwhvFCFUw
         zb0cNa9TO+QUEMEzlF3ST/nshptIxXAuFgwiQRgSGLRpmOzpPvXP4LvWoBg6G9lZCvrr
         Eg3t4i4830LPDUHE2K27nQsgj7WmLaRXRmngTHN6/LXRhr5gwPMweD0oy5I5WsFnBz9L
         wVpA==
X-Forwarded-Encrypted: i=1; AJvYcCXP4v/3tw4EGfpihrSKtYU0XO6/klJ/cYxh6GowH2u58/rwRIAkFFyWMPc5Ap8d2U6Kp6Z29pWGxf3w3kSY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DTU+sezuFp/3W/8NjcsmRe0ADK21F9Noer2jcWwf8++4hoMh
	mG7oOuIZbZb7oov7oAAAPCfqvCswLFhdYh0r21hMnl82EBWlZ7ZrU4JZtPsVNOcqtQ==
X-Gm-Gg: ASbGncv/bIf/iHZNsAfuaD9SFXUJNMhUn75uEm92xUeL3utDi7Vjm1CCEDoL0TSK/0R
	dSHwcM6oh8ggrNoUZfjuu/9T7NxP5UwFwloD4Br38PQyBE8y2FpIJuIZ7EsafefWOs4GIywG0wN
	BlFpEdNiUIXPV1gve4gCv3GReuiZwlqHqAxVwUb8ssXgYB9gjGg55QCSB3EGMsVyAeCK83dEtt3
	WCKls+TLEk48WPfEedF0mh7PNlQpMxRTW1Visfasclr5SvxJd9pRzo286SI7Bf7KqgorpD7Ka7y
	wFoFZUPattCQVAm7cHAHvkw94KQ3USRP07h+uvd2YcTAs8lFeOJdMLBcjVJC2Dr+bQ==
X-Google-Smtp-Source: AGHT+IG6keXC3NsOp2Ins+/oPh724/MxHSdE1WbIS33oc9s9zagcbgJChxdFiOB1royOBlBoftNKog==
X-Received: by 2002:a05:6a00:1d15:b0:748:e4f6:ff31 with SMTP id d2e1a72fcca58-748e4f7091emr9593788b3a.8.1750301091998;
        Wed, 18 Jun 2025 19:44:51 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:7cb6:ce70:9b77:ed3b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748ff646231sm44607b3a.146.2025.06.18.19.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 19:44:51 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:44:40 +0900
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
Subject: Re: [PATCH RFC 03/29] mm/zsmalloc: drop PageIsolated() related
 VM_BUG_ONs
Message-ID: <ved33aqy5rlayhagg3x6xcry3cyadw6eponaj6dfwkt7xmbep6@dpcvwrfgrjxx>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618174014.1168640-4-david@redhat.com>

On (25/06/18 19:39), David Hildenbrand wrote:
> Let's drop these checks; these are conditions the core migration code
> must make sure will hold either way, no need to double check.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

