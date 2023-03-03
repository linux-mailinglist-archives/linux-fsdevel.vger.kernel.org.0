Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7999D6AA43B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 23:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjCCWYL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 17:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjCCWXq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:23:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBC06BDF2;
        Fri,  3 Mar 2023 14:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kI8/5p22vEnObQIn+bPz4hNfMUdIOhxE3ykG+foeASQ=; b=0lzI6C9XDd3RF6muzd4kjEvu++
        VmGqdmnUwAf9jpeBvonsGnuiydMs3cgCXUcXShT2ouhwjGa/jeg1KTep8w/KNj85kz1/CqKCm7Dk6
        ZIVhjpXPGsNFGIWw89lydkmraazH9K/lqcs/il7PcQZ0WXYUrLd7aJqKkM++Jq+qJfCEGZBKcyHdD
        YWOr0X5iCo4qy456D7vCP/+vOR5QXjmrONKLHbT0N20sJXm7c7i91XK09hE9w8ZsLUvC86tK0t6ke
        Gj0CEPEvuBHGGH5fciqP+nlvAzrVPE/fPQYkSm+TJmROBzzK9sYSZrpK2IpoqNTQR28iVJ1k83Ybf
        PwGyZp8Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYDfz-007iBH-J2; Fri, 03 Mar 2023 22:14:55 +0000
Date:   Fri, 3 Mar 2023 14:14:55 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAJxX2u4CbgVpNNN@bombadil.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
 <ZAJvu2hZrHu816gj@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAJvu2hZrHu816gj@kbusch-mbp.dhcp.thefacebook.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 03, 2023 at 03:07:55PM -0700, Keith Busch wrote:
> On Fri, Mar 03, 2023 at 01:45:48PM -0800, Luis Chamberlain wrote:
> > 
> > You'd hope most of it is left to FS + MM, but I'm not yet sure that's
> > quite it yet. Initial experimentation shows just enabling > PAGE_SIZE
> > physical & logical block NVMe devices gets brought down to 512 bytes.
> > That seems odd to say the least. Would changing this be an issue now?
> 
> I think you're talking about removing this part:
> 
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c2730b116dc68..2c528f56c2973 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1828,17 +1828,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  	unsigned short bs = 1 << ns->lba_shift;
>  	u32 atomic_bs, phys_bs, io_opt = 0;
>  
> -	/*
> -	 * The block layer can't support LBA sizes larger than the page size
> -	 * yet, so catch this early and don't allow block I/O.
> -	 */
> -	if (ns->lba_shift > PAGE_SHIFT) {
> -		capacity = 0;
> -		bs = (1 << 9);
> -	}
> -
>  	blk_integrity_unregister(disk);
> -
>  	atomic_bs = phys_bs = bs;

Yes, clearly it says *yet* so that begs the question what would be
required?

Also, going down to 512 seems a bit dramatic, so why not just match the
PAGE_SIZE so 4k? Would such a comprmise for now break some stuff?

  Luis
