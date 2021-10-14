Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8D942D033
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 04:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhJNCO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 22:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229846AbhJNCOZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634177541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rKi/nC1vwY+bmICKgPE8kpfZB/d+Vx8FvEWoSRsnXMI=;
        b=AVD7qGDyCHvlgJZZKKDNX+zoUwszQylZbB/m6huaO8yNl5z/tcbGPXK4QeljMHKxhgSfVB
        D/ysHaRteemiI4c5cVVVFidtWWOBaJsqQK2ZAekhIa+uHDb0v+JEZy9a0V9/NyHzqTepfJ
        w9Y/UNsetRZ+a8Mx7Jg+OzNiDzZZkzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-aJwzUtPhPXmykCOmR_Jyfw-1; Wed, 13 Oct 2021 22:12:16 -0400
X-MC-Unique: aJwzUtPhPXmykCOmR_Jyfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5163279EDD;
        Thu, 14 Oct 2021 02:12:13 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47E042B0B2;
        Thu, 14 Oct 2021 02:11:50 +0000 (UTC)
Date:   Thu, 14 Oct 2021 10:11:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YWeR4moCRh+ZHOmH@T590>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-12-mcgrof@kernel.org>
 <YWeOJP2UJWYF94fu@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWeOJP2UJWYF94fu@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 14, 2021 at 09:55:48AM +0800, Ming Lei wrote:
> On Mon, Sep 27, 2021 at 09:38:04AM -0700, Luis Chamberlain wrote:

...

> 
> Hello Luis,
> 
> Can you test the following patch and see if the issue can be addressed?
> 
> Please see the idea from the inline comment.
> 
> Also zram_index_mutex isn't needed in zram disk's store() compared with
> your patch, then the deadlock issue you are addressing in this series can
> be avoided.
> 
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index fcaf2750f68f..3c17927d23a7 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1985,11 +1985,17 @@ static int zram_remove(struct zram *zram)
>  
>  	/* Make sure all the pending I/O are finished */
>  	fsync_bdev(bdev);
> -	zram_reset_device(zram);
>  
>  	pr_info("Removed device: %s\n", zram->disk->disk_name);
>  
>  	del_gendisk(zram->disk);
> +
> +	/*
> +	 * reset device after gendisk is removed, so any change from sysfs
> +	 * store won't come in, then we can really reset device here
> +	 */
> +	zram_reset_device(zram);
> +
>  	blk_cleanup_disk(zram->disk);
>  	kfree(zram);
>  	return 0;
> @@ -2073,7 +2079,12 @@ static int zram_remove_cb(int id, void *ptr, void *data)
>  static void destroy_devices(void)
>  {
>  	class_unregister(&zram_control_class);
> +
> +	/* hold the global lock so new device can't be added */
> +	mutex_lock(&zram_index_mutex);
>  	idr_for_each(&zram_index_idr, &zram_remove_cb, NULL);
> +	mutex_unlock(&zram_index_mutex);
> +

Actually zram_index_mutex isn't needed when calling zram_remove_cb()
since the zram-control sysfs interface has been removed, so userspace
can't add new device any more, then the issue is supposed to be fixed
by the following one line change, please test it:

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fcaf2750f68f..96dd641de233 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1985,11 +1985,17 @@ static int zram_remove(struct zram *zram)
 
 	/* Make sure all the pending I/O are finished */
 	fsync_bdev(bdev);
-	zram_reset_device(zram);
 
 	pr_info("Removed device: %s\n", zram->disk->disk_name);
 
 	del_gendisk(zram->disk);
+
+	/*
+	 * reset device after gendisk is removed, so any change from sysfs
+	 * store won't come in, then we can really reset device here
+	 */
+	zram_reset_device(zram);
+
 	blk_cleanup_disk(zram->disk);
 	kfree(zram);
 	return 0;



Thanks, 
Ming

