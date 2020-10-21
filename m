Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DB3294F9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 17:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444079AbgJUPMG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 11:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444029AbgJUPMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:12:06 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B7EC0613CE;
        Wed, 21 Oct 2020 08:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=QRmeq+WhhmJFQx9ptzkESWhLkZL0448bxepNUGUOWXM=; b=sjFBa4jL1qJ+CEJeH03Xwxxk6e
        kuNFWgpIshoWVHEx/rq5Jx9hLUNKt/gdaTaUGZQLnFS2ETWD6gd417JHritOq1mzxCaLbV29n5Aoi
        2FAs94ESvUe8q1G9lCdeKgB3zPw/Ve2EBKfeN8+sALcVjdAY4090snwd+T/V3umbd0IMWT+lfo/DR
        4OECSXEF1A/MhrpaIoG/8dZcG1JZQH7CDN3IEeYBy4cvu/e1z1vqraOFlwQ3p0j8HS6vDjmMhoMnB
        hRyiuMSHHeLbr3n+EBgGHmZVPdNsRcE4t26ZtnopA6lMEoCLsHnQcJeHcyctFKwCzEDkUDS6DvsMA
        kh7Tjo6w==;
Received: from [2601:1c0:6280:3f0::507c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVFmU-0003zU-Dg; Wed, 21 Oct 2020 15:12:02 +0000
Subject: Re: [PATCH 2/2] blk-snap - snapshots and change-tracking for block
 devices
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, hch@infradead.org,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, rjw@rjwysocki.net,
        len.brown@intel.com, pavel@ucw.cz, akpm@linux-foundation.org,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com, jack@suse.cz,
        tj@kernel.org, gustavo@embeddedor.com, bvanassche@acm.org,
        osandov@fb.com, koct9i@gmail.com, damien.lemoal@wdc.com,
        steve@sk2.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <1603271049-20681-3-git-send-email-sergei.shtepa@veeam.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e11c8a85-9d51-2668-53ec-f2795024c762@infradead.org>
Date:   Wed, 21 Oct 2020 08:11:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1603271049-20681-3-git-send-email-sergei.shtepa@veeam.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/21/20 2:04 AM, Sergei Shtepa wrote:
> diff --git a/drivers/block/blk-snap/Kconfig b/drivers/block/blk-snap/Kconfig
> new file mode 100644
> index 000000000000..7a2db99a80dd
> --- /dev/null
> +++ b/drivers/block/blk-snap/Kconfig
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# blk-snap block io layer filter module configuration
> +#
> +#
> +#select BLK_FILTER
> +
> +config BLK_SNAP
> +	tristate "Block device snapshot filter"
> +	depends on BLK_FILTER
> +	help
> +

No blank line here.

> +	  Allow to create snapshots and track block changes for a block

	                                                    for block

> +	  devices. Designed for creating backups for any block devices
> +	  (without device mapper). Snapshots are temporary and are released
> +	  then backup is completed. Change block tracking allows you to

	  when

> +	  create incremental or differential backups.
> +
> +config BLK_SNAP_SNAPSTORE_MULTIDEV
> +	bool "Multi device snapstore configuration support"
> +	depends on BLK_SNAP
> +	help
> +
No blank line here.

> +	  Allow to create snapstore on multiple block devices.


thanks.
-- 
~Randy

