Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E3629D631
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgJ1WLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730712AbgJ1WLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:11:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBC8C0613CF
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2020 15:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lDUTJNTL4+tkdhCbZqZECbuPcosEGYa7Hu8t/UjdKwQ=; b=YO/Dfeu/hmhudKaAu596wCI4tA
        oGHrydam0h5c00vnM2m30n2r6hh8HSiA9Wq0ATvo7tAHLydxgd9D4AyktOs7JDu7kCIJiGf09TLz7
        YG6EZnmx0s6YboKot2JNzOGDfsHNQwrEy12Bir+3iYdAx6CG4fIqTTDnNcFS46c7DgwE97jTpDUZJ
        WR40VTh7hVzVQ+GgWS9uKBCUu38HQrKVlhylemQuu8rHnz6ylo0NDtwAbKJqxhN2osEDHl6HGp/zz
        6hAHwXNWTvVatRnCEgHsS5i3veV88WhXnGS1BcyPFlZ4f8AoZRq148Fcm3C23vge42Fd8swrlYveR
        8XX6wsfg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXfvb-00008x-Oo; Wed, 28 Oct 2020 07:31:27 +0000
Date:   Wed, 28 Oct 2020 07:31:27 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: support partial page discard on writeback block
 mapping failure
Message-ID: <20201028073127.GA32068@infradead.org>
References: <20201026182019.1547662-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026182019.1547662-1-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  	if (unlikely(error)) {
> +		unsigned int	pageoff = offset_in_page(file_offset);
> +		/*
> +		 * Let the filesystem know what portion of the current page
> +		 * failed to map. If the page wasn't been added to ioend, it
> +		 * won't be affected by I/O completion and we must unlock it
> +		 * now.
> +		 */
> +		if (wpc->ops->discard_page)
> +			wpc->ops->discard_page(page, pageoff);

I don't think we need the pageoff variable here.   Also it would
seem more natural to pass the full file_offset offset instead of
having to recreate it in the file system.
