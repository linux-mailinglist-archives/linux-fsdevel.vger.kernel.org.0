Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCBA42FC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 21:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfFLTOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 15:14:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40722 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbfFLTOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:14:24 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so19725510qtn.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2019 12:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q6iGM1TiupqbenVhxjWmtAI5HyN33SMdpalMPy6x5OY=;
        b=fKZgzRoQazhx2NyU0bXbVZS8dOqt2ksyWGIauwNWYHJH8kgsCVJI03c4N5lKN0UfbL
         Bhd0f7dzZ8VYCFXXU+aLJIcr64Q7WMzXQZhTBHMZGz5IhlK3ID/yDJO/l9SrdO5KfgqK
         Pzqt+w2uTJiIBcYRcbkg+zqo7JEvQt6YgPwzekPufoXbr56qiO4x0n/EncSJ7JDY0Ihx
         5v476nbYAMqpu7FcZAOCJM9Yr1cgH62Vahq2y1Hbu0KZAQpHI9vvaxHreBBJ1eHnpDXL
         1X7rLB8DRwb8xJ6R2YIgnjubs6XczMXMrodaik5vqBCeF/b9SQjTHUeI0/OO4EIsnzG3
         NonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q6iGM1TiupqbenVhxjWmtAI5HyN33SMdpalMPy6x5OY=;
        b=UP//GEd9z4cT0AaqWTgYiHgL+ekMs6M3vrxu/19528PWUmjN/pk8Ma3VEH3ffkz3tM
         tDaFBLWuPSY82ZR9J6vzD9l+1zJRGxWRA0WgaMRJvtZaWWK/g8qJGdazFo1mPrDH5CnB
         hX11Yu6L47aZL/LgHnpnaPSg3VWDnlrIN8QSmvlO/QNm6djiWZWNnsEh4agjITjSdQ1T
         kAS0kdEFNw3ad0+V+FJPMc/27sXvCP2KgeDc4RKIXJBwDSg44qkfThRhtv5s78WC+K0S
         B5/IBNEFADO/TQAE/YUOfBWh74QI2Jzjyj2Bx/KHH4wO4qzQ97esSOGbsjbZar+YnJ21
         uPuA==
X-Gm-Message-State: APjAAAU/FkkhNnGyaCuOKSfoPq0JmyiE7X/xtG9wndLdKUGovh5Roo3C
        uIkz/f2ToxizKc6tp0wD1ejxpw==
X-Google-Smtp-Source: APXvYqxNVQoMlV0omgFKo75Awgw9qRfhh6FBsXYbr1pvY1QOdw5O302UlF57KTTs2aFOEmTGVw1+7g==
X-Received: by 2002:aed:3a03:: with SMTP id n3mr38086132qte.85.1560366863270;
        Wed, 12 Jun 2019 12:14:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id e66sm296313qtb.55.2019.06.12.12.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 12:14:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hb8hR-00037z-Na; Wed, 12 Jun 2019 16:14:21 -0300
Date:   Wed, 12 Jun 2019 16:14:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190612191421.GM3876@ziepe.ca>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606195114.GA30714@ziepe.ca>
 <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
 <20190607103636.GA12765@quack2.suse.cz>
 <20190607121729.GA14802@ziepe.ca>
 <20190607145213.GB14559@iweiny-DESK2.sc.intel.com>
 <20190612102917.GB14578@quack2.suse.cz>
 <20190612114721.GB3876@ziepe.ca>
 <20190612120907.GC14578@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612120907.GC14578@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 12, 2019 at 02:09:07PM +0200, Jan Kara wrote:
> On Wed 12-06-19 08:47:21, Jason Gunthorpe wrote:
> > On Wed, Jun 12, 2019 at 12:29:17PM +0200, Jan Kara wrote:
> > 
> > > > > The main objection to the current ODP & DAX solution is that very
> > > > > little HW can actually implement it, having the alternative still
> > > > > require HW support doesn't seem like progress.
> > > > > 
> > > > > I think we will eventually start seein some HW be able to do this
> > > > > invalidation, but it won't be universal, and I'd rather leave it
> > > > > optional, for recovery from truely catastrophic errors (ie my DAX is
> > > > > on fire, I need to unplug it).
> > > > 
> > > > Agreed.  I think software wise there is not much some of the devices can do
> > > > with such an "invalidate".
> > > 
> > > So out of curiosity: What does RDMA driver do when userspace just closes
> > > the file pointing to RDMA object? It has to handle that somehow by aborting
> > > everything that's going on... And I wanted similar behavior here.
> > 
> > It aborts *everything* connected to that file descriptor. Destroying
> > everything avoids creating inconsistencies that destroying a subset
> > would create.
> > 
> > What has been talked about for lease break is not destroying anything
> > but very selectively saying that one memory region linked to the GUP
> > is no longer functional.
> 
> OK, so what I had in mind was that if RDMA app doesn't play by the rules
> and closes the file with existing pins (and thus layout lease) we would
> force it to abort everything. Yes, it is disruptive but then the app didn't
> obey the rule that it has to maintain file lease while holding pins. Thus
> such situation should never happen unless the app is malicious / buggy.

We do have the infrastructure to completely revoke the entire
*content* of a FD (this is called device disassociate). It is
basically close without the app doing close. But again it only works
with some drivers. However, this is more likely something a driver
could support without a HW change though.

It is quite destructive as it forcibly kills everything RDMA related
the process(es) are doing, but it is less violent than SIGKILL, and
there is perhaps a way for the app to recover from this, if it is
coded for it.

My preference would be to avoid this scenario, but if it is really
necessary, we could probably build it with some work.

The only case we use it today is forced HW hot unplug, so it is rarely
used and only for an 'emergency' like use case.

Jason
