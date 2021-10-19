Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C867433C35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 18:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhJSQcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 12:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhJSQcx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634661040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PiPwD9y8spZoLZVNjvkxF8b9SR5+UePopQh4Nk2pw54=;
        b=Cjv+//dt79ECXvLOauVmg/weJnfZM5MpnEwptVs2AcDirhvGTbGfTQhrmSHeNtVlHqxxwm
        wlddBInjxpIIBR/h5VCoU1/WKrm0DmRGWJTXLNB1/KO8i9C2qiiJHvExxXwGlQtJjLNCZo
        U6Kuw+Iah3kpShujP50sZbVaHO+Nei8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-yTQWi08OMOG3Ccr8Ujy_mw-1; Tue, 19 Oct 2021 12:30:36 -0400
X-MC-Unique: yTQWi08OMOG3Ccr8Ujy_mw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 742D280A5C5;
        Tue, 19 Oct 2021 16:30:33 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AEC47100238C;
        Tue, 19 Oct 2021 16:29:58 +0000 (UTC)
Date:   Wed, 20 Oct 2021 00:29:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, keescook@chromium.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YW7ygbLAwm2/LZFl@T590>
References: <YWeR4moCRh+ZHOmH@T590>
 <YWiSAN6xfYcUDJCb@bombadil.infradead.org>
 <YWjCpLUNPF3s4P2U@T590>
 <YWjJ0O7K+31Iz3ox@bombadil.infradead.org>
 <YWk9e957Hb+I7HvR@T590>
 <YWm68xUnAofop3PZ@bombadil.infradead.org>
 <YWq3Z++uoJ/kcp+3@T590>
 <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590>
 <YW7kFXlzRrvwzARP@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW7kFXlzRrvwzARP@bombadil.infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 08:28:21AM -0700, Luis Chamberlain wrote:
> On Tue, Oct 19, 2021 at 10:34:41AM +0800, Ming Lei wrote:
> > Please try the following patch against upstream(linus or next) tree(basically
> > fold revised 2 and 3 of V1, and cover two issues: not fail zram_remove in
> > module_exit(), race between zram_remove() and disksize_store()), and see if
> > everything is fine for you:
> 
> Page fault ...
> 
> [   18.284256] zram: Removed device: zram0
> [   18.312974] BUG: unable to handle page fault for address:
> ffffad86de903008
> [   18.313707] #PF: supervisor read access in kernel mode
> [   18.314248] #PF: error_code(0x0000) - not-present page
> [   18.314797] PGD 100000067 P4D 100000067 PUD 10031e067 PMD 136a28067

That is another race between zram_reset_device() and disksize_store(),
which is supposed to be covered by ->init_lock, and follows the delta fix
against the last patch I posted, and the whole patch can be found in the
github link:

https://github.com/ming1/linux/commit/fa6045b1371eb301f392ac84adaf3ad53bb16894


diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d0cae7a42f4d..a14ba3d350ea 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1704,12 +1704,12 @@ static void zram_reset_device(struct zram *zram)
 	set_capacity_and_notify(zram->disk, 0);
 	part_stat_set_all(zram->disk->part0, 0);
 
-	up_write(&zram->init_lock);
 	/* I/O operation under all of CPU are done so let's free */
 	zram_meta_free(zram, disksize);
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	zcomp_destroy(comp);
 	reset_bdev(zram);
+	up_write(&zram->init_lock);
 }
 
 static ssize_t disksize_store(struct device *dev,

-- 
Ming

