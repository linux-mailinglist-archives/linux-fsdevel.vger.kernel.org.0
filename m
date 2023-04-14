Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370376E1C2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 08:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjDNGEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 02:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjDNGEp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:04:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D0255AB;
        Thu, 13 Apr 2023 23:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nhEU6trFR/zXM102avw1Xqh9MbixmvEPkZoZ4Y0dEcg=; b=wuFVNYGutUBoobXw3zhGGSo7i2
        CbgR/CwxrYQcmazhxyhhlkY3XfeDvRddEyEKYDotmhXCiz4aPeKPx4nTNrY/mxd760tD3DDjUN4jv
        V25TAcUDjtGWygcMsscB7FVdYqDdD7V0I+xfxzWxCLuzKPCzBug4Mu3vteZ3naCE5sL+GJ7zQtODw
        U4oCHs6Qc6XJbMmw1fC0BPhpasWgOoYTkfLdflNQEWa6QAM8c+srHo/tTXL6n8Tlqtbz2zYJTerct
        XxCRVPKoeWgpjIllW4J28wpQDJBfx7I30cV2yKcon1O3YRsg7l8eBh/g3to1amkteawHcruJqNWmO
        2h4FwyoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnCY7-008Qdl-1F;
        Fri, 14 Apr 2023 06:04:43 +0000
Date:   Thu, 13 Apr 2023 23:04:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv3 10/10] iomap: Add trace points for DIO path
Message-ID: <ZDjs+/T/mf1nHUHI@infradead.org>
References: <cover.1681365596.git.ritesh.list@gmail.com>
 <93ab8386c4620395c5e674a7930506895fc758ef.1681365596.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93ab8386c4620395c5e674a7930506895fc758ef.1681365596.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before, ret);
>  	dio = __iomap_dio_rw(iocb, iter, ops, dops, dio_flags, private,
>  			     done_before);
>  	if (IS_ERR_OR_NULL(dio)) {
> @@ -689,6 +691,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	}
>  	ret = iomap_dio_complete(dio);
>  out:
> +	trace_iomap_dio_rw_end(iocb, iter, dio_flags, done_before, ret);

The trace_iomap_dio_rw_end tracepoint heere seems a bit weird,
and we'll miss it for file systems using  __iomap_dio_rw directly.

I'd instead add a trace_iomap_dio_rw_queued for the case where
__iomap_dio_rw returns ERR_PTR(-EIOCBQUEUED), as otherwise we're
nicely covered by the complete trace points.

> +		  __print_flags(__entry->dio_flags, "|", TRACE_IOMAP_DIO_STRINGS),

Please avoid the overly lone line here.

