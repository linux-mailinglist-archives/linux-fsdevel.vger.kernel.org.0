Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3424315D7D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 13:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgBNM5b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 07:57:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30566 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgBNM5b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 07:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581685049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M0W1G09myWqh7xVsLTycq4q1u2+SorrNYLpq3JdGz7g=;
        b=cNRyr18x3rPBeg/qyly5zjWSnGajPSY/wqcn7EZTpl/reEIL/eftVydqylzIbqFqH/tzNT
        cF+S3pyWqtqrpqZLoty0ssG4Gs6G01ROgVUlC8pLi5RasJIbiTLvPGWdMKDo6ovGPl1F31
        JxbqtkMkw2ttKKnaof1HGL45ChOgtWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-L4pxzCI4MtmRVwXtGSPurA-1; Fri, 14 Feb 2020 07:57:21 -0500
X-MC-Unique: L4pxzCI4MtmRVwXtGSPurA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7ACF8107B267;
        Fri, 14 Feb 2020 12:57:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCC978ECFA;
        Fri, 14 Feb 2020 12:57:17 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4BD172257D2; Fri, 14 Feb 2020 07:57:17 -0500 (EST)
Date:   Fri, 14 Feb 2020 07:57:17 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com
Cc:     dm-devel@redhat.com, vishal.l.verma@intel.com
Subject: Re: [PATCH v3 0/7] dax,pmem: Provide a dax operation to zero range
 of memory
Message-ID: <20200214125717.GA18654@redhat.com>
References: <20200207202652.1439-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207202652.1439-1-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 03:26:45PM -0500, Vivek Goyal wrote:
> Hi,
> 
> This is V3 of patches. I have dropped RFC tag from the series as it
> looks like there is agreement on the interface. These patches are also
> available at.

Hi Dan, Christoph,

Ping for this patch series. How does it look? Do you have concerns?
If not, it will be good if this is merged.

Thanks
Vivek

> 
> https://github.com/rhvgoyal/linux/commits/dax-zero-range-v3
> 
> I posted previous versions here.
> 
> v2:
> https://lore.kernel.org/linux-fsdevel/20200203200029.4592-1-vgoyal@redhat.com/
> v1:
> https://lore.kernel.org/linux-fsdevel/20200123165249.GA7664@redhat.com/
> 
> Changes since V2:
> 
> Primarily took care of comments from Christoph.
> 
> - Changed zero_copy_range() parameters to pass dax device offset as u64.
> - Fixed comment which says current interface only supports zeroing
>   with-in page.
> - Refactored pmem_do_bvec() and reused write side of code in
>   zero_page_range().
> - Removed generic_dax_zero_page_range()
> - Fixed s390 dcssblk.c compilation issue.
> 
> Please review. 
> 
> Thanks
> Vivek
> 
> Vivek Goyal (7):
>   pmem: Add functions for reading/writing page to/from pmem
>   pmem: Enable pmem_do_write() to deal with arbitrary ranges
>   dax, pmem: Add a dax operation zero_page_range
>   s390,dcssblk,dax: Add dax zero_page_range operation to dcssblk driver
>   dm,dax: Add dax zero_page_range operation
>   dax,iomap: Start using dax native zero_page_range()
>   dax,iomap: Add helper dax_iomap_zero() to zero a range
> 
>  drivers/dax/super.c           |  19 ++++++
>  drivers/md/dm-linear.c        |  21 +++++++
>  drivers/md/dm-log-writes.c    |  19 ++++++
>  drivers/md/dm-stripe.c        |  26 ++++++++
>  drivers/md/dm.c               |  31 ++++++++++
>  drivers/nvdimm/pmem.c         | 112 ++++++++++++++++++++++++----------
>  drivers/s390/block/dcssblk.c  |  17 ++++++
>  fs/dax.c                      |  53 ++++------------
>  fs/iomap/buffered-io.c        |   9 +--
>  include/linux/dax.h           |  20 ++----
>  include/linux/device-mapper.h |   3 +
>  11 files changed, 235 insertions(+), 95 deletions(-)
> 
> -- 
> 2.20.1
> 

