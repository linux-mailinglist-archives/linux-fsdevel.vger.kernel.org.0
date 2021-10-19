Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9343A433F53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 21:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhJSTjM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 15:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhJSTjM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 15:39:12 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CABC06161C;
        Tue, 19 Oct 2021 12:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=npiA1/BckufA/m+irMg6eqFPqYx0reNFf9Z4p7vaYXU=; b=HBXrBM4kBn1mIISA6ZRTEsVa/a
        HbBElJD/ZtV+aPX7EEvN/Ig7haO5MpBSF61XfTafLHBdoosPyZzQkAF2gVZCx44+eUHwMH8ynYmYh
        d5HggA4pW6WC5wxQPWEA52Fhh9joVMOrt9ac2f8Ytgcl3iwSvkVi6clwuAn7GwJNPk0R9qKP0xzQo
        TM7za36h8cD0QShOa3WPbe3xYmOxnF64R0jxhDduGpQq7N1QPCyFHW+PscBcEhLiDwoGbMvRHCovb
        XHUwkw1dDZY01MdpXO0tIa86xh/71FnxSRi30TsVo+CQEepu4V0EW7DLrufD3qQupRSkFWGZgJnTi
        630Qdx0g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcuug-002X6t-6v; Tue, 19 Oct 2021 19:36:42 +0000
Date:   Tue, 19 Oct 2021 12:36:42 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
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
Message-ID: <YW8eSq2B+5FtOLZb@bombadil.infradead.org>
References: <YWiSAN6xfYcUDJCb@bombadil.infradead.org>
 <YWjCpLUNPF3s4P2U@T590>
 <YWjJ0O7K+31Iz3ox@bombadil.infradead.org>
 <YWk9e957Hb+I7HvR@T590>
 <YWm68xUnAofop3PZ@bombadil.infradead.org>
 <YWq3Z++uoJ/kcp+3@T590>
 <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590>
 <YW7kFXlzRrvwzARP@bombadil.infradead.org>
 <YW7ygbLAwm2/LZFl@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW7ygbLAwm2/LZFl@T590>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:29:53AM +0800, Ming Lei wrote:
> On Tue, Oct 19, 2021 at 08:28:21AM -0700, Luis Chamberlain wrote:
> > On Tue, Oct 19, 2021 at 10:34:41AM +0800, Ming Lei wrote:
> > > Please try the following patch against upstream(linus or next) tree(basically
> > > fold revised 2 and 3 of V1, and cover two issues: not fail zram_remove in
> > > module_exit(), race between zram_remove() and disksize_store()), and see if
> > > everything is fine for you:
> > 
> > Page fault ...
> > 
> > [   18.284256] zram: Removed device: zram0
> > [   18.312974] BUG: unable to handle page fault for address:
> > ffffad86de903008
> > [   18.313707] #PF: supervisor read access in kernel mode
> > [   18.314248] #PF: error_code(0x0000) - not-present page
> > [   18.314797] PGD 100000067 P4D 100000067 PUD 10031e067 PMD 136a28067
> 
> That is another race between zram_reset_device() and disksize_store(),
> which is supposed to be covered by ->init_lock, and follows the delta fix
> against the last patch I posted, and the whole patch can be found in the
> github link:
> 
> https://github.com/ming1/linux/commit/fa6045b1371eb301f392ac84adaf3ad53bb16894
> 
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index d0cae7a42f4d..a14ba3d350ea 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1704,12 +1704,12 @@ static void zram_reset_device(struct zram *zram)
>  	set_capacity_and_notify(zram->disk, 0);
>  	part_stat_set_all(zram->disk->part0, 0);
>  
> -	up_write(&zram->init_lock);
>  	/* I/O operation under all of CPU are done so let's free */
>  	zram_meta_free(zram, disksize);
>  	memset(&zram->stats, 0, sizeof(zram->stats));
>  	zcomp_destroy(comp);
>  	reset_bdev(zram);
> +	up_write(&zram->init_lock);
>  }
>  
>  static ssize_t disksize_store(struct device *dev,

With this, it still ends up in a state where we loop and can't get out of:

zram: Can't change algorithm for initialized device

  Luis
