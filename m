Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704AB2CFC2A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Dec 2020 17:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgLEQu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Dec 2020 11:50:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbgLEQoo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Dec 2020 11:44:44 -0500
Date:   Sat, 5 Dec 2020 15:10:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607177374;
        bh=GqJgKgKfkXV2E/cKEl+IwBiAIYSLVSK21HRqHXfoboQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=kj2Mfzyav+eSVN9O1zun+6FovXVMb3nkQa66UcHmEHZsRD4wmt8EgH/EDlSXCrzp/
         Fj9n6sPBBIrJrn19nFPxqPLdnApCiqc2doGN4AKNkx8IJCF5DDvTWV9v51cAhZ0FTu
         NhNQ1QGmnXAuazcozS0AFv+54SwfFhg2xS7wR/Q8=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     rafael@kernel.org, adobriyan@gmail.com, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        hughd@google.com, will@kernel.org, guro@fb.com, rppt@kernel.org,
        tglx@linutronix.de, esyr@redhat.com, peterx@redhat.com,
        krisman@collabora.com, surenb@google.com, avagin@openvz.org,
        elver@google.com, rdunlap@infradead.org, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 5/9] mm: memcontrol: convert NR_FILE_THPS account to pages
Message-ID: <X8uU6ODzteuBY9pf@kroah.com>
References: <20201205130224.81607-1-songmuchun@bytedance.com>
 <20201205130224.81607-6-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205130224.81607-6-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 05, 2020 at 09:02:20PM +0800, Muchun Song wrote:
> Converrt NR_FILE_THPS account to pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  drivers/base/node.c | 3 +--
>  fs/proc/meminfo.c   | 2 +-
>  mm/filemap.c        | 2 +-
>  mm/huge_memory.c    | 3 ++-
>  mm/khugepaged.c     | 2 +-
>  mm/memcontrol.c     | 5 ++---
>  6 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 05c369e93e16..f6a9521bbcf8 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -466,8 +466,7 @@ static ssize_t node_read_meminfo(struct device *dev,
>  				    HPAGE_PMD_NR),
>  			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
>  				    HPAGE_PMD_NR),
> -			     nid, K(node_page_state(pgdat, NR_FILE_THPS) *
> -				    HPAGE_PMD_NR),
> +			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),

Again, is this changing a user-visable value?

