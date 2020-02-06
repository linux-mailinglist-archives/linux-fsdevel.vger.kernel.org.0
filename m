Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44922154566
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 14:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgBFNtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 08:49:07 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38041 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgBFNtH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:49:07 -0500
Received: by mail-qk1-f194.google.com with SMTP id 21so5539299qki.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 05:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DHRzcCOcfhrmm5JpAoZVwghERoHF/KR/QX0GjakaiY0=;
        b=WxKpQD2B98cdrxgC9OvO6+mIVpPXvVeJrYrVmY0OlZv2vV2fXHLe4PLl5mf8+3nJMT
         IPM1VH/h6vtD42zhYwCWdWlGhNWnbfHeNvjey5zFroF7v2t8nb3lBvtMRkrZ4+KTBp4u
         NkIHEWK0zuwAexD1fcLzoz132snN/Pzuu54lgqNCNsVKg/erHbhtleJeMB5PHzTlvvsj
         WWrP/liZAa7+D/k6D10Lbs8JIF3ZZMi7tIZqJD/gEZPf5lt6OxuTyfHbz4OxTd9NrumF
         oC5Sd7azc3dGSJcUJe6gDNxvpFXerXiGNJmqWIMlJJuFrrKx/aFiY3s2SnteV9G1KJJO
         bUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DHRzcCOcfhrmm5JpAoZVwghERoHF/KR/QX0GjakaiY0=;
        b=X6486GfX5xjKV8fJF9I8pdULWWi1yirfPN+xzAZR6UoJQyxmUuAHC8F4nXrwnFIAXr
         pGmRJJqx8QdzAnZtabTunox121K9n2DBiVvrKvdatxgCnRV+agwabw+RQHXv1Cb2g0qf
         lFiQtIt2KXK+EQnM25Lere38CYOGBWQpoSOb9qQwqRj8H/fu8ZXBM9SO56fJXt3FVKAo
         R55jdWzXO2cO1a+U8QjcX0fZQTXsLFTQvJnB+0TlnUHUzhRngGXauTU3CzOut9/f8Jus
         PCD+gK3QL+2WsGLZJBHvjv7t19uweQw4IFKqoTz/AL+dBCPe0mFWopqY1jdP9M6agbwJ
         4NlQ==
X-Gm-Message-State: APjAAAUgVAKhlVm3NpD7RQlnRSVB4iQYYEItQ0NGB9VekQ202GWu9Ii0
        WzzAFycWvGijszNZOPxd0KWCdOX3Qlk=
X-Google-Smtp-Source: APXvYqwHDepDOaH9EZPj408YgHc3HjGdELtaEwNLPpM3ZqeQ6EYbs2s5K9LVqLU+A4Du9gvhYhIKxA==
X-Received: by 2002:ae9:e211:: with SMTP id c17mr2474765qkc.133.1580996945931;
        Thu, 06 Feb 2020 05:49:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id f28sm1396397qkk.130.2020.02.06.05.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Feb 2020 05:49:05 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1izhWi-0002o4-KW; Thu, 06 Feb 2020 09:49:04 -0400
Date:   Thu, 6 Feb 2020 09:49:04 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 8/8] xarray: Don't clear marks in xas_store()
Message-ID: <20200206134904.GD25297@ziepe.ca>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-9-jack@suse.cz>
 <20200205184344.GB28298@ziepe.ca>
 <20200205215904.GT8731@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205215904.GT8731@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 01:59:04PM -0800, Matthew Wilcox wrote:

> > How is RCU mark reading used anyhow?
> 
> We iterate over pages in the page cache with, eg, the dirty bit set.
> This bug will lead to the loop terminating early and failing to find
> dirty pages that it should.

But the inhernetly weak sync of marks and pointers means that
iteration will miss some dirty pages and return some clean pages. It
is all OK for some reason?
 
> > Actually the clearing of marks by xa_store(, NULL) is creating a very
> > subtle bug in drivers/infiniband/core/device.c :( Can you add a Fixes
> > line too:
> > 
> > ib_set_client_data() is assuming the marks for the entry will not
> > change, but if the caller passed in NULL they get wrongly reset, and
> > three call sites pass in NULL:
> >  drivers/infiniband/ulp/srpt/ib_srpt.c
> >  net/rds/ib.c
> >  net/smc/smc_ib.c
> > Fixes: 0df91bb67334 ("RDMA/devices: Use xarray to store the client_data")
> 
> There's no bug here.
> 
> If you're actually storing NULL in the array, then the marks would go
> away.  That's inherent -- imagine you have an array with a single entry
> at 64.  Then you store NULL there.  That causes the node to be deleted,
> and the marks must necessarily disappear with it -- there's nowhere to
> store them!

Ah, it is allocating! These little behavior differences are tricky to
remember over with infrequent use :(

Jason
