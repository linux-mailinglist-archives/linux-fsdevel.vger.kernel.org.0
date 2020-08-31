Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C99257145
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 02:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgHaAq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Aug 2020 20:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgHaAqw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Aug 2020 20:46:52 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CB7C061573
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2020 17:46:52 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id v69so3584847qkb.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2020 17:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GAtlAOpFNvkVEnaD4rG6Py3jBZNpY6f39We+YB2KFgU=;
        b=YkGK8jWKINAUr+tIoIiSSQ4BIjEfNrjAhThq7A5ONV03xEieAI+Knqoy/5bLZnyulJ
         zO01lynK1T4y3a0lL7tb6xM0FWnwD/ru+gnLeMGpcBUgBm1M7ozUhSbsZZ6Oi/5S3MdJ
         Vr1smocPZXnvRW6uXaq1tdjVw6ZF89o95yKrEg3myJq1uU67oorYAvDkIIfHnQHbAD+6
         cHy3X1l2mbOigMnl2btNaytzC/8Px76kSBBgkgreigYdvJ9jHRj+QmdZRueYBQb1es29
         d0FyMtudcL7MbtlgoVrivy452SFB+rkbvcrF1NZ0RHxte+yyqebtlBV0OY6kF70jlqy3
         yocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GAtlAOpFNvkVEnaD4rG6Py3jBZNpY6f39We+YB2KFgU=;
        b=m/YOTAGiz+j/Slfvm6ldddT6qt9TKa53wlPSFAnMewXt3FX93FiiJ2toHlJX0CQf+c
         Jj5BB9cAuwroqMLSY53+C2cUDP17DXLvrtEreQ2FhpVLOC+Ua08JJObxUNQvEH7ldFVX
         q+X879m8dVLp6r6oL5Hw0Ml8XbMA01GTp+mHn6+cHTHG5fvu5kWJYLZO52RlV2a833Bh
         /BITZq+DGBRfw++x3au6oV6n/5MM9M6jt2TsO8pjfcJazLytl3oud57XKIK2ZW6HcadC
         qLr6is3tWarDV7C16+mj48TIGTTTJmjWtUEWIOdwEmIP3lBxbq2L81gfWLesdM1o9bFz
         vjWQ==
X-Gm-Message-State: AOAM533iVNIOby+jVU3nWFxm1fdF2hgraTI1sIw4fN+NqoMVUBebUv5v
        GWMxvbybcPQaRPYXDjwlDQ7FxQ==
X-Google-Smtp-Source: ABdhPJwqxOtfupp7u+KVWB7WMnFW4s2YHKph8MqJXsUD1woVGS/maUvQOIBkCESVttSeNfAzf3+fNg==
X-Received: by 2002:a05:620a:805:: with SMTP id s5mr8540672qks.214.1598834809026;
        Sun, 30 Aug 2020 17:46:49 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m196sm399505qke.87.2020.08.30.17.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 17:46:48 -0700 (PDT)
Date:   Sun, 30 Aug 2020 20:46:46 -0400
From:   Qian Cai <cai@lca.pw>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: fix WARN_ON_ONCE() from unprivileged users
Message-ID: <20200831004645.GB4039@lca.pw>
References: <20200830013057.14664-1-cai@lca.pw>
 <20200831003033.GZ6096@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831003033.GZ6096@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 30, 2020 at 05:30:33PM -0700, Darrick J. Wong wrote:
> On Sat, Aug 29, 2020 at 09:30:57PM -0400, Qian Cai wrote:
> > It is trivial to trigger a WARN_ON_ONCE(1) in iomap_dio_actor() by
> > unprivileged users which would taint the kernel, or worse - panic if
> > panic_on_warn or panic_on_taint is set. Hence, just convert it to
> > pr_warn_ratelimited() to let users know their workloads are racing.
> > Thanks Dave Chinner for the initial analysis of the racing reproducers.
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  fs/iomap/direct-io.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index c1aafb2ab990..6a6b4bc13269 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -389,7 +389,14 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
> >  	case IOMAP_INLINE:
> >  		return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
> >  	default:
> > -		WARN_ON_ONCE(1);
> > +		/*
> > +		 * DIO is not serialised against mmap() access at all, and so
> > +		 * if the page_mkwrite occurs between the writeback and the
> > +		 * iomap_apply() call in the DIO path, then it will see the
> > +		 * DELALLOC block that the page-mkwrite allocated.
> > +		 */
> > +		pr_warn_ratelimited("page_mkwrite() is racing with DIO read (iomap->type = %u).\n",
> > +				    iomap->type);
> 
> Shouldn't we log the name of triggering process and the file path?  Sort
> of like what dio_warn_stale_pagecache does?

Good idea. I'll add them.
