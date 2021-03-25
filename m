Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA456349433
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 15:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhCYOec (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 10:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhCYOe3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:34:29 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E597C06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 07:34:21 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id j7so1770893qtx.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 07:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EBYoeSyDCelHfJ08uskYOli02Uf/rlFwmOTlzuC7hgI=;
        b=N+fdDxgVQQYMaT/p6QFW+V+ir33fgy01dD+fxi2S7KZNbrlN0AKe9IlL/J1vJWeJnz
         hDQZQOIunjFFjO8/Jo+aGOaXBeoSrUgkbdCqiGfXW7noLO5+gnskrV0qxQbbRE40LJkk
         ziNgqfdxF7bKl35iD7YXDKSgmva/aIGNM+q1myQy5V9FMBTxaL17ESoplXA7WfzuR5pU
         TnaNXA2Ff4Gn7s8apv0fssxRfjCBVhYRqE21LX+Ef/XjQlA11SY/LFfjgVU+1vZ/eHZ9
         /fgdB/rMEifTJ16pYmqArjc3KG7IFBW7u6A7EEZEn8cGeucy5yC0ULc0S1+papQW7uC0
         yGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EBYoeSyDCelHfJ08uskYOli02Uf/rlFwmOTlzuC7hgI=;
        b=OZM8AuDjjobHpi+xDUwR5UZW/e36YHf1lX3M0BUKhUoZbHyzHpF9sRh05tfLvw+NMV
         iv3IswmxHARoC5s9ki8Pfz1xKcnwD/4jJbyFmhb29TR41A2SN5OpNdwiMmk+c2MDtEKT
         Jv335gzxcSQGrywU7lBjoIc63J8QRFnU50Wqxq+YUs77tdBoki0ruwoAHCH9QugyBEus
         85Y/KU7lXzoS5Et5qrHPyMnmuUQeAUI40vLXbaiYhXK2TnQuHEIUojcf0KKETotZyLCD
         zn2a3SxwwckvNDDo23HA0SWV5TlcPVnMQ3l3v/KnafNF4GpKy/qpPhojI7ylY4gQ8U1V
         EhpA==
X-Gm-Message-State: AOAM5304tJJmlrkrOYRgU7v2XnpMRRkuIwpoL+xytyGSm/uqA9IAS4+n
        hXjWKRF8xSYc25Y5a764x3ACrQ==
X-Google-Smtp-Source: ABdhPJyvtuKX2zV8mCdrg2NYsULLUlLCccMHLxDM/TG/XquL4LiIlTucJUYDBbZjw339FUqKik+Tow==
X-Received: by 2002:ac8:4412:: with SMTP id j18mr8003677qtn.387.1616682860918;
        Thu, 25 Mar 2021 07:34:20 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 73sm4206300qkk.131.2021.03.25.07.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 07:34:20 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lPR3z-002fmd-5a; Thu, 25 Mar 2021 11:34:19 -0300
Date:   Thu, 25 Mar 2021 11:34:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Joao Martins <joao.m.martins@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        david <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH 3/3] mm/devmap: Remove pgmap accounting in the
 get_user_pages_fast() path
Message-ID: <20210325143419.GK2710221@ziepe.ca>
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com>
 <66514812-6a24-8e2e-7be5-c61e188fecc4@oracle.com>
 <CAPcyv4g8=kGoQiY14CDEZryb-7T1_tePnC_-21w-wTfA7fQcDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g8=kGoQiY14CDEZryb-7T1_tePnC_-21w-wTfA7fQcDg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:03:06AM -0700, Dan Williams wrote:
> Yes. I still need to answer the question of whether mapping
> invalidation triggers longterm pin holders to relinquish their hold,
> but that's a problem regardless of whether gup-fast is supported or
> not.

It does not, GUP users do not interact with addres_space or mmu
notifiers

Jason
