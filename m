Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0FD017F741
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 13:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgCJMSl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 08:18:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52017 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726273AbgCJMSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583842718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=On3jrUJ3qJSEovCH5Mvj0GPbi4DtGWxMoOE2wJW9Vps=;
        b=cmtURjQ9MQtU8tCMp4GnGcZ8yEh5GINTi0XnNkYDrDjGTppzEvHgsJRdzOONfnpf5fCIO7
        JiW2kOPWxtABeW4TfkFt+Vto7TeivTIsVw7LMSQNZSSso/5YReXE4BtkjWPy+ZvzXxHX0w
        NQ263/GdBAZog2Kc9Y2FW3SPbzVx0/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-PbGEKDs0OnqHC_wsSkBcAQ-1; Tue, 10 Mar 2020 08:18:37 -0400
X-MC-Unique: PbGEKDs0OnqHC_wsSkBcAQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 983E71402;
        Tue, 10 Mar 2020 12:18:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0D2F27189;
        Tue, 10 Mar 2020 12:18:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5F29D220291; Tue, 10 Mar 2020 08:18:32 -0400 (EDT)
Date:   Tue, 10 Mar 2020 08:18:32 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com
Cc:     david@fromorbit.com, jmoyer@redhat.com, dm-devel@redhat.com
Subject: Re: [PATCH v6 0/6] dax/pmem: Provide a dax operation to zero page
 range
Message-ID: <20200310121832.GA38440@redhat.com>
References: <20200228163456.1587-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228163456.1587-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 11:34:50AM -0500, Vivek Goyal wrote:
> Hi,
> 
> This is V6 of patches. These patches are also available at.

Hi Dan,

Ping. Does this patch series look fine to you?

Vivek

> 
> Changes since V5:
> 
> - Dan Williams preferred ->zero_page_range() to only accept PAGE_SIZE
>   aligned request and clear poison only on page size aligned zeroing. So
>   I changed it accordingly. 
> 
> - Dropped all the modifications which were required to support arbitrary
>   range zeroing with-in a page.
> 
> - This patch series also fixes the issue where "truncate -s 512 foo.txt"
>   will fail if first sector of file is poisoned. Currently it succeeds
>   and filesystem expectes whole of the filesystem block to be free of
>   poison at the end of the operation.
> 
> Christoph, I have dropped your Reviewed-by tag on 1-2 patches because
> these patches changed substantially. Especially signature of of
> dax zero_page_range() helper.
> 
> Thanks
> Vivek
> 
> Vivek Goyal (6):
>   pmem: Add functions for reading/writing page to/from pmem
>   dax, pmem: Add a dax operation zero_page_range
>   s390,dcssblk,dax: Add dax zero_page_range operation to dcssblk driver
>   dm,dax: Add dax zero_page_range operation
>   dax: Use new dax zero page method for zeroing a page
>   dax,iomap: Add helper dax_iomap_zero() to zero a range
> 
>  drivers/dax/super.c           | 20 ++++++++
>  drivers/md/dm-linear.c        | 18 +++++++
>  drivers/md/dm-log-writes.c    | 17 ++++++
>  drivers/md/dm-stripe.c        | 23 +++++++++
>  drivers/md/dm.c               | 30 +++++++++++
>  drivers/nvdimm/pmem.c         | 97 ++++++++++++++++++++++-------------
>  drivers/s390/block/dcssblk.c  | 15 ++++++
>  fs/dax.c                      | 59 ++++++++++-----------
>  fs/iomap/buffered-io.c        |  9 +---
>  include/linux/dax.h           | 21 +++-----
>  include/linux/device-mapper.h |  3 ++
>  11 files changed, 221 insertions(+), 91 deletions(-)
> 
> -- 
> 2.20.1
> 

