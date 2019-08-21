Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E478984C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 21:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfHUTsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 15:48:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41199 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730137AbfHUTsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:48:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id i4so4534611qtj.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RKaQWnWiA/zCcExfi75lqB9ALEnDHuRristulqneTd4=;
        b=VF//ZkIgb0ccMf/fYMR8ys1oZHmy5JRKO8S8IVnwY93iOCu/W7+tqrcWFw+5rldxNI
         aOtLu3PsXm0Him3edXbZNXCIhRk5dw4XYfKu4e3yv8iN/mxXDcev7A64Goh60uRoeToj
         KsbYARzI5dfW3WUW2nHR+o8WkktwHJGaehfIiJX8Npx8V5kKAL0zIUWne13iFi3yzfE0
         Mr3GgB9fCwjOgBICH92Ndb17k2AjhI3vfLJVcZ59QAI/xkGuigPoWEVo0xwQOrmHgZvG
         +llknKnaKUAXOzinx5ExtHyGDbPgE5bGB/pnb1FjLysYXUDhwnplOXXe90luAkrxNaEF
         /MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RKaQWnWiA/zCcExfi75lqB9ALEnDHuRristulqneTd4=;
        b=PdhRdmUlM2QYpZ36LpX28QK+Yxd/RR3nB1PVSV+F3unqTM8mNKeCInw2PTNQXkIRA4
         fOlVD9kEE80VyzyDxmjpMrcOoJoqG0USBZHz3X6e2v6csNSR0izxFVtg66ZWLdUSsSB9
         Qxe8S1gm6MXEvVMFAZlE+TrAcyAKHof4ADTdqIIIdUJVRXiic9BPtF9wqZXhTRjsoFfA
         7remRHLvf5/5N97v14HNJAr54Y9tV0CnhHZL3MDC7LPP1ZJmwoEd+lsT7figQL3NMCa5
         oqB6+zGOJm3VIWN3at5PuPcqWNb56ovMXFS/b6Vh4CvyNbORhb8aDeXkD19cXkcDxjiC
         iAZA==
X-Gm-Message-State: APjAAAVn7tt1Tu363ly4IKWkCNQ+h4bKe3kAddpOnxVXiv/EZGhYMh5N
        psgX2/jfx6e2coPQcg+ty6Qq1A==
X-Google-Smtp-Source: APXvYqynnJZ0Zi7g4jGmr+xM0aj4NgAU3mYFQCm90qX+6uBLqZGFaKsA8ELnMbT3xzkDRjmj+/uCGg==
X-Received: by 2002:ac8:468f:: with SMTP id g15mr33328922qto.353.1566416891773;
        Wed, 21 Aug 2019 12:48:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id q62sm11253497qkb.69.2019.08.21.12.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 12:48:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i0WaY-0005kK-I1; Wed, 21 Aug 2019 16:48:10 -0300
Date:   Wed, 21 Aug 2019 16:48:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;-)
Message-ID: <20190821194810.GI8653@ziepe.ca>
References: <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
 <20190819123841.GC5058@ziepe.ca>
 <20190820011210.GP7777@dread.disaster.area>
 <20190820115515.GA29246@ziepe.ca>
 <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190821181343.GH8653@ziepe.ca>
 <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 21, 2019 at 11:57:03AM -0700, Ira Weiny wrote:

> > Oh, I didn't think we were talking about that. Hanging the close of
> > the datafile fd contingent on some other FD's closure is a recipe for
> > deadlock..
> 
> The discussion between Jan and Dave was concerning what happens when a user
> calls
> 
> fd = open()
> fnctl(...getlease...)
> addr = mmap(fd...)
> ib_reg_mr() <pin>
> munmap(addr...)
> close(fd)

I don't see how blocking close(fd) could work. Write it like this:

 fd = open()
 uverbs = open(/dev/uverbs)
 fnctl(...getlease...)
 addr = mmap(fd...)
 ib_reg_mr() <pin>
 munmap(addr...)
  <sigkill>

The order FD's are closed during sigkill is not deterministic, so when
all the fputs happen during a kill'd exit we could end up blocking in
close(fd) as close(uverbs) will come after in the close
list. close(uverbs) is the thing that does the dereg_mr and releases
the pin.

We don't need complexity with dup to create problems.

Jason
