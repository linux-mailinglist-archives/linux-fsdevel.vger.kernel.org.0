Return-Path: <linux-fsdevel+bounces-7149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0386C8226B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 02:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3003FB2203F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 01:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5165417993;
	Wed,  3 Jan 2024 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPXoqfoh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C4317988
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704246915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5+OwCGOsIHEiALaM4BtPfZn1YP8/WcwN0PC3E3A5Muo=;
	b=GPXoqfoh4ETj8OZvv0L+OHLoV0YhpvhOstzYc6Qf4XQvKe+WhWjfTaL4iHkpQpItXYz1UH
	k0J7RkNpyDOVh+qjQaHA7QgkqCgr1ZdqBOYQ7KrjbEprwuuoSaognuy5P4DnCs3GfGYM3z
	96ZuM0oazoT94+mF1z/uUZ8lDDSSHP4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-BsTnW0h-MhqFBrzoznwFOQ-1; Tue, 02 Jan 2024 20:55:14 -0500
X-MC-Unique: BsTnW0h-MhqFBrzoznwFOQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28bea0ff98cso2258845a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jan 2024 17:55:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704246913; x=1704851713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+OwCGOsIHEiALaM4BtPfZn1YP8/WcwN0PC3E3A5Muo=;
        b=mzh+92PMtte00zYEmaThveM/8ZQzbxNBC1A3OBJ3TDyC69aTO/AfFC8pPTV/PjBreC
         WW1KW8ORKlKKINEZyNFtq4MudF/Lu/bUExfrS4kweoHGSBNND5QeBRZE6dV46QWqUILA
         oYMKOJfS/Bgu00uTVl04dik46JH7jRm2UP4UrHedSu+N8E/GtyyRRAWpm4GHw07ENPbA
         Y/PSWK7k3fUz1B19DaHv1145IqC82Y3n+VnVr0rk1pQ5/1WhK33KwZAqznsvU8bP6B09
         Y6AtRYGGKRFV5i/ECT0juiSIziO4/gWdMgS90rdBS0l4kKwEJQXhZqXuzOhWg4GlCzqK
         GcsA==
X-Gm-Message-State: AOJu0YyPuOZ9/MjsyUvM5c3y/wOZ6egZ5rqu3p6w3lS7LUWu/yMKRF3i
	ljxa25lfQqG+FEx28yxb0M/HsQcidouAy66WELF7k4oJ9fC/JLs3mV/GoV1XEN5yaRFSY8VsN2H
	v+qXd4ZxD96w1/E3PyhKofDNtfpxgyHyeaw==
X-Received: by 2002:a17:902:d389:b0:1d4:f1c:6363 with SMTP id e9-20020a170902d38900b001d40f1c6363mr36694258pld.3.1704246913073;
        Tue, 02 Jan 2024 17:55:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE1VRAgZlF4eJzDsAhgUMRAVjD8W2rPGkIhmIJMebLALfwg6LoEE4rio7wycrCnlrts/vgwQ==
X-Received: by 2002:a17:902:d389:b0:1d4:f1c:6363 with SMTP id e9-20020a170902d38900b001d40f1c6363mr36694251pld.3.1704246912799;
        Tue, 02 Jan 2024 17:55:12 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902868500b001d096757ac1sm22501248plo.47.2024.01.02.17.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 17:55:12 -0800 (PST)
Date: Wed, 3 Jan 2024 09:54:58 +0800
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com,
	david@redhat.com, ryan.roberts@arm.com, hughd@google.com,
	mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
	willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
	zhangpeng362@huawei.com, bgeffon@google.com, kaleshsingh@google.com,
	ngeoffray@google.com, jdduke@google.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/1] userfaultfd: fix move_pages_pte() splitting folio
 under RCU read lock
Message-ID: <ZZS-crdr54WqL7Ns@x1n>
References: <20240102233256.1077959-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240102233256.1077959-1-surenb@google.com>

On Tue, Jan 02, 2024 at 03:32:56PM -0800, Suren Baghdasaryan wrote:
> While testing the split PMD path with lockdep enabled I've got an
> "Invalid wait context" error caused by split_huge_page_to_list() trying
> to lock anon_vma->rwsem while inside RCU read section. The issues is due
> to move_pages_pte() calling split_folio() under RCU read lock. Fix this
> by unmapping the PTEs and exiting RCU read section before splitting the
> folio and then retrying. The same retry pattern is used when locking the
> folio or anon_vma in this function. After splitting the large folio we
> unlock and release it because after the split the old folio might not be
> the one that contains the src_addr.
> 
> Fixes: 94b01c885131 ("userfaultfd: UFFDIO_MOVE uABI")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


