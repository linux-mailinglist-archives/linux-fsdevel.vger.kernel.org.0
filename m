Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C169DEE97A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 21:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfKDUbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 15:31:20 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:47028 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbfKDUbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 15:31:19 -0500
Received: by mail-qk1-f195.google.com with SMTP id h15so9264159qka.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Nov 2019 12:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aYX4F5OJlshBJ+QLO90C7o41djzLcZaOuQTAXbn39ZY=;
        b=i7XYQ1ZHnaY5oxYezVkAZAHGtsh9bOxhHHH3Sn5BIbI+VqJGCPCEvJJaUK5id2Lxjo
         QZy6D5PvoaQcuBVLCBsiP73L6feFkqb9tVyMSKRQoFapdLhYlh11jHUlLfPVcbmAdyn1
         qgfQIJll3BI0DBDvZGBzvIVtKJCbp1OnuM2aeiBnkmmVUjaX5fsGUiMUJQeUjXWcxDWM
         sAgWZWBan6hPzPaW8EaeJ7isi+vnjjn+QWBP0lAA7PgqU29xvVlAbi4989CKgrofdhsL
         SLPnsPkcXFsQUt+67vnjQSIXC5MpAEuJFrM68zNna9vYOt+4Hz7I+EIeX0dmXrL/tCRN
         VzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aYX4F5OJlshBJ+QLO90C7o41djzLcZaOuQTAXbn39ZY=;
        b=JKZS/y+DRHslK5pxcfQO0LwtWIMXvh9iPfGOBg3EdaWe/AHxcKdBAGIBIvGmn/FoBN
         zRtMt7Or//nIbJDxVwwfoirwx9y9nFt3t2mZU2EpRB+q679ujJDk7oqsVTMxwTczkz1M
         n3OixIwSW/E/ZAmL2iTcAPg5o+5cMMhCdBUiY/DOFJ3TEO3lCCHxeT620XwN/ZlcdoYA
         ikGsJ7zeyxY5lUavqqfP9dp/mMnnNFhJvXAAoAlpSnqS1xMONxmkwuARsvCIUAcAtf8n
         apWMR5oCCstJZv4cCqZXUV6lxI4L5MOk0mb1tE54AbAsDGBl/DZVJyKybg3KtWYkH9LR
         f3OQ==
X-Gm-Message-State: APjAAAVhISkAZnPY0aaIOzRK0p5RtLplp+cZva2/FnvbPMfqlMvVYEKq
        5owgahAGlxdSRDWbwozRNgMkow==
X-Google-Smtp-Source: APXvYqzTj81BtQYcnQbs3rWnwUMY938CFsks7F1nt4LFfYHLDO23qLLbnBWdB3geEbkRzW5fLjS+gw==
X-Received: by 2002:a37:7d03:: with SMTP id y3mr6497602qkc.385.1572899478562;
        Mon, 04 Nov 2019 12:31:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id g20sm636338qke.129.2019.11.04.12.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Nov 2019 12:31:17 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iRj0P-0005GE-Di; Mon, 04 Nov 2019 16:31:17 -0400
Date:   Mon, 4 Nov 2019 16:31:17 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, bpf@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/18] mm/gup: introduce pin_user_pages*() and FOLL_PIN
Message-ID: <20191104203117.GE30938@ziepe.ca>
References: <20191103211813.213227-1-jhubbard@nvidia.com>
 <20191103211813.213227-6-jhubbard@nvidia.com>
 <20191104173325.GD5134@redhat.com>
 <be9de35c-57e9-75c3-2e86-eae50904bbdf@nvidia.com>
 <20191104191811.GI5134@redhat.com>
 <e9656d47-b4a1-da8a-e8cc-ebcfb8cc06d6@nvidia.com>
 <20191104195248.GA7731@redhat.com>
 <25ec4bc0-caaa-2a01-2ae7-2d79663a40e1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25ec4bc0-caaa-2a01-2ae7-2d79663a40e1@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 04, 2019 at 12:09:05PM -0800, John Hubbard wrote:

> Note for Jason: the (a) or (b) items are talking about the vfio case, which is
> one of the two call sites that now use pin_longterm_pages_remote(), and the
> other one is infiniband:
> 
> drivers/infiniband/core/umem_odp.c:646:         npages = pin_longterm_pages_remote(owning_process, owning_mm,

This is a mistake, it is not a longterm pin and does not need FOLL_PIN
semantics

> Jason should weigh in on how he wants this to go, with respect to branching
> and merging, since it sounds like that will conflict with the hmm branch 

I think since you don't need to change this site things should be
fine?

Jason
