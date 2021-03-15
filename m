Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14FC33B1C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 12:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCOLzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 07:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhCOLy7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:54:59 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ECEC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Mar 2021 04:54:59 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id y1so15838816ljm.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Mar 2021 04:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TCKES4KspyjNo/wG6JlZwaabmOGw2Jey0GicXPV904o=;
        b=QofG4+vX6fm1lS8Ti+Sc8uYu9K3mrAW/Zt51ntjHYb7oPYBEuUa71SJMW6Ix65YfHf
         h6Rm2mkTYqfNHKZ63Wub4y/6rJxNGW4xwmcCNRbzKugLnrgiuDJEgNHFSktztrcSMzPh
         wAV+TvvaV1AOZNYHNLrh3/M/iFG76m88mZied3mCZoXjYAZleUbSq0jKDWQOoUyoh8+C
         ppMf6KNdOyBhWJr8W8V2O5SPmTfEb1wWRUQBVsD3tcQm/RNNemAqj9EFTS5MlCOzR/mE
         x4lUP098Rcwiru++abTAX+uLsKMIuunUctiLmlUfWO+oqBWRGLVfdcbKQO6SK1XUinXY
         OVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TCKES4KspyjNo/wG6JlZwaabmOGw2Jey0GicXPV904o=;
        b=g4yOxfz3c/jMgreDyEuJtb6Rb8atB8hI2hYWjjy3EHTq8+dEZMHwBZyAJk2jN04NyK
         G4f9vLUYdhQGiecc5p3udP3dIlrB28PUf+JjSBL6IIfE0pcUdV/mJ3i/WfFAUygHbx2E
         PNmUHzggoNZl3KsX1EVtss5vuA7JMw+8ajxc9oStdYxrxVKvJc3c3mbsmQWEQyPyclQn
         YpLQn5YjmFr6nifRsk05bFfhZVHAyVSncGIc6tQduEq71BTx9r1BaNTGRLjcscXaiC5Z
         UVkc7U5Z7kF7dlix2Dp1Rg9ASt95nXeHQ+Fliou+kawNyTz/YHSgdiyOvJcOvRM6z8iX
         yHbg==
X-Gm-Message-State: AOAM5315Y0H5+sDFV/a9OYTXPxthVxs68L5Dr/2Y3wB7Jy1xa+EB6N+i
        8oQ9VwOl5wOmsYwS9vNEyc6SSw==
X-Google-Smtp-Source: ABdhPJxskvGqVCaD7c5cQLEXx7onYddRtZr2Vrf4cuw2WNFh8fiISy6s9e81NVnbHcCvTGkhNlNV2g==
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr10494828ljj.116.1615809297641;
        Mon, 15 Mar 2021 04:54:57 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 200sm2688793lfl.2.2021.03.15.04.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 04:54:57 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 40B4A10246E; Mon, 15 Mar 2021 14:55:01 +0300 (+03)
Date:   Mon, 15 Mar 2021 14:55:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/25] Page folios
Message-ID: <20210315115501.7rmzaan2hxsqowgq@box>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210313123658.ad2dcf79a113a8619c19c33b@linux-foundation.org>
 <alpine.LSU.2.11.2103131842590.14125@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2103131842590.14125@eggly.anvils>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 13, 2021 at 07:09:01PM -0800, Hugh Dickins wrote:
> On Sat, 13 Mar 2021, Andrew Morton wrote:
> > On Fri,  5 Mar 2021 04:18:36 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> > 
> > > Our type system does not currently distinguish between tail pages and
> > > head or single pages.  This is a problem because we call compound_head()
> > > multiple times (and the compiler cannot optimise it out), bloating the
> > > kernel.  It also makes programming hard as it is often unclear whether
> > > a function operates on an individual page, or an entire compound page.
> > > 
> > > This patch series introduces the struct folio, which is a type that
> > > represents an entire compound page.  This initial set reduces the kernel
> > > size by approximately 6kB, although its real purpose is adding
> > > infrastructure to enable further use of the folio.
> > 
> > Geeze it's a lot of noise.  More things to remember and we'll forever
> > have a mismash of `page' and `folio' and code everywhere converting
> > from one to the other.  Ongoing addition of folio
> > accessors/manipulators to overlay the existing page
> > accessors/manipulators, etc.
> > 
> > It's unclear to me that it's all really worth it.  What feedback have
> > you seen from others?
> 
> My own feeling and feedback have been much like yours.
> 
> I don't get very excited by type safety at this level; and although
> I protested back when all those compound_head()s got tucked into the
> *PageFlag() functions, the text size increase was not very much, and
> I never noticed any adverse performance reports.
> 
> To me, it's distraction, churn and friction, ongoing for years; but
> that's just me, and I'm resigned to the possibility that it will go in.
> Matthew is not alone in wanting to pursue it: let others speak.

I'm with Matthew on this. I would really want to drop the number of places
where we call compoud_head(). I hope we can get rid of the page flag
policy hack I made.

-- 
 Kirill A. Shutemov
