Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F60D64BB6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 18:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbiLMRzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 12:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiLMRzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:55:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C21F22B13;
        Tue, 13 Dec 2022 09:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mV0qwzG31bTb5vj921caNZbXANVzA4Jj24SrJofjGtg=; b=WB5lO1TfVwVMiMjtTiqxdnuFTR
        tYhqgd0ydjpA9ATz4zaVEn5+6xd0gBv0iChpT6jN8oSufw8R5pOF63rc5F38dNmgpG+lTceO3Uli1
        xanQLhjYPbe9c8rJ+DpoEiMVvCKryY7vgdCb4TcXYA33fQtpH8X2IDx6CpYEErqM2lJX2wl58fncn
        TzxiH7nTFfKM+RGmURlb3d4KCqeZgqJNjfSv48zK/lULJnVXd9j7KC3NZoCNlgOCvNKmjuNmftlie
        NA+aU3phvyCTvQek2egp9fN/uxXMVUtjgfQscbzoJ1JcbGobfyYXHKwzWSU/gUSV39h8bT9tt2V02
        sQ4sTpVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p59Uw-00CSBD-Dp; Tue, 13 Dec 2022 17:55:22 +0000
Date:   Tue, 13 Dec 2022 17:55:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] pagemap: add mapping_clear_large_folios()
 wrapper
Message-ID: <Y5i8igBLu+6OQt8H@casper.infradead.org>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-3-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213172935.680971-3-aalbersh@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 06:29:26PM +0100, Andrey Albershteyn wrote:
> Add wrapper to clear mapping's large folio flag. This is handy for
> disabling large folios on already existing inodes (e.g. future XFS
> integration of fs-verity).

I have two problems with this.  One is your use of __clear_bit().
We can use __set_bit() because it's done as part of initialisation.
As far as I can tell from your patches, mapping_clear_large_folios() is
called on a live inode, so you'd have to use clear_bit() to avoid races.

The second is that verity should obviously be enhanced to support
large folios (and for that matter, block sizes smaller than PAGE_SIZE).
Without that, this is just a toy or a prototype.  Disabling large folios
is not an option.

I'm happy to work with you to add support for large folios to verity.
It hasn't been high priority for me, but I'm now working on folio support
for bufferhead filesystems and this would probably fit in.

> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  include/linux/pagemap.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index bbccb40442224..63ca600bdf8f7 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -306,6 +306,11 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
>  	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
>  }
>  
> +static inline void mapping_clear_large_folios(struct address_space *mapping)
> +{
> +	__clear_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
> +}
> +
>  /*
>   * Large folio support currently depends on THP.  These dependencies are
>   * being worked on but are not yet fixed.
> -- 
> 2.31.1
> 
