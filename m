Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD0E435CEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 10:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhJUIef (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 04:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhJUIef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:34:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045D0C06161C;
        Thu, 21 Oct 2021 01:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EdrFcH42EwLK5V5gMSieZqkljFin5KO7KisbZAJ1evs=; b=JE2XIXaEgrJCDgmxD/0lNd/3Ow
        tGIcwt4f6qXKR8yqj3tOvtfRBPLvUD2FZLgjsXCWS6ikldzmlbrHdPoz517dSMjNrQxjBvxvGx7iP
        a1Kgpe4kUEWEtXDceBRrcJR7R/Xp+oQKNfhPZJMaxes+SBkfdp9P+NuEgQC/n3lmM7CPYVnUVTeNa
        D6poLGeft88Sl7j3PNhl0wexRA4Y4z8hsD8MaRuGVZOtAqf1GMnt3W+g5rTJQQ/x2oIq1xYmDyGws
        4QQhT++tIsPEclUQG5+RoLGRECfgoHZhVkjxpkfOIDFAfv3kqGSoSFTnMSJxtDyBxyAOeAefUV7hD
        CkTNQt3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdTUp-006r2I-Lg; Thu, 21 Oct 2021 08:32:19 +0000
Date:   Thu, 21 Oct 2021 01:32:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] fs: replace the ki_complete two integer arguments
 with a single argument
Message-ID: <YXElk52IsvCchbOx@infradead.org>
References: <4d409f23-2235-9fa6-4028-4d6c8ed749f8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d409f23-2235-9fa6-4028-4d6c8ed749f8@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> @@ -1436,8 +1436,8 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
>  		file_end_write(kiocb->ki_filp);
>  	}
>  
> -	iocb->ki_res.res = res;
> -	iocb->ki_res.res2 = res2;
> +	iocb->ki_res.res = res & 0xffffffff;
> +	iocb->ki_res.res2 = res >> 32;

This needs a big fat comments explaining the historic context.

Otherwise this looks fine to me.
