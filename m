Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A9A27F387
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 22:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgI3Uqx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 16:46:53 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:25111 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgI3Uqx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 16:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601498813; x=1633034813;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=XbNOWeAHjXdc18oeXXyRojpqrg19RF+CX4RcweS8pmY=;
  b=NCnjxxAy+HzYGzAV3zjPq95tDkNDyg+8Bqy6g/foSZWkn5496Po9i3Fg
   9xEV+Y3y1dSfVQyLhVnGjd/QSB0oLCQSRVvQxeN9AkSov/+iTR3yFZILa
   xlorR0vkCFZJ/Ff/sx+ZXsTUcRVTkjpFoNtpQsZbxiLLPmhN8sghAyBGh
   I=;
X-IronPort-AV: E=Sophos;i="5.77,322,1596499200"; 
   d="scan'208";a="57041457"
Subject: Re: [PATCH] fs: nfs: return per memcg count for xattr shrinkers
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 30 Sep 2020 20:46:51 +0000
Received: from EX13MTAUEE001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id BA2E9A1B8A;
        Wed, 30 Sep 2020 20:46:49 +0000 (UTC)
Received: from EX13D18UEE002.ant.amazon.com (10.43.62.65) by
 EX13MTAUEE001.ant.amazon.com (10.43.62.200) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 30 Sep 2020 20:46:48 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D18UEE002.ant.amazon.com (10.43.62.65) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 30 Sep 2020 20:46:48 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Wed, 30 Sep 2020 20:46:48 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 1FE05C14B2; Wed, 30 Sep 2020 20:46:48 +0000 (UTC)
Date:   Wed, 30 Sep 2020 20:46:48 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Message-ID: <20200930204648.GA9098@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200927114220.141530-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200927114220.141530-1-shy828301@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 27, 2020 at 04:42:20AM -0700, Yang Shi wrote:
> 
> The list_lru_count() returns the pre node count, but the new xattr
> shrinkers are memcg aware, so the shrinkers should return per memcg
> count by calling list_lru_shrink_count() instead.  Otherwise over-shrink
> might be experienced.  The problem was spotted by visual code
> inspection.
> 
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Anna Schumaker <anna.schumaker@netapp.com>
> Cc: Frank van der Linden <fllinden@amazon.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  fs/nfs/nfs42xattr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
> index 86777996cfec..6e5f34916937 100644
> --- a/fs/nfs/nfs42xattr.c
> +++ b/fs/nfs/nfs42xattr.c
> @@ -882,7 +882,7 @@ nfs4_xattr_cache_count(struct shrinker *shrink, struct shrink_control *sc)
>  {
>         unsigned long count;
> 
> -       count = list_lru_count(&nfs4_xattr_cache_lru);
> +       count = list_lru_shrink_count(&nfs4_xattr_cache_lru, sc);
>         return vfs_pressure_ratio(count);
>  }
> 
> @@ -976,7 +976,7 @@ nfs4_xattr_entry_count(struct shrinker *shrink, struct shrink_control *sc)
>         lru = (shrink == &nfs4_xattr_large_entry_shrinker) ?
>             &nfs4_xattr_large_entry_lru : &nfs4_xattr_entry_lru;
> 
> -       count = list_lru_count(lru);
> +       count = list_lru_shrink_count(lru, sc);
>         return vfs_pressure_ratio(count);
>  }
> 
> --
> 2.26.2
> 

Yep, thanks.

Reviewed-by: Frank van der Linden <fllinden@amazon.com>
