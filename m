Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF7A1BE023
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 16:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgD2OFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 10:05:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37119 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726691AbgD2OFh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588169136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=15mWh+Q+04E+O3p3+W4qaQIE3K1ImLyGac8MlS9sbR0=;
        b=UhtTEWO19igxVq0qpMW7n6EjDZzq6QqAU5Jdy47xs4wElqhbRphtcp/SANz5/i6nTzeAAI
        9fw6W6VUkApDAO/XW1plkQrvEvKeYmaUiYq2LTj+HRWKxKyPkzufNbgQc6VtctvsyfkMps
        ACuShzBHQycvZUS/h2D63Lq7leRzh/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-4U-OHgS5MwmQkHZ3Cn2JOg-1; Wed, 29 Apr 2020 10:05:32 -0400
X-MC-Unique: 4U-OHgS5MwmQkHZ3Cn2JOg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B07118FF661;
        Wed, 29 Apr 2020 14:05:30 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 193705D9C9;
        Wed, 29 Apr 2020 14:05:18 +0000 (UTC)
Date:   Wed, 29 Apr 2020 22:05:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] loop: be paranoid on exit and prevent new
 additions / removals
Message-ID: <20200429140513.GD700644@T590>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429074627.5955-7-mcgrof@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 07:46:27AM +0000, Luis Chamberlain wrote:
> Be pedantic on removal as well and hold the mutex.
> This should prevent uses of addition while we exit.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/block/loop.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index da693e6a834e..6dccba22c9b5 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2333,6 +2333,8 @@ static void __exit loop_exit(void)
>  
>  	range = max_loop ? max_loop << part_shift : 1UL << MINORBITS;
>  
> +	mutex_lock(&loop_ctl_mutex);
> +
>  	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
>  	idr_destroy(&loop_index_idr);
>  
> @@ -2340,6 +2342,8 @@ static void __exit loop_exit(void)
>  	unregister_blkdev(LOOP_MAJOR, "loop");
>  
>  	misc_deregister(&loop_misc);
> +
> +	mutex_unlock(&loop_ctl_mutex);
>  }
>  
>  module_init(loop_init);
> -- 
> 2.25.1
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

