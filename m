Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D8C6F5B77
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 17:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjECPsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 11:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjECPs3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 11:48:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4829149DE
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 08:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DysVl8ah3hMoGSeCuK3v7kqIkIueRi3AppErUPwlC/g=; b=FxIH2i9c1yFwyXmBMH5CkdRmJx
        MN9P9gnT8r99CEXpK38H3W5zpcq083Vxw+ifMaXhhKdOl9x4TyTa/AIhjqLgWWSRlI7Ed7/vI4Z+y
        ZEtPN/0tlpejHCF8l8vfSYk22GGoq5lY8RgxCPgYJo0vdeiYvJX+QZ1/rYdYpBu36KFRYp+JFhFhq
        T1Xqy2aPJdNkhDpF5t4X71Z67PSykSsnykIXkxe/TDZV/t+iNp/cOVDsb2RVWNReqayVpkPELO4P7
        CUNCgdGPFbdIdofvPSoa1+ivxU8jzTGfAov9+5Wo957OSMqgFugK5v+NX+PTl00meOvdW/HCw3+bm
        FJoiOyQA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1puEiK-009gtE-Si; Wed, 03 May 2023 15:48:20 +0000
Date:   Wed, 3 May 2023 16:48:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     akpm@linux-foundation.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] filemap: fix the conditional folio_put in
 filemap_fault
Message-ID: <ZFKCRPRgoKWaWhQW@casper.infradead.org>
References: <20230503154526.1223095-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503154526.1223095-1-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 03, 2023 at 05:45:25PM +0200, Christoph Hellwig wrote:
> @@ -3372,14 +3372,14 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  
>  	return VM_FAULT_SIGBUS;
>  
> +out_retry_put_folio:
> +	folio_put(folio);
>  out_retry:
>  	/*
>  	 * We dropped the mmap_lock, we need to return to the fault handler to
>  	 * re-find the vma and come back and find our hopefully still populated
>  	 * page.
>  	 */
> -	if (folio)
> -		folio_put(folio);

Why not simply:

-	if (folio)
+	if (!IS_ERR_OR_NULL(folio))
