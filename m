Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4CE1AFE5E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 23:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgDSVRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 17:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726009AbgDSVRM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 17:17:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBB4C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2020 14:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=1HlEwYF4wLAxHEp+7gRMdgZfwDtzlR2lp+Xg0n8pkXY=; b=tP2Hy4ZnyvT+ETMNngCJoLK5bN
        aJe5sFQBDf9K+M0DUmhS4GJYd218kbxm/I0i3qI4c02nzIRROlIGmBhLGt6glzk9xNsZB0+0Nq6Dl
        9RYuVxPNOIXysEJ1gIRjqqIxGSZsNj53Lzend4/m0RQhUtd/mEyh33jEwoggCozQdV7Mf4C81mnH2
        +OkZu7CbN783zDuUf3kT2zLYY9tdeBlCjCtRE1jWpRM80UBNOe7IG62Abzycdt9CvgI0asFfqw/nj
        7DFB3wWLBfOsgpeeY7itR3arOkuepT0btmbLqbK8r8lxXgZftzl5ODQZoRJMA0Lq0I0VU48XnloKr
        NC7qazLA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQHJL-0003EM-NA; Sun, 19 Apr 2020 21:17:07 +0000
Date:   Sun, 19 Apr 2020 14:17:07 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] export __clear_page_buffers to cleanup code
Message-ID: <20200419211707.GY5820@bombadil.infradead.org>
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
 <20200419031443.GT5820@bombadil.infradead.org>
 <e412762b-3121-b69f-2b4b-263e888a171c@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e412762b-3121-b69f-2b4b-263e888a171c@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 19, 2020 at 10:31:26PM +0200, Guoqing Jiang wrote:
> On 19.04.20 05:14, Matthew Wilcox wrote:
> > On Sun, Apr 19, 2020 at 12:51:18AM +0200, Guoqing Jiang wrote:
> > > When reading md code, I find md-bitmap.c copies __clear_page_buffers from
> > > buffer.c, and after more search, seems there are some places in fs could
> > > use this function directly. So this patchset tries to export the function
> > > and use it to cleanup code.
> > OK, I see why you did this, but there are a couple of problems with it.
> > 
> > One is just a sequencing problem; between exporting __clear_page_buffers()
> > and removing it from the md code, the md code won't build.
> 
> Seems the build option BLK_DEV_MD is depended on BLOCK, and buffer.c
> is relied on the same option.
> 
> ifeq ($(CONFIG_BLOCK),y)/x
> obj-y +=        buffer.o block_dev.o direct-io.o mpage.o
> else
> obj-y +=        no-block.o
> endif
> 
> So I am not sure it is necessary to move the function to include/linux/mm.h
> if there is no sequencing problem, thanks for your any further suggestion.

The sequencing problem is that there will be _two_ definitions of
__clear_page_buffers().

The reason it should go in mm.h is that it's a very simple function
and it will be better to inline it than call an external function.
The two things are not related to each other.
