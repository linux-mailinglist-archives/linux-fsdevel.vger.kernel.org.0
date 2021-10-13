Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D1142B2CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 04:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbhJMCnN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 22:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236473AbhJMCnL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 22:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634092868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ft1VC9zrQcW79FB0tNwhaRoMQpMWx16xNlQ9+j3yL0Q=;
        b=OLZfSMJwGcdFd1OaJkhLELknSJA0auwbTqfYT0N1wHlArQNNKYh0mNK+eAjJyUJq4NJ9p8
        5imoQ4BvilBjjuTBKmdt3OgVxnLdlg1/KGEWTcwblYB6w/wwjIgvYKf3FYCx5b13yRf+xr
        gnEsIFAXhEiHqwgCaHLRHznK2vGyjas=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-iuVxIIsjPCSFuXA4hFPtWw-1; Tue, 12 Oct 2021 22:41:07 -0400
X-MC-Unique: iuVxIIsjPCSFuXA4hFPtWw-1
Received: by mail-pj1-f70.google.com with SMTP id pg13-20020a17090b1e0d00b001a094e26d51so981955pjb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 19:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ft1VC9zrQcW79FB0tNwhaRoMQpMWx16xNlQ9+j3yL0Q=;
        b=xrb5iL5ndMgjLqb5NnXYvMs5xIlIjT2MKPM5STXKAc9rvvK/Tl43suQjOReFKAmhlP
         k3rnWvMGxoDIsb1gTidb3GSWN0hEcKJKw++nWz+vqLWjLSrLZvfqIkguUEvfBB3nc3wW
         n8M2hJPd8HC5SZaxDar/U0Y74yL8+6rlw2yZDtbG97Eilw0y3kyTeGC1o6aTVRU5Ao5m
         mqBjETBGnxio3Q3n+wbSPnPLt9Z6HODM2LsrdL7pfmwyB1nnYAYqpCP8ged7zrA5z9yp
         u/gaz1wX4fYta3qXs2+2NAbZDQIGiCsUW3VzB7rM0NBdAAFNFRvtL4gEltEvoPFtp0GE
         P0ag==
X-Gm-Message-State: AOAM531gCqKzO8Lvzl9hUyHFzpiNifoJKk6iLdR4nkWKn9frbp6dfTPl
        uWsRQwUewiCj88n4Mb8IbQYFb5y33c0IgcNPIr+CGFjYJGCXewVSy18IAs1bAMBO4Tgl7Ryceon
        G4vnoq0LF3saF443B9YlUGeqq+g==
X-Received: by 2002:a17:90a:8b89:: with SMTP id z9mr10389116pjn.89.1634092865742;
        Tue, 12 Oct 2021 19:41:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzv4fE/XpKqdSojl1JvafE8JRzpy63XtSbqmEDaHX4njX6bFnlJqEI2qmA63YhiSVFaEXHm+w==
X-Received: by 2002:a17:90a:8b89:: with SMTP id z9mr10389092pjn.89.1634092865381;
        Tue, 12 Oct 2021 19:41:05 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p18sm12844157pgk.28.2021.10.12.19.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 19:41:04 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:40:57 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        osalvador@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 0/5] Solve silent data loss caused by poisoned
 page cache (shmem/tmpfs)
Message-ID: <YWZHOYgFrMYbmNA/@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930215311.240774-1-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 30, 2021 at 02:53:06PM -0700, Yang Shi wrote:
> Yang Shi (5):
>       mm: hwpoison: remove the unnecessary THP check
>       mm: filemap: check if THP has hwpoisoned subpage for PMD page fault
>       mm: hwpoison: refactor refcount check handling
>       mm: shmem: don't truncate page if memory failure happens
>       mm: hwpoison: handle non-anonymous THP correctly

Today I just noticed one more thing: unpoison path has (unpoison_memory):

	if (page_mapping(page)) {
		unpoison_pr_info("Unpoison: the hwpoison page has non-NULL mapping %#lx\n",
				 pfn, &unpoison_rs);
		return 0;
	}

I _think_ it was used to make sure we ignore page that was not successfully
poisoned/offlined before (for anonymous), so raising this question up on
whether we should make sure e.g. shmem hwpoisoned pages still can be unpoisoned
for debugging purposes.

-- 
Peter Xu

