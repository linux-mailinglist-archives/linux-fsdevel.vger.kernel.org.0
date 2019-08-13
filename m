Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B79A98C014
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 20:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfHMSAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 14:00:24 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45148 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfHMSAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 14:00:24 -0400
Received: by mail-qt1-f195.google.com with SMTP id k13so9961371qtm.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 11:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IBxnXq2Ic/FEKXbpZLemvQFxGE32/we3wuo4f4S9MyU=;
        b=JkdPDFhKWlCBD9Qi7RNp1yC1abkdUc7/1dY6LV39VmLNemSn9Powu35LNiuyO8uczt
         Nadnkpe9izQcaWOyGGeQHJ23tWPRR6bGmsg+cyaAilqF+z1rDRrm+slvgHjrpOBu79SN
         04/Y6/+5Ps6m17X0m+HDUinYIh8C32SkpSSPGyvi4DXoJS3WXfpvU9blzoRZ5bcDgJEL
         IDg+rbA5MUkHi8mQ00jNvvGVGA9O50CHREVVTEuNyId2Vgr0BUJk+6udZ7yoDqN0JsU4
         gZy0AfBcuVAFDG6OCN/ZVHt5uncO6CdDnK24oMMrw6a/bv0Qfkyj1OjJY0s/rkuU/UyI
         PpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IBxnXq2Ic/FEKXbpZLemvQFxGE32/we3wuo4f4S9MyU=;
        b=mUuNV/UAgU4jcr0Rwui2J/QAl8yViVh72kvXAboX9jDYvdZSEXu78Kh2UrktP03chO
         4H86VoDlQiwScln43mngVsjOIlTAUaQF5OgeKoXEimoHF5rgelGI77Lc2vB/vYfk4ujp
         PmRaJLzmU19rpd3NRFqeptKyTxCNiz/4/670YJjI6fMhYKw8+3C5GmmuH2iakiSz2xPi
         eHhPl6ZSJhPr5X/Qv6j5tMYqO7/XfudZtCJuE0qeyuTD4u6qSKNfiMxPE45nQYl2++lE
         DyEunm2W8Az1uwvp63qV4Wr9ZNbjJNM2feTVYXcZM4ygJZ3GEt5SiuRjUeSbjz9SHAVE
         iqUQ==
X-Gm-Message-State: APjAAAWfwCDcN2q36/BeiZGhvOXQfBaX8pdQFjvtl9vGNl/8v36Z5/Rh
        zZql1atBnM7Ami7Rj0UYm+pLIA==
X-Google-Smtp-Source: APXvYqwwH31e/CxiSAwLKzyYNpXPBlqnkZplwVbsfv2VH9N4iB3HSg736Ni8yTKYk8KDSLHvJDt7lg==
X-Received: by 2002:ac8:1a6c:: with SMTP id q41mr32662928qtk.217.1565719223137;
        Tue, 13 Aug 2019 11:00:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y204sm5010562qka.54.2019.08.13.11.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 11:00:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hxb5q-0000sY-7l; Tue, 13 Aug 2019 15:00:22 -0300
Date:   Tue, 13 Aug 2019 15:00:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 16/19] RDMA/uverbs: Add back pointer to system
 file object
Message-ID: <20190813180022.GF29508@ziepe.ca>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-17-ira.weiny@intel.com>
 <20190812130039.GD24457@ziepe.ca>
 <20190812172826.GA19746@iweiny-DESK2.sc.intel.com>
 <20190812175615.GI24457@ziepe.ca>
 <20190812211537.GE20634@iweiny-DESK2.sc.intel.com>
 <20190813114842.GB29508@ziepe.ca>
 <20190813174142.GB11882@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813174142.GB11882@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 13, 2019 at 10:41:42AM -0700, Ira Weiny wrote:

> And I was pretty sure uverbs_destroy_ufile_hw() would take care of (or ensure
> that some other thread is) destroying all the MR's we have associated with this
> FD.

fd's can't be revoked, so destroy_ufile_hw() can't touch them. It
deletes any underlying HW resources, but the FD persists.
 
> > This is why having a back pointer like this is so ugly, it creates a
> > reference counting cycle
> 
> Yep...  I worked through this...  and it was giving me fits...
> 
> Anyway, the struct file is the only object in the core which was reasonable to
> store this information in since that is what is passed around to other
> processes...

It could be passed down in the uattr_bundle, once you are in file operations
handle the file is guarenteed to exist, and we've now arranged things
so the uattr_bundle flows into the umem, as umems can only be
established under a system call.

Jason
