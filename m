Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2566C435FCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 12:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhJUK7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 06:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhJUK7Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:59:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3390AC06161C;
        Thu, 21 Oct 2021 03:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dub8UqOFRYaTWZsCvyLvD1E6FjdsA28JdylaDkp2hpM=; b=g9+VbEern6p9EX4w8aSL7V5UKX
        l8iS5HfrUU6gNWsA22ENGum0q/RZNGLkmJQJlDHfwLohj5+rKpNnKCo07dEFlMGmd9zf85XKF4egT
        adseBxHCCQTyTImqmSL6c/X+8mawDFOesTJnS7gpbF7zaL+bYNvr4qQmE+jgzJq78l04g/xwdF+Co
        eEeZAicjvSWqvjM6zM6jAANn2QY5C6x4aJmgwQI1VnoicgvPZyaMZUKkizHTwg/yKJv7z+Eu2W8c6
        lLX84QO7k/SRv0emgkq/jQiB5QGa2SyMcfagYZDzV8qiS1DrkbWG6cMCBiQHjuNm3nxpVvysymKWF
        WEnJMFlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdVkx-007Ifc-FC; Thu, 21 Oct 2021 10:57:07 +0000
Date:   Thu, 21 Oct 2021 03:57:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] fs: replace the ki_complete two integer arguments
 with a single argument
Message-ID: <YXFHgy85MpdHpHBE@infradead.org>
References: <4d409f23-2235-9fa6-4028-4d6c8ed749f8@kernel.dk>
 <YXElk52IsvCchbOx@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXElk52IsvCchbOx@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 01:32:19AM -0700, Christoph Hellwig wrote:
> > @@ -1436,8 +1436,8 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
> >  		file_end_write(kiocb->ki_filp);
> >  	}
> >  
> > -	iocb->ki_res.res = res;
> > -	iocb->ki_res.res2 = res2;
> > +	iocb->ki_res.res = res & 0xffffffff;
> > +	iocb->ki_res.res2 = res >> 32;
> 
> This needs a big fat comments explaining the historic context.

Oh, and please use the upper_32_bits / lower_32_bits helpers.
