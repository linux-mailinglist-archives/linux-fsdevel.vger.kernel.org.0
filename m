Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C15E90665
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 19:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfHPREM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 13:04:12 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41410 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfHPREM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:04:12 -0400
Received: by mail-qk1-f194.google.com with SMTP id g17so5253168qkk.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2019 10:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3/tESAZDqjf2ti4MOUFqaLyuCU2G0DdLcKzf9OCJK1A=;
        b=CgyAwPGtGbDRUG8Q8IPdiAN946YBd9GiTLHLY9qdMO5DtczZ+v/ksZz5SGjHhHDB0g
         hiV6XUJ4c9P/Fox7d6UOuEz97SD/EhMDbiCw8kD+oxlGk5WZy2o/dhyrB5D8Leo7SHAD
         BKUA1fyEb0S2R5LJe+cV2l0+5GCV3Ei1qwVPLJVNjVyjL/1JaNhiXlUIMTcYmIQCwa5w
         UFybR3WyOnO6J0TyWyymvk11R0w9E51nhI3I9ejTlLJRWh894PP5rmYob/zftnr58EHa
         1R9EcYM6LGmbUn/CP/1T6cgliyd8l3igSjchOMhsF9pHYkfmf7q8dp+B8ImzDvpVFHxr
         0xBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3/tESAZDqjf2ti4MOUFqaLyuCU2G0DdLcKzf9OCJK1A=;
        b=gYS7wUNP5Py5D7ll/y/4Sl4MpUEhj3fe7F9mkQQoZNPylnqQyJ+3fgT5x6R43FA84V
         FpXb+9+fBY5xguQqHlxe4V3WRlHwetfFsnOgLYBqUJB6DmsmDLzDT5jgmub5B35RN+pM
         D4dlCEQgTCSpKDhTSfWY5VttsEX6Fo2jcYoYbrylkvSq4prAyCZdf7WGnouinYXW5aNX
         GQpiHAlyFVTCIu6YVAzlAp+TJeFfYMnoZnxJ5OlYTBKF4gJAamcFyj8szx9L1mm8w9gi
         OC7BFC0dTmJAhbTWA3qQDOcpqLqHmVUA3lCgMN2LDw+Jw8BOXE9BjTiM75Dr03MMpngj
         Z4Sg==
X-Gm-Message-State: APjAAAWzdEQiO6+IeXhqVHmBkBlmfA/Cz7x9iAsSRF4qKBvVojGb1CxO
        BkaFKHV/Os32/W/MLy9f2ODRwA==
X-Google-Smtp-Source: APXvYqx/H9DYP00gkOY/+C82HTHZ3xyAsu8DjOC+iOmym4LKCzVRjzFvWdNtwrKPess7YdPgQyP7Sw==
X-Received: by 2002:a05:620a:16d6:: with SMTP id a22mr9866792qkn.414.1565975051948;
        Fri, 16 Aug 2019 10:04:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s58sm3477747qth.59.2019.08.16.10.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Aug 2019 10:04:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hyfe6-0000CI-Dj; Fri, 16 Aug 2019 14:04:10 -0300
Date:   Fri, 16 Aug 2019 14:04:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm/gup: introduce vaddr_pin_pages_remote()
Message-ID: <20190816170410.GH5398@ziepe.ca>
References: <20190814234959.GA463@iweiny-DESK2.sc.intel.com>
 <2cbdf599-2226-99ae-b4d5-8909a0a1eadf@nvidia.com>
 <ac834ac6-39bd-6df9-fca4-70b9520b6c34@nvidia.com>
 <20190815132622.GG14313@quack2.suse.cz>
 <20190815133510.GA21302@quack2.suse.cz>
 <0d6797d8-1e04-1ebe-80a7-3d6895fe71b0@suse.cz>
 <20190816154404.GF3041@quack2.suse.cz>
 <20190816155220.GC3149@redhat.com>
 <20190816161355.GL3041@quack2.suse.cz>
 <20190816165445.GD3149@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816165445.GD3149@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 16, 2019 at 12:54:45PM -0400, Jerome Glisse wrote:

> > Yes, I understand. But the fact is that GUP calls are currently still there
> > e.g. in ODP code. If you can make the code work without taking a page
> > reference at all, I'm only happy :)
> 
> Already in rdma next AFAIK so in 5.4 it will be gone :)

Unfortunately no.. only a lot of patches supporting this change will
be in 5.4. The notifiers are still a problem, and I need to figure out
if the edge cases in hmm_range_fault are OK for ODP or not. :(

This is taking a long time in part because ODP itself has all sorts of
problems that make it hard to tell if the other changes are safe or
not..

Lots of effort is being spent to get there though.

Jason
