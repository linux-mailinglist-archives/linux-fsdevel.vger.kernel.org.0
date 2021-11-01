Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7B1441E08
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 17:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhKAQYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 12:24:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232174AbhKAQYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635783689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E9idZ9g7Qiy202IHm24WOcqzjkMEWV4Amwu/3bidfKY=;
        b=Jb2ieF+UJCAXaI4awu80SUFZWF1CkD+S/ZJK/qbpHthY8oUap767smt5XzxZrVboica49v
        Gc/NLA+cN/NPFJyzzwDixs9cL1vW5tpevJ1qXmdcl2xVTclP6wi6hIsKzEOnYopmlUHAik
        6/rk9NCN9qyolMzY00bExSCWPb1mljU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-6-XcwvldNc-wU9rtMacKOg-1; Mon, 01 Nov 2021 12:21:28 -0400
X-MC-Unique: 6-XcwvldNc-wU9rtMacKOg-1
Received: by mail-qv1-f70.google.com with SMTP id p10-20020a0cc3ca000000b0038559d56582so16770803qvi.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Nov 2021 09:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E9idZ9g7Qiy202IHm24WOcqzjkMEWV4Amwu/3bidfKY=;
        b=cnFtN3H4Q3esQJgGeRW94m89E7u3ncdSRd913ChF8JMUBm9NLi0DwDzBx6m8MS07xW
         BCwLpnfQ/x1rktAvC6FJf+WoUeOaIWUVXJqmtUGEO1uw69bv1ESt2c976btEv3mz1MAe
         uY+0vjIDYqTjnf6fgDOqSZa3E5YUvMwBs/dHxt5QrSVy4HJ8CLriChW+7c3LbmEH1Sp6
         a2pFPwAx6pBhHV5BRVZeVaiexjC+V0g/FI4/Z4fGhd6FU1nZeB0mTflkiEbvLLbHnrci
         qiQ2MPYQOiufwgt+rls54gKwPNUlJ9vPt5FaWogc/9DXNH/5MWbGn7EQwoFtOMWGsRFy
         2VWw==
X-Gm-Message-State: AOAM533rIaepmWhY46mxP079fIhe0yDsREt08IZ4eBdZu5JLQSyQH3un
        lLUKvVqzmbuC0tN9TkBrZZIqsPGXk+DoyORqWcEwlO+HoLj6kHa49W7gOPyGhl+NX9GmaOf156y
        xGAtxtjAeKryJGPdPw0+6omdv
X-Received: by 2002:ac8:7d04:: with SMTP id g4mr30472034qtb.183.1635783688231;
        Mon, 01 Nov 2021 09:21:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXhGf8N2V91WU2Co6WJDyYs4GGgkn9JXnS/oEwWuG4J0RZNo7zMUQJUBh2KgjI9ZclpX5QJg==
X-Received: by 2002:ac8:7d04:: with SMTP id g4mr30472009qtb.183.1635783688071;
        Mon, 01 Nov 2021 09:21:28 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id bj3sm2670847qkb.75.2021.11.01.09.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:21:27 -0700 (PDT)
Date:   Mon, 1 Nov 2021 12:21:26 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 10/11] dm-stripe: add a stripe_dax_pgoff helper
Message-ID: <YYAUBkiPlRCVPnyv@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-11-hch@lst.de>
 <CAPcyv4iLbbqyAsy1yjFXT48D3Ssp+jy4EMJt+Sj_o2W-WMgK9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iLbbqyAsy1yjFXT48D3Ssp+jy4EMJt+Sj_o2W-WMgK9w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27 2021 at  9:41P -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Add a helper to perform the entire remapping for DAX accesses.  This
> > helper open codes bdev_dax_pgoff given that the alignment checks have
> > already been done by the submitting file system and don't need to be
> > repeated.
> 
> Again, looks good. Kind of embarrassing when the open-coded version is
> less LOC than using the helper.
> 
> Mike, ack?

Acked-by: Mike Snitzer <snitzer@redhat.com>

