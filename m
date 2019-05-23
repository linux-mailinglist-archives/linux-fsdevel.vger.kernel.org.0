Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465E528746
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 21:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389462AbfEWTRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 15:17:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44961 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389452AbfEWTRh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 15:17:37 -0400
Received: by mail-qt1-f194.google.com with SMTP id f24so8074092qtk.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 12:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pm+Vx0dhObnzybiaJozRDpH0LoNYUiVOhc6EGMjBZwU=;
        b=O0RCPEGvWXVRXRZ7y88skUaFHv3isN4h6Tr6VLsss0em/c8A1IncniPr014w2Ci4io
         9rBOKNHmm68kYI6ygpwlm+QtR16oXFPy2bhxS9CwKHFqrIfMtEWctvqEZ4eVLH4Cn7TJ
         HOeZtmCGjBcvBSU18syidFL3Um1gGyCpWXeJsZC2Nvpz7PwdjRmaH9U2HY3sw2gtM83U
         WGdsqtqNuVbxSdeTfdP4MztNl8z1hsbkujcQdJiIBLEMbySogRMR8przLBmtfBbirVh8
         fc9baIPJgppq8UkcxW/nJPwGb+5dwFFa4fUBYQGfezP1UVVzSkaq/4vRP8kXOph9tKhv
         tF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pm+Vx0dhObnzybiaJozRDpH0LoNYUiVOhc6EGMjBZwU=;
        b=pOtG1dbNRvI4knXuteUqzPJXlLwdYRylAcu7ojRFuxJuIAcfcMzUC6HYegZVRqb+nd
         cMTQ85WV4SWyiF2XiI3fz9scyf8CC2EK+vwmyZPPK6KIHr8rmnBATxpKVKlbYdpNfvpb
         hGlqN28QHdMTTT2L1ASw8ER/uIVz80fPR9kZOxM3O1CxPB8Gr3oZnykZgbj9qrlfrgWt
         uoixGYiD2dS7Hz3UAP1vN0ZrL71ssj0w+kBSmqYeYL5AKsohCwcxscPRNA3z7/d9L7An
         k43hGHXDh2Sy6qBgTF+xqasnSf/bo0vOWM8S2SEvphjZvMOwjRUlWRaA6z4y5y/hHIIu
         gg3w==
X-Gm-Message-State: APjAAAUvx1MPuNWDoN+Uv1gC5ffCBhT3CWNOhf6IhvulDyVlNDEv+Vbd
        G/5B6EmYrZgRzLiAeKHLH6QKTA==
X-Google-Smtp-Source: APXvYqyby6SPIf9lPMNL5yZPBW7JhGUYjZjNDXWEHEzHk702uXmsFYcPFIXfDXhIH78qusR4hcmSJg==
X-Received: by 2002:a0c:9acb:: with SMTP id k11mr59015856qvf.85.1558639055850;
        Thu, 23 May 2019 12:17:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id q24sm139016qtq.58.2019.05.23.12.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 12:17:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTtDa-0000kS-RM; Thu, 23 May 2019 16:17:34 -0300
Date:   Thu, 23 May 2019 16:17:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "john.hubbard@gmail.com" <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/1] infiniband/mm: convert put_page() to put_user_page*()
Message-ID: <20190523191734.GH12159@ziepe.ca>
References: <20190523072537.31940-1-jhubbard@nvidia.com>
 <20190523072537.31940-2-jhubbard@nvidia.com>
 <20190523172852.GA27175@iweiny-DESK2.sc.intel.com>
 <20190523173222.GH12145@mellanox.com>
 <fa6d7d7c-13a3-0586-6384-768ebb7f0561@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa6d7d7c-13a3-0586-6384-768ebb7f0561@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 10:46:38AM -0700, John Hubbard wrote:
> On 5/23/19 10:32 AM, Jason Gunthorpe wrote:
> > On Thu, May 23, 2019 at 10:28:52AM -0700, Ira Weiny wrote:
> > > > @@ -686,8 +686,8 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
> > > >   			 * ib_umem_odp_map_dma_single_page().
> > > >   			 */
> > > >   			if (npages - (j + 1) > 0)
> > > > -				release_pages(&local_page_list[j+1],
> > > > -					      npages - (j + 1));
> > > > +				put_user_pages(&local_page_list[j+1],
> > > > +					       npages - (j + 1));
> > > 
> > > I don't know if we discussed this before but it looks like the use of
> > > release_pages() was not entirely correct (or at least not necessary) here.  So
> > > I think this is ok.
> > 
> > Oh? John switched it from a put_pages loop to release_pages() here:
> > 
> > commit 75a3e6a3c129cddcc683538d8702c6ef998ec589
> > Author: John Hubbard <jhubbard@nvidia.com>
> > Date:   Mon Mar 4 11:46:45 2019 -0800
> > 
> >      RDMA/umem: minor bug fix in error handling path
> >      1. Bug fix: fix an off by one error in the code that cleans up if it fails
> >         to dma-map a page, after having done a get_user_pages_remote() on a
> >         range of pages.
> >      2. Refinement: for that same cleanup code, release_pages() is better than
> >         put_page() in a loop.
> > 
> > And now we are going to back something called put_pages() that
> > implements the same for loop the above removed?
> > 
> > Seems like we are going in circles?? John?
> > 
> 
> put_user_pages() is meant to be a drop-in replacement for release_pages(),
> so I made the above change as an interim step in moving the callsite from
> a loop, to a single call.
> 
> And at some point, it may be possible to find a way to optimize put_user_pages()
> in a similar way to the batching that release_pages() does, that was part
> of the plan for this.
> 
> But I do see what you mean: in the interim, maybe put_user_pages() should
> just be calling release_pages(), how does that change sound?

It would have made it more consistent.. But it seems this isn't a
functional problem in this patch

Jason
