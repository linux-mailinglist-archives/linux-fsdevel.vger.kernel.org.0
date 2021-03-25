Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7E4349443
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 15:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhCYOho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 10:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhCYOhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:37:33 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805DCC06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 07:37:32 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 7so1936958qka.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 07:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yUUY0ROAP+SLb7HLoPQ+wA8YpHFO9kWKGRbvh/B/IQ4=;
        b=B8UZG840ltXLZaJ3g7LqogpLPEEKfgbMjrJ+zqNNPxJFW3SGTOScgcllhOu7YgBiL0
         oporCVsfZXMbpB+i5+qwq3P9pQ6m4/ILUksomJ3JDUrEDpKJEoSd+zwc9zdQws6pOrSp
         gdAEyFuujj8Ult+YZO/Z6hMyiwU00dKvEMmYn+fpqpFK1LlznqaiZpHQWU5kb3PMezAh
         puXp0II/Ux5PIo5ANTztzOO8ZU0pcnupnz2W1xCq3pqg9BPJFH0DUsI+17n7p+JUvnNB
         eIh7WUvmxjS6vre84wz62VYvBU+QKcvvJO1+1vVU/57P3npxdBkRBBwPOwYPwIgJmsmB
         iBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yUUY0ROAP+SLb7HLoPQ+wA8YpHFO9kWKGRbvh/B/IQ4=;
        b=rCHLPKIh9ou6Nhixv+M5u+wOUalYGEimkNXJEnEFidZ1YknRyJfCQPDdzTSGyznsU/
         QuoX47eWxCza2XJKJHnZlXI1jLxMjGu21rSGM6ByFwAZnmZeyRav2AduNJnddN7hA1mU
         9gjTXT0txdQgB521+o0uRCZVlY/K7E9pAU7AxVc9fnQLRNQtq5fYV0ChtJF+vPyEnM4/
         j8Njbsg3A0HAD2QSjYWzoO7QGYMK/+yCVkPaqIuqGsoxQdwzahkpen3JEyw6yAiArdr0
         yS9gaexKrZh1T4yjsWdjC2jRXwJwJQ1iweWm/uhx5F8RSMIhigL8gb0W/tXSPVGRUwY+
         4CVA==
X-Gm-Message-State: AOAM532M2/AAAnuTy4gC6UkJNWI4Yq3cD8jeXt8r4+GcM47dBd4I2ucu
        ccTYppar7dViQj2tSCJg8nhdCg==
X-Google-Smtp-Source: ABdhPJxxJrqA/cHtDo5IXqd0JMRtMBxMRmcICARR+0tz9w078q1svpjeQewlY8ZmShsZXpobmfQbSQ==
X-Received: by 2002:a37:2785:: with SMTP id n127mr8496495qkn.320.1616683051840;
        Thu, 25 Mar 2021 07:37:31 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id g6sm4269899qkd.62.2021.03.25.07.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 07:37:31 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lPR74-002fqr-7U; Thu, 25 Mar 2021 11:37:30 -0300
Date:   Thu, 25 Mar 2021 11:37:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        Christoph Hellwig <hch@lst.de>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/devmap: Remove pgmap accounting in the
 get_user_pages_fast() path
Message-ID: <20210325143730.GL2710221@ziepe.ca>
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 09:08:28PM -0700, Dan Williams wrote:
> Now that device-dax and filesystem-dax are guaranteed to unmap all user
> mappings of devmap / DAX pages before tearing down the 'struct page'
> array, get_user_pages_fast() can rely on its traditional synchronization
> method "validate_pte(); get_page(); revalidate_pte()" to catch races with
> device shutdown. Specifically the unmap guarantee ensures that gup-fast
> either succeeds in taking a page reference (lock-less), or it detects a
> need to fall back to the slow path where the device presence can be
> revalidated with locks held.
> 
> Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  mm/gup.c |   38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)

I'm happy to see this, and it is really the right thing that PTEs are
properly removed before anything happens to the pages under them.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
