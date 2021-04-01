Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AB53518AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 19:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbhDARrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 13:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbhDARnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:43:25 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98ACC08EA7A
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 06:30:36 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 7so2124168qka.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 06:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w/7ssEDMUVD4QlYKgBNJoPZ/Vwpdfp7p9SjtiE2HkVw=;
        b=W+UTAUw+g6a1Plj/cURzd01NfugXhFMhp/aCzakOwDQduKQDrdrhO2WSp8U7ct03if
         nRXnd8lqUvyKe1lFdnCSFrZD/96GhrkvfZ645xfS0tBX8UpkhDrof5joth6ixU7iOuA2
         Is/+RK5tJ0Cu42vcARGXUviWPFWGZ+er26s5Y+KqB78x34n9WlbicjIYb6NKvgsrDrsS
         sc9T+Pxq12aRj0wO6xcnrWIi1JmEssEg6MipVRx/NVsPe7v9dbG8NeNNLqrpmkxLuV80
         ZCELs+XTBlo/7PyqylMHVXLf15wzvCqurfYGKuyl4vuoolxyGSNLdPfNt2BZge/u1tH0
         RSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w/7ssEDMUVD4QlYKgBNJoPZ/Vwpdfp7p9SjtiE2HkVw=;
        b=bHD7xrvi76OJU+0fF0OSYI4a60/KGlhAv1SYWBxgr38YTM+0kT11DmM4DYKmd3A/Do
         pU3ypXw7gedTKuiO0sEbnuZ57zD4M+wAyl5IthtE6fNg/N16kIHHo10rL/mnKDB2glno
         ZO+d415QEV+GXyI3iV80BC4JoFSXBhaFRQ4SUbfnQGCjVjtAq0lELfRgce4e4PLQfOkk
         NsPBeikdWVVK/MoaD12O6uS8lOpv+OmOEGgb1XnHXhwn8M+bTiUkLycc8piGQSlXIgwf
         PmXTG3ZOWuC65S5S4FDX0Ue/S9Cn+ZBDIX1IGqc2S29J+p3HJvWI2fmjr9jGO2MaD5Of
         +NQQ==
X-Gm-Message-State: AOAM533OpUnxNlR9u+Dy3lqD+X2U7cbdByclM0jwgey8Pm3qo3fRvudP
        nXyCv6btGSNOPTRagrn5d/t4VQ==
X-Google-Smtp-Source: ABdhPJwY/Erz6f9mFV6feM+OIMmzbcrd0Oem+ltCCxeD8d8BAt0sMjxB8TtGsmIhiYyPHtNa/an8xQ==
X-Received: by 2002:a37:596:: with SMTP id 144mr8617287qkf.387.1617283836177;
        Thu, 01 Apr 2021 06:30:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id x7sm3413511qtp.10.2021.04.01.06.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 06:30:35 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lRxP8-006knq-LW; Thu, 01 Apr 2021 10:30:34 -0300
Date:   Thu, 1 Apr 2021 10:30:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 00/27] Memory Folios
Message-ID: <20210401133034.GF2710221@ziepe.ca>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210401070537.GB1363493@infradead.org>
 <20210401112656.GA351017@casper.infradead.org>
 <20210401122803.GB2710221@ziepe.ca>
 <20210401125201.GD351017@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401125201.GD351017@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 01:52:01PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 01, 2021 at 09:28:03AM -0300, Jason Gunthorpe wrote:
> > On Thu, Apr 01, 2021 at 12:26:56PM +0100, Matthew Wilcox wrote:
> > > On Thu, Apr 01, 2021 at 08:05:37AM +0100, Christoph Hellwig wrote:
> > > > On Wed, Mar 31, 2021 at 07:47:01PM +0100, Matthew Wilcox (Oracle) wrote:
> > > > >  - Mirror members of struct page (for pagecache / anon) into struct folio,
> > > > >    so (eg) you can use folio->mapping instead of folio->page.mapping
> > > > 
> > > > Eww, why?
> > > 
> > > So that eventually we can rename page->mapping to page->_mapping and
> > > prevent the bugs from people doing page->mapping on a tail page.  eg
> > > https://lore.kernel.org/linux-mm/alpine.LSU.2.11.2103102214170.7159@eggly.anvils/
> > 
> > Is that gcc structure layout randomization stuff going to be a problem
> > here?
> > 
> > Add some 
> >   static_assert(offsetof(struct folio,..) == offsetof(struct page,..))
> > 
> > tests to force it?
> 
> You sound like the kind of person who hasn't read patch 1.

Yes, I missed this hunk :)

Jason
