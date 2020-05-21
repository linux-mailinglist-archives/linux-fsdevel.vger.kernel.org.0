Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50E21DDA90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 00:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgEUWwf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 18:52:35 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:51388 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730041AbgEUWwf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 18:52:35 -0400
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 1E5E5820761;
        Fri, 22 May 2020 08:52:30 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jbu32-0000i0-RJ; Fri, 22 May 2020 08:52:20 +1000
Date:   Fri, 22 May 2020 08:52:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, willy@infradead.org
Subject: Re: [PATCH 10/10] mm/migrate.c: call detach_page_private to cleanup
 code
Message-ID: <20200521225220.GV2005@dread.disaster.area>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
 <20200517214718.468-11-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517214718.468-11-guoqing.jiang@cloud.ionos.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=kj9zAlcOel0A:10 a=sTwFKg_x9MkA:10 a=UgJECxHJAAAA:8 a=7-415B0cAAAA:8
        a=AK4pDz-JxGAavDNz_KEA:9 a=CjuIK1q_8ugA:10 a=-El7cUbtino8hM1DCn8D:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 17, 2020 at 11:47:18PM +0200, Guoqing Jiang wrote:
> We can cleanup code a little by call detach_page_private here.
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
> No change since RFC V3.
> 
>  mm/migrate.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 5fed0305d2ec..f99502bc113c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -804,10 +804,7 @@ static int __buffer_migrate_page(struct address_space *mapping,
>  	if (rc != MIGRATEPAGE_SUCCESS)
>  		goto unlock_buffers;
>  
> -	ClearPagePrivate(page);
> -	set_page_private(newpage, page_private(page));
> -	set_page_private(page, 0);
> -	put_page(page);
> +	set_page_private(newpage, detach_page_private(page));

attach_page_private(newpage, detach_page_private(page));

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
